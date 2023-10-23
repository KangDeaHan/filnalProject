package kr.or.ddit.salary.controller;

import java.security.Principal;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.poi.ss.usermodel.DataFormatter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javafx.scene.input.DataFormat;
import kr.or.ddit.common.vo.EmpVO;
import kr.or.ddit.salary.service.dataManagementService;
import kr.or.ddit.salary.vo.SalaryCertVO;
import kr.or.ddit.setting.vo.CompanyInfoVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/salary")
@Controller

public class dataManagementController {

	@Autowired
	dataManagementService dataManagementService;

	@GetMapping("/dataManagement")
	public String dataManagemenet(Model model) {
		
		//명세서 발급 내역 출력
		List<SalaryCertVO> scIssueList = dataManagementService.selectScIssueList();
		
		model.addAttribute("scIssueList", scIssueList);
		
		return "salary/dataManagement";
	}
	
	@ResponseBody
	@GetMapping("/empMember")
	public List<EmpVO> empMember(@RequestParam("name") String name) {
		log.info("이름 : " + name);
		List<EmpVO> empVOList =  dataManagementService.empList(name);
		log.info("리스트::" + empVOList );
		return empVOList;
	}
	
	//급여명세서 발급하기 버튼 (증명서 insert, 명세서 내용 select)
	@ResponseBody
	@PostMapping("/issueSC")
	public List<SalaryCertVO> issueSC(@RequestBody Map<String, String> data) {
		//컨트롤러 data : {scIsRsn=금융기관제출, empNo=202309001, scNo=7, scType=sc1}
		log.info("컨트롤러 data : " + data);
		
		
		int scNo = Integer.parseInt(data.get("scNo"));
		String empNo = data.get("empNo");
		String scIsRsn = data.get("scIsRsn");
		String scType = data.get("scType");
		
		SalaryCertVO scVo = new SalaryCertVO();
		scVo.setScNo(scNo);
		scVo.setScIsRsn(scIsRsn);
		scVo.setScType(scType);
		scVo.setEmpNo(empNo);
		
		int insertSCres = dataManagementService.insertSC(scVo); //급여명세서 발급사유, 발급일, 명세서 종류, 발급대상자 insert
		List<SalaryCertVO> salaryCert = null;
		if (insertSCres>= 1) {
			salaryCert = dataManagementService.selectSalaryCert(scVo);
			log.info("salaryCert" + salaryCert);
		}
		
		return salaryCert;
	}
	
	//소득세원천징수확인서 발급하기 버튼 (증명서 insert, 증명서 내용 select)
	@ResponseBody
	@PostMapping("/issueIncCert")
	public Map<String, Object> issueIncCert(@RequestBody SalaryCertVO scVo) {
		//컨트롤러 data : {scIsRsn=금융기관제출, empNo=202309001, scNo=7, scType=sc2}
		log.info("컨트롤러 data : " + scVo);
		
		int insertINCres = dataManagementService.insertINC(scVo); //증명서 발급사유, 발급일, 명세서 종류, 발급대상자 insert
		List<SalaryCertVO> taxAmtList = null; 
		List<SalaryCertVO> totalTaxAmtList = null; 
		CompanyInfoVO companyInfo = null;
		EmpVO taxpayerInfo = null;
		Map<String, Object> responseMap = new HashMap<String, Object>();
		SalaryCertVO scIsInfo = null;
		
		if (insertINCres>= 1) {
			taxAmtList = dataManagementService.selectTaxAmt(scVo); //급여귀속연도,귀속월, 원천세액, 납세일자 리스트
			log.info("taxAmtList" + taxAmtList);
			
			totalTaxAmtList = dataManagementService.selectTotalTaxAmt(scVo); //과세총액 리스트
			log.info("totalTaxAmtList" + totalTaxAmtList);
			
			companyInfo = dataManagementService.selectCompanyInfo(); //원천징수의무자 (회사정보)
			log.info("companyInfo" + companyInfo);
			
			taxpayerInfo = dataManagementService.selectTaxpayer(scVo); //납세자 (EMP 정보)
			log.info("taxpayerInfo" + taxpayerInfo);
			
			scIsInfo = dataManagementService.selectScIsInfo(); //방금 발급된 증명서 발급사유 가져오기
			
		    responseMap.put("taxAmtList", taxAmtList);
		    responseMap.put("totalTaxAmtList", totalTaxAmtList);
		    responseMap.put("companyInfo", companyInfo);
		    responseMap.put("taxpayerInfo", taxpayerInfo);
		    responseMap.put("scIsInfo", scIsInfo);
		    
		}
		
		log.info("responseMap" + responseMap);
		
		return responseMap;
	}
	
	@ResponseBody
	@GetMapping("/issueSC2/{scNo}")
	public List<SalaryCertVO> issued2(@PathVariable String scNo) {
		//컨트롤러 data : {scIsRsn=금융기관제출, empNo=202309001, scNo=7, scType=sc1}
		log.info("컨트롤러 data : " + scNo);
		
		SalaryCertVO scVo = new SalaryCertVO();
		scVo.setScNo(Integer.parseInt(scNo));
				
		
		List<SalaryCertVO>	salaryCert = dataManagementService.selectSalaryCert2(scVo);
		log.info("salaryCert" + salaryCert);
		
		
		return salaryCert;
	}
	
	//empNo 선택에 따른 급여명세서 list(모달창에 출력) (파라미터 : empNo) (ajax)
	@ResponseBody
	@PostMapping("/SCList")
	public List<SalaryCertVO> SCList(@RequestBody SalaryCertVO scVo) {
		
		log.info("scVo 나오나요?" + scVo);
		
		List<SalaryCertVO> SCList = dataManagementService.selectSCList(scVo);
		
		return SCList;
	}
	
	//급여명세서
	@GetMapping("/payStub")
	public String payStub(Principal principal) {
		
		String empNo = principal.getName();
		
		SalaryCertVO scVo = new SalaryCertVO();
		scVo.setEmpNo(empNo);
			
		return "salary/payStub";
	}
	
	@ResponseBody
	@GetMapping("/payStubAjax/{year}")
	public List<SalaryCertVO> payStubAjax(Principal principal, @PathVariable String year) {
		
		log.info("연동" + year);
		
		log.info("로그인" + principal.getName());
		
		String empNo = principal.getName();
		
		LocalDate now = LocalDate.now();
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy");
		
		String prYr = now.format(formatter);
		
		SalaryCertVO scVo = new SalaryCertVO();
		scVo.setEmpNo(empNo);
		
		if(year == null) {
			scVo.setPrYr(Integer.parseInt(prYr));
		}else {
			scVo.setPrYr(Integer.parseInt(year));
		}
		
		
		log.info("년도 " + scVo.getPrYr());
		
		List<SalaryCertVO> SCList = dataManagementService.selectPrYrSumNetAmt(scVo);
		log.info("dd?" + SCList) ;
		
		return SCList;
	}
	
	@ResponseBody
	@GetMapping("/loadYear")
	public List<SalaryCertVO> loadYear(Principal principal){
		
		String empNo = principal.getName();
		
		List<SalaryCertVO> SCList = dataManagementService.loadYear(empNo);
		log.info("연도별 쳌" + SCList);
		return SCList;
	}
		
	
}
