package controller_admin;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import common.Common;
import dao.CallingDAO;
import util.Paging_Design_Admin_Calling;
import util.Paging_Design_Admin_Reservation;
import vo.CallingVO;

@Controller
public class AdminController_Calling {

	CallingDAO calling_dao;
	public void setCalling_dao(CallingDAO calling_dao) {
		this.calling_dao = calling_dao;
	}

	//관리자-상담예약 리스트 조회(페이지 이동)
	@RequestMapping("admin_calling_list.do")
	public String admin_calling_list(
			Model model, Integer page, String search, String search_text) {

		int nowPage = 1;

		//정상적으로 페이지 값을 받은 경우
		if(page != null) {
			nowPage = page; 
		}

		//한 페이지에 표시할 게시글의 시작번호와 끝번호를 계산
		int start = (nowPage - 1) * Common.Call.BLOCKLIST + 1;
		int end = start + Common.Call.BLOCKLIST - 1;

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("start", start);
		map.put("end", end);

		//검색
		if( search != null && !search.equals("all") ) {
			if( "calling_name".equals(search) ) {
				map.put("calling_name", search_text);
			}
			if( "calling_tel".equals(search) ) {
				map.put("calling_tel", search_text);
			}
		}

		List<CallingVO> list = null;
		
		//페이지 정보를 담은 map을 가지고 모든 회원의 예약들을 조회
		list = calling_dao.selectCallList( map );

		//전체 상담예약 수
		int row_total = calling_dao.getRowTotal(map);
		
		String search_param = String.format(
				"search=%s&search_text=%s",	search, search_text);
		
		//페이지메뉴 생성
		String pageMenu = Paging_Design_Admin_Calling.getPaging(
				"admin_calling_list.do", nowPage, row_total, search_param,
				Common.Call.BLOCKLIST, Common.Call.BLOCKPAGE);

		model.addAttribute("list", list);
		model.addAttribute("pageMenu", pageMenu);
		
		return Common.Admin.VIEW_PATH + "calling/Admin_Calling_List.jsp";
	}

	// 관리자 - 선택한 상담예약 모두 삭제
	@RequestMapping("delete_calling_check.do")
	@ResponseBody
	public String delete_calling_all(@RequestParam("calling_idx") String calling_idx) {

		// 쉼표로 구분된 calling_idx를 리스트로 변환
		List<Integer> calling_idxs = new ArrayList<Integer>();
		String[] idxArray = calling_idx.split(","); // 쉼표로 분리

		for (String idx : idxArray) {
			try {
				calling_idxs.add(Integer.parseInt(idx.trim())); // 정수로 변환하여 리스트에 추가
			} catch (NumberFormatException e) {
				// 변환 실패 시 무시하거나 로그 처리 가능
				System.err.println("Invalid number format: " + idx);
			}
		}

		int res = calling_dao.delete_calling_check(calling_idxs);

		String result = "fail";
		if(res > 0) {
			result = "succ";
		}

		String resultStr = String.format("[{'result':'%s'}]", result);
		return resultStr;
	}//delete_calling_all

	//상담예약 여부 수정
	@RequestMapping("update_calling_chk.do")
	@ResponseBody
	public String update_calling_chk(int calling_idx) {

		//calling_idx로 해당 예약의 예약여부 수정하기
		int res = calling_dao.update_calling_chk(calling_idx);

		String result = "fail";
		if(res > 0) {
			result = "succ";
		}

		String resultStr = String.format("[{'result':'%s'}]", result);
		return resultStr;
	}





}
