package controller;


import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import common.Common;
import dao.BannerDAO;
import dao.LoginDAO;
import dao.MypageDAO;
import dao.NoticeDAO;
import service.MailSendService;
import vo.BannerVO;
import vo.NaverVO;
import vo.NoticeVO;
import vo.PatientVO;

@Controller
public class LoginController {

	@Autowired
	HttpSession session;

	LoginDAO login_dao;
	public void setLogin_dao(LoginDAO login_dao) {
		this.login_dao = login_dao;
	}

	BannerDAO banner_dao;
	public void setBanner_dao(BannerDAO banner_dao) {
		this.banner_dao = banner_dao;
	}

	MypageDAO mypage_dao;
	public void setMypage_dao(MypageDAO mypage_dao) {
		this.mypage_dao = mypage_dao;
	}

	NoticeDAO notice_dao;
	public void setNotice_dao(NoticeDAO notice_dao) {
		this.notice_dao = notice_dao;
	}

	MailSendService mss;
	public void setMss(MailSendService mss) {
		this.mss = mss;
	}

	//기본 메인화면
	@RequestMapping(value = {"/", "main.do"})
	public String main_start(Model model, Integer pat_idx) {

		int nowPat_idx = 0;

		if(pat_idx != null) {
			nowPat_idx = pat_idx; 
		}

		//배너 이미지 담은 list들 DB에서 가져오기
		List<BannerVO> list_banner = banner_dao.Banner_List();

		//메인화면의 공지사항 박스 채우기 위해 공지사항 담은 list들 DB에서 가져오기
		List<NoticeVO> list_notice = notice_dao.selectNotList();

		//로그인 시 관리자인지 확인하기 위해 회원정보 담은 list들 DB에서 가져오기
		PatientVO vo_user = login_dao.selectPatientByIdx(nowPat_idx);


		model.addAttribute("images", list_banner);
		model.addAttribute("notices", list_notice);

		// vo가 null인지 확인
		if (vo_user == null || vo_user.getPat_id() == null) {
			//회원 정보가 존재하지 않는 경우(로그인 안 한 경우)
			return Common.main.VIEW_PATH + "MainPage_User.jsp";
		}

		// 회원 ID가 'admin'인지 확인
		if ("admin".equals(vo_user.getPat_id())) {
			//회원 아이디가 'admin'이면 관리자 페이지로 이동
			model.addAttribute("vo", vo_user);
			return Common.main.VIEW_PATH + "Admin/MainPage_Admin.jsp";
		} else {
			return Common.main.VIEW_PATH + "MainPage_User.jsp";
		}
	}

	//로그인 페이지
	@RequestMapping("login_page.do")
	public String login() {
		return Common.login.VIEW_PATH + "login.jsp";
	}

	//회원가입 페이지 -----------------------------------------------------------------------------
	@RequestMapping("register_page.do")
	public String register() {
		return Common.login.VIEW_PATH + "register/register_step1.jsp";
	}

	@RequestMapping("register_input.do")
	public String registerInput() {
		return Common.login.VIEW_PATH + "register/register.jsp";
	}

	@RequestMapping("register_fin.do")
	public String registerFin(Model model, String pat_name) {
		model.addAttribute("pat_name", pat_name);
		return Common.login.VIEW_PATH + "register/regist_step3.jsp";
	}

	//환자정보 insert -----------------------------------------------------------------------------
	@RequestMapping("register_patient_insert.do")
	@ResponseBody
	public String insertPatient(PatientVO vo, String pat_email_addr, 
			String pat_phone1_1, String pat_phone1_2,
			String pat_phone2_1, String pat_phone2_2) {

		String fullEmail = vo.getPat_email() + "@" + pat_email_addr;
		String fullPhone = vo.getPat_phone() + "-" + pat_phone1_1 + "-" + pat_phone1_2;
		String fullPhone2 = vo.getPat_phone2() + "-" + pat_phone2_1 + "-" + pat_phone2_2;

		vo.setPat_email(fullEmail);
		vo.setPat_phone(fullPhone);
		vo.setPat_phone2(fullPhone2);

		String result;
		// 중복 체크
		PatientVO vo2 = login_dao.selectPatientByPatphone(fullPhone);
		if (vo2 != null) {
			result = String.format("[{'result': '%s'}]", "fail");
			return result;
		}

		int res = login_dao.insertPatient(vo);
		System.out.println("insert 성공 : " + res);

		if (res > 0) {
			result = String.format("[{'result': '%s'}]", "success");
		} else {
			result = String.format("[{'result': '%s'}]", "error");
		}

		return result;
	} //insertPatient

	//환자정보 select (아이디 중복체크를 위한) ----------------------------------------------------------
	@RequestMapping("register_check_id.do")
	@ResponseBody
	public String checkId(String pat_id) {
		PatientVO vo = login_dao.selectPatientById(pat_id);

		String result = "no";
		if(vo != null) { //해당 아이디와 동일한 환자정보가 존재하는 경우
			result = "yes";
		}

		String resultStr = String.format("[{'result' : '%s'}]", result);
		return resultStr;
	} //checkId

	//회원정보 select (로그인 시 아이디, 비밀번호 체크를 위한)  ----------------------------------------------------------
	@RequestMapping("login_chk_correct.do")
	@ResponseBody
	public String login(String pat_id, String pat_pwd) {
		//아이디가 존재하는지 체크
		PatientVO vo1 = login_dao.selectPatientById(pat_id); 

		//비밀번호가 일치하는지 체크
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("pat_id", pat_id);
		map.put("pat_pwd", pat_pwd);
		PatientVO vo2 = login_dao.selectPatient(map);

		String result = "id_not_exist";
		int pat_idx = 0;
		if(vo2 != null) { //아이디와 비밀번호가 모두 일치하는 경우
			result = "login_success";
			//아이디에 해당하는 pat_idx 가져오기
			pat_idx = login_dao.selectPatientIdx(pat_id);
		} else if (vo1 != null) { //비밀번호는 일치하지 않지만 아이디는 일치하는 경우
			result = "id_exist";
		}

		//세션스코프에 로그인한 회원 정보 저장
		session.setAttribute("patient", vo2);

		//세션 유지시간(30분(기존) -> 1시간)
		session.setMaxInactiveInterval(3600);

		String resultStr = 
				String.format("[{'result' : '%s'}, {'pat_idx' : '%d'}]", result, pat_idx);
		return resultStr; 
	}

	//로그아웃 --------------------------------------------------------------------------------------------
	@RequestMapping("logout.do")
	public String logout(HttpSession session) {
		System.out.println("로그아웃 요청 수신"); // 로그 확인용
		session.invalidate(); // 세션 무효화
		return "redirect:/main.do";
	}

	//아이디 찾기 ----------------------------------------------------------------------------------------------
	@RequestMapping("login_find_id_form.do")
	public String findIdForm() {
		return Common.login.VIEW_PATH + "find/find_id.jsp";
	}

	@RequestMapping("login_find_id.do")
	@ResponseBody
	public String findId(String pat_name, String pat_email) {
		Map<String, String> map = new HashMap<String, String>();

		map.put("pat_name", pat_name);
		map.put("pat_email", pat_email);

		String result = "";

		//1) 존재하는 회원인지 조회
		PatientVO vo = login_dao.selectPatientByEmailAndName(map);
		String id = "";
		if(vo == null) { //존재하지 않는 회원인 경우
			result = "no_patient";
		}

		//2) 이메일 전송하기 (존재하는 회원인 경우)
		else { 
			result = mss.sendNumberEmail(pat_email);
			id=vo.getPat_id();
		}

		String resultStr = String.format("[{'result' : '%s'}, {'id' : '%s'}]", result, id);
		return resultStr; 
	}
	@RequestMapping("login_find_id_page.do")
	public String findIdPage(String pat_id) {
		return Common.login.VIEW_PATH + "find/find_id_page.jsp";
	}

	//비밀번호 찾기 ----------------------------------------------------------------------------------------------
	@RequestMapping("login_find_pwd_form.do")
	public String findPwdForm() {
		return Common.login.VIEW_PATH + "find/find_pwd.jsp";
	}

	@RequestMapping("login_find_pwd.do")
	@ResponseBody
	public String findPwd(String pat_id, String pat_email) {
		Map<String, String> map = new HashMap<String, String>();

		map.put("pat_id", pat_id);
		map.put("pat_email", pat_email);

		String result = "";

		//1) 존재하는 회원인지 조회
		PatientVO vo = login_dao.selectPatientByEmailAndId(map);
		int idx = 0;
		if(vo == null) { //존재하지 않는 회원인 경우
			result = "no_patient";
		}

		//2) 이메일 전송하기 (존재하는 회원인 경우)
		else { 
			result = mss.sendNumberEmail(pat_email);
			idx = vo.getPat_idx();
		}

		String resultStr = String.format("[{'result' : '%s'}, {'idx': '%d'}]", result, idx);
		return resultStr; 
	}

	//비밀번호 재설정 페이지로 이동
	@RequestMapping("login_find_pwd_page.do")
	public String findPwdPage(String pat_idx) {
		return Common.login.VIEW_PATH + "find/find_pwd_page.jsp?pat_idx=" + pat_idx;
	}

	//비밀번호 재설정
	@RequestMapping("login_update_pwd.do")
	public String updatePwd(String pwd_new, int pat_idx) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("pwd_new", pwd_new);
		map.put("pat_idx", pat_idx);

		int res = mypage_dao.updatePatientPwd(map);
		System.out.println("pwd update 결과 : " + res);
		return "redirect:login_page.do"; 
	}

	//네이버로 로그인----------------------------------------------------------------------------------------------
	//step1 화면으로 이동
	@RequestMapping("register_step1_naver.do") 
	public String registerNaver() {
		return Common.login.VIEW_PATH + "register/register_step1_naver.jsp";
	}

	@RequestMapping(value = "/register_naver_page.do", method = RequestMethod.GET)
	public String naverLogin(HttpSession session, HttpServletRequest request, Model model) {
		//로그인 API 설정
		String clientId = "WYuXnPaEfWiiYkAtng_L";
		String clientSecret = "luGDdwKsFQ";
		String code = request.getParameter("code");
		String state = request.getParameter("state");
		String redirectURI;

		//Redirect URI 인코딩
		try {
			redirectURI = URLEncoder.encode("http://localhost:8080/hos/register_naver_page.do", "UTF-8");
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}

		//네이버 API에 액세스 토큰 요청
		String apiURL = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code&" +
				"client_id=" + clientId + "&client_secret=" + clientSecret +
				"&redirect_uri=" + redirectURI + "&code=" + code + "&state=" + state;

		try {
			//HTTP 요청을 통해 액세스 토큰 응답 처리
			URL url = new URL(apiURL);
			HttpURLConnection con = (HttpURLConnection) url.openConnection();
			con.setRequestMethod("GET");
			int responseCode = con.getResponseCode();

			BufferedReader br;
			if (responseCode == 200) {
				br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			} else {
				br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
			}

			StringBuilder res = new StringBuilder();
			String inputLine;
			while ((inputLine = br.readLine()) != null) {
				res.append(inputLine);
			}
			br.close();

			ObjectMapper objectMapper = new ObjectMapper();
			JsonNode json = objectMapper.readTree(res.toString());
			String accessToken = json.get("access_token").asText();

			// 사용자 정보 가져오기
			String userApiURL = "https://openapi.naver.com/v1/nid/me";
			HttpHeaders headers = new HttpHeaders();
			headers.set("Authorization", "Bearer " + accessToken);
			HttpEntity<String> entity = new HttpEntity<String>(headers);

			RestTemplate restTemplate = new RestTemplate();
			ResponseEntity<String> responseEntity = restTemplate.exchange(userApiURL, HttpMethod.GET, entity, String.class);

			JsonNode userJson = objectMapper.readTree(responseEntity.getBody());
			NaverVO naverVO = new NaverVO();
			naverVO.setN_name(userJson.path("response").path("name").asText());
			naverVO.setN_email(userJson.path("response").path("email").asText());
			naverVO.setN_gender(userJson.path("response").path("gender").asText());
			naverVO.setN_birthday(userJson.path("response").path("birthday").asText());
			naverVO.setN_phone(userJson.path("response").path("mobile").asText());
			naverVO.setN_birthday(userJson.path("response").path("birthYear").asText());

			model.addAttribute("naverVO", naverVO);
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}

		return Common.login.VIEW_PATH + "register/register_naver.jsp";	
	}

}


