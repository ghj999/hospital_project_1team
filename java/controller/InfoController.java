package controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import common.Common;
import dao.FloorDAO;
import dao.NoticeDAO;
import util.Paging_Design_Notice;
import vo.FloorVO;
import vo.NoticeVO;

@Controller
public class InfoController { 
	
	@Autowired
	HttpSession session;
	
	NoticeDAO notice_dao;
	public void setNotice_dao(NoticeDAO notice_dao) {
		this.notice_dao = notice_dao;
	}
	
	FloorDAO floor_dao;
	public void setFloor_dao(FloorDAO floor_dao) {
		this.floor_dao = floor_dao;
	}
	
	//주차 안내
	@RequestMapping("parking_info.do")
	public String parkingInfo() {
		return Common.info.VIEW_PATH + "parking_info.jsp";
	}
	
	//오시는 길 
	@RequestMapping("/way_info.do")
	public String wayinfo() {
		return Common.info.VIEW_PATH + "way_info.jsp";
	}
	
	
	// ------------------------ 층별안내 -----------------------------------------
	//층별 안내
	@RequestMapping("floor_info.do")
	public String floorInfo(Model model) {
		
		List<FloorVO> floor = floor_dao.selectFloor();
	    
	    // 층별(floor_info)로 그룹화
		Map<Integer, List<FloorVO>> groupedFloors = 
				new HashMap<Integer, List<FloorVO>>();
		for (FloorVO f : floor) {
			groupedFloors.computeIfAbsent(f.getFloor_info(), new java.util.function.Function<Integer, List<FloorVO>>() {

				@Override
				public List<FloorVO> apply(Integer k) {
					return new ArrayList<FloorVO>();
				}
			}).add(f);

		}
		
		model.addAttribute("groupedFloors", groupedFloors);
		// 첫 페이지 1층으로 선택되게
	    model.addAttribute("defaultFloor", 1); 
		
		return Common.info.VIEW_PATH + "floor_info.jsp";
	}
	
	//위치명 검색
	@RequestMapping("search_floor.do")
	@ResponseBody
	public List<FloorVO> searchFloor(@RequestParam("search_text") String search_text, Model model){
		List<FloorVO> search_list = floor_dao.searchFloor(search_text);
		return search_list;
	}
	
	// ------------------------ 공지사항 -----------------------------------------
	//공지사항 조회 페이지로 전환
	@RequestMapping("/info_notice_list.do")
	public String hos_notice_form(Model model, Integer page,
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
		
		
		String pageMenu = Paging_Design_Notice.getPaging(
				"info_notice_list.do", nowPage, row_total,
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
		
		return Common.info.VIEW_PATH + "hos_notice.jsp?page="+nowPage;
	}
	
	//공지사항 상세보기 페이지로 전환
	@RequestMapping("/info_notice_view.do")
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
		
		return Common.info.VIEW_PATH + "hos_notice_view.jsp?page="+nowPage;
	}
	
	
	
}


