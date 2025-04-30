package dao;

import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import vo.DeviceVO;

@Repository
public class DeviceDAO {

	/*
	 * @Autowired private SqlSession sqlSession;
	 */
		
	SqlSession sqlSession; 
	public void setSqlSession(SqlSession sqlSession) {
	this.sqlSession = sqlSession;
	}
	 	
	//기기 목록 조회
	public List<DeviceVO> selectDevice(Map<String, Integer> map) {
		List<DeviceVO> list = sqlSession.selectList("m.medical_device_list", map);
		return list;
	}
	
	// 전체 게시글 수
	public int getRowTotal() {
		int cnt = sqlSession.selectOne("m.device_count");
		return cnt;
		}
	
	// 특정 기기 정보 조회
	public DeviceVO selectDeviceInfo(int dev_idx) {
		return sqlSession.selectOne("m.selectDeviceInfo", dev_idx);
	}	
	
	 // 키워드 검색 
	public List<DeviceVO> searchDevicesByKeyword(String keyword ) { 
	// MyBatis XML에 정의된 "m.searchDevices" 쿼리를 호출 
	  return sqlSession.selectList("m.searchDevices", keyword); }
	 
	// 검색 조건을 받아서 MyBatis 매퍼 쿼리를 실행	
	public List<DeviceVO> searchDevices(Map<String, Object> params) {
	    System.out.println("Executing query with params: " + params);
	    return sqlSession.selectList("m.searchDevices", params);
	}	
}