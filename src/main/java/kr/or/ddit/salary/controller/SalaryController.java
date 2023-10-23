package kr.or.ddit.salary.controller;

import java.io.IOException;
import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.collections4.map.HashedMap;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.DataFormat;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import kr.or.ddit.common.service.CommonService;
import kr.or.ddit.common.vo.EmpVO;
import kr.or.ddit.personnel.service.MemberService;
import kr.or.ddit.salary.service.PayTplService;
import kr.or.ddit.salary.service.SalaryService;
import kr.or.ddit.salary.vo.PageVO;
import kr.or.ddit.salary.vo.PayDedVO;
import kr.or.ddit.salary.vo.PayTplVO;
import kr.or.ddit.salary.vo.PdHistoryVO;
import kr.or.ddit.salary.vo.SalaryCertVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/salary")
@Controller
public class SalaryController {
	
	@Autowired
	PayTplService payTplService;
	
	@Autowired
	CommonService comService;
	
	@Autowired
	MemberService ppservice;
	
	@Autowired
	SalaryService salaryService;
	
//	//급여정산 홈 화면  (세션에 담는 법)
//	@GetMapping("/home")
//	public String home(HttpSession session) {
//		Map<String,Object> map = new HashMap<String,Object>();
//		map.put("name", "9월 정기 급여");
//		map.put("yymm", "2023년 03월");
//		map.put("payday", "2023-09-30");
//		
//		session.setAttribute("map", map);
//		
//		return "salary/salaryHome"; 
//	}
	
	//급여정산 홈 화면 
	@GetMapping("/home")
	public String home(Principal principal, Model model) {
		String empNo = principal.getName();
		log.info("empNo 나오닝? : " + empNo);
		
		EmpVO vo =  comService.SelectEmp(empNo);
		model.addAttribute("empVO",vo);
		
		return "salary/salaryHome";
	}
		
		
	//지난 정산 내역 화면
	@GetMapping("/pastPayroll")
	public String pastPayroll(Model model) {
		
		//null처리 해줘야함 (아무런 정산내역이 없을때 출력 메시지)
		
		int latestPrYr = salaryService.selectLatestPrYr();
		
		SalaryCertVO scVo = new SalaryCertVO();
		scVo.setPrYr(latestPrYr);
		
		List<SalaryCertVO> pastPayroll = salaryService.selectPastPayroll(scVo);
		
		model.addAttribute("latestPrYr", latestPrYr);
		model.addAttribute("pastPayrollList", pastPayroll);
		
		return "salary/pastPayroll";
	}
	
	//급여정산하기 모달창 form 태그 전송 (post) (다음페이지로 매개변수로 받은 vo 전달)
	@PostMapping(value="/startPR", produces="text/plain;charset=utf-8") 
	public String startPR(@ModelAttribute SalaryCertVO salaryCertVO, HttpSession session) {
		log.info("salaryCertVO 넘어온 값 : " + salaryCertVO);
		// salaryCertVO 넘어온 값 : SalaryCertVO(scNo=null, empNo=null, ptNo=0, scIsdate=null, 
		// prYr=2023, prMth=9, pytlAmt=0, ddtlAmt=0, netAmt=0, prFdate=null, finYn=null, prPdate=2023-09-21, prStlNm=9월 정기급여, prYM=2023-09)
		
		String prYM = salaryCertVO.getPrYM();
		
		int prYr = Integer.parseInt(prYM.split("-")[0]);
		int prMth = Integer.parseInt(prYM.split("-")[1]);
		
		salaryCertVO.setPrYr(prYr);
		salaryCertVO.setPrMth(prMth);
		
		session.setAttribute("SCVO", salaryCertVO); //세션에 값 담음

		
		return "redirect:/salary/wageEmp";
	}
	
	
//	//급여정산하기 모달창 Ajax (세션에 담기)           //세션에 담으면 브라우저 두개 띄우고 8월급여정산, 9월급여정산 따로따로 작업할 때 세션값 충돌이 됨.
//	@ResponseBody
//	@PostMapping(value="/startPR", produces="text/plain;charset=utf-8")    //consumes는 클라이언트->서버 보내는 데이터 타입을 명시. produces는 서버->클라이언트 반환하는 데이터 타입을 명시.
//	public String startPR(@RequestBody SalaryCertVO salaryCertVO, HttpSession session) {
//		log.info("salaryCertVO 넘어온 값 : " + salaryCertVO);
//		// salaryCertVO 넘어온 값 : SalaryCertVO(scNo=null, empNo=null, ptNo=0, scIsdate=null, 
//		// prYr=2023, prMth=9, pytlAmt=0, ddtlAmt=0, netAmt=0, prFdate=null, finYn=null, prPdate=2023-09-21, prStlNm=9월 정기급여)
//		
//		int prYr = salaryCertVO.getPrYr();
//		int prMth = salaryCertVO.getPrMth();
//		String prPdate = salaryCertVO.getPrPdate();
//		String prStlNm = salaryCertVO.getPrStlNm();
//		int ptNo = salaryCertVO.getPtNo();
//		
//		session.setAttribute("prYr", prYr);
//		session.setAttribute("prMth", prMth);
//		session.setAttribute("prPdate", prPdate);
//		session.setAttribute("prStlNm", prStlNm);
//		session.setAttribute("ptNo", ptNo);
//		
//		return "세션에 저장 성공";
//	}
	
	
	
	//정산대상자 선택 화면
	@GetMapping("/wageEmp")
	public String wageEmp(HttpSession session, Model model) {
//	public String wageEmp(@RequestParam int ptNo, Model model) {
		
		SalaryCertVO vo = (SalaryCertVO)session.getAttribute("SCVO");
		log.info("세션 값 나와라? : " + vo);
		
		int ptNo = vo.getPtNo();
		
		PayTplVO payTplVO = payTplService.selectTpl(ptNo);
		String ptNm = payTplVO.getPtNm();
		
		model.addAttribute("ptNm", ptNm);
		
		return "salary/wageEmp";
	}
	
	//정산대상자 사원정보리스트 select (Ajax)
	@ResponseBody
	@PostMapping("/wageEmpListAjax") 
	public Map<String,Object> wageEmpListAjax(@RequestBody PageVO pageVO){
		
//		log.debug("pageVO 나와라 {}", pageVO);
		log.debug("pageVO 나와라 "+ pageVO); //PageVO(total=0, currentPage=3, pageCnt=0, startPage=0, pageSize=15, endPage=0, keyword=null, condition=null)
																
		int total = salaryService.getTotal(pageVO);
		log.info("total 몇개?" + total); //40
		
		int startPage =(pageVO.getCurrentPage()-1) * pageVO.getPageSize() +1;
		
		int endPage = pageVO.getCurrentPage()*pageVO.getPageSize();	
		
		if(endPage > total) {
			endPage = total;
		}
		
		pageVO.setStartPage(startPage);
		pageVO.setEndPage(endPage);
		
		log.info("startPage : " + startPage);
		log.info("endPage : " + endPage);
		
		List<EmpVO> empList = salaryService.selectEmpList(pageVO);
		log.info("empList?? " + empList);
		
		Map<String,Object> pageMap = new HashedMap<String, Object>();
		pageMap.put("total", total);
		pageMap.put("startPage", startPage);
		pageMap.put("endPage", endPage);
		pageMap.put("pageData", empList);
		
		log.debug("pageMap {}",pageMap);
		/* 
		    토탈갯수 : select
		  pageSize: 받아와야하는 값 
		  curPage:  받아와야 함
		  페이지수 : 계산가능 
		  
		*/
		
		return pageMap;
	}
	
	//정산대상자 추가(insert) _ Ajax
	@ResponseBody
	@PostMapping("/checkedEmpList")
	public String checkedEmpList(@RequestBody List<String> checkedEmpList, HttpSession session) { 

		log.info("checkedEmpList : " + checkedEmpList);
		
//		 List<EmpVO> checkedEmpList = new ArrayList<EmpVO>();
		
		
		SalaryCertVO svo = (SalaryCertVO) session.getAttribute("SCVO");
		SalaryCertVO newSvo = new SalaryCertVO(); //세션 객체 데이터 복사
		
		log.info("svo1 : " + svo); //SalaryCertVO(scNo=0, empNo=null, ptNo=1, scIsdate=null, prYr=2023, prMth=9, pytlAmt=0, ddtlAmt=0, netAmt=0, prFdate=null, finYn=null, prPdate=2023-09-30, prStlNm=9월 급여, prYM=2023-09, pdNm=null, pdAmt=0, empNm=null, basePay=0, basicHourWage=0, totalAdmitTime=0, totalExtime=0, totalNightime=0, totalHdtime=0, overtimePay=0, nightimePay=0, hdtimePay=0, totalExPay=0)
		
		int result = 0;
	    
		// checkedEmpList의 각 문자열을 EmpVO 객체로 변환하여 리스트에 추가
	    for (String empNo : checkedEmpList) {
	    	
    		log.info("newSvo1 : " + newSvo); //SalaryCertVO(scNo=0, empNo=null, ptNo=0, scIsdate=null, prYr=0, prMth=0, pytlAmt=0, ddtlAmt=0, netAmt=0, prFdate=null, finYn=null, prPdate=null, prStlNm=null, prYM=null, pdNm=null, pdAmt=0, empNm=null, basePay=0, basicHourWage=0, totalAdmitTime=0, totalExtime=0, totalNightime=0, totalHdtime=0, overtimePay=0, nightimePay=0, hdtimePay=0, totalExPay=0)
	    	
	    	newSvo.setEmpNo(empNo);
	    	newSvo.setPtNo(svo.getPtNo());
	    	newSvo.setPrYr(svo.getPrYr());
	    	newSvo.setPrMth(svo.getPrMth());
	    	newSvo.setPrPdate(svo.getPrPdate());
	    	newSvo.setPrStlNm(svo.getPrStlNm()); //세션 데이터 복사 (세션값 변경 방지)
	        
	        result += salaryService.insertPR(newSvo);
	        
	        log.info("result" + result);
//		        empList.add(empVO);
	    }
	    log.info("svo2 : " + svo); //SalaryCertVO(scNo=0, empNo=null, ptNo=1, scIsdate=null, prYr=2023, prMth=9, pytlAmt=0, ddtlAmt=0, netAmt=0, prFdate=null, finYn=null, prPdate=2023-09-30, prStlNm=9월 급여, prYM=2023-09, pdNm=null, pdAmt=0, empNm=null, basePay=0, basicHourWage=0, totalAdmitTime=0, totalExtime=0, totalNightime=0, totalHdtime=0, overtimePay=0, nightimePay=0, hdtimePay=0, totalExPay=0)
	    log.info("newSvo2 : " + newSvo);//SalaryCertVO(scNo=2, empNo=202309001, ptNo=1, scIsdate=null, prYr=2023, prMth=9, pytlAmt=0, ddtlAmt=0, netAmt=0, prFdate=null, finYn=null, prPdate=2023-09-30, prStlNm=9월 급여, prYM=null, pdNm=null, pdAmt=0, empNm=null, basePay=0, basicHourWage=0, totalAdmitTime=0, totalExtime=0, totalNightime=0, totalHdtime=0, overtimePay=0, nightimePay=0, hdtimePay=0, totalExPay=0)
		    
//	svo1 : SalaryCertVO(scNo=null, empNo=null, ptNo=30, scIsdate=null, prYr=2023, prMth=9, pytlAmt=0, ddtlAmt=0, netAmt=0, prFdate=null, finYn=null, prPdate=2023-09-26, prStlNm=9월 정기급여, prYM=2023-09)
//	svo2 : SalaryCertVO(scNo=null, empNo=202101011, ptNo=30, scIsdate=null, prYr=2023, prMth=9, pytlAmt=0, ddtlAmt=0, netAmt=0, prFdate=null, finYn=null, prPdate=2023-09-26, prStlNm=9월 정기급여, prYM=2023-09)
		    						
	    if(result >= 1) {
	    	return "success";
	    }else {
	    	return "fail";
	    }
		
	}
	
	//정산 - 지급  화면
	@GetMapping("/wagePay")
	public String wagePay(HttpSession session, Model model) throws Exception {
		
		SalaryCertVO scVo = (SalaryCertVO)session.getAttribute("SCVO");
		log.info("scVo 뭐들어있어?? :" + scVo); //SalaryCertVO(scNo=0, empNo=null, ptNo=1, scIsdate=null, prYr=2023, prMth=9, pytlAmt=0, ddtlAmt=0, netAmt=0, prFdate=null, finYn=null, prPdate=2023-09-30, prStlNm=9월 급여, prYM=2023-09, pdNm=null, pdAmt=0, empNm=null, basePay=0, basicHourWage=0, totalAdmitTime=0, totalExtime=0, totalNightime=0, totalHdtime=0, overtimePay=0, nightimePay=0, hdtimePay=0, totalExPay=0)
		
		/////////////////////////////////////////////////////////SalaryCertVO(scNo=17, empNo=202101011, ptNo=1, scIsdate=null, prYr=2023, prMth=9, pytlAmt=0, ddtlAmt=0, netAmt=0, prFdate=null, finYn=null, prPdate=2023-09-27, prStlNm=9월 정기급여, prYM=2023-09)
		int ptNo = scVo.getPtNo();
		
		PayTplVO payTplVO = payTplService.selectTpl(ptNo);
		String ptNm = payTplVO.getPtNm();
		
		///////////////////////////////////////////////////////////////
		//선택한 정산대상자 리스트		
		List<SalaryCertVO> checkedEmpNoList = salaryService.selectCheckedEmpNoList(scVo);
		log.info("checkedEmpNoList: " + checkedEmpNoList);
 		
		List<List<PayDedVO>> pdTotalList = new ArrayList<List<PayDedVO>>();   
		List<SalaryCertVO> exPayList = new ArrayList<SalaryCertVO>();   
		List<SalaryCertVO> basePayList = new ArrayList<SalaryCertVO>();   
		
		SalaryCertVO newScVo = new SalaryCertVO();
		
		for(SalaryCertVO empVo : checkedEmpNoList) {
			
			String empNo = empVo.getEmpNo();
			String empNm = empVo.getEmpNm();
			
			log.info("empNo : " + empNo);
			log.info("empNm : " + empNm);

			newScVo.setEmpNo(empNo);
			newScVo.setPrYr(scVo.getPrYr());
			newScVo.setPrMth(scVo.getPrMth());
			newScVo.setPtNo(scVo.getPtNo());
			
			//기타수당
			List<PayDedVO> pdVOList = salaryService.selectOtherPay(newScVo);
//			EmpVO empBS = salaryService.selectBaseSalary(empVo); //각 선택된 정산대상자마다 기본급 뽑기
			log.info("pdVOList : " + pdVOList);
			
			//ajax의 경우 @responseBody에 내장되어있는 코드 형식. 모델로 forwarding할 때 ObjectMapper로 json문자열로 만들어서 보냄
			ObjectMapper pdVOMapper = new ObjectMapper();
			
			String pdVOListJson= pdVOMapper.writeValueAsString(pdVOList);
			//log.debug("체킁:{}",pdVOMapper.writeValueAsString(pdVOList));
			
			
			model.addAttribute("pdVOList", pdVOList);
			model.addAttribute("pdVOListJson", pdVOListJson);
			
			pdTotalList.add(pdVOList);
			
			//////////////////////////////////////////////////////////////
			//기본급
			//SalaryCertVO(scNo=0, empNo=202309001, ptNo=5, scIsDate=null
			//, prYr=2023, prMth=9, pytlAmt=0, ddtlAmt=0, netAmt=0, prFdate=null
			//, finYn=null, prPdate=null, prStlNm=null, prYM=null, pdNm=null, pdAmt=0
			//, pdNo=0, pdLawYn=null, pdType=null, basePay=0, basicHourWage=0
			//, totalAdmitTime=0, totalExtime=0, totalNightime=0, totalHdtime=0
			//, overtimePay=0, nightimePay=0, hdtimePay=0, totalExPay=0, totalTaxAmt=0
			//, whdTaxAmt=0, scIsNo=0, scIsRsn=null, scType=null, incIsRsn=null, incIsDate=null, prPdateMth=0
			//, prPdateDay=0, prPdateWeekday=null, prFdateMth=0, prFdateDay=0, sumPytlAmt=0, sumDdtlAmt=0
			//, sumNetAmt=0, dnm=null, empBrdt=null, dpdntNum=0, empMail=null, empNm=null, entDate=null
			//, outDate=null, dtcodeNm=null, ptnCodeNm=null
			//, jcodeNm=null, grdCodeNm=null, stClfCdNm=null, svfiName=null, sdate=null, edate=null, taxDate=null)
			SalaryCertVO scEmpVO = salaryService.selectBaseSalary(newScVo); 
			
			basePayList.add(scEmpVO);
			log.info("basePayList : " + basePayList);
			
			/////////////////////////////////////////////////////////////
			// 기본급 / 초과근무수당 - 연장, 야간, 휴일별 금액 각각 산출
			SalaryCertVO exPay = salaryService.selectOverTimePay(newScVo); 
			log.info("exPay :" + exPay);
			
			if(exPay != null) {
				exPay.setEmpNo(empNo);
				exPay.setEmpNm(empNm);
				int overtimePay = exPay.getOvertimePay();
				int nightimePay = exPay.getNightimePay();
				int hdtimePay = exPay.getHdtimePay();
				
				log.info("overtimePay : " + overtimePay);
				log.info("nightimePay : " + nightimePay);
				log.info("hdtimePay : " + hdtimePay);
				
				exPayList.add(exPay);
			}else{
				exPay = new SalaryCertVO();
				log.info("testtest : " + exPay);
				exPay.setEmpNo(empNo);
				log.info("testtest2 : " + exPay);
				exPay.setEmpNm(empNm);
				exPay.setBasicHourWage(scEmpVO.getBasicHourWage());
				exPay.setTotalAdmitTime(0);
				exPay.setTotalExtime(0);
				exPay.setOvertimePay(0);
				exPay.setTotalNightime(0);
				exPay.setNightimePay(0);
				exPay.setTotalHdtime(0);
				exPay.setHdtimePay(0);
				exPay.setTotalExPay(0);
				
				exPayList.add(exPay);
			}
			log.info("exPayList : " + exPayList);
			
		
		}//for끝

		model.addAttribute("ptNm", ptNm);
		model.addAttribute("pdTotalList", pdTotalList);
		model.addAttribute("exPayList", exPayList);
		model.addAttribute("basePayList", basePayList);
		
//		model.addAttribute("empCnt", empCnt);
//		model.addAttribute("sumPdAmt1", sumPdAmt1);
//		model.addAttribute("sumPdAmt2", sumPdAmt2);
//		model.addAttribute("sumPdAmt3", sumPdAmt3);
//		model.addAttribute("sumPdAmt4", sumPdAmt4);
//		model.addAttribute("sumPdAmt5", sumPdAmt5);
//		model.addAttribute("sumPdAmt6", sumPdAmt6);
//		model.addAttribute("sumPdAmt7", sumPdAmt7);
		
		return "salary/wagePay";
	}
	
	
	
	//정산 지급항목 이력 - 기본급 insert (ajax)
	@ResponseBody
	@PostMapping("/insertBasePay")
	public String insertBasePay(@RequestBody SalaryCertVO scVo) {
		
		int insertBPres = salaryService.insertBasePay(scVo);
		
		
		if(insertBPres >= 1) {
	    	return "success";
	    }else {
	    	return "fail";
	    }
	}
	
	//정산 지급항목 이력 - 초과근무수당 insert (ajax)
	@ResponseBody
	@PostMapping("/insertOvertimePay")
	public String insertOvertimePay(@RequestBody SalaryCertVO scVo) {
		
		int insertOtPres = salaryService.insertOvertimePay(scVo);
		
		
		if(insertOtPres >= 1) {
	    	return "success";
	    }else {
	    	return "fail";
	    }
	}
	
	//정산 지급항목 이력 - 기타수당 항목별로 insert (ajax)
	@ResponseBody
	@PostMapping("/insertOtherPay")
	public String insertOtherPay(@RequestBody SalaryCertVO scVo) {
		
		int insertOPres = salaryService.insertOtherPay(scVo);
		
		
		if(insertOPres >= 1) {
	    	return "success";
	    }else {
	    	return "fail";
	    }
	}
	//////////////////////////////////////////////////////////////////////////////////////////
	
	//정산 - 공제 화면
	@GetMapping("/wageDed")
	public String wageDed(HttpSession session, Model model) {
		
		SalaryCertVO scVo = (SalaryCertVO)session.getAttribute("SCVO");
		int ptNo = scVo.getPtNo();
		int prYr = scVo.getPrYr();
		int prMth = scVo.getPrMth();
		
		PayTplVO payTplVO = payTplService.selectTpl(ptNo);
		String ptNm = payTplVO.getPtNm();
		
		///////////////////////////////////////////////////////////////
		//선택한 정산대상자 리스트		
		List<SalaryCertVO> checkedEmpNoList2 = salaryService.selectCheckedEmpNoList(scVo); //민우, 퀘스천수지 (empNo, empNm 들어있음)
		log.info("checkedEmpNoList2 : " + checkedEmpNoList2);
		// [SalaryCertVO(scNo=0, empNo=202308216, ptNo=0, scIsdate=null, prYr=0, prMth=0, pytlAmt=0, ddtlAmt=0, netAmt=0, prFdate=null, finYn=null, prPdate=null, prStlNm=null, prYM=null, pdNm=null, pdAmt=0, pdNo=0, pdLawYn=null, empNm=퀘스천수지, basePay=0, basicHourWage=0, totalAdmitTime=0, totalExtime=0, totalNightime=0, totalHdtime=0, overtimePay=0, nightimePay=0, hdtimePay=0, totalExPay=0, dpdntNum=0, totalTaxAmt=0), SalaryCertVO(scNo=0, empNo=202309001, ptNo=0, scIsdate=null, prYr=0, prMth=0, pytlAmt=0, ddtlAmt=0, netAmt=0, prFdate=null, finYn=null, prPdate=null, prStlNm=null, prYM=null, pdNm=null, pdAmt=0, pdNo=0, pdLawYn=null, empNm=민우, basePay=0, basicHourWage=0, totalAdmitTime=0, totalExtime=0, totalNightime=0, totalHdtime=0, overtimePay=0, nightimePay=0, hdtimePay=0, totalExPay=0, dpdntNum=0, totalTaxAmt=0)]

		
		List<List<SalaryCertVO>> totalEmpDedList = new ArrayList<List<SalaryCertVO>>();   
		List<List<SalaryCertVO>> totalOtherDedList = new ArrayList<List<SalaryCertVO>>();   
//		List<SalaryCertVO> wageDedList = new ArrayList<SalaryCertVO>();   
		
		SalaryCertVO newScVo = new SalaryCertVO(); //세션값 변경될 때 null되는 것 막기 위해 객체 생성해서 변수 옮겨담음.
		
		for(SalaryCertVO empVo : checkedEmpNoList2) { //1명씩 뽑음
		
		String empNo = empVo.getEmpNo();
		String empNm = empVo.getEmpNm();
		
		log.info("empNo : " + empNo);
		log.info("empNm : " + empNm);
		
		newScVo.setEmpNo(empNo);
		newScVo.setPtNo(scVo.getPtNo()); //세션에 있는 값 담음
		newScVo.setPrYr(prYr);
		newScVo.setPrMth(prMth);
		
		//공제항목 - 법정 공제 항목 금액 전체 select (파라미터 : empNo, ptNo) 
		List<SalaryCertVO> LawDedList = salaryService.selectDedSummary(newScVo);
		log.info("LawDedList : " + LawDedList);
		
		//공제항목 - 기타 공제 항목 금액 전체 select (파라미터 : empNo, ptNo) 
		List<SalaryCertVO> OtherDedList = salaryService.selectOtherDed(newScVo);
		log.info("OtherDedList : " + OtherDedList);
		
		//ajax의 경우 @responseBody에 내장되어있는 코드 형식. 모델로 forwarding할 때 ObjectMapper로 json문자열로 만들어서 보냄
//		ObjectMapper pdVOMapper = new ObjectMapper();
		
//		String pdVOListJson= pdVOMapper.writeValueAsString(pdVOList);
		//log.debug("체킁:{}",pdVOMapper.writeValueAsString(pdVOList));
		
		
		model.addAttribute("LawDedList", LawDedList);
		model.addAttribute("OtherDedList", OtherDedList);
//		model.addAttribute("pdVOListJson", pdVOListJson);
		
		totalEmpDedList.add(LawDedList);
		totalOtherDedList.add(OtherDedList);

		}//for끝
		
		log.info("totalOtherDedList" + totalOtherDedList);
		
		model.addAttribute("ptNm", ptNm);
		model.addAttribute("totalEmpDedList", totalEmpDedList);
		model.addAttribute("totalOtherDedList", totalOtherDedList);
		
		return "salary/wageDed";
	}
	
	//정산 공제항목 이력 - 공제항목 insert (법정공제항목, 기타공제항목 쿼리 동일) (ajax)
	@ResponseBody
	@PostMapping("/insertWageDed")
	public String insertWageDed(@RequestBody SalaryCertVO scVo) {
		
		int insertWDres = salaryService.insertWageDed(scVo);
		
		if(insertWDres >= 1) {
	    	return "success";
	    }else {
	    	return "fail";
	    }
	}
	
	////////////////////////////////////////////////////////////////////////////////////////////
	
	//정산 미리보기 페이지 화면
	@GetMapping("/wagePrev")
	public String wagePrev(HttpSession session, Model model) {
		
		SalaryCertVO scVo = (SalaryCertVO)session.getAttribute("SCVO");
		int ptNo = scVo.getPtNo();
		int prYr = scVo.getPrYr();
		int prMth = scVo.getPrMth();
		
		PayTplVO payTplVO = payTplService.selectTpl(ptNo);
		String ptNm = payTplVO.getPtNm();
		
		///////////////////////////////////////////////////////////////
		//선택한 정산대상자 리스트		
		List<SalaryCertVO> checkedEmpNoList3 = salaryService.selectCheckedEmpNoList(scVo); //민우, 퀘스천수지 (empNo, empNm 들어있음)
		log.info("checkedEmpNoList3: " + checkedEmpNoList3);
		// [SalaryCertVO(scNo=0, empNo=202308216, ptNo=0, scIsdate=null, prYr=0, prMth=0, pytlAmt=0, ddtlAmt=0, netAmt=0, prFdate=null, finYn=null, prPdate=null, prStlNm=null, prYM=null, pdNm=null, pdAmt=0, pdNo=0, pdLawYn=null, empNm=퀘스천수지, basePay=0, basicHourWage=0, totalAdmitTime=0, totalExtime=0, totalNightime=0, totalHdtime=0, overtimePay=0, nightimePay=0, hdtimePay=0, totalExPay=0, dpdntNum=0, totalTaxAmt=0), SalaryCertVO(scNo=0, empNo=202309001, ptNo=0, scIsdate=null, prYr=0, prMth=0, pytlAmt=0, ddtlAmt=0, netAmt=0, prFdate=null, finYn=null, prPdate=null, prStlNm=null, prYM=null, pdNm=null, pdAmt=0, pdNo=0, pdLawYn=null, empNm=민우, basePay=0, basicHourWage=0, totalAdmitTime=0, totalExtime=0, totalNightime=0, totalHdtime=0, overtimePay=0, nightimePay=0, hdtimePay=0, totalExPay=0, dpdntNum=0, totalTaxAmt=0)]
		
		
		int payCount = 0;
		int dedCount = 0;
		int paySum = 0;
		int dedSum = 0;
		
		List<List<PdHistoryVO>> empPayHList = new ArrayList<List<PdHistoryVO>>();
		List<List<PdHistoryVO>> empDedHList = new ArrayList<List<PdHistoryVO>>();
		List<EmpVO> empInfoList = new ArrayList<EmpVO>();
		
		SalaryCertVO newScVo = new SalaryCertVO(); //세션값 변경될 때 null되는 것 막기 위해 객체 생성해서 변수 옮겨담음.
		
		for(SalaryCertVO empVo : checkedEmpNoList3) { //1명씩 뽑음
		
			String empNo = empVo.getEmpNo();
			String empNm = empVo.getEmpNm();
			
			log.info("empNo3 : " + empNo);
			log.info("empNm3 : " + empNm);
		
			newScVo.setEmpNo(empNo);
			newScVo.setPtNo(scVo.getPtNo()); //세션에 있는 값 담음
			newScVo.setPrYr(prYr);
			newScVo.setPrMth(prMth);
			
			log.info("newScVo3 : " + newScVo);
			
			//지급항목 수, 공제항목 수
			payCount = salaryService.selectPayCount(newScVo);
			dedCount = salaryService.selectDedCount(newScVo);
			//지급 합, 공제 합
			paySum = salaryService.selectPaySum(newScVo);
			dedSum = salaryService.selectDedSum(newScVo);
			
			log.info("payCount : " + payCount);
			log.info("dedCount : " + dedCount);
			log.info("paySum : " + paySum);
			log.info("dedSum : " + dedSum);
			
			List<PdHistoryVO> payHistoryVO = salaryService.selectPayHistory(newScVo);
			log.info("payHistoryVO : " + payHistoryVO);
			List<PdHistoryVO> dedHistoryVO = salaryService.selectDedHistory(newScVo);
			log.info("dedHistoryVO : " + dedHistoryVO);
			/*[
				PdHistoryVO(pdNo=1, scNo=2, pdNm=기본급, pdType=B0401, pdAmt=8000000, pdTaxYn=B0101), 
				PdHistoryVO(pdNo=3, scNo=2, pdNm=초과근무수당, pdType=B0401, pdAmt=6717789, pdTaxYn=B0101), 
				PdHistoryVO(pdNo=15, scNo=2, pdNm=연구활동비, pdType=B0401, pdAmt=300000, pdTaxYn=B0102), 
				PdHistoryVO(pdNo=16, scNo=2, pdNm=식비, pdType=B0401, pdAmt=200000, pdTaxYn=B0102), 
				PdHistoryVO(pdNo=18, scNo=2, pdNm=123, pdType=B0401, pdAmt=500000, pdTaxYn=B0101), 
				PdHistoryVO(pdNo=20, scNo=2, pdNm=차량운전보조금, pdType=B0401, pdAmt=200000, pdTaxYn=B0102), 
				PdHistoryVO(pdNo=21, scNo=2, pdNm=육아수당, pdType=B0401, pdAmt=700000, pdTaxYn=B0102)
			  ]*/
			
			EmpVO empInfo = salaryService.selectCheckedEmpInfo(newScVo);
			empInfo.setPayHistoryVO(payHistoryVO);
			empInfo.setDedHistoryVO(dedHistoryVO);
			empInfo.setPaySum(paySum);
			empInfo.setDedSum(dedSum);
			
			empInfoList.add(empInfo);
			log.info("empInfoList : " + empInfoList);
			
			empPayHList.add(payHistoryVO);
			empDedHList.add(dedHistoryVO);
		
		}//for끝
		
		log.info("empPayHList" + empPayHList);
		log.info("empDedHList" + empDedHList);
		log.info("empInfoList" + empInfoList);
		
		model.addAttribute("ptNm", ptNm);
		model.addAttribute("payCount", payCount);
		model.addAttribute("dedCount", dedCount);
		model.addAttribute("empInfoList", empInfoList);
		model.addAttribute("empPayHList", empPayHList);
		model.addAttribute("empDedHList", empDedHList);
		
		
		return "salary/wagePrev";
	}
	
	
	//정산 지급총액, 공제총액, 실지급액 UPDATE (ajax)
	@ResponseBody
	@PutMapping("/updateFinalAmt")
	public String updateFinalAmt(@RequestBody SalaryCertVO scVo) {
		
		int updateFinAmtRes = salaryService.updateFinalAmt(scVo);
		
		if(updateFinAmtRes >= 1) {
	    	return "success";
	    }else {
	    	return "fail";
	    }
	}
	
	/////////////////////////////////////////////////////////////////////////////
	
	//정산 결과 페이지 화면  //필요한 파라미터 : ptNo, prYr, prMth
	@GetMapping("/wageRes")
	public String wageRes(HttpSession session, Model model) {
		
		SalaryCertVO scVo = (SalaryCertVO)session.getAttribute("SCVO");
		int ptNo = scVo.getPtNo();
		int prYr = scVo.getPrYr();
		int prMth = scVo.getPrMth();
		
		
		PayTplVO payTplVO = payTplService.selectTpl(ptNo);
		String ptNm = payTplVO.getPtNm();
		
		SalaryCertVO SCSummary = salaryService.selectSCSummary(scVo);
		int empCnt = salaryService.selectEmpCnt(scVo);
		
		model.addAttribute("ptNm", ptNm);
		model.addAttribute("SCSummary", SCSummary);
		model.addAttribute("empCnt", empCnt);
		
		return "salary/wageRes";
	}
	
	//해당 지난정산내역 완료화면으로 form 태그 전송 (post) (다음페이지로 매개변수로 받은 vo 전달)
	@PostMapping("/viewWageRes") 
	public String viewWageRes(@ModelAttribute SalaryCertVO scVo, Model model) {
		log.info("salaryCertVO 넘어온 값(form) : " + scVo);
		
		int prYr = scVo.getPrYr();
		int prMth = scVo.getPrMth();
		int ptNo = scVo.getPtNo();
		
		PayTplVO payTplVO = payTplService.selectTpl(ptNo);
		String ptNm = "";
		if(payTplVO!=null) {
			ptNm = payTplVO.getPtNm();
		}else {
			ptNm = "정기급여";
		}
		SalaryCertVO SCSummary = salaryService.selectSCSummary(scVo);
		int empCnt = salaryService.selectEmpCnt(scVo);
		
		model.addAttribute("SCVO", scVo);
		model.addAttribute("ptNm", ptNm);
		model.addAttribute("SCSummary", SCSummary);
		model.addAttribute("empCnt", empCnt);
		
		return "salary/wageRes";
	}
	
	//해당 정산내역 급여대장 삭제 (ajax) 
	@ResponseBody
	@DeleteMapping("/deletePayroll") 
	public String deletePayroll(@RequestBody SalaryCertVO scVo) {
		log.info("급여대장 삭제버튼 - salaryCertVO 넘어온 값(ajax) : " + scVo);
		
		int deletePRres = salaryService.deletePayroll(scVo);
		log.info("deletePRres : " + deletePRres);
		
		if(deletePRres >= 1) {
	    	return "success";
	    }else {
	    	return "fail";
	    }
	}
	
	//급여명세서 발급 INSERT (파라미터 : scNo, scIsRsn)
	/*
	 INSERT INTO SC_ISSUE(SC_IS_NO, SC_NO, SC_IS_DATE, SC_IS_RSN)
        VALUES(#{scIsNo}, (SELECT SC_NO FROM SALARY_CERT WHERE EMP_NO=#{empNo} 
        AND PT_NO=#{ptNo} AND PR_YR=#{prYr} AND PR_MTH=#{prMth}), 
        SYSDATE, #{scIsRsn})
	 */
	@ResponseBody
	@PostMapping("/insertSC")
	public String insertSC(SalaryCertVO salaryCertVO) {
		log.info("salaryCertVO : " + salaryCertVO);
		
		return "success";
	}
	                                                                                                                         
	//정산 급여대장 엑셀 다운로드
	@ResponseBody
	@PostMapping("/excelDownPayroll")
	public void excelDownPayroll(@RequestBody SalaryCertVO scVo, HttpServletResponse response) throws IOException {
		  //엑셀 파일 하나를 만듭니다
		  Workbook workbook = new SXSSFWorkbook();
		  // 엑셀 파일 내부에 Sheet 를 하나 생성합니다
		  Sheet sheet = workbook.createSheet("payroll");//시트생성. 시트명 : "payroll" 
		  
		  CellStyle cellStyle = workbook.createCellStyle();
		  DataFormat dataFormat = workbook.createDataFormat();
		  cellStyle.setDataFormat(dataFormat.getFormat("yyyy-MM-dd HH:mm:ss")); // 날짜 포맷 지정
		  
		  
		  List<SalaryCertVO> dataList = salaryService.selectExcelDownList(scVo);
		  log.info("dataList" + dataList);
		  
		  // 헤더를 생성합니다
		  int rowIndex = 0;
		  Row headerRow = sheet.createRow(rowIndex++);
		  Cell headerCell1 = headerRow.createCell(0); //첫번째열 (0부터 시작)
		  headerCell1.setCellValue("사원번호"); //셀에 값넣기

		  Cell headerCell2 = headerRow.createCell(1);
		  headerCell2.setCellValue("이름");

		  Cell headerCell3 = headerRow.createCell(2);
		  headerCell3.setCellValue("이메일");

		  Cell headerCell4 = headerRow.createCell(3);
		  headerCell4.setCellValue("입사일");
		  
		  Cell headerCell5 = headerRow.createCell(4);
		  headerCell5.setCellValue("퇴사일");
		  
		  Cell headerCell6 = headerRow.createCell(5);
		  headerCell6.setCellValue("부서");
		  
		  Cell headerCell7 = headerRow.createCell(6);
		  headerCell7.setCellValue("직책");
		  
		  Cell headerCell8 = headerRow.createCell(7);
		  headerCell8.setCellValue("직위");
		  
		  Cell headerCell9 = headerRow.createCell(8);
		  headerCell9.setCellValue("역할(직무)");
		  
		  Cell headerCell10 = headerRow.createCell(9);
		  headerCell10.setCellValue("직급");
		  
		  Cell headerCell11 = headerRow.createCell(10);
		  headerCell11.setCellValue("재직상태");

		  Cell headerCell12 = headerRow.createCell(11);
		  headerCell12.setCellValue("기본급");
		  
		  Cell headerCell13 = headerRow.createCell(12);
		  headerCell13.setCellValue("지급총액");
		  
		  Cell headerCell14 = headerRow.createCell(13);
		  headerCell14.setCellValue("공제총액");
		  
		  Cell headerCell15 = headerRow.createCell(14);
		  headerCell15.setCellValue("실지급액");
		  
		  Cell headerCell16 = headerRow.createCell(15);
		  headerCell16.setCellValue("급여지급일자");
		  
		  // 바디에 데이터를 넣어줍니다
		  
	
		  for (SalaryCertVO vo : dataList) {
		    Row bodyRow = sheet.createRow(rowIndex++);

		    Cell bodyCell1 = bodyRow.createCell(0);
		    bodyCell1.setCellValue(vo.getEmpNo());

		    Cell bodyCell2 = bodyRow.createCell(1);
		    bodyCell2.setCellValue(vo.getEmpNm());
		    
		    Cell bodyCell3 = bodyRow.createCell(2);
		    bodyCell3.setCellValue(vo.getEmpMail());
		    
		    Cell bodyCell4 = bodyRow.createCell(3);
		    bodyCell4.setCellValue(vo.getEntDate());
		    
		    Cell bodyCell5 = bodyRow.createCell(4);
		    bodyCell5.setCellValue(vo.getOutDate());
		    
		    Cell bodyCell6 = bodyRow.createCell(5);
		    bodyCell6.setCellValue(vo.getDnm());
		    
		    Cell bodyCell7 = bodyRow.createCell(6);
		    bodyCell7.setCellValue(vo.getDtcodeNm());
		    
		    Cell bodyCell8 = bodyRow.createCell(7);
		    bodyCell8.setCellValue(vo.getPtnCodeNm());
		    
		    Cell bodyCell9 = bodyRow.createCell(8);
		    bodyCell9.setCellValue(vo.getJcodeNm());
		    
		    Cell bodyCell10 = bodyRow.createCell(9);
		    bodyCell10.setCellValue(vo.getGrdCodeNm());
		    
		    Cell bodyCell11 = bodyRow.createCell(10);
		    bodyCell11.setCellValue(vo.getStClfCdNm());
		    
		    Cell bodyCell12 = bodyRow.createCell(11);
		    bodyCell12.setCellValue(vo.getBasePay());
		    
		    Cell bodyCell13 = bodyRow.createCell(12);
		    bodyCell13.setCellValue(vo.getPytlAmt());
		    
		    Cell bodyCell14 = bodyRow.createCell(13);
		    bodyCell14.setCellValue(vo.getDdtlAmt());
		    
		    Cell bodyCell15 = bodyRow.createCell(14);
		    bodyCell15.setCellValue(vo.getNetAmt());
		    
		    Cell bodyCell16 = bodyRow.createCell(15);
		    bodyCell16.setCellValue(vo.getPrPdate());
		
		  }
		  
		  response.setContentType("ms-vnd/excel");
		  response.setHeader("Content-Disposition", "attach;filename=poiTest.xlsx");
		  workbook.write(response.getOutputStream());
		  workbook.close();
	}
	
			
		
		  
	
}

