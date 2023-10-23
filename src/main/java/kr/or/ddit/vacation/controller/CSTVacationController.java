package kr.or.ddit.vacation.controller;


import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.apache.commons.collections4.map.HashedMap;
import org.apache.poi.hpsf.Array;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.ObjectMapper;

import kr.or.ddit.approval.mapper.ApprovalMapper;
import kr.or.ddit.approval.service.ApprovalService;
import kr.or.ddit.approval.vo.ApboxVO;
import kr.or.ddit.approval.vo.DocWriVO;
import kr.or.ddit.personnel.service.MemberService;
import kr.or.ddit.vacation.service.CusMainService;
import kr.or.ddit.vacation.vo.VacApplyVO;
import kr.or.ddit.vacation.vo.VacHoldVO;
import kr.or.ddit.vacation.vo.VacTypeVO;
import kr.or.ddit.vacation.vo.VacationFormVO;
import kr.or.ddit.vo.AuthMenuVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/vct")
@Controller
public class CSTVacationController {
	@Autowired
	private CusMainService cusMainService;
	@Autowired
	MemberService ppservice;
	
	@ResponseBody
	@GetMapping("/main1")
	public String getMain(){
	
		log.info("갔냐?:");
		return "Success";
	}
	
	//사원번호를 조건으로 하여 관리자가 결재 완료하면 자동으로 사용자가 결재확인
	@ResponseBody
	@GetMapping(value="/apstMain2")
	public int apstMain2(Principal principal) {
		
		
		String empNo = principal.getName();
		log.info("결재 상태보는 empNo"+empNo);
		
		int result = cusMainService.apstMain2(empNo);
			log.info("이거는 결재확인할 reuslt"+result);
		return result;
	}
	
	
	@GetMapping( value="/main" ,produces = "application/json;charset=utf-8")
	public String getList(Principal principal,String vacTypeNo,Model model){
		
		String empNo = principal.getName();
		//202309001
		log.info("vacController->empNo:"+empNo);

		//휴가 종류 
		List<VacTypeVO> vaclist = cusMainService.vacType(empNo);
		
		model.addAttribute("vaclist",vaclist);
		
		
		//--------------------------------------------------------------//
		
		//신청내역 조회
		List<VacApplyVO> applyList = cusMainService.selectApplyList(empNo);
		log.info("SelectApplyList->applyList:"+applyList);
		log.info("번호 : " + vacTypeNo);
		
		model.addAttribute("applyList", applyList);
		
		//--------------------------------------------------------------//
		//사원번호를 조건으로 하여 관리자가 결재 완료하면 자동으로 사용자가 결재확인
		//승인상태일때 결재완료 뜸
		int result = cusMainService.apstMain2(empNo);
			log.info("이거는 결재확인할 reuslt:"+result);
		//반려일때 반려라고 뜸
		int result2 = cusMainService.apstMain3(empNo);
			log.info("이거는 결재확인할 reuslt2:"+result2);
			
	     //권한정보 
         SecurityContext context = SecurityContextHolder.getContext();
         Authentication authentication = context.getAuthentication();
         log.info("33?" + authentication.getAuthorities());

	      //권한별 메뉴 리스트
	      List<AuthMenuVO> authMenuList = ppservice.authMenu();   
	      
	        
	        model.addAttribute("authMenuList",authMenuList);
	        model.addAttribute("authentication", authentication);
	
			
		return "vacation/vacMain";
	}
	
	//휴가 신청
	@ResponseBody
	@PostMapping("/mainInsert")
	public String insertVactionApply(Principal principal ,@RequestBody VacApplyVO vacApplyVO){
		//vacApplyVO : VacApplyVO(vaapCode=0, empNo=null, vhCngNo=0, vaapEmp=null, vaapApEmp=null, vaapDays=0, vaapRsn=휴가신청!
		//, vaapApstCode=null, vaapApDate=null, vaapRtRs=null, vaapCcSt=null, vaapCcDate=null, vaapStart=Wed Sep 13 09:00:00 KST 2023, vaapEnd=Fri Sep 15 09:00:00 KST 2023, vaapType=0, vacTypeNo=2)
		String empNo = principal.getName();
		
		vacApplyVO.setEmpNo(empNo);
		log.info("이거는EmpVO" + empNo);
		
		log.info("나왔다.vacApplyVO : " + vacApplyVO);
		int result = cusMainService.insertVacApply(vacApplyVO);
		log.info("이거 result 임" + result);
		
		String vaapCode =Integer.toString(cusMainService.vaapCodeSelect());
		
		
		if(result>0) {//성공
			return vaapCode;
		}else {
			return "fail";
		}
	}
	//내역별 조회
	@ResponseBody
	@GetMapping(value="/main/{vaapCode}")
	public VacApplyVO selectOneApply(Principal principal,@PathVariable int vaapCode) {
		//체크111->vacTypeNo : 3
		
		String empNo = principal.getName();
		System.out.println("체크111->vaapCode : " + vaapCode);
			VacApplyVO vacApplyVO = new VacApplyVO();
			vacApplyVO.setVaapCode(vaapCode);
			vacApplyVO.setEmpNo(empNo);
			log.info("확인용 VO vaapCode : " + vacApplyVO);
		    
			////vaapCode=818, empNo=202309001, vhCngNo=0, vaapEmp=null, vaapApEmp=null, vaapDays=2, vaapRsn=null, vaapApstCode=C0104, vaapApDate=null, vaapRtRs=null, 
			//vaapCcSt=null, vaapCcDate=null, vaapStart=2023-10-06, vaapEnd=2023-10-07, vaapType=null, vacTypeNo=1, vaapDate=null, vacTypeName=연차, vhInfo=근속 기간이 1년 이상인 직원에게 매월마다 1일씩 지급된다.,
			//		vacTypeUseDate=13.0, totalDays=null, dftNo=0, totalDays2=null)
			
			log.info("2222 principal : " + principal);
			System.out.println("체크2222->vaapCode : " + vaapCode);
			VacApplyVO vo = cusMainService.selectOneApply(vacApplyVO);
			log.info("selectOneApply->vo : " + vo);
			
			return vo;
	}
	
	//내역별 삭제
	@ResponseBody
	@PostMapping(value="/main/{vaapCode}")
	public int deleteApply(@PathVariable int vaapCode) {
		VacApplyVO ApplyVO = new VacApplyVO();
		ApplyVO.setVacTypeNo(vaapCode);
		log.info("확인용 VO : " + ApplyVO);
		log.info("여기는 delete----------------------------------------"+vaapCode);
		int vo =cusMainService.deleteApply(vaapCode);
		log.info("deleteApply->>>>>"+vo);
		
		return vo;
	}
	
	//내역별 수정
	@ResponseBody
	@PutMapping(value="/mainUpdate",produces = "application/json;charset=utf-8")
	public int updateApply(@RequestBody VacApplyVO vacApplyVO) {
		
		log.info("수정 VO",vacApplyVO);
		
		return cusMainService.updateApply(vacApplyVO);
	}
	
	//ajax로 여기에 값 넘기기
	@ResponseBody
	@PostMapping(value="/multiInsert")
	public String WriInsert(Principal principal ,@RequestBody List<Object> totalList,Model model, VacApplyVO vacApplyVO ) {
		
		
		String empNo = principal.getName();
		vacApplyVO.setEmpNo(empNo);
		ObjectMapper jinsuMapper = new ObjectMapper();
		
		 VacationFormVO vacationFormVO = jinsuMapper.convertValue(totalList.get(0),VacationFormVO.class);  // 강제 맵핑
		 log.debug("확인1! {}", vacationFormVO);

		 
		List<ApboxVO> apboxListVO = new ArrayList<ApboxVO>();

		 @SuppressWarnings("unchecked")
		List<Object> jinsuList = (List<Object>)totalList.get(1);
		for (Object obj : jinsuList) {
		     ApboxVO  apboxVO= jinsuMapper.convertValue(obj, ApboxVO.class);   // 강제 맵핑!
		     apboxListVO.add(apboxVO);
		}
		log.debug("확인2! {}", apboxListVO);
		 
		 	
		DocWriVO docWriVO = new DocWriVO();
			docWriVO.setEmpNo(empNo);
			log.info("@@@@@여기는 empNo입니다.@@@@@"+empNo);
			
		vacationFormVO.setVaapEmp(empNo);

		
		//1.VAC_APPLY 테이블에 insert
		VacationFormVO vacationFormVO2 = jinsuMapper.convertValue(totalList.get(0), VacationFormVO.class);
		vacationFormVO2.getDftNo();
		
		vacationFormVO2.setEmpNo(empNo);
		
		int result3 =cusMainService.insertVacApply1(vacationFormVO2);
		
		int vaapCode = vacationFormVO2.getVaapCode();
		log.info("WriInsert->vaapCode : " + vaapCode);
		
		vacApplyVO.setVaapCode(vaapCode);
		log.info("vaapCode야 이거 "+vaapCode);
		log.info("vacationFormVO2::" + vacationFormVO2);
		
		//2.VACATIONFORM 테이블에 insert
		vacationFormVO.setVaapCode(vaapCode);
		int result1 = cusMainService.WriInsert(docWriVO, vacationFormVO, apboxListVO);
		log.info("@@@@@여기는 result입니다.@@@@@::"+result1);
		
		//3. VAC_APPLY 테이블의 DFT_NO를 UPDATE
		log.info("WriInsert->vacationFormVO : " + vacationFormVO);
		cusMainService.insertVacApply2(vacationFormVO);
		
		
		int result2 = cusMainService.apstCodeUpdate(vaapCode);
		
		int result = result1 + result2 + result3;
		
		return Integer.toString(result);			
		
	}
	////결재선에서 승인 반려 진행 상황에 따른 조회
	@ResponseBody
	@GetMapping(value="/selectApbox", produces = "application/json;charset=utf-8")
	public Map<String, Object> selectApbox(Principal principal,@RequestParam int vaapCode) {
		String empNo = principal.getName();
			log.info("결재 상태보는 empNo"+empNo);
			
			VacApplyVO vacVO = new VacApplyVO();
			vacVO.setVaapCode(vaapCode);
			log.info("결재 상태보는 vacvo:"+vaapCode);
			
			VacApplyVO vaapVO = cusMainService.selectDftNo(vaapCode);
			log.info("결재 상태보는 vaapVO:"+vaapVO);
			
			ApboxVO apboxVo = new ApboxVO();
			apboxVo.setDftNo(vaapVO.getDftNo()); 
		

			List<ApboxVO> apVO=  cusMainService.selectApbox(apboxVo);
			log.info("결재 상태보는 apBoxVO"+apVO);
			
			
			Map<String, Object> result = new HashMap<String, Object>();
		 		result.put("vaapVO", vaapVO);
		 		result.put("apVO", apVO);
		 			
		 	
		 return result;
	}
	
	@GetMapping(value="/Annual")
	public String DetailAnnual(Model model) {
		
		
		
		//권한정보 
		SecurityContext context = SecurityContextHolder.getContext();
		Authentication authentication = context.getAuthentication();
		log.info("33?" + authentication.getAuthorities());
		
		//권한별 메뉴 리스트
		List<AuthMenuVO> authMenuList = ppservice.authMenu();  
		model.addAttribute("authMenuList",authMenuList);
		model.addAttribute("authentication", authentication);
					
		return "vacation/vacAnnual";
	}
	
	//연차 상세 조회
	@ResponseBody
	@GetMapping(value="/AnList")
	public Map<String, Object> AnnualList(Principal principal,@RequestParam String vhGiveDate , @RequestParam String vaapDate, Model model) {
	
		
		String empNo = principal.getName();
		log.info("empNo:"+empNo);
		
		log.info("이건 giveDate::"+vhGiveDate);
		log.info("이건 vaapDate::"+vaapDate);

		VacHoldVO vo = new VacHoldVO();
		vo.setVhGiveDate(vhGiveDate);
		vo.setEmpNo(empNo);
		log.info("@@여기는 VacHoldVO@@"+vo);
	
	List<VacHoldVO> holdList = cusMainService.DetailAnnual(vo);
			
			
			int result1 = 0;
				for (VacHoldVO vacHoldVO : holdList) {
					result1 += vacHoldVO.getVhGiveDays();
				}
			log.info("result1:::" + result1);
			
			VacApplyVO vo1 = new VacApplyVO();
			vo1.setVaapDate(vaapDate);
			vo1.setEmpNo(empNo);
			log.info("@@여기는 vacApplyVO@@"+vo1);
			
	List<VacApplyVO> holdList2 = cusMainService.DetailAnnual2(vo1);
			
			log.info("이것은 holdList2: "+holdList2);
			
			
			int result2 = 0;
			for(VacApplyVO applyVO : holdList2) {
				result2+= applyVO.getVaapDays();
			}
			log.info("result2::::"+result2);
			
			int result = result1 - result2;
				log.info("최종 result"+result);
				
				int result3[] = new int[3];
				 result3[0] = result1;
				 result3[1] = result2;
				 result3[2] = result;
				
				log.info("result3:::"+result3);

				
			Map<String, Object> total = new HashMap<String, Object>();
				total.put("plusList", result1);
				total.put("minusList", result2);
				total.put("total", result);
				total.put("list1", holdList);
				total.put("list2", holdList2);
				total.put("vo", vo);
				total.put("vo1", vo1);
				
				log.info("이건 map에담은 total"+total);
			
				return total;
	}
	
		
	
}



