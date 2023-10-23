package kr.or.ddit.vacation.controller;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.common.vo.EmpVO;
import kr.or.ddit.vacation.service.AdminVacationListService;
import kr.or.ddit.vacation.vo.BkApplyVO;
import kr.or.ddit.vacation.vo.RsReqstVO;
import kr.or.ddit.vacation.vo.VacApplyVO;
import kr.or.ddit.vacation.vo.VacHoldVO;
import lombok.extern.slf4j.Slf4j;
@Slf4j
@Controller
@RequestMapping("/advct")
public class ADMVacationController {
	
	@Autowired
	private AdminVacationListService adminService;
	
	@GetMapping("/main")
	public String adMain() {
		 return "vacation/adMain";
	}
	
	
	@GetMapping("/vacbk")
	public String vacationSelectList(Principal principal, Model model) {
		String empNo = principal.getName();
			log.info(empNo);
		//휴가 리스트 조회
		List<VacApplyVO> vacList= adminService.vacationSelectList();
			model.addAttribute("vacList",vacList);
					log.info("이건 관리자 휴가 리스트 조회"+vacList);
					
		//휴직 리스트 조회
	    List<BkApplyVO> bkList = adminService.bkSelectList();
	    	model.addAttribute("bkList",bkList);
	    			log.info("이건 휴직 리스트 조회:"+bkList);
			
	    //복직 리스트 조회	
	    List<RsReqstVO> rsList = adminService.rsSelectList();
	   		model.addAttribute("rsList",rsList);
	   				log.info("이건 복직 리스트 조회:"+rsList);
	   				
		return "vacation/adVacBkList";
	}
	
	@GetMapping(value="/annualGive")
	public String annualGive() {
		
		return "vacation/annualGive";
	}
	
	//직원 상세 리스트 조회
	@ResponseBody
	@GetMapping(value="/empList")
	public List<EmpVO> empList(Principal prin) {
			String empNo =prin.getName();
				log.info("empNo@@@"+empNo);
			List<EmpVO> result = adminService.empList();
				log.info("이건 result@@@"+result);
				
		return result;
	}
	
	//연차 부여
	@ResponseBody
	@PostMapping(value="/giveDays",produces = "application/json;charset=utf-8")
	public int giveDaysInsert(Principal principal, @RequestBody VacHoldVO holdVO) {
			String empNo = principal.getName();
				log.info("empNo입니다."+empNo);
				
				holdVO.setEmpNo(empNo);
				
				int vo = adminService.giveDaysInsert(holdVO);
					log.info("vovovovovo"+vo);
		return vo;
		
	}
	//부여 연차 업데이트
	@ResponseBody
	@PutMapping(value="/updateDays")
	public int giveDaysUpdate(Principal principal,@RequestBody VacHoldVO vacHoldVO) {
		
		String empNo = principal.getName();

		vacHoldVO.setEmpNo(empNo);
		
		int result = adminService.giveDaysUpdate(vacHoldVO);
				log.info("@@@@@@@@@@@@@@reulst"+result);
		return result;
	}
}
