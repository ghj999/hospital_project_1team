package controller;


import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import common.Common;
import dao.PatBoardDAO;
import dao.VolcommentDAO;
import dao.VolreplyDAO;
import dao.VolunteerDAO;
import util.Paging_Design_Thank;
import util.Paging_Design_Volunteer;
import util.Paging_Design_VolunteerComm;
import util.VolCommPaging;
import util.VolPaging;
import vo.PatBoardVO;
import vo.PatientVO;
import vo.VolcommentVO;
import vo.VolreplyVO;
import vo.VolunteerVO;

//고객참여 컨트롤러
@Controller
public class JoinController {
	@Autowired
	HttpSession session;

	PatBoardDAO patBoard_dao;
	public void setPatBoard_dao(PatBoardDAO patBoard_dao) {
		this.patBoard_dao = patBoard_dao;
	}

	VolunteerDAO volunteer_dao;
	public void setVolunteer_dao(VolunteerDAO volunteer_dao) {
		this.volunteer_dao = volunteer_dao;
	}

	VolcommentDAO volcomment_dao;
	public void setVolcomment_dao(VolcommentDAO volcomment_dao) {
		this.volcomment_dao = volcomment_dao;
	}
	
	VolreplyDAO volreply_dao;
	public void setVolreply_dao(VolreplyDAO volreply_dao) {
		this.volreply_dao = volreply_dao;
	}


	@Autowired
	ServletContext application;
	// ------------------------------ 감사합니다 (조회) --------------------------------------
	//감사합니다 리스트 조회 
	@RequestMapping("/join_thanks_list.do")
	public String thanks_list_form(Model model, Integer page, Integer pat_idx) {

		int nowPage = 1;
		if( page != null ) {
			nowPage = page;
		}

		int nowPatIdx = 0;
		if(pat_idx == null) {
			//버튼 클릭시 로그인이 되어있지 않으면 로그인 창으로 넘어감
			return "redirect:/login_page.do";
		}else{
			nowPatIdx = pat_idx;
		}
		// 세션에서 patient 객체 가져오기
		Object patient = session.getAttribute("patient");

		// 세션에 patient 정보가 없으면 로그인 페이지로 리디렉트
		if (patient == null) {
			return "redirect:/login_page.do";
		}

		int start = (nowPage - 1) * Common.Board.BLOCKLIST + 1;
		int end = start + Common.Board.BLOCKLIST - 1;

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("start", start);
		map.put("end", end);

		List<PatBoardVO> list = patBoard_dao.selectThanks( map );

		int row_total = patBoard_dao.getRowTotal();

		String pageMenu = Paging_Design_Thank.getPaging(
				"join_thanks_list.do", nowPage, row_total,
				Common.Board.BLOCKLIST,
				Common.Board.BLOCKPAGE);

		model.addAttribute("list", list);
		model.addAttribute("pageMenu", pageMenu);

		return Common.join.VIEW_PATH + "thanks_list.jsp?pat_idx="+nowPatIdx;
	}

	//감사합니다 글 작성 페이지 전환
	@RequestMapping("/join_thanks_insert_form.do")
	public String thanks_insert_form(Integer pat_idx) {

		int nowPatIdx = 0;
		if(pat_idx == null) {
			//버튼 클릭시 로그인이 되어있지 않으면 로그인 창으로 넘어감
			return "redirect:/login_page.do";
		}else{
			nowPatIdx = pat_idx;
		}
		// 세션에서 patient 객체 가져오기
		Object patient = session.getAttribute("patient");

		// 세션에 patient 정보가 없으면 로그인 페이지로 리디렉트
		if (patient == null) {
			return "redirect:/login_page.do";
		}

		return Common.join.VIEW_PATH + "thanks_insert.jsp?pat_idx="+nowPatIdx;
	}

	// ----------------------------- 건의합니다 (추가 페이지로) ------------------------------------
	//건의합니다 작성 페이지로 전환
	@RequestMapping("/join_compl_insert_form.do")
	public String complaint_insert_form(Integer pat_idx) {

		int nowPatIdx = 0;
		if(pat_idx == null) {
			//버튼 클릭시 로그인이 되어있지 않으면 로그인 창으로 넘어감
			return "redirect:/login_page.do";
		}else{
			nowPatIdx = pat_idx;
		}

		// 세션에서 patient 객체 가져오기
		Object patient = session.getAttribute("patient");

		// 세션에 patient 정보가 없으면 로그인 페이지로 리디렉트
		if (patient == null) {
			return "redirect:/login_page.do";
		}

		return Common.join.VIEW_PATH + "complaint_insert.jsp?pat_idx="+nowPatIdx;
	}
	// ---------------------------- 감사합니다, 건의합니다 (추가)------------------------------------
	//감사, 건의합니다 추가
	@RequestMapping("/join_board_insert.do")
	public String thanks_insert(@ModelAttribute PatBoardVO vo, String board_phone,
			String board_phone_1, String board_phone_2,
			String board_email1, String board_email2,
			String page, Integer pat_idx) {

		String fullPhone = board_phone+"-" +board_phone_1+"-"+board_phone_2;
		String fullEmail = board_email1+"@"+board_email2;

		vo.setBoard_phone(fullPhone);
		vo.setBoard_email(fullEmail);

		//사진 파일 업로드
		String webPath = "resources/uploadThanksCompl/"; //상대경로
		String savePath = application.getRealPath(webPath); //절대경로

		System.out.println("--- 감사합니다 절대경로 : " + savePath);

		//업로드를 위한 파일 정보 
		MultipartFile photo = vo.getPhoto();
		String filename = "no_file";

		if( !photo.isEmpty() ) {
			filename = photo.getOriginalFilename();

			//저장할 파일 경로
			File saveFile = new File(savePath, filename);
			if( !saveFile.exists() ) {
				//절대경로 존재하지 않는다면 생성
				saveFile.mkdirs();
			}else {
				//파일 동일명 설정
				long time = System.currentTimeMillis();
				filename = String.format("%d_%s", time, filename);
				saveFile = new File(savePath, filename);
			}

			//절대경로에 파일 생성
			try {
				photo.transferTo(saveFile);
			} catch (Exception e) {
				e.printStackTrace();
			} 

		}else {
			filename = "no_file";
		}

		vo.setBoard_file(filename);

		int res = patBoard_dao.insertJoin(vo);

		String redirectUrl = "";

		if( "thanks".equals(vo.getBoard_type()) ) {				
			redirectUrl = "/join_thanks_list.do?pat_idx="+pat_idx;
		}else if( "complaint".equals(vo.getBoard_type()) ) {
			redirectUrl = "/mypage_managing_posts.do?pat_idx="+pat_idx;
		}

		return "redirect:" + redirectUrl;

	}

	// ------------------------------ 자원봉사 --------------------------------------
	//자원봉사 조회
	@RequestMapping("/join_volunteer_list.do")
	public String volunteer_list(Model model, Integer pat_idx, Integer page,
			String search, String search_text) {

		int nowPage = 1;
		if( page != null ) {
			nowPage = page;
		}

		int nowPatIdx = 0;
		if(pat_idx == null) {
			//버튼 클릭시 로그인이 되어있지 않으면 로그인 창으로 넘어감
			return "redirect:/login_page.do";
		}else{
			nowPatIdx = pat_idx;
		}

		// 세션에서 patient 객체 가져오기
		Object patient = session.getAttribute("patient");

		// 세션에 patient 정보가 없으면 로그인 페이지로 리디렉트
		if (patient == null) {
			return "redirect:/login_page.do";
		}

		int start = (nowPage - 1) * Common.VolNot.BLOCKLIST + 1; 
		int end = start + Common.VolNot.BLOCKLIST - 1;

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("start", start);
		map.put("end", end);

		//검색
		if( search != null &&  search_text != null && !"all".equals(search_text) ) {

			if( "title_content".equals(search) ) {
				map.put("vol_title", search_text);
				map.put("vol_content", search_text);
			}
			if( "vol_title".equals(search) ) {
				map.put("vol_title", search_text);
			}
			if( "vol_content".equals(search) ) {
				map.put("vol_content", search_text);
			}

		}

		List<VolunteerVO> list = volunteer_dao.selectVol( map );

		int row_total = volunteer_dao.getRowTotal( map );

		String search_param = String.format(
				"search=%s&search_param=%s", search, search_text);

		String pageVol = Paging_Design_Volunteer.getPaging(
				"join_volunteer_list.do", nowPage, row_total,
				search_param,
				Common.VolNot.BLOCKLIST, 
				Common.VolNot.BLOCKPAGE);

		// 현재 페이지의 시작 번호 계산 (전체 게시글 번호를 유지하기 위함)
		int startIndex = row_total - (nowPage - 1) * Common.VolNot.BLOCKLIST;

		model.addAttribute("list", list);
		model.addAttribute("pageVol", pageVol);
		model.addAttribute("startIndex", startIndex);

		//조회수
		session.removeAttribute("show");

		return Common.join.VIEW_PATH + "volunteer_list.jsp?pat_idx="+nowPatIdx+"&page="+nowPage;
	}

	//자원봉사 상세보기 페이지로 전환
	@RequestMapping("/join_volunteer_view.do")
	public String volunteer_view_form(Model model, 
			Integer vol_idx, Integer pat_idx, Integer page) {

		int nowPage = 1;
		if( page != null ) {
			nowPage = page;
		}

		PatientVO patVO = volunteer_dao.selectPatInfo(pat_idx);
		VolunteerVO volVO = volunteer_dao.selectVolOne(vol_idx);

		VolunteerVO preVol = volunteer_dao.preVol(vol_idx);
		VolunteerVO nextVol = volunteer_dao.nextVol(vol_idx);

		//조회수 증가
		String show = (String)session.getAttribute("show");

		if( show == null ) {
			int res = volunteer_dao.update_hits(vol_idx);
			session.setAttribute("show", "y");
		}

		model.addAttribute("vo", volVO);
		model.addAttribute("patVO", patVO);

		model.addAttribute("preVol", preVol);
		model.addAttribute("nextVol", nextVol);

		return Common.join.VIEW_PATH + "volunteer_view.jsp?page="+nowPage;
	}


	// ------------------------------ 자원봉사 댓글 --------------------------------------
	//자원봉사 댓글,답글 조회
	@RequestMapping("join_volcomm_list.do")
	public String volcomm_list(Model model, Integer pat_idx, Integer vol_idx, Integer comm_page) {

		int nowPage = 1;
		if( comm_page != null ) {
			nowPage = comm_page;
		}

		int start = (nowPage - 1) * Common.VolComm.BLOCKLIST + 1;
		int end = start + Common.VolComm.BLOCKLIST - 1;

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("start", start);
		map.put("end", end);
		map.put("vol_idx", vol_idx);

		//댓글 조회
		List<VolcommentVO> comm_list = volcomment_dao.selectVolComm(map);
		//답글 조회
		List<VolreplyVO> reply_list = volreply_dao.selectVolReply();
		
		int row_total = volcomment_dao.getRowTotal(vol_idx);
		String pageVolComm = Paging_Design_VolunteerComm.getPaging(
				"join_volcomm_list.do", nowPage, row_total, 
				Common.VolComm.BLOCKLIST, 
				Common.VolComm.BLOCKPAGE);

		model.addAttribute("comm_list", comm_list);
		model.addAttribute("reply_list", reply_list);
		model.addAttribute("pageVolComm", pageVolComm);

		return Common.join.VIEW_PATH + "volcomment_list.jsp";
	}


	//자원봉사 댓글 추가
	@RequestMapping("join_volcomment_insert.do")
	@ResponseBody
	public String comment_insert(VolcommentVO vo) {

		int res = volcomment_dao.comm_insert(vo);

		System.out.println("--res"+res);

		String result = "fail";
		if( res == 1 ) {
			result = "succ";
		}

		String resultStr = String.format("[{'result':'%s'}]", result);
		return resultStr;
	}

	//자원봉사 댓글 삭제
	@RequestMapping("join_volcomm_del.do")
	@ResponseBody
	public String volcomm_del(Integer comm_idx) {

		int res = volcomment_dao.comm_del(comm_idx);

		String result = "fail";
		if( res == 1 ) {
			result = "succ";
		}

		String resultStr = String.format("[{'result':'%s'}]", result);
		return resultStr;
	}

}





