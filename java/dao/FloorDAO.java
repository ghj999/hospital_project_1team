package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import vo.FloorVO;

public class FloorDAO {
	
	SqlSession sqlSession;
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public List<FloorVO> selectFloor(){
		List<FloorVO> list = sqlSession.selectList("floor.select_floor");
		return list;
	}
	
	public List<FloorVO> searchFloor(String search_text){
	    List<FloorVO> list = sqlSession.selectList("floor.search_floor", search_text);
		return list;
	}
	
	

}
