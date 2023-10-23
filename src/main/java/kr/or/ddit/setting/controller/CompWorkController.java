package kr.or.ddit.setting.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.setting.service.CompWorkService;
import kr.or.ddit.vo.WorkVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/setting")
@Controller
public class CompWorkController {

	@Autowired
	CompWorkService compWorkSVC;
	
	@ResponseBody
	@PostMapping("/workAdd")
	public String workAdd(@RequestBody WorkVO workVO) {
		log.info("workVO::" + workVO);
		
		return Integer.toString(compWorkSVC.workAdd(workVO));
		
	}
	
	@ResponseBody
	@GetMapping("/getWorkInfo/{wkNo}")
	public WorkVO getWorkInfo(@PathVariable int wkNo) {
		log.info("wkNo::" + wkNo);
		
		return compWorkSVC.getWork(wkNo);
	}
	
	@ResponseBody
	@PostMapping("/workUp")
	public String workUp(@RequestBody WorkVO workVO) {
		log.info("workVO::" + workVO);
		
		return Integer.toString(compWorkSVC.workUp(workVO));
	}
	
	@ResponseBody
	@PostMapping("/workDel")
	public String workDel(@RequestBody int wkNo) {
		log.info("wkNo::" + wkNo);
		
		return Integer.toString(compWorkSVC.workDel(wkNo));
	}
	
	@ResponseBody
	@PostMapping("/workApUp")
	public String workApUp(@RequestBody String empNo) {
		log.info("empNo::" + empNo);
		
		return Integer.toString(compWorkSVC.workApUp(empNo));
	}
}
