package kr.or.ddit.vacation.controller;

import java.io.File;
import java.io.IOException;
import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.swing.filechooser.FileNameExtensionFilter;

import org.apache.commons.collections4.map.HashedMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.databind.ObjectMapper;

import kr.or.ddit.approval.vo.ApboxVO;
import kr.or.ddit.approval.vo.DocWriVO;
import kr.or.ddit.common.vo.EmpVO;
import kr.or.ddit.common.vo.FileInfoVO;
import kr.or.ddit.personnel.service.MemberService;
import kr.or.ddit.vacation.service.CusBkApplyService;
import kr.or.ddit.vacation.service.CusMainService;
import kr.or.ddit.vacation.vo.BkApplyVO;
import kr.or.ddit.vacation.vo.RsReqstVO;
import kr.or.ddit.vacation.vo.VacApplyVO;
import kr.or.ddit.vo.AuthMenuVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/vct")
@Controller
public class CSTBreakController {
	
	@Autowired
	private CusBkApplyService cusBkApplyService;
	@Autowired
	MemberService ppservice;
	@ResponseBody
	@GetMapping(value="/bkApply1")
	public String EmpInfo(Principal principal) {
			log.info("여기는 ");
			
			
			
		return "vacation/bkApply";
	}
	//사원조회
	@ResponseBody
	@GetMapping(value="/bkApply/{empNo}",produces = "application/json;charset=utf-8")
	public EmpVO selectEmp(Principal principal,@PathVariable String empNo) {
		log.info("잘왔어?--------------------------------------------------");
		
		String empno = principal.getName();
		log.info("principalNo:"+empno);
		
		
		EmpVO vo = cusBkApplyService.EmpSelect(empno);
		log.info("cusBkApplyService-->vo"+vo);
		
		return vo;
	}
	//휴직신청
	@ResponseBody
	@PostMapping(value="/bkApply")
	public String insertBkApply(Principal principal,@RequestBody BkApplyVO bkApplyVO,FileInfoVO fileInfoVO) {

//		cusBkApplyService.bkApplyFileSnInsert();
		
		String empNo = principal.getName();
		bkApplyVO.setEmpNo(empNo);
//		int fileSn = cusBkApplyService.selectFileSn(bkNo);
//		bkApplyVO.setFileSn(fileSn);
		log.info("@@empNo-->@@"+empNo);
		log.info("@@bkApplyVO-->vo@@"+bkApplyVO);
		int result= cusBkApplyService.insertBkApply(bkApplyVO);
		log.info("result-->"+result);
		
		
		
		
		return "success";
	}
	//모달휴직신청
	@ResponseBody
	@PostMapping(value="/bkApply1")
	public String insertBkApply1(Principal principal,@RequestBody BkApplyVO bkApplyVO,FileInfoVO fileInfoVO,BkApplyVO bkNo) {
		
//		cusBkApplyService.bkApplyFileSnInsert();
		
		String empNo = principal.getName();
		bkApplyVO.setEmpNo(empNo);
//		int fileSn = cusBkApplyService.selectFileSn(bkNo);
//		bkApplyVO.setFileSn(fileSn);
		log.info("@@empNo-->@@"+empNo);
		log.info("@@bkApplyVO-->vo@@"+bkApplyVO);
		int result= cusBkApplyService.insertBkApply1(bkApplyVO);
		log.info("result-->"+result);
		
		
		return "success";
	}
	
	
	//나의 휴직 리스트
	@ResponseBody
	@GetMapping("/myVacationList")
	public List<BkApplyVO> myVacationList(Principal principal) {
		
	    String empNo = principal.getName();
	    log.info("여기는 로그인 아이디-->" + empNo);
	    
	    List<BkApplyVO> applyList = cusBkApplyService.getSelect(empNo);
	    log.info("list--->" + applyList);
	    
	    for (BkApplyVO bkApplyVO : applyList) {
	    	if(bkApplyVO.getDftNo() > 0) {
	    		List<ApboxVO> apBoxList = cusBkApplyService.apBoxList(bkApplyVO.getDftNo());
	    		bkApplyVO.setApBoxList(apBoxList);
	    	}
		}
		return applyList;
	}
	
	//휴직신청내역조회
	@GetMapping(value="/bkApply",produces = "application/json;charset=utf-8")
	public String getSelect(Principal principal, Model model) {
		
	    String empNo = principal.getName();
	    log.info("여기는 로그인 아이디-->" + empNo);
	    
	    List<BkApplyVO> applyList = cusBkApplyService.getSelect(empNo);
	    log.info("list--->" + applyList);
	    
	    model.addAttribute("applyList",applyList);
	    
	    //복직신청 내역조회
	    List<RsReqstVO> empList = cusBkApplyService.selectRsList(empNo);
		model.addAttribute("empList",empList);
		log.info("이건 empList"+empList);
		
		//권한정보 
        SecurityContext context = SecurityContextHolder.getContext();
        Authentication authentication = context.getAuthentication();
        log.info("33?" + authentication.getAuthorities());

        //권한별 메뉴 리스트
        List<AuthMenuVO> authMenuList = ppservice.authMenu();  
        model.addAttribute("authMenuList",authMenuList);
		model.addAttribute("authentication", authentication);
		
		//결재완료및 반려 표시
//		List<BkApplyVO> bkApplyVOList = cusBkApplyService.bkNo();
//		Map<Integer, Integer> map = new HashMap<Integer, Integer>();
//		int returnResult = 0;
//		for (BkApplyVO bkApplyVO : bkApplyVOList) {
//			int bkNo = bkApplyVO.getBkNo();
//			
//			
//			BkApplyVO bkapVO = cusBkApplyService.dftNoSelect(bkNo);
//			log.info("결재 상태보는 dftNo알기위한것:"+bkapVO); //791
//			if(bkapVO == null) {
//				continue;
//			}else{
//				ApboxVO apboxVO = new ApboxVO();
//				apboxVO.setDftNo(bkapVO.getDftNo());
//				
//				List<ApboxVO> apVOList=  cusBkApplyService.apboxSelect(apboxVO);
//				log.info("결재 상태보는 apBoxVO"+apVOList);
//				
//				int result = 0;
//				
//				for (ApboxVO apboxVO2 : apVOList) {
//					String result1 = apboxVO2.getApbPro();
//					if(result1.equals("승인")){
//						result++;
//					}
//				}
//				if(apVOList.size() == result) {
//					returnResult = 1; 
//				}else {
//					continue;
//				}
//				map.put(bkNo, returnResult);
//			}
//			if(returnResult == 1) {
//				
//				map.put(bkNo, returnResult);
//			}
//		}
//		log.info("map::" + map);
//		model.addAttribute("returnMap", map);
	    return "vacation/bkApply";
	}
	//신청내역 모달에 띄우기
	@ResponseBody
	@GetMapping(value="/bkSelectOne/{bkNo}")
	public Map<String, Object> bkSelectOne(Principal principal, @PathVariable int bkNo) {
		
		BkApplyVO bkVO = new BkApplyVO();
			bkVO.setBkNo(bkNo);
		log.info("@bkVO입니다.@::"+bkVO);
		
		String empNo= principal.getName();
		log.info("empNo잘넘어옴?:"+empNo);
			
			BkApplyVO result = cusBkApplyService.bkSelectOne(bkNo);
			log.info("result 결과값:"+result);
			
			int fileSn= result.getFileSn();
			FileInfoVO result1 = cusBkApplyService.fileInfo(fileSn);
				log.info("@@@이건 result1@값"+result1);
				
				Map<String, Object> totalResultMap = new HashedMap<String, Object>();
				totalResultMap.put("result", result);
				totalResultMap.put("result1", result1);
						
				
		return totalResultMap;
		
	}
	//파일업로드
	@ResponseBody
	@PostMapping(value="/fileInsert", produces = "application/json;charset=utf-8")
	public String fileInsert(Principal principal,MultipartFile file,BkApplyVO bkApplyVO)throws Exception{
		
		String empNo = principal.getName();
		log.info("empNo이야:"+empNo);
		
		UUID uuid = UUID.randomUUID();
		log.info("uuid입니다."+uuid);

		String orignalFileName = file.getOriginalFilename();
		log.info("orignalFileName입니다."+orignalFileName);
		String uploadFileName = uuid.toString() + "_" + orignalFileName;
		
		long fileSize = file.getSize();
		log.info("fileSize입니다."+fileSize);
		
		String categoryNo = "vacation";
		String savePath = "d:/myTool/sts3WS/insight/src/main/webapp/resources/images/vacation/break"+uploadFileName; // 학원컴
//		String savePath = "D:/temp/MyTool/STS3/insight/src/main/resources/images/vacation/break/"+uploadFileName; //노트북
		
		FileInfoVO fileVO = new FileInfoVO();
		fileVO.setOrfiName(orignalFileName);
		fileVO.setSvfiName("/vacation/break/"+uploadFileName);
		fileVO.setFileSize(fileSize);
		fileVO.setFileUdter(empNo);
		fileVO.setFileRoot(savePath);
		fileVO.setFileSetting(categoryNo);
		
		log.info("fileVO입니다."+fileVO);
		
		int result = cusBkApplyService.fileInsert(fileVO);
		if(result>0) {
			file.transferTo(new File(savePath));
		}
		
		
		BkApplyVO applyVO = new BkApplyVO();
		applyVO.setFileSn(fileVO.getFileSn());
		log.info("applyVO의 sn값",applyVO);
		
		int fileSn = cusBkApplyService.fileSnSelect();
		String webURL = "/vacation/break/"+uploadFileName;
		
		
		
		return fileSn+"";
	}
	@ResponseBody
	@PutMapping(value="/bkUpdate")
	private int BkUpdate(BkApplyVO bkApplyVO, Principal principal) throws IllegalStateException, IOException {
		//bkApplyVO : BkApplyVO(bkNo=735, empNo=null, bkCode=null, bkSdate=2023-10-26, bkEdate=2023-10-27, bkRsn=zxczxczxc, bkApstCode=C0104
		//, bkCertYn=B0103, fileSetting=null, bkName=병역 휴직, dftNo=0, empNm=null, 
		//file=org.springframework.web.multipart.support.StandardMultipartHttpServletRequest$StandardMultipartFile@38a8c99f
		//, fileList=null, fileSn=0, orfiName=null)
		bkApplyVO.setEmpNo(principal.getName());
		
		log.info("bkApplyVO : " + bkApplyVO);
		
		log.info("이건 bkVO"+bkApplyVO);
		int result = cusBkApplyService.bkUpdate(bkApplyVO);
		
		return result;
	}
	@ResponseBody
	@PutMapping(value="/fileUpdate",produces = "application/json;charset=utf-8")
	private FileInfoVO FileUpdate(@RequestBody FileInfoVO fileInfoVO) {
		
		
		FileInfoVO fileVO = cusBkApplyService.fileUpdate(fileInfoVO);
		log.info("이건 fileVO"+fileVO);
		
		
		
		
		return fileVO;
	}
	
	//사원정보 모달조회
	@ResponseBody
	@GetMapping(value="/selectEmpInfo/{empNo}",produces = "application/json;charset=utf-8")
	public EmpVO selectEmpInfo(Principal principal, @PathVariable String empNo) {
		log.info("잘왔겠지??--------------------------------------------------");
		
		String empno = principal.getName();
		log.info("principalNo:"+empno);
		
		
		EmpVO vo = cusBkApplyService.selectEmpInfo(empno);
		log.info("EmpVO-->vo"+vo);
		
		return vo;
	}
	//복직 신청
	@ResponseBody
	@PostMapping(value="/insertReqst", produces = "application/json;charset=utf-8")
	public int insertReqst(Principal principal ,@RequestBody RsReqstVO rsReqstVO) {
			
			String empNo = principal.getName();
			rsReqstVO.setEmpNo(empNo);
				log.info("empno입니다다다"+empNo);
		
		
		int vo = cusBkApplyService.insertReqst(rsReqstVO);
		
		return vo;
	}
	
	//내역별 모달 조회
	@ResponseBody
	@GetMapping(value="/rsModal/{rsNo}")
	public RsReqstVO rsModalSelect(Principal principal, @PathVariable int rsNo) {
				
					RsReqstVO rsVO = new RsReqstVO();
					rsVO.setRsNo(rsNo);
					log.info("이건 rsNo"+rsNo);
					log.info("@@rsVO:"+rsVO);
			
					rsVO= cusBkApplyService.rsModalSelect(rsNo);
					log.info("@@vo:",rsVO);
		return rsVO;
	}
	//내역별 모달 수정
	@ResponseBody
	@PutMapping(value="/rsModal", produces = "application/json;charset=utf-8")
	public int rsModalUpdate( @RequestBody RsReqstVO rsReqstVO) {
				
				log.info("수정rsReqstVO@"+rsReqstVO);
		return cusBkApplyService.rsModalUpdate(rsReqstVO);
	}
	
	//복직 결재 신청 ajax로 값넘겨받기 
	@ResponseBody
	@PostMapping(value="/RsmultiInsert")
	public String WriInsert(Principal principal,@RequestBody List<Object> totalList) {
		
		String empNo = principal.getName();
		
		ObjectMapper objMapper = new ObjectMapper();
		
//		RsReqstVO rsReqstVO = objMapper.convertValue(totalList.get(0), RsReqstVO.class);
//		log.debug("확인{}",rsReqstVO);
		
		
		List<ApboxVO> apboxListVO = new ArrayList<ApboxVO>();
		
		@SuppressWarnings("unchecked")
		List<Object> List =(List<Object>)totalList.get(1);
		for(Object obj : List) {
			ApboxVO apboxVO = objMapper.convertValue(obj, ApboxVO.class);
			apboxListVO.add(apboxVO);
		}
		log.debug("확인2{}",apboxListVO);
		
		DocWriVO docWriVO = new DocWriVO();
		docWriVO.setEmpNo(empNo);
		log.info("@@여기는 empNo입니다.@@"+empNo);
		
//		rsReqstVO.setEmpNo(empNo);
		
		int result1 = cusBkApplyService.WriInsert(docWriVO, apboxListVO);
		log.info("@@여기는 result입니다@@:"+result1);
		
		RsReqstVO rsReqstVO2 = objMapper.convertValue(totalList.get(0), RsReqstVO.class);
		
		int rsNo = rsReqstVO2.getRsNo();
		log.info("이것은 rsNo"+rsNo);
		
		int result2 = cusBkApplyService.apstCodeUpdate(rsNo);
		
		int result = result1+result2;
		
		return Integer.toString(result);
		
	}
	//휴직 결재 신청
	@ResponseBody
	@PostMapping(value="/bkMultiInsert")
	public String bkWriInsert(Principal principal,@RequestBody List<Object> totalList) {
		String empNo = principal.getName();
		
		ObjectMapper objMapper = new ObjectMapper();
		
		List<ApboxVO> apboxListVO = new ArrayList<ApboxVO>();
		
		@SuppressWarnings("unchecked")
		List<Object> List =(List<Object>)totalList.get(1);
		for(Object obj : List) {
			ApboxVO apboxVO = objMapper.convertValue(obj, ApboxVO.class);
			apboxListVO.add(apboxVO);
		}
		log.info("확인@@@@@",apboxListVO);
		
		DocWriVO docWriVO = new DocWriVO();
		docWriVO.setEmpNo(empNo);
		log.info("empNo@@@@"+empNo);
		
		int result1 = cusBkApplyService.bkWriInsert(docWriVO, apboxListVO);
		log.info("result1@@"+result1);
		
		
//		int bkNo = cusBkApplyService.bkNo();
		BkApplyVO bkVO = objMapper.convertValue(totalList.get(0), BkApplyVO.class);
		bkVO.setDftNo(docWriVO.getDftNo());
		int bkNo = bkVO.getBkNo();
		int dftNo = bkVO.getDftNo();
		log.info("이게 나와야해 bkNo::"+bkNo);
		log.info("이게 나와야해 dftNo::"+dftNo);
		
		FileInfoVO fileVO = new FileInfoVO();
		fileVO.setFileUdter(empNo);
		fileVO.setFileSn(bkVO.getFileSn());
		log.info("fileVO입니다."+fileVO);
		
		
		
		int result2 = cusBkApplyService.bkApstCodeUpdate(bkVO);
		int result = result1+result2;
		return Integer.toString(result);
		
		
	}
////결재선에서 승인 반려 진행 상황에 따른 조회
	@ResponseBody
	@GetMapping(value="/apboxSelect", produces = "application/json;charset=utf-8")
	public List<ApboxVO> apboxSelect(Principal principal,@RequestParam int bkNo) {
		String empNo = principal.getName();
		log.info("결재 상태보는 empNo"+empNo);
		
		BkApplyVO bkapVO = cusBkApplyService.dftNoSelect(bkNo);
		log.info("결재 상태보는 dftNo알기위한것:"+bkapVO); //791
		
		ApboxVO apboxVO = new ApboxVO();
		apboxVO.setDftNo(bkapVO.getDftNo());
			

		List<ApboxVO> apVOList=  cusBkApplyService.apboxSelect(apboxVO);
		log.info("결재 상태보는 apBoxVO"+apVOList);
		
		return apVOList;
			
	}
	
}