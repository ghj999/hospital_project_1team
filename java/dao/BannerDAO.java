package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import vo.BannerVO;

public class BannerDAO {
	SqlSession sqlSession;
	public void setSqlSesson(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	//배너 모든 이미지 조회(메인화면 띄우기)
	public List<BannerVO> Banner_List() {
		List<BannerVO> list = sqlSession.selectList("banner.banner_list");
		return list;
	}
	
	//관리자-배너 에약여부 수정
	public int updateBanner_chk(BannerVO vo) {
		int res = sqlSession.update("banner.banner_update_chk", vo);
		return res;
	}
	
	//배너 이미지 추가
	public int insertBanner(BannerVO vo) {
		int res = sqlSession.insert("banner.banner_insert",vo);
		return res;
	}
	
	//배너 이미지 삭제
	public int deleteBanner(List<Integer> banner_idxs) {
		int res = sqlSession.delete("banner.banner_delete", banner_idxs);
		return res;
	}
	
	//관리자-배너 파일명 가져오기
	public List<String> getBannerFiles(List<Integer> banner_idxs){
		List<String> list = sqlSession.selectList("banner.baner_getFiles", banner_idxs);
		return list;
	}
	
}





