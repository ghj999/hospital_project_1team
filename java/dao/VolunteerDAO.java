package dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import vo.PatientVO;
import vo.VolunteerVO;

public class VolunteerDAO {
	
	SqlSession sqlSession;
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	//자원봉사 조회
	public List<VolunteerVO> selectVol( Map<String, Object> map ){
		List<VolunteerVO> list = sqlSession.selectList("volunteer.vol_list", map);
		return list;
	}
	
	//자원봉사 전체 수
	public int getRowTotal( Map<String, Object> map ) {
		int cnt = sqlSession.selectOne("volunteer.volunteer_count", map);
		return cnt;
	}
	
	//상세보기 조회
	public VolunteerVO selectVolOne(int vol_idx) {
		VolunteerVO vo = sqlSession.selectOne("volunteer.vol_one", vol_idx);
		return vo;
	}
	
	//상세보기 조회 (환자 이름)
	public PatientVO selectPatInfo(int pat_idx) {
		PatientVO vo = sqlSession.selectOne("volunteer.pat_info", pat_idx);
		return vo;
	}
	
	//이전글
	public VolunteerVO preVol(int vol_idx) {
		VolunteerVO vo = sqlSession.selectOne("volunteer.select_pre", vol_idx);
		return vo;
	}
	
	//다음글
	public VolunteerVO nextVol(int vol_idx) {
		VolunteerVO vo = sqlSession.selectOne("volunteer.select_next", vol_idx);
		return vo;
	}
	
	//조회수 증가
	public int update_hits( int vol_idx ) {
		int res = sqlSession.update("volunteer.update_hits", vol_idx);
		return res;
	}
	
	//관리자-자원봉사 추가
	public int insert_volunteer(VolunteerVO vo) {
		int res = sqlSession.update("volunteer.insert_volunteer", vo);
		return res;
	}
	
	//관리자-자원봉사 삭제
	public int volunteer_delete(int vol_idx) {
		int res = sqlSession.update("volunteer.delete_volunteer", vol_idx);
		return res;
	}
	
	
	
	
}
