package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import vo.VolcommentVO;
import vo.VolreplyVO;

public class VolreplyDAO {

	SqlSession sqlSession;
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	//답글 조회
	public List<VolreplyVO> selectVolReply(){
		List<VolreplyVO> list = sqlSession.selectList("volreply.reply_list");
		return list;
	}
	
	//답글 추가
	public int reply_insert(VolreplyVO vo) {
		int res = sqlSession.insert("volreply.insert_reply", vo);
		return res;
	}
	
	//댓글 하나의 답글들 모두 삭제
	public int reply_del_all(int comm_idx) {
		int res = sqlSession.delete("volreply.delete_reply_all", comm_idx);
		return res;
	}
	
	//답글 하나 삭제
	public int reply_delete(int reply_idx) {
		int res = sqlSession.delete("volreply.delete_reply", reply_idx);
		return res;
	}
	
	
}
