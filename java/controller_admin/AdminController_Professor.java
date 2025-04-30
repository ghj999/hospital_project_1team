package controller_admin;


import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import common.Common;
import dao.ProfessorDAO;
import dao.ScheduleDAO;
import util.Paging_Design_Admin_Professor;
import vo.DepartmentVO;
import vo.ProfessorListVO;
import vo.ProfessorVO;
import vo.ScheduleVO;

@Controller
public class AdminController_Professor {

	@Autowired
	ServletContext app;

	ProfessorDAO professorDao;
	public void setProfessorDao(ProfessorDAO professorDao) {
		this.professorDao = professorDao;
	}

	ScheduleDAO scheduleDao;
	public void setScheduleDao(ScheduleDAO scheduleDao) {
		this.scheduleDao = scheduleDao;
	}

	// 처음 화면. 매핑 하나 새로 더 만들어서. 
	@RequestMapping("admin_professor_list_before.do")
	public String searchHome() {       
		return Common.Admin.VIEW_PATH + "professor/Admin_Professor_List_Before.jsp";
	}    

	//관리자-모든 의료진 조회
	@RequestMapping("admin_professor_list.do")
	public String admin_professor_list(
			Model model, String searchType, String keyword, Integer page) {

		//페이지
		int nowPage = 1;
		if( page != null ) {
			nowPage = page;
		}

		int start = (nowPage - 1) * Common.Professor.BLOCKLIST + 1;	// 페이징 시작 번호 
		int end = start + Common.Professor.BLOCKLIST - 1;	 // 페이징 끝 번호

		// 파라미터 생성
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("start", start);
		map.put("end", end);

		// 검색 조건 추가
		if (searchType != null && !searchType.equals("all")) {
			if ("search_all".equals(searchType)) {
				map.put("pro_name", keyword);
				map.put("dept_name", keyword);
				map.put("pro_field", keyword);
			} else if ("pro_name".equals(searchType)) {
				map.put("pro_name", keyword);
			} else if ("dept_name".equals(searchType)) {
				map.put("dept_name", keyword);
			} else if ("pro_field".equals(searchType)) {
				map.put("pro_field", keyword);
			}
		}

		// 검색 결과 리스트
		List<ProfessorListVO> list = professorDao.selectProfessor(map);

		// 전체 데이터 개수 조회
		int rowTotal = professorDao.getRowTotal(map);

		// 페이징 메뉴 생성
		String searchParam = String.format(
				"searchType=%s&keyword=%s", searchType, keyword); 

		String pageMenu = Paging_Design_Admin_Professor.getPaging(
				"admin_professor_list.do", nowPage, rowTotal, searchParam,
				Common.Professor.BLOCKLIST, Common.Professor.BLOCKPAGE);

		// 검색 결과 여부 확인
		boolean hasResult = (list != null && !list.isEmpty());

		model.addAttribute("list", list);
		model.addAttribute("pageMenu", pageMenu);
		model.addAttribute("hasResult", hasResult);

		return Common.Admin.VIEW_PATH + "professor/Admin_Professor_List_After.jsp";
	}

	//관리자-의료진 추가 페이지로 이동
	@RequestMapping("admin_professor_insert_form.do")
	public String admin_professor_insert_form(Model model) {

		List<DepartmentVO> list = professorDao.deptList();

		model.addAttribute("list", list);

		return Common.Admin.VIEW_PATH + "professor/Admin_Professor_Insert_Form.jsp";
	}

	//관리자-의료진 추가
	@RequestMapping("admin_professor_insert.do")
	public String admin_professor_insert(ProfessorVO pro_vo, 
			@RequestParam(value = "weekdays", required = false) List<String> weekdays) {

		String fake_path = "/resources/upload/";
		String real_path = app.getRealPath(fake_path);
		System.out.println("절대 경로: " + real_path);

		MultipartFile photo = pro_vo.getPhoto();
		String filename = "no_file";

		//업로드 하고자 하는 파일이 존재한다면
		if(!photo.isEmpty()) {
			filename = photo.getOriginalFilename();

			File saveFile = new File(real_path, filename);

			if(!saveFile.exists()) {
				saveFile.mkdirs();
			}else {
				//동일 파일명 처리
				long time = System.currentTimeMillis();
				filename = String.format("%d_%s", time, filename);
				saveFile = new File(real_path, filename);
			}

			//실제로 파일을 절대경로에 생성
			try {
				photo.transferTo(saveFile);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}//if

		pro_vo.setPro_file(filename);

		//vo의 정보를 가지고 의료진 정보 추가
		int res1 = professorDao.professor_insert(pro_vo);

		if(res1 > 0) {
			// 이름으로 pro_idx 조회
			ProfessorVO new_pro_vo = professorDao.professor_nameView(pro_vo.getPro_name());

			// weekdays 배열이 비어있지 않으면 반복 처리
			if (weekdays != null && !weekdays.isEmpty()) {
				for (String weekday : weekdays) {
					// String을 int로 변환
					int day = Integer.parseInt(weekday);

					// ScheduleVO에 데이터 설정
					ScheduleVO sche_vo = new ScheduleVO();
					sche_vo.setPro_idx(new_pro_vo.getPro_idx());
					sche_vo.setWeekday(day);

					// scheduleDao.schedule_insert를 호출하여 일정 추가
					int res2 = scheduleDao.schedule_insert(sche_vo);
					if (res2 > 0) {
						System.out.println("일정 추가 성공: " + day);
					} else {
						System.out.println("일정 추가 실패: " + day);
					}
				}
			}
		}
		return Common.Admin.VIEW_PATH + "professor/Admin_Professor_List_Before.jsp";
	}

	//관리자-의료진 삭제
	@RequestMapping("admin_professor_delete.do")
	@ResponseBody
	public String admin_professor_delete(int pro_idx){
		
		int res1 = professorDao.professor_delete(pro_idx);
		int res2 = scheduleDao.schedule_delete(pro_idx);
		
		String result = "fail";
		if(res1 > 0 && res2 > 0) {
			result = "succ";
		}

		String resultStr = String.format("[{'result':'%s'}]", result);
		return resultStr;
	}



}
