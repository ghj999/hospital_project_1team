package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import vo.ScheduleVO;

public class ScheduleDAO {
	SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public List<ScheduleVO> pro_schedule(int pro_idx){
		List<ScheduleVO> list = sqlSession.selectList("sche.abledays", pro_idx);
		return list;
	}
	
	//관리자-의료진 일정 추가
	public int schedule_insert(ScheduleVO vo) {
		int res = sqlSession.insert("sche.schedule_insert", vo);
		return res;
	}
	
	//관리자-의료진 일정 삭제
	public int schedule_delete(int pro_idx) {
		int res = sqlSession.delete("sche.schedule_delete", pro_idx);
		return res;
	}
}
