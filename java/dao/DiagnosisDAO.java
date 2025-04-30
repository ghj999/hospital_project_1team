package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import vo.DiagnosisVO;

@Repository
public class DiagnosisDAO {

	@Autowired
	private SqlSession sqlSession;
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	//부서목록 조회
	public List<DiagnosisVO> selectDiagnosis() {
		List<DiagnosisVO> list = sqlSession.selectList("d.diagnosis_list");
		return list;
		//return sqlSession.selectList("d.diagnosis_list");
	}	
	// 특정 질병 정보 조회
	public DiagnosisVO selectDiseaseInfo(int ill_idx) {
	    return sqlSession.selectOne("d.selectDiseaseInfo", ill_idx);
	}
}
