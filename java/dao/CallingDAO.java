package dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import vo.CallingVO;

public class CallingDAO {
	
	SqlSession sqlSesson;
	public void setSqlsesson(SqlSession sqlSesson) {
		this.sqlSesson = sqlSesson;
	}
	
	//상담예약 추가
	public int calling_insert(CallingVO vo) {
		int res = sqlSesson.insert("calling.insert_calling", vo);
		return res;
	}
	
	//관리자-상담예약 리스트 조회
	public List<CallingVO> selectCallList(Map<String, Object> map){
		List<CallingVO> list = sqlSesson.selectList("calling.calling_list", map);
		return list;
	}
	
	//관리자-상담예약 갯수
	public int getRowTotal(Map<String, Object> map) {
		int count = sqlSesson.selectOne("calling.calling_count",map);
		return count;
	}
	
	//관리자-체크된 예약들 삭제
	public int delete_calling_check(List<Integer> calling_idxs) {
		int res = sqlSesson.delete("calling.delete_calling_check", calling_idxs);
		return res;
	}
	
	//관리자-예약여부 수정하기
	public int update_calling_chk(int calling_idx) {
		int res = sqlSesson.update("calling.update_calling_chk", calling_idx);
		return res;
	}
	
	
}
