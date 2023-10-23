package kr.or.ddit.setting.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.setting.service.CompHoliService;
import kr.or.ddit.setting.vo.CompanyHoliVO;
import kr.or.ddit.setting.vo.CompanyInfoVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/setting")
@Controller
public class CompHoliController {
	
	@Autowired
	private CompHoliService compHoliSVC;

	@ResponseBody
	@PostMapping(value = "/companyHoliday/update")
	public List<CompanyHoliVO> updateCompanyHoli(CompanyInfoVO companyInfoVO) {
		log.debug("companyInfoVO : " + companyInfoVO);
		
		List<CompanyHoliVO> companyHoliVOList = companyInfoVO.getCompanyHoliVOList();
		
		for (CompanyHoliVO companyHoliVO : companyHoliVOList) {
			if(companyHoliVO.getCohYn().equals("true")) {
				companyHoliVO.setCohYn("Y");
			} else if(companyHoliVO.getCohYn().equals("false")) {
				companyHoliVO.setCohNo(0);
			}
			compHoliSVC.compHoliUpdate(companyHoliVO);			
		}
		
		List<CompanyHoliVO> list = compHoliSVC.compHoliSelect();
		log.debug("업데이트후 compHoliVO: " + list);
		
		return list;
		
	}
	
	@ResponseBody
	@PostMapping("/companyHoliday/delete")
	public String deleteCompanyHoli(@RequestBody int cohNo) {
		log.debug("12312421: " + cohNo);
	    return Integer.toString(compHoliSVC.compHoliUpdate2(cohNo));
	}
	
	@ResponseBody
	@PostMapping("/companyHoliday/holiAdd")
	public String addHoli(@RequestBody CompanyHoliVO companyHoliVO) {
		if(companyHoliVO.getCohEsntlYn().equals("true")) {
			companyHoliVO.setCohEsntlYn("Y");
		} else if(companyHoliVO.getCohEsntlYn().equals("false")) {
			companyHoliVO.setCohEsntlYn("N");
		} 
		if(companyHoliVO.getCohRepeatYn().equals("true")) {
			companyHoliVO.setCohRepeatYn("Y");
		} else if(companyHoliVO.getCohRepeatYn().equals("false")) {
			companyHoliVO.setCohRepeatYn("N");
		}
		log.debug("holiAdd확인:" + companyHoliVO);
		int result = compHoliSVC.compHoliAdd(companyHoliVO);
		log.info("result::" + result);
		return Integer.toString(compHoliSVC.maxCohNoSelect());
	}
	
	@ResponseBody
	@PostMapping("/companyHoliday/remove")
	public String removeCompanyHoli(@RequestBody String cohNo) {
		log.debug("remove 파라미터 cohNo: " + cohNo);
	    return Integer.toString(compHoliSVC.compHoliRemove(cohNo));
	}
	
	@ResponseBody
	@PostMapping("searchCompHoli")
	public String searchCompHoli(@RequestBody String cohNo) {
		log.debug("cohNo::" + cohNo);
		
		return Integer.toString(compHoliSVC.searchCompHoli(cohNo));
	}
	
}
