package dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import vo.MypagePayVO;
import vo.MypageResListVO;
import vo.PatBoardVO;
import vo.PatientVO;

public class MypageDAO {
	SqlSession sqlSession;
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	//기본정보변경
	public int updatePatientInfo(PatientVO vo) {
		int res = sqlSession.update("mypage.update_patient_info", vo);
		return res;
	}
	
	//비밀번호변경
	public int updatePatientPwd(Map<String, Object> map) {
		int res = sqlSession.update("mypage.update_patient_pwd", map);
		return res;
	}
	
	//회원탈퇴
	public int withdrawalPatient(int pat_idx) {
		int res = sqlSession.delete("mypage.withdrawal_patient", pat_idx);
		return res;
	}
	
	//예약내역조회 (진료과, 교수명, 교수사진, 진료일정, 진료과위치)
	public List<MypageResListVO> selectReservationList(int pat_idx){
		List<MypageResListVO> list = sqlSession.selectList("mypage.select_reservation_list", pat_idx);
		return list;
	}

	//작성글조회
	public List<PatBoardVO> selectPatBoardList(int pat_idx){
		List<PatBoardVO> list = sqlSession.selectList("mypage.select_patboard_list", pat_idx);
		return list;
	}
	
	//작성글내용조회
	public PatBoardVO selectPatBoardDetail(int board_idx){
		PatBoardVO vo = sqlSession.selectOne("mypage.select_patboard_detail", board_idx);
		return vo;
	}
	
	//작성글삭제
	public int deletePatBoard(int board_idx) {
		int res = sqlSession.delete("mypage.delete_pat_board", board_idx);
		return res;
	}
	
	//작성글수정
	public int updatePatBoard(PatBoardVO vo) {
		int res = sqlSession.update("mypage.update_pat_board", vo);
		return res;
	}
	
	//진료비내역조회
	public List<MypagePayVO> selectPaymentList(int pat_idx){
		List<MypagePayVO> list = sqlSession.selectList("mypage.select_payment_list", pat_idx);
		return list;
	}
	
	//진료비내역수정 
	public int updatePaymentList(int res_idx) {
		int res = sqlSession.update("mypage.update_payment_list", res_idx);
		return res;
	}
}
