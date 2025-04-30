package dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import vo.PatientVO;

public class LoginDAO {
	SqlSession sqlSession;
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	//모든 회원조회
	public List<PatientVO> SelectList(){
		List<PatientVO> list = sqlSession.selectList("login.patient_list");
		return list;
	}
	
	//회원추가
	public int insertPatient(PatientVO vo) {
		int res = sqlSession.insert("login.insert_patient", vo);
		return res;
	}
	
	//아이디로 회원 조회
	public PatientVO selectPatientById(String pat_id) {
		PatientVO vo = sqlSession.selectOne("login.select_patient_id", pat_id);
		return vo;
	}
	
	//아이디와 비밀번호로 회원조회
	public PatientVO selectPatient(Map<String, Object> map) {
		PatientVO vo = sqlSession.selectOne("login.select_patient", map);
		return vo;
	}
	
	//아이디로 회원조회(인덱스만)
	public int selectPatientIdx(String pat_id) {
		int pat_idx = sqlSession.selectOne("login.select_patient_idx", pat_id);
		return pat_idx;
	}
	
	//인덱스로 회원조회
	public PatientVO selectPatientByIdx(int pat_idx) {
		PatientVO vo = sqlSession.selectOne("login.select_patient_by_idx", pat_idx);
		return vo;
	}
	
	//이메일과 이름으로 회원조회
	public PatientVO selectPatientByEmailAndName(Map<String, String> map) {
		PatientVO vo = sqlSession.selectOne("login.select_patient_by_emailandName", map);
		return vo;
	}
	
	//이메일과 아이디로 회원조회
	public PatientVO selectPatientByEmailAndId(Map<String, String> map) {
		PatientVO vo = sqlSession.selectOne("login.select_patient_by_emailandId", map);
		return vo;
	}
	
	//전화번호로 회원조회
	public PatientVO selectPatientByPatphone(String pat_phone) {
		PatientVO vo = sqlSession.selectOne("login.select_patient_by_phone", pat_phone);
		return vo;
	}
	
}
