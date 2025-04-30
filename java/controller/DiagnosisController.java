package controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import common.Common;
import dao.DiagnosisDAO;
import vo.DiagnosisVO;

@Controller
public class DiagnosisController {
	DiagnosisDAO diagnosisDao;
	public void setDiagnosisDao(DiagnosisDAO diagnosisDao) {
		this.diagnosisDao = diagnosisDao;
	}
	
	//질병목록 조회
	@RequestMapping("/diagnosis_list.do")
	public String select( Model model ) {
		
		List<DiagnosisVO> list = diagnosisDao.selectDiagnosis();
		model.addAttribute("list", list);
		
		System.out.println("s:"+ list.size());
		return Common.Diagnosis.VIEW_PATH + "diagnosis_list.jsp";		
	}

	// 팝업 
	@RequestMapping("/diseaseInfo.do")
	public String getDiseaseInfo(int ill_idx, Model model) {
	    // 질병 정보를 데이터베이스에서 조회
	    DiagnosisVO disease = diagnosisDao.selectDiseaseInfo(ill_idx);
	    
	    // 모델에 조회 결과 추가
	    model.addAttribute("disease", disease);
	    
	    // 팝업 화면으로 이동
	    return Common.Diagnosis.VIEW_PATH + "illness_popup.jsp";
	}	    
}
