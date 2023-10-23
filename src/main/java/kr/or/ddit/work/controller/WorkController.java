package kr.or.ddit.work.controller;

import java.io.File;
import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.approval.mapper.ApprovalMapper;
import kr.or.ddit.approval.vo.ApboxVO;
import kr.or.ddit.approval.vo.DocWriVO;
import kr.or.ddit.common.service.CommonService;
import kr.or.ddit.common.vo.EmpVO;
import kr.or.ddit.common.vo.TbNotificationVO;
import kr.or.ddit.personnel.service.MemberService;
import kr.or.ddit.vo.AuthMenuVO;
import kr.or.ddit.vo.BbsVO;
import kr.or.ddit.vo.WkApVO;
import kr.or.ddit.vo.WorkVO;
import kr.or.ddit.work.service.WkApService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/work")
@Controller
public class WorkController {

	@Autowired
	WkApService wkapService;
	@Autowired
	private CommonService service;
	@Autowired
	private ApprovalMapper approvalMapper;
	@Autowired
	private MemberService ppservice;
	
	@GetMapping("/work")
	public String work(Model model, Principal principal) {
		//회원 한명조회
		String empNo = principal.getName();
		
		WkApVO vo = new WkApVO();
		vo.setWaAper(empNo);
		
		EmpVO empVo = service.SelectEmp(empNo);
		List<WkApVO> listWkap = wkapService.workOneSelect();
		
		model.addAttribute("empVO",empVo);
		model.addAttribute("list",listWkap);
		
        //권한정보
        SecurityContext context = SecurityContextHolder.getContext();
        Authentication authentication = context.getAuthentication();
        log.info("권한설정 log 확인 : " + authentication.getAuthorities());

        //권한별 메뉴 리스트
        List<AuthMenuVO> authMenuList = ppservice.authMenu();   
      
        
        model.addAttribute("authMenuList",authMenuList);
        model.addAttribute("authentication", authentication);

		
		
		return "work/work";
	}
	
	@GetMapping("/member")
	public String memberWork() {
		return "work/MemberWork";
	}
	
	@GetMapping("/detailWork/{waAper}")
	public String detailWork(Model model, @PathVariable String waAper) {
		
		WkApVO wkapVO = new WkApVO();
		wkapVO.setWaAper(waAper);
		
		EmpVO empVo = service.SelectEmp(waAper);
		model.addAttribute("empVO",empVo);
		model.addAttribute("wkapVO",wkapVO);
		
		
		return "work/detailWork";
	}
	
	@ResponseBody
	@GetMapping(value="/test",produces = "application/json;charset=utf-8")
	public List<WkApVO> workSelect() {
		List<WkApVO> list = wkapService.workSelect();
		log.info(list.toString());
		return list;
	}
	
	@ResponseBody
	@Transactional
	@PostMapping(value="/test",produces = "application/json;charset=utf-8")
	public String workInsert(@RequestBody List<WkApVO> wkapVOList, Principal principal) {
		
		log.info("1wkapVOList wkapVOList wkapVOList"+wkapVOList);
		int result = 0;
		for (WkApVO wkApVO : wkapVOList) {
			
		String empNo = wkapService.workAuthSelect();
		String myNo = principal.getName();
		log.debug("여기서 empNo는 무엇인가 ? ",empNo);
		int maxDftNo = wkapService.selectdftNo() +1;
		log.info("1씩 증가 되너요"+maxDftNo);
		
		DocWriVO docWriVO = new DocWriVO();
		docWriVO.setEmpNo(empNo);
		docWriVO.setDftNo(maxDftNo);
		result += wkapService.docInsert(docWriVO);
		
		
		wkApVO.setDftNo(maxDftNo);
		ApboxVO apBoxVO = new ApboxVO();
		apBoxVO.setEmpNo(empNo);
		apBoxVO.setDftNo(maxDftNo);
		result += wkapService.apboxInsert(apBoxVO);
		
		result += wkapService.workInsert(wkApVO);
		
        //알림세팅
        String empNoid   = apBoxVO.getEmpNo();
        String content = "근무신청내용입니다";
        String status  = "N";
        String url     = "/approval/workflow";
        String titel   = "근무신청";
        
        //알림 vo넣기
        TbNotificationVO tbNotificationVO = new TbNotificationVO();
        tbNotificationVO.setNtcnRcverEmpNo(empNoid);
        tbNotificationVO.setNtcnContent(content);
        tbNotificationVO.setNtcnUrl(url);
        tbNotificationVO.setNtcnReadStatus(status);
        tbNotificationVO.setNtcnTitle(titel);
        tbNotificationVO.setNtcnSenderEmpNo(myNo);
        tbNotificationVO.setDftNo(maxDftNo);
        result += approvalMapper.notificationInsert(tbNotificationVO);
		
		}
		
		//return Integer.toString(wkapService.workInsert(wkapVO));
		return result+"";
	}
	
    // 근무 신청 단일 등록
    @ResponseBody
    @PostMapping(value="/workInsert", produces = "application/json;charset=utf-8")
    public int BbsInsert(@RequestBody WkApVO wkapVO, Principal principal) {
    	
  	    log.debug("<<근무 신청 단일 등록 컨트롤러 >> ", wkapVO);
  	    int result = 0;
  	    String empNo = wkapService.workAuthSelect();
  	    String myNo = principal.getName();
  	    int maxDftNo = wkapService.selectdftNo() +1;
  	  
	  	DocWriVO docWriVO = new DocWriVO();
		docWriVO.setEmpNo(empNo);
		docWriVO.setDftNo(maxDftNo);
		result += wkapService.docInsert(docWriVO);
		
		wkapVO.setDftNo(maxDftNo);
		ApboxVO apBoxVO = new ApboxVO();
		apBoxVO.setEmpNo(empNo);
		apBoxVO.setDftNo(maxDftNo);
		result += wkapService.apboxInsert(apBoxVO);
		
		result += wkapService.workInsert(wkapVO);
		
        //알림세팅
        String empNoid   = apBoxVO.getEmpNo();
        String content = "근무신청내용입니다";
        String status  = "N";
        String url     = "/approval/workflow";
        String titel   = "근무신청";
        
        //알림 vo넣기
        TbNotificationVO tbNotificationVO = new TbNotificationVO();
        tbNotificationVO.setNtcnRcverEmpNo(empNoid);
        tbNotificationVO.setNtcnContent(content);
        tbNotificationVO.setNtcnUrl(url);
        tbNotificationVO.setNtcnReadStatus(status);
        tbNotificationVO.setNtcnTitle(titel);
        tbNotificationVO.setNtcnSenderEmpNo(myNo);
        tbNotificationVO.setDftNo(maxDftNo);
        result += approvalMapper.notificationInsert(tbNotificationVO);
  	  
  	  return result;
    }
	
	@ResponseBody
	@PutMapping(value="/test",produces = "application/json;charset=utf-8")
	public String workUpdate(@RequestBody WkApVO wkapVO) {
		return Integer.toString(wkapService.workUpdate(wkapVO));
	}
	
	@ResponseBody
	@DeleteMapping(value="/test/{waNo}",produces = "application/json;charset=utf-8")
	public String workDelete(@PathVariable int waNo) {
		WkApVO wkapVO = new WkApVO();
		wkapVO.setWaNo(waNo);
		return Integer.toString(wkapService.workDelete(wkapVO));
	}
	
	@ResponseBody
	@GetMapping(value="/test/{waAper}",produces = "application/json;charset=utf-8")
	public List<WkApVO> getEmpSelect(@PathVariable String waAper) {
		List<WkApVO> list = wkapService.getEmpSelect(waAper);
		return list;
	}
	
	@ResponseBody
	@GetMapping(value="/workOneSelect",produces = "application/json;charset=utf-8")
	public List<WkApVO> workOneSelect() {
		List<WkApVO> list = wkapService.workOneSelect();
		return list;
	}
	
	@ResponseBody
	@GetMapping(value="/countEMP",produces = "application/json;charset=utf-8")
	public List<WkApVO> countEMP() {
		List<WkApVO> list = wkapService.countEMP();
		return list;
	}
	
	//1개 조회
	@ResponseBody
	@GetMapping(value="/get/{waAper}",produces = "application/json;charset=utf-8")
	public WkApVO OneSelect(@PathVariable String waAper) {
		WkApVO wkapVO = new WkApVO();
		wkapVO.setWaAper(waAper);
		
		return wkapService.OneSelect(wkapVO);
	}

	//사원전체 엑셀파일로 다운로드
	@PostMapping("/downloadExcel")
	@ResponseBody
	public String downloadExcel(HttpServletResponse response) {
	    // 서비스를 통해 직원 데이터를 가져옴
	    List<WkApVO> wkapList = wkapService.workOneSelect();

	    log.info("데이터 잘 받아왔냐?"+wkapList);

	    // 엑셀 파일 생성
	    String directoryPath = "D:\\insightFile"; // 디렉토리 경로
	    String fileName = "employee_list.xlsx"; // 파일 이름

	    // 디렉토리가 존재하지 않으면 생성
	    File directory = new File(directoryPath);
	    if (!directory.exists()) {
	        directory.mkdirs();
	    }

	    String filePath = directoryPath + File.separator + fileName; // 최종 파일 경로

	    wkapService.generateExcelFile(wkapList, filePath, response);

	    return "/insightFile/" + fileName;
	}

	// 근무 타입 리스트 불러오기
	@ResponseBody
	@GetMapping(value="/workTypeList",produces = "application/json;charset=utf-8")
	public List<WorkVO> workTypeList() {
		List<WorkVO> workTypeList = wkapService.workTypeList();
		log.info("<<근무타입 불러오기>> " + workTypeList.toString());
		return workTypeList;
	}
    
}
