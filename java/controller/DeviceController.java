package controller;



import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import common.Common;
import dao.DeviceDAO;
import util.Paging_Design_Device;
import vo.DeviceVO;

@Controller
public class DeviceController {
	
	@Autowired
	HttpSession session;
	
	@Autowired
	HttpServletRequest request; 
	
	@Autowired 
	DeviceDAO deviceDao;
	public void setDeviceDao(DeviceDAO deviceDao) {
		this.deviceDao = deviceDao;
	}
	
	//기기 목록 조회
	@RequestMapping("/device_list.do")
	public String select( Model model, Integer page ) {
		
		System.out.println("hihi");
		
		int nowPage = 1;
		if (page != null) {
			nowPage = page;
		}

		int start = (nowPage - 1) * Common.Device.BLOCKLIST + 1;
		int end = start + Common.Device.BLOCKLIST - 1;
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("start", start);
		map.put("end", end);
			
		List<DeviceVO> list = deviceDao.selectDevice(map);
	
		int row_total = deviceDao.getRowTotal();
		
		// 페이지 메뉴( ◀ 1 2 ▶ ) 생성하기
		String pageMenu = Paging_Design_Device.getPaging("device_list.do", nowPage, row_total, Common.Device.BLOCKLIST,
				Common.Device.BLOCKPAGE);		
		
		model.addAttribute("pageMenu", pageMenu);		
		model.addAttribute("list", list);
		
		return Common.Device.VIEW_PATH + "device_list.jsp";
	}
	
	// 의료 기기 팝업
	@RequestMapping("/deviceInfo.do")
	public String getDeviceInfo(int dev_idx, Model model) {
		//의료기기 정보를 데이터베이스에서 조회
		DeviceVO device = deviceDao.selectDeviceInfo(dev_idx);
		
		//모델에 조회 결과 추가
		model.addAttribute("device", device);
		
		// 팝업 화면으로 이동
		return Common.Device.VIEW_PATH + "device_popup.jsp";		
	}	
	
	// 검색 기능	
	//@Autowired private DeviceService deviceService; // 주입 코드		
	
	/*
	 * @Autowired private DeviceDAO deviceDao;
	 */	
	
	@RequestMapping("/search.do")
	public String searchDevices(
	        @RequestParam(required = false, defaultValue = "") String keyword,
	        @RequestParam(required = false, defaultValue = "name") String searchType, Model model) {

	    if (keyword.trim().isEmpty()) {
	        model.addAttribute("list", Collections.emptyList());
	    } else {
	        try {
	            Map<String, Object> params = new HashMap<String, Object>();
	            params.put("keyword", keyword.trim());
	            params.put("searchType", searchType);

	            System.out.println("Params: " + params);

	            List<DeviceVO> deviceList = deviceDao.searchDevices(params);
	            model.addAttribute("list", deviceList);
	        } catch (Exception e) {
	            System.out.println("Error during search: " + e.getMessage());
	            e.printStackTrace();
	            model.addAttribute("list", Collections.emptyList());
	        }
	    }
	    return Common.Device.VIEW_PATH + "device_list.jsp";
	}	
}