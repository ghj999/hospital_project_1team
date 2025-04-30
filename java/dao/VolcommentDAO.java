package dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import vo.VolcommentVO;

public class VolcommentDAO {
	
	SqlSession sqlSession;
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	//댓글 조회
	public List<VolcommentVO> selectVolComm(Map<String, Object> map) {
		List<VolcommentVO> list = sqlSession.selectList("volcomment.comm_list", map);
		return list;
	}
	
	//댓글 수
	public int getRowTotal(int vol_idx) {
		int cnt = sqlSession.selectOne("volcomment.comm_count", vol_idx);
		return cnt;
	}
	
	//댓글 추가
	public int comm_insert( VolcommentVO vo) {
		int res = sqlSession.insert("volcomment.insert_comm", vo);
		return res;
	}
	
	//댓글 삭제
	public int comm_del( int comm_idx ) {
		int res = sqlSession.delete("volcomment.del_comm", comm_idx);
		return res;
	}
	
	
	
	
}
