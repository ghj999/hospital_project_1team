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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import common.Common;
import dao.NoticeDAO;
import util.Paging_Design_Admin_Notice;
import vo.NoticeVO;

@Controller
public class AdminController_Notice {

	@Autowired
	HttpSession session;

	@Autowired
	ServletContext app;

	NoticeDAO notice_dao;
	public void setNotice_dao(NoticeDAO notice_dao) {
		this.notice_dao = notice_dao;
	}

	//관리자-공지사항 조회
	@RequestMapping("admin_notice_list.do")
	public String admin_notice_list(Model model, Integer page, 
			String search, String search_text) {
		//페이지
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
		if( search != null && !search.equals("all") ) {
			if( "title_content".equals(search) ) {
				map.put("not_title", search_text);
				map.put("not_content", search_text);
			}
			if( "not_title".equals(search) ) {
				map.put("not_title", search_text);
			}
			if( "not_content".equals(search) ) {
				map.put("not_content", search_text);
			}
		}

		List<NoticeVO> list = notice_dao.selectNotList( map );

		int row_total = notice_dao.getRowTotal( map );

		String search_param = String.format(
				"search=%s&search_text=%s",	search, search_text);

		String pageMenu = Paging_Design_Admin_Notice.getPaging(
				"admin_notice_list.do", nowPage, row_total,
				search_param,
				Common.VolNot.BLOCKLIST, 
				Common.VolNot.BLOCKPAGE);

		// 현재 페이지의 시작 번호 계산 (전체 게시글 번호를 유지하기 위함)
		int startIndex = row_total - (nowPage - 1) * Common.VolNot.BLOCKLIST;
		
		model.addAttribute("list", list);
		model.addAttribute("pageMenu", pageMenu);
		model.addAttribute("startIndex", startIndex);

		//조회수
		session.removeAttribute("show");

		return Common.Admin.VIEW_PATH + "notice/Admin_Notice_List.jsp?page=" + nowPage;
	}
	//======================================================================================================
	//관리자-공지사항 상세보기 페이지로 전환
	@RequestMapping("/admin_notice_view.do")
	public String hos_notice_view(Model model, Integer not_idx, Integer page) {

		NoticeVO vo = notice_dao.selectNotOne(not_idx);

		//페이지
		int nowPage = 1;
		if( page != null ) {
			nowPage = page;
		}

		//이전, 다음글 정보 가져오기
		NoticeVO preNotice = notice_dao.preNot(not_idx);
		NoticeVO nextNotice = notice_dao.nextNot(not_idx);

		//조회수 증가
		String show = (String)session.getAttribute("show");

		if( show == null ) {
			int res = notice_dao.update_hits(not_idx);
			session.setAttribute("show", "y");
		}

		model.addAttribute("vo", vo);
		model.addAttribute("preNotice", preNotice);
		model.addAttribute("nextNotice", nextNotice);

		return Common.Admin.VIEW_PATH + "notice/Admin_Notice_View.jsp?page="+nowPage;
	}
	//======================================================================================================
	//관리자-공지사항 추가 페이지로 이동
	@RequestMapping("admin_notice_insert_form.do")
	public String admin_notice_insert_form() {
		return Common.Admin.VIEW_PATH + "notice/Admin_Notice_Insert_Form.jsp";
	}

	//관리자-공지사항 추가
	@RequestMapping("admin_notice_insert.do")
	public String admin_notice_insert(NoticeVO vo) {

		String fake_path = "/resources/upload/";
		String real_path = app.getRealPath(fake_path);
		System.out.println("절대 경로: " + real_path);

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
		}//if

		vo.setNot_file(filename);
		int res = notice_dao.insert_notice(vo);
		return "redirect:admin_notice_list.do";
	}
	//======================================================================================================
	//관리자-해당 공지사항 수정 페이지로 이동
	@RequestMapping("admin_notice_update_form.do")
	public String admin_notice_update_form(Integer not_idx, Integer page, Model model) {

		//공지사항 번호로 공지사항 하나의 정보 가져오기
		NoticeVO vo = notice_dao.selectNotOne(not_idx);

		//페이지
		int nowPage = 1;
		if( page != null ) {
			nowPage = page;
		}

		model.addAttribute("vo", vo);

		return Common.Admin.VIEW_PATH + "notice/Admin_Notice_Update_Form.jsp?page="+nowPage;
	}

	//관리자-해당 공지사항 수정
	@RequestMapping("admin_notice_update.do")
	public String admin_notice_update(NoticeVO vo, Integer page, RedirectAttributes redirectAttributes) {

		int nowPage = 1;
		if(page != null) {
			nowPage = page;
		}

		String fake_path = "/resources/upload/";
		String real_path = app.getRealPath(fake_path);
		System.out.println(fake_path);

		MultipartFile photo = vo.getPhoto();
		String filename = "no_file";

		if(!photo.isEmpty()) { //새로운 파일을 잘 가져온 경우
			filename = photo.getOriginalFilename();

			File saveFile = new File(real_path, filename);
			if(!saveFile.exists()) {
				saveFile.mkdirs();

			}else {
				long time = System.currentTimeMillis();
				filename = String.format("%d_%s", time, filename);
				saveFile = new File(real_path, filename);
			}//if

			try {
				photo.transferTo(saveFile);
				saveFile = new File(real_path, vo.getNot_file());
				if(saveFile.exists()) {
					saveFile.delete(); //기존 파일 삭제
				}
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}else { //수정폼에서 사진을 선택하지 않아 기본값으로 처리해야 하는 경우
			filename = vo.getNot_file();
		}

		vo.setNot_file(filename);

		//vo정보들로 해당 공지사항 수정
		int res = notice_dao.update_notice(vo);

		// 알림 메시지를 전달
		redirectAttributes.addFlashAttribute("message", "수정이 완료되었습니다.");
		return "redirect:admin_notice_list.do?page=" + nowPage;
	}//수정
	//======================================================================================================
	//관리자-공지사항 삭제
	@RequestMapping("admin_notice_delete.do")
	@ResponseBody
	public String admin_notice_delete(int not_idx) {
	
		//해당 공지사항 가져오기
		NoticeVO vo = notice_dao.selectNotOne(not_idx);
		
		String fake_path = "/resources/upload/";
		String real_path = app.getRealPath(fake_path);

		//절대 경로에 있는 이미지 파일 삭제
		File deleteFile = new File(real_path, vo.getNot_file());
		if(deleteFile.exists()) {
			deleteFile.delete();
		}
		
		//해당 공지사항 DB에서 삭제
		int res = notice_dao.delete_notice(not_idx);
		
		String result = "fail";
		if(res > 0) {
			result = "succ";
		}

		String resultStr = String.format("[{'result':'%s'}]", result);

		return resultStr; 
	}






}






