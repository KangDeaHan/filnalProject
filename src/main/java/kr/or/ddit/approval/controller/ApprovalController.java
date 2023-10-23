package kr.or.ddit.approval.controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.poi.hpsf.Array;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.ObjectMapper;

import kr.or.ddit.approval.service.ApprovalService;
import kr.or.ddit.approval.vo.ApboxVO;
import kr.or.ddit.approval.vo.DocKindVO;
import kr.or.ddit.approval.vo.DocWriVO;
import kr.or.ddit.approval.vo.FixturesVO;
import kr.or.ddit.common.service.CommonService;
import kr.or.ddit.common.vo.DeptVO;
import kr.or.ddit.common.vo.EmpVO;
import kr.or.ddit.common.vo.FileInfoVO;
import kr.or.ddit.common.vo.TbNotiCheckVO;
import kr.or.ddit.common.vo.TbNotificationVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/approval")
public class ApprovalController {
	
	@Autowired
	private ApprovalService approvalService;
	@Autowired
	private CommonService service;
	
	/**
	 * 결제 화면으로 가기 
	 * @return
	 */
	@GetMapping("/workflow")
	public String patment() {
		return "approval/workflow";
	}
	
	/**
	 * 비품신청양식 페이지
	 * @return
	 */
	@GetMapping("/FurnitureApplicationForm")
	public String FurnitureApplicationForm() {
		return "/approval/FurnitureApplicationForm";
	}

	/**
	 * 내가할 일(결제 리스트들)
	 * @return
	 */
	@ResponseBody
	@GetMapping("/myDocList")
	public List<ApboxVO> myDocList(Principal principal) {
		String empNo = principal.getName();
		
		List<ApboxVO> list = approvalService.myDocList(empNo); //비품신청
		
		for (ApboxVO apboxVO : list) { //결제자 추가
			List<ApboxVO> apboxEmplist = approvalService.deptApboxList(apboxVO); //결제자 리스트
			apboxVO.setApboxEmpList(apboxEmplist);
		}
		
		List<ApboxVO> myVacationDocList = approvalService.myVacationDocList(empNo);//휴가신청
		for (ApboxVO apboxVO : myVacationDocList) {
			List<ApboxVO> apboxEmplist = approvalService.deptApboxList(apboxVO);
			apboxVO.setApboxEmpList(apboxEmplist);
			list.add(apboxVO);
		}
		
		List<ApboxVO> myWorkDocList = approvalService.myWorkDocList(empNo);
		for(ApboxVO apboxVO :  myWorkDocList) {
			List<ApboxVO> apboxEmplist = approvalService.deptApboxList(apboxVO);
			apboxVO.setApboxEmpList(apboxEmplist);
			list.add(apboxVO);
		}
		
		List<ApboxVO> myBkDocList = approvalService.myBkList(empNo);
		for (ApboxVO apboxVO : myBkDocList) {
			List<ApboxVO> apboxEmplist = approvalService.deptApboxList(apboxVO);
			apboxVO.setApboxEmpList(apboxEmplist);
			list.add(apboxVO);
		}
		
	
		log.debug("ApprovalController -> list : " + list);
		return list;
	}
	
	/**
	 * 비품신청 INSERT
	 * @param data
	 * @return
	 */
	@ResponseBody
	@PostMapping("/fixApp")
	public String fixApp(@RequestBody List<Object> data, Principal principal) {
		log.info("approval -> data1 " + data);
		log.info("approval -> data2 " + data.get(0));
		log.info("approval -> data3 " + data.get(1));
		
		ObjectMapper minuMapper = new ObjectMapper();
		
		@SuppressWarnings("unchecked")
		List<Object> preFixList = (List<Object>)data.get(0);
		@SuppressWarnings("unchecked")
		List<Object> preapBoxList = (List<Object>)data.get(1);
		
		
		List<FixturesVO> fixList = new ArrayList<FixturesVO>();
		List<ApboxVO> apboxList = new ArrayList<ApboxVO>();
		
		// 이게 뭐하는 짓이얌
		for (Object objVO : preFixList) {
			FixturesVO testMinu =minuMapper.convertValue(objVO, FixturesVO.class);
			fixList.add(testMinu);
		}
		
		// 이게 뭐하는 짓이얌
		for (Object objVO2 : preapBoxList) {
			ApboxVO testLim =minuMapper.convertValue(objVO2, ApboxVO.class);
			apboxList.add(testLim);
		}
		
		log.debug("임:"+ fixList.get(0).getFixName());
		log.debug("민우:"+ fixList.get(0).getDftNo());
		
		String empNo = principal.getName();
		String docKind = (String) data.get(2);
		
		DocWriVO docVo = new DocWriVO();
		docVo.setEmpNo(empNo);
		docVo.setDocKind(docKind);
		
		int result = approvalService.docInsert(docVo, fixList, apboxList);
		
		return result+"";
	}
	
	/**
	 * 문서양식 선택
	 * @return
	 */
	@ResponseBody
	@GetMapping("/writeWork/{docKind}")
	public DocKindVO writeWork(@PathVariable String docKind) {
		log.info(docKind);
		
		DocKindVO vo =  approvalService.selectDocKind(docKind);
		log.info("writeWork-> VO : " + vo);
		
		return vo;
	}
	
	/**
	 * 조직도 출력 
	 * @return
	 */
	@ResponseBody
	@GetMapping("/organizationChart")
	public Map<String,List<DeptVO>> organizationChart(){
		Map<String,List<DeptVO>> map = new HashMap();
		
		List<DeptVO> one = approvalService.organizationChartOne();
		List<DeptVO> two = approvalService.organizationChartTwo();
		
		map.put("one", one);
		map.put("two", two);
		
		log.info("이것은 One입니다" +one);
		log.info("이것은 Two입니다" +two);
		
		return map;
	}
	
	/**
	 * 선택한 사원 1명 조회하기
	 * @param keyword
	 * @return
	 */
	@ResponseBody
	@GetMapping("/selectEmp")
	public EmpVO selectEmp(@RequestParam String keyword) {
		log.info("CommonController->keyword : " + keyword);
		
		String EmpNo = keyword;
		log.info("CommonController->EmpNo : " + EmpNo);
		
		EmpVO vo = service.SelectEmp(EmpNo);
		List<FileInfoVO> myFileList = service.fileSelect(EmpNo);
		vo.setFileList(myFileList);
		log.info("CommonController->vo : " + vo);
		
		return vo;
	}
	
	
	//결제선 update
	@ResponseBody
	@PutMapping(value = "/updateApbox", produces ="application/json; charset=utf-8")
	public String updateApbox(@RequestBody ApboxVO apboxVO, Principal principal) {
		String myEmpNo = principal.getName();
		apboxVO.setEmpNo(myEmpNo);
		log.info("CommonController->apboxVO test : " + apboxVO);
		
		int result = 0;
		if(apboxVO.getApbPro().equals("중요") || apboxVO.getApbPro().equals("중요취소") ) {
			apboxVO.setApbImportant(apboxVO.getApbPro());
			result = approvalService.updateImportant(apboxVO);
		}else {
			result = approvalService.updateApbox(apboxVO);
		}
		return result + "";
	}
	

	/**
	 * 알림갯수 웹소켓으로 보내기
	 * @param principal
	 * @return
	 */
	@ResponseBody
	@GetMapping("/notifucationCount")
	public List<TbNotificationVO> notifucationCount(Principal principal) {
		String empNo = principal.getName();
		
		
		List<TbNotificationVO> list = new ArrayList<TbNotificationVO>();
		
		List<TbNotificationVO> fixList = approvalService.fixNotificationSelect(empNo);
		for (TbNotificationVO vo : fixList) {
			list.add(vo);
		}
		
		List<TbNotificationVO> workList = approvalService.workNotificationSelect(empNo);
		for (TbNotificationVO vo : workList) {
			list.add(vo);
		}
		
		List<TbNotificationVO> vactionList = approvalService.vacationNotificationSelect(empNo);
		for (TbNotificationVO vo : vactionList) {
			list.add(vo);
		}
		return list;
	}
	
	/**
	 * 알림 확인 했을 때
	 * @param tbNotiCheckVO
	 * @return
	 */
	@ResponseBody
	@PostMapping("/notiCheck")
	public String notiCheck(@RequestBody TbNotiCheckVO tbNotiCheckVO, Principal principal) {
		String empNo = principal.getName();
		tbNotiCheckVO.setEmpNo(empNo);
		log.info("CommonController->tbNotiCheckVO : " + tbNotiCheckVO);
		
		int result = approvalService.notiCheckInsert(tbNotiCheckVO);
		
		return result+"";
	}
	
	/**
	 * 나의 문서 상세정보
	 * @param deptNo
	 * @param docKind
	 * @param principal
	 * @return
	 */
	@ResponseBody
	@GetMapping(value="/selectDetailInfo/{deptNo}/{docKind}")
	public ApboxVO selectDetailInfo(@PathVariable int deptNo , @PathVariable String docKind, Principal principal) {
		log.info("이거 꼭 체크" + deptNo + "이거 꼭 2번째 체크" + principal + "이거 꼭 3번째 체크" + docKind );
		String empNo = principal.getName();
		
		ApboxVO vo = new ApboxVO();
		vo.setDftNo(deptNo);
		vo.setEmpNo(empNo);
		
		if(docKind.equals("비품신청")) {
			vo = approvalService.selectDetailInfo(vo); //결제문서
		}else if(docKind.equals("휴가신청")) {
			vo = approvalService.selectDetailVacationInfo(vo);
		}else if(docKind.equals("근무신청")) {
			vo = approvalService.selectDetailWorkInfo(vo);
		}else if(docKind.equals("나의비품")) {
			vo = approvalService.selectMyFix(vo);
		}else if(docKind.equals("휴직신청")) {
			vo = approvalService.selectDetailBkInfo(vo);
		}
		
		List<ApboxVO> list = approvalService.deptApboxList(vo);
		vo.setApboxEmpList(list);
		
		return vo;
	}
	
	/**
	 * 비품신청 페이지
	 * @return
	 */
	@GetMapping("/fixPage")
	public String fixPage() {
		return"approval/fixPage";
	}
	
	/**
	 * 니의 비품신청 List
	 * @param principal
	 * @return
	 */
	@ResponseBody
	@GetMapping("/myFixList")
	public List<FixturesVO> myFixList(Principal principal){
		String empNo = principal.getName();
		List<FixturesVO> list = approvalService.selectMyFixList(empNo);
		ApboxVO apboxVO = new ApboxVO();
		
		for (FixturesVO fixturesVO : list) {
			apboxVO.setDftNo(fixturesVO.getDftNo());
			List<ApboxVO> apboxlist = approvalService.deptApboxList(apboxVO);
			fixturesVO.setApboxList(apboxlist);
		}
		
		return list;
	}
}
