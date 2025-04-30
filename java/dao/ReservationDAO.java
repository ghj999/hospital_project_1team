package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import vo.DepartmentVO;
import vo.ManageReservationVO;
import vo.ReservationVO;

public class ReservationDAO {

	SqlSession sqlSession;
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	//진료과 조회
	public List<DepartmentVO> select_dept(){
		List<DepartmentVO> list = sqlSession.selectList("dept.dept_list");
		return list;
	}

	//태윤 - 진료가능 시간 조회
	public List<String> getReservedTimes(String date, int professorId) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("date", date);
		params.put("pro_idx", professorId);
		return sqlSession.selectList("reservation.getReservedTimes", params);
	}

	//태윤 - 진료 예약
	public void insertReservation(Map<String, Object> reservationData) {
		sqlSession.insert("reservation.insertReservation", reservationData);
	}
	//태윤 - 예약 취소
	public int cancel_res(int res_idx) {
		int res = sqlSession.delete("reservation.cancel_res", res_idx);
		return res;
	}
	//태윤 - 예약 수정
	public void updateReservation(Map<String, Object> reservationData) {
		sqlSession.update("reservation.updateReservation", reservationData);
	}
	//==========================================================================================================
	//관리자-모든예약 조회
	public List<ManageReservationVO> reservation_selectList(Map<String, Object> map){
		List<ManageReservationVO> list = sqlSession.selectList("reservation.reservation_list", map);
		return list;
	}

	//관리자-모든예약 갯수
	public int reservationCount(Map<String, Object> map) {
		int count = sqlSession.selectOne("reservation.reservation_count");
		return count;
	}

	//관리자-예약삭제
	public int delete_reservation_check(List<Integer> res_idxs) {
		int res = sqlSession.delete("reservation.reservation_manage_delete", res_idxs);
		return res;
	}
	
}



