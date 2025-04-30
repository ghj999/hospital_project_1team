package controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.databind.JavaType;
import com.fasterxml.jackson.databind.ObjectMapper;

import common.Common;
import dao.LoginDAO;
import dao.MypageDAO;
import vo.MypagePayVO;
import vo.MypageResListVO;
import vo.PatBoardVO;
import vo.PatientVO;

@Controller
public class MypageController {
	LoginDAO login_dao;
	public void setLogin_dao(LoginDAO login_dao) {
		this.login_dao = login_dao;
	}

	MypageDAO mypage_dao;
	public void setMypage_dao(MypageDAO mypage_dao) {
		this.mypage_dao = mypage_dao;
	}

	@Autowired
	ServletContext application;

	@Autowired
	HttpSession session;

	//마이페이지로 연결 ----------------------------------------------------------------------------------------------
	@RequestMapping("mypage.do")
	public String mypage(Model model, int pat_idx) {
		//환자정보 조회
		PatientVO vo = login_dao.selectPatientByIdx(pat_idx);
		model.addAttribute("vo", vo);

		//예약내역 조회
		List<MypageResListVO> list = mypage_dao.selectReservationList(pat_idx);
		model.addAttribute("list", list);

		return Common.mypage.VIEW_PATH + "mypage_main.jsp";
	}

	//회원정보 수정 ----------------------------------------------------------------------------------------------
	@RequestMapping("mypage_update_form.do")
	public String updateInfoForm(Model model, int pat_idx) {
		PatientVO vo = login_dao.selectPatientByIdx(pat_idx);

		model.addAttribute("vo", vo);
		return Common.mypage.VIEW_PATH + "update_info.jsp";
	}

	//기본정보변경
	@RequestMapping("mypage_update_info.do")
	public String updateInfo(HttpSession session, PatientVO vo, String[] pat_email_addr, 
			String pat_phone1_1, String pat_phone1_2,
			String pat_phone2_1, String pat_phone2_2) {

		String fullEmail = vo.getPat_email() + "@" + pat_email_addr[0];
		String fullPhone = vo.getPat_phone() +  "-" + pat_phone1_1 +  "-" +  pat_phone1_2;
		String fullPhone2 = vo.getPat_phone2() +  "-" +  pat_phone2_1 +  "-" +  pat_phone2_2;

		vo.setPat_email(fullEmail);
		vo.setPat_phone(fullPhone);
		vo.setPat_phone2(fullPhone2);

		int res = mypage_dao.updatePatientInfo(vo);
		if (res > 0) {
			// 세션 정보 갱신
			PatientVO updatedVo = login_dao.selectPatientByIdx(vo.getPat_idx());
			session.setAttribute("patient", updatedVo);
		}
		return "redirect:mypage.do?pat_idx=" + vo.getPat_idx(); 		
	}

	//비밀번호변경
	@RequestMapping("mypage_update_pwd.do")
	public String updatePwd(String pwd_new, int pat_idx, RedirectAttributes redirectAttributes) {
	    Map<String, Object> map = new HashMap<String, Object>();
	    map.put("pwd_new", pwd_new);
	    map.put("pat_idx", pat_idx);

	    int res = mypage_dao.updatePatientPwd(map);
	    System.out.println("pwd update 결과 : " + res);

	    if (res > 0) {
	        redirectAttributes.addFlashAttribute("success", "비밀번호 변경 완료");
	    }

	    return "redirect:mypage.do?pat_idx=" + pat_idx; 
	}

	//회원탈퇴 ----------------------------------------------------------------------------------------------
	@RequestMapping("mypage_withdrawal.do")
	public String withdrawalPatient(int pat_idx) {
		int res = mypage_dao.withdrawalPatient(pat_idx);
		return "redirect:main.do";
	}

	//증명서 발급 ----------------------------------------------------------------------------------------------
	@RequestMapping("mypage_certificates_print.do")
	public String certificatesPrint(Model model, Integer pat_idx) {
		
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

		//환자정보조회
		PatientVO patientVO = login_dao.selectPatientByIdx(nowPatIdx);
		model.addAttribute("patient", patientVO);

		return Common.mypage.VIEW_PATH + "certificates_print.jsp";
	}


	//진료사실확인서 ----------------------------------------------------------------------------------------------
	@RequestMapping("mypage_cert_confirm.do")
	public void certConfirm( HttpServletResponse response, String file_type) throws Exception {
		String path = "C:\\Users\\user1\\git\\hospital_project\\Hospital_Project\\src\\main\\webapp\\resources\\certificates_files\\" + file_type + ".hwp.pdf";

		File file = new File(path);
		response.setHeader("Content-Disposition", "attachment;filename=" + file.getName());
		FileInputStream fis = new FileInputStream(path);
		OutputStream os = response.getOutputStream();

		int read = 0;
		byte[] buffer = new byte[1024];
		while((read = fis.read(buffer)) != -1) {
			os.write(buffer, 0, read);
		}
	}

	//예약 내역 ----------------------------------------------------------------------------------------------
	@RequestMapping("mypage_reservation_list.do")
	public String reservationList(Model model, Integer pat_idx) {
		
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
        
		//진료과, 교수명, 교수사진, 진료일정, 진료과위치
		List<MypageResListVO> list = mypage_dao.selectReservationList(nowPatIdx);
		model.addAttribute("list", list);

		return Common.mypage.VIEW_PATH + "reservation_list.jsp";
	}

	//진료비 결제 ----------------------------------------------------------------------------------------------
	@RequestMapping("mypage_payment_page.do")
	public String paymentPage(Model model, Integer pat_idx) {
		
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
		
		List<MypagePayVO> list = mypage_dao.selectPaymentList(nowPatIdx);
		model.addAttribute("list", list);

		return Common.mypage.VIEW_PATH + "payment/payment_page.jsp";
	}
	//진료비 결제 팝업
	@RequestMapping("mypage_payment_popup.do")
	public String paymentPopup() {
		return Common.mypage.VIEW_PATH + "payment/payment_popup.jsp";
	}

	//진료비 결제 성공
	@RequestMapping("mypage_payment_success.do")
	public String paymentSuccess(@RequestParam(value = "paymentDetails", required = false) String paymentDetails,
			String paymentType, String orderId, String paymentKey, int amount, Model model) {
		if (paymentDetails != null && !paymentDetails.isEmpty()) {
			try {
				// JSON 문자열을 Java 객체로 변환
				ObjectMapper objectMapper = new ObjectMapper();
				JavaType type = objectMapper.getTypeFactory().constructCollectionType(List.class, MypagePayVO.class);
				List<MypagePayVO> details = objectMapper.readValue(paymentDetails, type);

				// 결제 내역 업데이트
				for (MypagePayVO detail : details) {
					int res = mypage_dao.updatePaymentList(detail.getRes_idx());
				}

				// 결제 완료 후, 예약 목록을 다시 가져와서 갱신
				List<MypagePayVO> updatedList = mypage_dao.selectPaymentList(details.get(0).getPat_idx());
				model.addAttribute("list", updatedList);
				model.addAttribute("details", details);

			} catch (Exception e) {
				e.printStackTrace();
			}
		} 
		else {
			System.out.println("paymentDetails가 제공되지 않았습니다.");
		}

		// 결제 완료 후, 결과 페이지로 이동
		return Common.mypage.VIEW_PATH + "payment/payment_success.jsp";
	}

	//진료비 결제 실패
	@RequestMapping("mypage_payment_fail.do")
	public String paymentFail() {
		return null;
	}

	//작성글관리 ----------------------------------------------------------------------------------------------
	//작성글 조회
	@RequestMapping("mypage_managing_posts.do")
	public String managingPost(Model model, int pat_idx) {
		List<PatBoardVO> list = mypage_dao.selectPatBoardList(pat_idx);
		model.addAttribute("list", list);

		return Common.mypage.VIEW_PATH + "my_post/managing_posts.jsp";
	}

	//작성글 내용조회
	@RequestMapping("mypage_detail_post.do")
	public String detailPost(Model model, int board_idx, int pat_idx) {
		PatBoardVO vo = mypage_dao.selectPatBoardDetail(board_idx);
		model.addAttribute("vo", vo);

		return Common.mypage.VIEW_PATH + "my_post/detail_post.jsp?pat_idx="+pat_idx;
	}

	//작성글 삭제
	@RequestMapping("mypage_delete_post.do")
	public String deletePost(int board_idx, int pat_idx) {
		int res = mypage_dao.deletePatBoard(board_idx);

		return "redirect:mypage_managing_posts.do?pat_idx=" + pat_idx;
	}

	//작성글 수정 폼
	@RequestMapping("mypage_update_post_form.do")
	public String updatePostForm(Model model, int board_idx, int pat_idx) {
		PatBoardVO vo = mypage_dao.selectPatBoardDetail(board_idx);
		model.addAttribute("vo", vo);

		return Common.mypage.VIEW_PATH + "my_post/modify_post.jsp?pat_idx="+pat_idx;
	}

	//작성글 수정
	@RequestMapping("mypage_update_post.do")
	public String updatePost(@ModelAttribute PatBoardVO vo, String board_phone_1, String board_phone_2) {

		String phone = vo.getBoard_phone() +"-" +board_phone_1+"-"+board_phone_2;
		vo.setBoard_phone(phone);

		//파일 업로드
		String webPath = "resources/uploadFiles/"; //상대경로
		String savePath = application.getRealPath(webPath); //절대경로
		System.out.println("--- 절대경로 : " + savePath);

		//업로드를 위한 파일 정보 
		MultipartFile photo = vo.getPhoto();
		String filename = "no_file";

		if( photo != null && !photo.isEmpty() ) {
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

		int res = mypage_dao.updatePatBoard(vo);
		return "redirect:mypage_managing_posts.do?pat_idx=" + vo.getPat_idx();
	}


	//메인페이지로 돌아가기 ----------------------------------------------------------------------------------------------
	@RequestMapping("mypage_main.do")
	public String mainPage(int pat_idx) {
		return "main.do?pat_idx=" + pat_idx;
	}
}







