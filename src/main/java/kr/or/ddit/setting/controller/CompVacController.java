package kr.or.ddit.setting.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.common.vo.FileInfoVO;
import kr.or.ddit.setting.service.CompVacService;
import kr.or.ddit.vacation.service.CusMainService;
import kr.or.ddit.vacation.vo.VacTypeVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/setting")
@Controller
public class CompVacController {
	
	@Autowired
	CompVacService compVacSVC;
	@Autowired
	CusMainService cusMainSVC;
	
	@PostMapping("/vacTypeAdd")
	public String vacTypeAdd(VacTypeVO vacTypeVO) {
		log.info("vacTypeVO:::" + vacTypeVO);
		compVacSVC.vacTypeAdd(vacTypeVO);
		
		return "redirect:setVacation";
	}
	
	@ResponseBody
	@GetMapping("/getVacationInfo/{vacTypeNo}")
	public VacTypeVO getVacationInfo(@PathVariable int vacTypeNo) {
		log.info("vacTypeNo:::" + vacTypeNo);
		
		return compVacSVC.getVacType(vacTypeNo);
	}
	
	@ResponseBody
	@PostMapping("/vacTypeUp")
	public String vacTypeUp(@RequestBody VacTypeVO vacTypeVO) {
		log.info("VacTypeVO:::" + vacTypeVO);
		
		return Integer.toString(compVacSVC.vacTypeUp(vacTypeVO));
	}
	
	@ResponseBody
	@PostMapping("/vacTypeDel")
	public String vacTypeDel(@RequestBody String vacTypeNo) {
		log.info("vacTypeNo::" + vacTypeNo);
		
		return Integer.toString(compVacSVC.vacTypeDel(vacTypeNo));
	}
	
	
}
