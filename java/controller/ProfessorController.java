package controller;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import common.Common;
import dao.ProfessorDAO;
import util.Paging_Design_Professor;
import vo.ProfessorListVO;

@Controller
public class ProfessorController {
	
	@Autowired
	HttpSession session;
	
    ProfessorDAO professorDao;
    public void setProfessorDao(ProfessorDAO professorDao) {
		this.professorDao = professorDao;
	}
    
    // 처음 화면. 매핑 하나 새로 더 만들어서. 
    @RequestMapping("/searchMain.do")
    public String searchHome() {       
    	return Common.Professor.VIEW_PATH + "professor_search.jsp";
	}      
    
    // 전체 조회. 전체 의료진 조회. 페이징 처리
    @RequestMapping("/searchProfessor.do")
    public String list(
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

        String pageMenu = Paging_Design_Professor.getPaging(
        		"searchProfessor.do", nowPage, rowTotal, searchParam,
                Common.Professor.BLOCKLIST, Common.Professor.BLOCKPAGE);
        
        // 현재 페이지의 시작 번호 계산 (전체 게시글 번호를 유지하기 위함)
	    int startIndex = rowTotal - (nowPage - 1) * Common.Professor.BLOCKLIST;
	    
	    // 검색 결과 여부 확인
	    boolean hasResult = (list != null && !list.isEmpty());

        model.addAttribute("list", list);
        model.addAttribute("pageMenu", pageMenu);
        model.addAttribute("startIndex", startIndex);
        model.addAttribute("hasResult", hasResult);
        
        return Common.Professor.VIEW_PATH + "professor_search_result.jsp";
    }
}