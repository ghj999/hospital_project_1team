package dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import vo.PatBoardVO;

public class PatBoardDAO {
	
	SqlSession sqlSession;
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	
	// ---------------------------- 감사합니다 --------------------------------------
	//감사합니다 조회
	public List<PatBoardVO> selectThanks( Map<String, Object> map ){
		List<PatBoardVO> list = sqlSession.selectList("patBoard.thanks_list", map);
		return list;
	}
	
	//감사합니다 게시판 게시글 수
	public int getRowTotal() {
		int cnt = sqlSession.selectOne("patBoard.patBoard_count");
		return cnt;
	}
	
	//감사합니다, 건의합니다 추가
	public int insertJoin(PatBoardVO vo) {
		int res = sqlSession.insert("patBoard.join_insert", vo);
		return res;
	}
	
	
	
	


}
