package dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import vo.NoticeVO;

public class NoticeDAO {

	SqlSession sqlSession;
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	//공지사항 전체 조회( 메인 화면 )
	public List<NoticeVO> selectNotList(){
		List<NoticeVO> list = sqlSession.selectList("notice.select_notice_list_main");
		return list;
	}
	
	//공지사항 전체 조회
	public List<NoticeVO> selectNotList( Map<String, Object> map ){
		List<NoticeVO> list = sqlSession.selectList("notice.select_notice_list", map);
		return list;
	}
	
	//공지사항 전체 수
	public int getRowTotal( Map<String, Object> map ) {
		int cnt = sqlSession.selectOne("notice.notice_count", map);
		return cnt;
	}
	
	//공지사항 상세 조회
	public NoticeVO selectNotOne( int not_idx ){
		NoticeVO vo = sqlSession.selectOne("notice.select_notice_one", not_idx);
		return vo;
	}
	
	//이전글 조회
	public NoticeVO preNot( int not_idx ) {
		NoticeVO vo = sqlSession.selectOne("notice.select_pre", not_idx);
		return vo;
	}
	
	//다음글 조회
	public NoticeVO nextNot( int not_idx ) {
		NoticeVO vo = sqlSession.selectOne("notice.select_next", not_idx);
		return vo;
	}
	
	//조회수 증가
	public int update_hits( int not_idx ) {
		int res = sqlSession.update("notice.update_hits", not_idx);
		return res;
	}
	
	//관리자-공지사항 수정
	public int update_notice(NoticeVO vo) {
		int res = sqlSession.update("notice.update_notice", vo);
		return res;
	}
	
	//관리자-공지사항 추가
	public int insert_notice(NoticeVO vo) {
		int res = sqlSession.insert("notice.insert_notice", vo);
		return res;
	}
	
	//관리자-공지사항 삭제
	public int delete_notice(int not_idx) {
		int res = sqlSession.delete("notice.delete_notice", not_idx);
		return res;
	}
	
}
