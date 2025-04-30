package controller_admin;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import common.Common;
import dao.PatBoardDAO;
import dao.VolcommentDAO;
import dao.VolreplyDAO;
import dao.VolunteerDAO;
import util.Paging_Design_Admin_Volunteer;
import util.Paging_Design_VolunteerComm;
import vo.VolcommentVO;
import vo.VolreplyVO;
import vo.VolunteerVO;



@Controller
public class AdminController_Volunteer {

	@Autowired
	HttpSession session;

	@Autowired 
	ServletContext app;

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
	
	//관리자-자원봉사 리스트 조회
	@RequestMapping("admin_volunteer_list.do")
	public String admin_volunteer_list(Model model, Integer page,
			String search, String search_text) {

		int nowPage = 1;
		if( page != null ) {
			nowPage = page;
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

		String pageVol = Paging_Design_Admin_Volunteer.getPaging(
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

		return Common.Admin.VIEW_PATH + "volunteer/Admin_Volunteer_List.jsp?page="+nowPage;
	}

	//자원봉사 상세보기 페이지로 전환
	@RequestMapping("admin_volunteer_view.do")
	public String volunteer_view_form(Model model,
			@RequestParam(value = "vol_idx", required = false) Integer vol_idx, Integer page) {

		int nowPage = 1;
		if( page != null ) {
			nowPage = page;
		}

		//PatientVO patVO = volunteer_dao.selectPatInfo(pat_idx);
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
		//model.addAttribute("patVO", patVO);

		model.addAttribute("preVol", preVol);
		model.addAttribute("nextVol", nextVol);

		return Common.Admin.VIEW_PATH + "volunteer/Admin_Volunteer_View.jsp?page="+nowPage;
	}

	//자원봉사 추가 페이지로 이동
	@RequestMapping("admin_volunteer_insert_form.do")
	public String admin_volunteer_insert_form() {
		return Common.Admin.VIEW_PATH + "volunteer/Admin_Volunteer_Insert_Form.jsp";
	}

	//자원봉사 추가
	@RequestMapping("admin_volunteer_insert.do")
	public String admin_volunteer_insert(VolunteerVO vo) {
		String fake_path = "/resources/upload/";
		String real_path = app.getRealPath(fake_path);
		System.out.println("Real path: " + real_path);

		MultipartFile photo = vo.getPhoto();
		String filename = "no_file";

		//업로드 하고자 하는 파일이 존재한다면
		if(!photo.isEmpty()) {
			filename = photo.getOriginalFilename();

			File saveFile = new File(real_path, filename);

			if(!saveFile.exists()) {
				saveFile.mkdirs();
			}else {
				//동일 파일명 처리
				long time = System.currentTimeMillis();
				filename = String.format("%d_%s", time, filename);
				saveFile = new File(real_path, filename);
			}

			//실제로 파일을 절대경로에 생성
			try {
				photo.transferTo(saveFile);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		vo.setVol_file(filename);
		int res = volunteer_dao.insert_volunteer(vo);
		return "redirect:admin_volunteer_list.do";
	}

	//자원봉사 삭제
	@RequestMapping("admin_volunteer_delete.do")
	@ResponseBody
	public String admin_professor_delete(int vol_idx){
		
		int res1 = volunteer_dao.volunteer_delete(vol_idx);
		
		String result = "fail";
		if(res1 > 0) {
			result = "succ";
		}
		
		String resultStr = String.format("[{'result':'%s'}]", result);
		return resultStr;
	}

	// ------------------------------ 자원봉사 댓글 --------------------------------------
	//자원봉사 댓글,답글 조회
	@RequestMapping("admin_volcomm_list.do")
	public String volcomm_list(Model model, int pat_idx, 
			@RequestParam(value = "vol_idx", required = false) Integer vol_idx, Integer comm_page) {

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

		return Common.Admin.VIEW_PATH + "volunteer/Admin_Volcomment_List.jsp";
	}

	//자원봉사 댓글 추가
	@RequestMapping("admin_volcomment_insert.do")
	@ResponseBody
	public String comment_insert(VolcommentVO vo) {

		int res = volcomment_dao.comm_insert(vo);

		String result = "fail";
		if( res == 1 ) {
			result = "succ";
		}

		String resultStr = String.format("[{'result':'%s'}]", result);
		return resultStr;
	}

	//자원봉사 댓글,관련 답글 모두 삭제
	@RequestMapping("admin_volcomm_del.do")
	@ResponseBody
	public String volcomm_del(Integer comm_idx) {

		int res1 = volcomment_dao.comm_del(comm_idx);
		
		
		String result = "fail";
		if( res1 > 0 ) {
			result = "succ";
		}

		String resultStr = String.format("[{'result':'%s'}]", result);
		return resultStr;
	}

	//자원봉사 답글 등록
	@RequestMapping("admin_volcomment_reply.do")
	@ResponseBody
	public String admin_volcomment_reply(VolreplyVO vo) {
				
		System.out.println("댓글 번호:" + vo.getComm_idx());
		System.out.println("답글 내용:" + vo.getReply_content());
		System.out.println("답글 작성자:" + vo.getReply_name());
		System.out.println("자원봉사 게시글 번호:" + vo.getVol_idx());
		System.out.println("회원 번호:" + vo.getPat_idx());
		
		int res = volreply_dao.reply_insert(vo);
		
		String result = res > 0 ? "succ" : "fail";

	    String resultStr = "{\"result\":\"" + result + "\"}";

	    return resultStr;
	}
	
	//자원봉사 답글 삭제
	@RequestMapping("admin_volreply_delete.do")
	@ResponseBody
	public String admin_volreply_delete(int reply_idx) {
		
		int res = volreply_dao.reply_delete(reply_idx);
		
		String result = "fail";
		if( res > 0 ) {
			result = "succ";
		}
		
		String resultStr = String.format("[{'result':'%s'}]", result);
		return resultStr;
	}

}





