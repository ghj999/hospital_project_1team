package controller;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.function.Function;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.ObjectMapper;

import common.Common;
import dao.CallingDAO;
import dao.ProfessorDAO;
import dao.ReservationDAO;
import dao.ScheduleDAO;
import service.HolidayService;
import vo.CallingVO;
import vo.DepartmentVO;
import vo.ProfessorVO;
import vo.ScheduleVO;

@Controller
public class ReservationController {

    // DAO 객체들
    ReservationDAO reservation_dao;
    ProfessorDAO professor_dao;
    ScheduleDAO schedule_dao;
    CallingDAO calling_dao;

    // 서비스 객체
    @Autowired
    private HolidayService holidayService;

    @Autowired
    HttpSession session;

    // Setter 메서드
    public void setReservation_dao(ReservationDAO reservation_dao) {
        this.reservation_dao = reservation_dao;
    }
    public void setProfessor_dao(ProfessorDAO professor_dao) {
        this.professor_dao = professor_dao;
    }
    public void setSchedule_dao(ScheduleDAO schedule_dao) {
        this.schedule_dao = schedule_dao;
    }
    public void setCalling_dao(CallingDAO calling_dao) {
		this.calling_dao = calling_dao;
	}
    
    //예약안내 페이지로 이동
    @RequestMapping("reservation_info_page.do")
    public String reservation_info_page() {
    	return Common.reservation.VIEW_PATH + "reservation_info_page.jsp";
    }
    
    //상담 예약 추가
    @RequestMapping("calling_insert.do")
    @ResponseBody
    public String calling_insert(String name, String tel) {
    	
    	CallingVO vo = new CallingVO();
    	vo.setCalling_name(name);
    	vo.setCalling_tel(tel);
    	
    	int res = calling_dao.calling_insert(vo);
    	
    	String result = "fail";
    	if(res > 0) {
    		result = "succ";
    	}
    	
    	String resultStr = String.format("[{'result':'%s'}]", result);
    	return resultStr;
    }
    
    // 회원 정보 로드
    @RequestMapping("/step1.do")
    public String loadMemberInfo(Model model, Integer pat_idx) {
    	
    	// 세션에서 patient 객체 가져오기
        Object patient = session.getAttribute("patient");

        // 세션에 patient 정보가 없으면 로그인 페이지로 리디렉트
        if (patient == null) {
            return "redirect:/login_page.do";
        }
        
     	// pat_idx가 null이면 0으로 설정
        int nowPatIdx = (pat_idx != null) ? pat_idx : 0;

        // DB에서 데이터를 가져옴
        List<DepartmentVO> list = reservation_dao.select_dept();

        // 대분류별로 그룹화
        Map<String, List<String>> categorizedDepartments = new HashMap<String, List<String>>();
        for (DepartmentVO vo : list) {
            categorizedDepartments.computeIfAbsent(vo.getDept_category(), new Function<String, List<String>>() {
				@Override
				public List<String> apply(String k) {
					return new ArrayList<String>();
				}
			})
                    .add(vo.getDept_name());
        }

        // JSP로 데이터 전달
        model.addAttribute("list", categorizedDepartments);
        return Common.reservation.VIEW_PATH + "step1.jsp?pat_idx=" + nowPatIdx;
    }

    // Step 2: 선택된 진료과의 교수 목록 가져오기
    @RequestMapping("step2.do")
    public String step2_reservation(Model model, String name, String contact) {
        List<ProfessorVO> list = professor_dao.select_professor(name);
        System.out.println(list);
        System.out.println(contact);
        
        model.addAttribute("contact", contact);
        model.addAttribute("list", list);
        //model.addAttribute("pat_idx", pat_idx);
        return Common.reservation.VIEW_PATH + "step2.jsp";
    }

    // Step 3: 교수의 예약 가능한 날짜와 공휴일 정보 가져오기
    @RequestMapping("/step3.do")
    public String step3_reservation(int pro_idx, Model model, String contact) {
        List<ScheduleVO> ableDays = schedule_dao.pro_schedule(pro_idx);
        ProfessorVO vo = professor_dao.select_professor(pro_idx);

        // 올해의 전체 공휴일 가져오기
        int year = LocalDate.now().getYear();
        int month = LocalDate.now().getMonthValue();
        List<String> holidays = holidayService.getHolidays(year, month);

        System.out.println("Holidays in Controller: " + holidays);
        
        model.addAttribute("contact", contact);
        model.addAttribute("vo", vo);

        // 데이터를 JSON으로 변환하여 JSP로 전달
        ObjectMapper mapper = new ObjectMapper();
        try {
            String jsonAbleDays = mapper.writeValueAsString(ableDays);
            String jsonProfessor = mapper.writeValueAsString(vo);
            String jsonHolidays = mapper.writeValueAsString(holidays);

            model.addAttribute("availableDays", jsonAbleDays);
            model.addAttribute("professor", jsonProfessor);
            model.addAttribute("holidays", jsonHolidays);
        } catch (Exception e) {
            e.printStackTrace();
        }

        // JSP로 이동
        return Common.reservation.VIEW_PATH + "step3.jsp";
    }

    // AJAX 요청을 통해 예약된 시간을 가져오기
    @RequestMapping("/hos/getReservedTime.do")
    @ResponseBody
    public List<String> getReservedTimes(String date, int pro_idx) {
        System.out.println("Received Date: " + date);
        System.out.println("Received Professor ID: " + pro_idx);

        // 데이터베이스에서 예약된 시간 조회
        List<String> reservedTimes = reservation_dao.getReservedTimes(date, pro_idx);
        System.out.println("Reserved Times: " + reservedTimes);
        return reservedTimes;
    }
    
    @RequestMapping(value = "/addReservation", method = RequestMethod.POST)
    @ResponseBody
    public String addReservation(@RequestParam("pat_idx") int patIdx, @RequestParam("pro_idx") int proIdx,
                                 @RequestParam("res_time") String resTime, @RequestParam("contact") String contact) {
       System.out.println("pat_idx :" + patIdx +"pro_idx:"+proIdx + "res_time:" + resTime );
        try {
            System.out.println("Received res_time (raw): " + resTime);

             // 시간 정규화
             if (resTime.contains(" ")) {
                 String[] parts = resTime.split(" ");
                 String timePart = parts[1];
                 if (timePart.length() == 4) {
                     resTime = parts[0] + " " + "0" + timePart;
                 }
             }

            System.out.println("Final normalized res_time: " + resTime);           
           
            Map<String, Object> reservationData = new HashMap<String, Object>();
            reservationData.put("pat_idx", patIdx);
            reservationData.put("pro_idx", proIdx);
            reservationData.put("res_time", resTime);
            reservationData.put("contact", contact);

            reservation_dao.insertReservation(reservationData);
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
            return "fail";
        }
    }
    
	@RequestMapping( value ="/res_cancel.do", method = RequestMethod.POST)
	@ResponseBody
	public String cancel_res(int pat_idx, int res_idx) {
		
		int res = reservation_dao.cancel_res(res_idx);

		String result = "no";
		if(res > 0) { 
			result = "yes";
		}
		
		String resultStr = 
				String.format("[{'result' : '%s'}, {'pat_idx' : '%d'}]", result, pat_idx);
		return resultStr; 
    
	}
	
	@RequestMapping("/update_reservation.do")
    public String update_res(int pro_idx, Model model, int res_idx) {
        List<ScheduleVO> ableDays = schedule_dao.pro_schedule(pro_idx);
        ProfessorVO vo = professor_dao.select_professor(pro_idx);
        
        // 올해의 전체 공휴일 가져오기
        int year = LocalDate.now().getYear();
        int month = LocalDate.now().getMonthValue();
        List<String> holidays = holidayService.getHolidays(year, month);

        System.out.println("Holidays in Controller: " + holidays);

        model.addAttribute("vo", vo);

        // 데이터를 JSON으로 변환하여 JSP로 전달
        ObjectMapper mapper = new ObjectMapper();
        try {
            String jsonAbleDays = mapper.writeValueAsString(ableDays);
            String jsonProfessor = mapper.writeValueAsString(vo);
            String jsonHolidays = mapper.writeValueAsString(holidays);

            model.addAttribute("availableDays", jsonAbleDays);
            model.addAttribute("professor", jsonProfessor);
            model.addAttribute("holidays", jsonHolidays);
            model.addAttribute("res_idx", res_idx);
        } catch (Exception e) {
            e.printStackTrace();
        }

        // JSP로 이동
        return Common.reservation.VIEW_PATH + "update_res.jsp";
    }

    // AJAX 요청을 통해 예약된 시간을 가져오기
    @RequestMapping("/hos/getReservedTime2.do")
    @ResponseBody
    public List<String> getReservedTimes1(String date, int pro_idx) {
        System.out.println("Received Date: " + date);
        System.out.println("Received Professor ID: " + pro_idx);

        // 데이터베이스에서 예약된 시간 조회
        List<String> reservedTimes = reservation_dao.getReservedTimes(date, pro_idx);
        System.out.println("Reserved Times: " + reservedTimes);
        return reservedTimes;
    }
	
    
    @RequestMapping(value = "/updateReservation", method = RequestMethod.POST)
    @ResponseBody
    public String updateReservation(@RequestParam("res_idx") int resIdx, 
                                     @RequestParam("pat_idx") int patIdx, 
                                     @RequestParam("pro_idx") int proIdx,
                                     @RequestParam("res_time") String resTime) {
        System.out.println("res_idx: " + resIdx + ", pat_idx: " + patIdx + ", pro_idx: " + proIdx + ", res_time: " + resTime);

        try {
            Map<String, Object> reservationData = new HashMap<String, Object>();
            reservationData.put("res_idx", resIdx);  // 업데이트할 예약의 고유 ID
            reservationData.put("pat_idx", patIdx);
            reservationData.put("pro_idx", proIdx);
            reservationData.put("res_time", resTime);

            // 예약 업데이트 처리
            reservation_dao.updateReservation(reservationData);
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
            return "fail";
        }
    }
	
	
    
}

