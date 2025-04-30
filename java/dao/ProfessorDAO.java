package dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import vo.DepartmentVO;
import vo.ProfessorListVO;
import vo.ProfessorVO;

public class ProfessorDAO {
	SqlSession sqlSession;

	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	// 관리자-교수 전체목록
	public List<ProfessorListVO> selectList() {
		List<ProfessorListVO> list = sqlSession.selectList("reservation.professor_list");
		return list;
	}
	//관리자-진료과 목록
	public List<DepartmentVO> deptList(){
		List<DepartmentVO> list = sqlSession.selectList("pro.department_list");
		return list;
	}
	
	//관리자-의료진 추가
	public int professor_insert(ProfessorVO vo) {
		int res = sqlSession.insert("pro.professor_insert", vo);
		return res;
	}
	
	//관리자-의료진 이름으로 vo조회
	public ProfessorVO professor_nameView(String pro_name) {
		ProfessorVO vo = sqlSession.selectOne("pro.professor_nameView", pro_name);
		return vo;
	}
	
	//관리자-의료진 정보 삭제
	public int professor_delete(int pro_idx) {
		int res = sqlSession.delete("pro.professor_delete", pro_idx);
		return res;
	}
	
	//태윤님파트
	public List<ProfessorVO> select_professor(String name) {
		List<ProfessorVO> list = sqlSession.selectList("pro.professor_list", name);
		return list;
	}
	
	//태윤님파트
	public ProfessorVO select_professor(int pro_idx) {
		ProfessorVO vo = sqlSession.selectOne("pro.select_professor", pro_idx);
		return vo;
	}
	
	//===============================================================================================
	// professor 테이블, department 테이블 조인 후. 전체 조회
	public List<ProfessorListVO> selectJoinList() { 
		List<ProfessorListVO> list = sqlSession.selectList("pro.professor_department_join");
		return list; 
	}	 
	
	// 다시 작성, ProfessorListVO로. ProfessorVO가 아니라.
	public List<ProfessorListVO> selectList(Map<String, Object> map) {
		List<ProfessorListVO> list = sqlSession.selectList("pro.professor_search_page", map);
		return list;
	}

	// 전체 교수 조회
	public List<ProfessorListVO> selectProfessor(Map<String, Object> map) {
		List<ProfessorListVO> list = sqlSession.selectList("pro.professor_list_table", map);
		return list;
	}
	
	// 상세 조회. 즉 검색 기능 - 사용 안할 듯. 
	public List<ProfessorListVO> ProfessorSearch(Map<String, Object> map) {
		List<ProfessorListVO> list = sqlSession.selectList("pro.professor_search_table", map);
		return list;
	}	
	
	// 키워드 검색
	public List<ProfessorVO> searchProfessorByKeyword(String keyword) {
		return sqlSession.selectList("pro.searchProfessor", keyword);
	}

	// 검색 기능
	public List<ProfessorVO> searchProfessor(Map<String, Object> params) {
		List<ProfessorVO> list = sqlSession.selectList("pro.searchProfessor", params);
		return list;
	}

	// 전체 의료진 수
	public int getRowTotal(Map<String, Object> map) {
		int count = sqlSession.selectOne("pro.professor_count", map);
		return count;
	}
	
}
