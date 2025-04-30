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
import dao.LoginDAO;
import dao.ProfessorDAO;
import dao.ReservationDAO;
import util.Paging_Design_Admin_Calling;
import util.Paging_Design_Admin_Reservation;
import vo.ManageReservationVO;

@Controller
public class AdminController_Reservation {

	ReservationDAO reservation_dao;
	public void setReservation_dao(ReservationDAO reservation_dao) {
		this.reservation_dao = reservation_dao;
	}
	LoginDAO login_dao;
	public void setLogin_dao(LoginDAO login_dao) {
		this.login_dao = login_dao;
	}
	ProfessorDAO professor_dao;
	public void setProfessor_dao(ProfessorDAO professor_dao) {
		this.professor_dao = professor_dao;
	}

	//관리자-예약관리 페이지로 이동(모든예약 조회)------------------------------------------------------------------------------
	@RequestMapping("admin_reservation_list.do")
	public String reservation_ManagePage(
			Model model, Integer page, String search, String search_text) {

		int nowPage = 1;

		//정상적으로 페이지 값을 받은 경우
		if(page != null) {
			nowPage = page; 
		}

		//한 페이지에 표시할 게시글의 시작번호와 끝번호를 계산
		int start = (nowPage - 1) * Common.reservation.BLOCKLIST + 1;
		int end = start + Common.reservation.BLOCKLIST - 1;

		//start와 end를 map에 저장
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("start", start);
		map.put("end", end);

		//검색
		if( search != null && !search.equals("all") ) {
			if( "pat_pro_name".equals(search) ) {
				map.put("pat_name", search_text);
				map.put("pro_name", search_text);
			}
			if( "pat_name".equals(search) ) {
				map.put("pat_name", search_text);
			}
			if( "pro_name".equals(search) ) {
				map.put("pro_name", search_text);
			}
		}

		List<ManageReservationVO> res_list = null;

		//페이지 정보를 담은 map을 가지고 모든 회원의 예약들을 조회
		res_list = reservation_dao.reservation_selectList(map);

		//전체 게시글 수
		int row_total = reservation_dao.reservationCount(map); 

		String search_param = String.format(
				"search=%s&search_text=%s",	search, search_text);

		// 현재 페이지의 시작 번호 계산 (전체 게시글 번호를 유지하기 위함)
		int startIndex = row_total - (nowPage - 1) * Common.VolNot.BLOCKLIST;

		//페이지메뉴 생성
		String pageMenu = Paging_Design_Admin_Reservation.getPaging(
				"admin_reservation_list.do", nowPage, row_total, search_param,
				Common.reservation.BLOCKLIST, Common.reservation.BLOCKPAGE);

		model.addAttribute("pageMenu", pageMenu);
		model.addAttribute("res_list", res_list);
		model.addAttribute("startIndex", startIndex);

		return Common.Admin.VIEW_PATH + "/reservation/reservation_list.jsp";
	}

	//관리자-선택한 진료예약 삭제
	@RequestMapping("delete_reservation_check.do")
	@ResponseBody
	public String delete_reservation(@RequestParam("res_idx") String res_idx) {
		
		// 쉼표로 구분된 res_idx를 리스트로 변환
		List<Integer> res_idxs = new ArrayList<Integer>();
		String[] idxArray = res_idx.split(","); // 쉼표로 분리

		for (String idx : idxArray) {
			try {
				res_idxs.add(Integer.parseInt(idx.trim())); // 정수로 변환하여 리스트에 추가
			} catch (NumberFormatException e) {
				// 변환 실패 시 무시하거나 로그 처리 가능
				System.err.println("Invalid number format: " + idx);
			}
		}//for
		
		int res = reservation_dao.delete_reservation_check(res_idxs);

		String result = "fail";
		if(res > 0) {
			result = "succ";
		}

		String resultStr = String.format("[{'result':'%s'}]", result);
		return resultStr;
	}

}







