package controller_admin;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import common.Common;
import dao.BannerDAO;
import vo.BannerVO;

@Controller
public class AdminController_Banner {

	@Autowired 
	ServletContext app;

	BannerDAO banner_dao;
	public void setBanner_dao(BannerDAO banner_dao) {
		this.banner_dao = banner_dao;
	}

	//관리자-배너 리스트 조회(페이지 이동)
	@RequestMapping("admin_banner_list.do")
	public String admin_banner_list(Model model) {

		List<BannerVO> list = banner_dao.Banner_List();

		model.addAttribute("list", list);
		return Common.Admin.VIEW_PATH + "banner/Admin_Banner_List.jsp";
	}

	//관리자-배너 사용 여부 수정
	@RequestMapping("admin_banner_update.do")
	@ResponseBody
	public String update_chk(int banner_idx, int banner_chk) {

		BannerVO vo = new BannerVO();
		vo.setBanner_idx(banner_idx);
		vo.setBanner_chk(banner_chk);

		int res = banner_dao.updateBanner_chk(vo);

		String result = "fail";
		if(res > 0) {
			result = "succ";
		}

		String resultStr = String.format("[{'result':'%s'}]", result);

		return resultStr; 
	}

	//관리자- 배너 이미지 추가 페이지로 이동
	@RequestMapping("admin_insert_banner_page.do")
	public String insert_banner_page() {
		return Common.Admin.VIEW_PATH + "banner/Admin_Banner_Insert_Form.jsp";
	}

	//관리자- 배너 이미지 추가
	@RequestMapping(value = "admin_banner_insert.do", method = RequestMethod.POST)
	@ResponseBody
	public String insert_banner(@ModelAttribute BannerVO vo) {
	    String fake_path = "/resources/upload/";
	    String real_path = app.getRealPath(fake_path);
	    System.out.println("Real path: " + real_path);

	    MultipartFile photo = vo.getPhoto();
	    String filename = "no_file";

	    if (!photo.isEmpty()) {
	        filename = photo.getOriginalFilename();
	        File saveFile = new File(real_path, filename);
	        if (!saveFile.exists()) {
	            saveFile.mkdirs();
	        } else {
	            long time = System.currentTimeMillis();
	            filename = time + "_" + filename;
	            saveFile = new File(real_path, filename);
	        }
	        try {
	            photo.transferTo(saveFile);
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	    }

	    vo.setBanner_file(filename);

	    int res = banner_dao.insertBanner(vo);
	    System.out.println("Insert Result: " + res);
	    
	    String result = "fail";
		if(res > 0) {
			result = "succ";
		}

		String resultStr = String.format("[{\"result\":\"%s\"}]", result);
		
	    return resultStr;
	}


	//관리자- 선택한 배너 삭제
	@RequestMapping("admin_delete_banner.do")
	@ResponseBody
	public String delete_banner(String banner_idx) {
		
		// 쉼표로 구분된 banner_idx를 리스트로 변환
		List<Integer> banner_idxs = new ArrayList<Integer>();
		String[] idxArray = banner_idx.split(","); // 쉼표로 분리

		for (String idx : idxArray) {
			try {
				banner_idxs.add(Integer.parseInt(idx.trim())); // 정수로 변환하여 리스트에 추가
			} catch (NumberFormatException e) {
				// 변환 실패 시 무시하거나 로그 처리 가능
				System.err.println("Invalid number format: " + idx);
			}
		}
		
		int res = banner_dao.deleteBanner(banner_idxs);

		String result = "fail";
		if(res > 0) {
			result = "succ";
		}

		String resultStr = String.format("[{'result':'%s'}]", result);
		return resultStr;
	}



}




