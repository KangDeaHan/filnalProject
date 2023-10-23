package kr.or.ddit.common.controller;

import java.io.File;
import java.io.IOException;
import java.security.Principal;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Select;
import org.apache.poi.hssf.record.BottomMarginRecord;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
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
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import kr.or.ddit.common.service.BbsService;
import kr.or.ddit.common.service.CommonService;
import kr.or.ddit.common.service.NoticeService;
import kr.or.ddit.common.service.impl.NoticeServiceImpl;
import kr.or.ddit.common.vo.AccaVO;
import kr.or.ddit.common.vo.CnthxVO;
import kr.or.ddit.common.vo.DeptVO;
import kr.or.ddit.common.vo.EmpVO;
import kr.or.ddit.common.vo.FileInfoVO;

import kr.or.ddit.personnel.service.MemberService;
import kr.or.ddit.vo.AsgmtVO;
import kr.or.ddit.vo.AuthMenuVO;
import kr.or.ddit.vo.AuthorAlwncVO;
import kr.or.ddit.vo.BbsVO;
import kr.or.ddit.vo.CareerVO;
import kr.or.ddit.vo.CmCodeVO;
import kr.or.ddit.security.CustomNoOpPasswordEncoder;

import kr.or.ddit.vo.NoticeVO;
import kr.or.ddit.vo.WkApVO;
import kr.or.ddit.vo.WkHrVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/common")
public class CommonController {
   
	@Autowired
	MemberService ppservice;
   
   @Autowired
   private CommonService service;
   
   @Autowired
   private NoticeService noticeService;
   
   @Autowired
   BCryptPasswordEncoder passwordEncoder; 
	
   @Autowired
   private BbsService bbsService;
   
   
   /**
    * 웹소켓 테스트
    * @return
    */
   @GetMapping("/chat")
   public String chatChat() {
      return "/common/myChat";
   }
   
   /**
    * 로그인 화면으로 가기
    * @return
    */
   @GetMapping("/login")
   public String login() {
      return "/common/login";
   }
   
   /**
    * 로그인 오류처리
    * @return
    */
   @PostMapping("/loginfFailed")
   public String loginfFailed() {
	   return "/common/loginfFailed";
   }
   
   @GetMapping("/findPw")
   public String findPw() {
      return "/common/findPw";
   }
   
   
   @ResponseBody
   @PostMapping("/findPw")
   public int PostfindPw(@RequestBody Map<String, String> e7e) {
	   
	    try {
	        EmpVO empVO = new EmpVO();
	        empVO.setEmpNo(e7e.get("userId"));
	        empVO.setRegn(e7e.get("birthday"));
	        empVO.setEmpMail(e7e.get("myEmail"));
	        empVO.setEmpPass(tPass());
	    
	        String before = empVO.getEmpPass();
	        log.info("임시비번"+before);
	        String Pw = passwordEncoder.encode(empVO.getEmpPass());
	        empVO.setEmpPass(Pw);
	    
	        int result = service.findPW(empVO);
	        
	        log.info("몇개들어옴?" + result);
	        
	        if (result == 2) {
	            String myaddr = "pqc101@naver.com";
	            String title = "인사이트 임시 비밀번호입니다.";
	            String body = "안녕하세요 인사이트 입니다. \r\n "+empVO.getEmpNo()+" 님의 임시비밀번호는 \r\n "+before+" 입니다.";
	            String to = e7e.get("myEmail");
	            service.sendEmail(to, myaddr, title, body);
	            return 0; // 성공적으로 처리되었음을 나타내는 값
	        } else {
	            return -1; // 비밀번호를 찾을 수 없음을 나타내는 값
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	        return -2; // 오류가 발생했음을 나타내는 값
	    }
	}
	   
   public String tPass(){
       char[] charSet = new char[] { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F',
               'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z' };

       String str = "";

       // 문자 배열 길이의 값을 랜덤으로 10개를 뽑아 구문을 작성함
       int idx = 0;
       for (int i = 0; i < 10; i++) {
           idx = (int) (charSet.length * Math.random());
           str += charSet[idx];
       }
       return str;
   }
   


   
   
   /**
    * 홈피드 화면으로 가기
    * @return
    */
   @GetMapping("/home")
   public String home(Model model, Principal principal) {
      // 접속한 아이디로
      String empNo = principal.getName();
      
      EmpVO empVo = service.SelectEmp(empNo);
      
      model.addAttribute("empVO",empVo);
      
      SecurityContext context = SecurityContextHolder.getContext();
      Authentication authentication = context.getAuthentication();
      log.info("33?" + authentication.getAuthorities());
      
      List<AuthMenuVO> authMenuList = ppservice.authMenu();   
      
      model.addAttribute("authMenuList",authMenuList);
      model.addAttribute("authentication", authentication);
      
      return "common/home";
   }
   
   /**
    * 회사소식 화면으로 가기
    * @return
    */
   @GetMapping("/companyNews")
   public String companyNews(Model model, Principal principal) {
      // 접속한 아이디로
      String empNo = principal.getName();
      
      EmpVO empVo = service.SelectEmp(empNo);
      
      model.addAttribute("empVO",empVo);
      
      SecurityContext context = SecurityContextHolder.getContext();
      Authentication authentication = context.getAuthentication();
      log.info("33?" + authentication.getAuthorities());
      
      List<AuthMenuVO> authMenuList = ppservice.authMenu();   
      
      model.addAttribute("authMenuList",authMenuList);
      model.addAttribute("authentication", authentication);
      
      return "common/companyNews";
   }
   
   /**
    * AJAX로 검색결과 받기
    * @param keyword
    * @return
    */
   @ResponseBody
   @GetMapping("/suchEmp")
   public List<EmpVO> suchEmp(@RequestParam String keyword){
      log.info("CommonController->keyword : " + keyword);
      List<EmpVO> list = service.suchEmp(keyword);
      log.info("CommonController->list : " + list);
      return list;
   }
   
   /**
    * 마이페이지로 가기(사이드바에서 내정보 클릭시 이동),사원 리스트에서 클릭시
    * @return
    */
   @GetMapping("/myPage")
   public String myPage(Principal principal,Model model,String empNo) {
      String EmpNo = principal.getName();
      EmpVO empVO = service.SelectEmp(EmpNo);
      log.info("principal아 잘 들어왔냐? : " + principal);
      
      
      //개인 정보 셋팅
	  EmpVO vo = service.SelectEmp(empNo);
      List<FileInfoVO> myFileList = service.fileSelect(empNo);
      vo.setFileList(myFileList);
      
      //인사 정보 셋팅
      EmpVO vo2 = service.SelectEmp2(empNo);
      log.info("CommonController->vo2 : " + vo2);
      vo.setEntDate(vo2.getEntDate());
      vo.setDnm(vo2.getDnm());
      vo.setGrdCodeNm(vo2.getGrdCodeNm());
      log.info("CommonController->vo야 잘 세팅됐냐? : " + vo);
      
      //계약 정보 세팅
      CnthxVO cnthxVO = service.myCnthx(empNo);
      log.info("CommonController->cnthxVO야 잘 세팅됐냐? : " + cnthxVO);
      
      //경력/학력정보 세팅 
      AccaVO accaVO = service.myAcca(empNo);
//      CareerVO careerVO;
      
	  List<CmCodeVO> cmCodeMn = ppservice.selectCmcode();
	  log.info("CM 정보 나와라!!"+cmCodeMn);		
		
	  List<DeptVO> deptMn = ppservice.selectDept();
	  log.info("부서 정보 나와라!!"+deptMn);		
	  
		//권한정보 ㅎㅎ
      SecurityContext context = SecurityContextHolder.getContext();
      Authentication authentication = context.getAuthentication();
      log.info("33?" + authentication.getAuthorities());

	 //권한별 메뉴 리스트
	 List<AuthMenuVO> authMenuList = ppservice.authMenu();   
		
      
      model.addAttribute("authMenuList",authMenuList);
      model.addAttribute("authentication", authentication);
		
	  model.addAttribute("cmCodelist",cmCodeMn);
	  model.addAttribute("deptlist",deptMn);
	  log.info("CM,부서 리스트 잘 들어갔냐?"+model);	
      
      
      // Map 객체를 생성하여 데이터를 담습니다.
      // Map<String, Object> myDataMap = new HashMap<>();
      // myDataMap.put("vo", vo);
      // log.info("CommonController->myDataMap야 잘 세팅됐냐? : " + myDataMap);
      
      //로그인 정보 보내기
      model.addAttribute("empVO", empVO);
      // Model에 Map 객체를 추가합니다.
      // model.addAttribute("myDataMap", myDataMap);
      //선택한 사람 정보 모델세팅
      model.addAttribute("vo", vo);
      //계약 정보 모델세팅
      model.addAttribute("cnthxVO", cnthxVO);
      //경력/학력정보 모델세팅
      model.addAttribute("accaVO", accaVO);
      model.addAttribute("empNo", empNo);
      model.addAttribute("loginNo", EmpNo);
      //log.info("CommonController->model아 잘 세팅됐냐? : " + myDataMap);
      log.info("CommonController->model 잘 세팅됐냐? : " + model);
      

      return "common/myPage";
   }
   
   /**
    * 사원 1명 조회하기
    * @param principal
    * @return
    */
   @ResponseBody
   @GetMapping("/selectEmp")
   public EmpVO selectEmp(Principal principal, String empNo,Model model) {
      
	   //변수 세팅
	   String bankNm = ""; 
	   
//      String EmpNo = principal.getName();
      log.info("CommonController->empNo : " + empNo);
      EmpVO vo = service.SelectEmp(empNo);
      log.info("CommonController->인사vo : " + vo);
      EmpVO vo2 = service.SelectEmp2(empNo);
      vo.setDnm(vo2.getDnm());
      
      vo.setGrdCodeNm(vo2.getGrdCodeNm());
      log.info("CommonController->인사vo야 잘 세팅됐냐? : " + vo);
      
      //CM코드 세팅
      List<CmCodeVO> cmCodevoList = ppservice.selectCmcode();
	  log.info("cmCodevoList 잘 들어 갔니?????????? : " + cmCodevoList);
      //은행이름 세팅
      for(CmCodeVO cmCodeVO : cmCodevoList) {
			if(cmCodeVO.getCmGroup().equals("bank")) {
				if(cmCodeVO.getCmCode().equals(vo.getBankCode())) {
					bankNm = cmCodeVO.getCmNm();
			}
		  }
	  }
      vo.setBankCodeNm(bankNm);
      
		//권한정보 ㅎㅎ
      SecurityContext context = SecurityContextHolder.getContext();
      Authentication authentication = context.getAuthentication();
      log.info("33?" + authentication.getAuthorities());

	 //권한별 메뉴 리스트
	 List<AuthMenuVO> authMenuList = ppservice.authMenu();
	 
	 
	 Map<String, Object> map = new HashMap<String, Object>();
	 map.put("authentication", authentication);
	 map.put("authMenuList", authMenuList);
	 map.put("loginNo", principal.getName());
	 map.put("empNo", empNo);

      List<FileInfoVO> myFileList = service.fileSelect(empNo);
      vo.setFileList(myFileList);
      log.info("CommonController->vo야 정말로 잘 됐어? : " + vo);
           
      return vo;
   }
   
   @ResponseBody
   @GetMapping("/selectEmp2")
   public Map<String, Object> selectEmp2(Principal principal, String empNo,Model model) {
	   
//      String EmpNo = principal.getName();
	   log.info("CommonController->empNo : " + empNo);
	   EmpVO vo = service.SelectEmp(empNo);
	   log.info("CommonController->인사vo : " + vo);
	   EmpVO vo2 = service.SelectEmp2(empNo);
	   vo.setDnm(vo2.getDnm());
	   
	   vo.setGrdCodeNm(vo2.getGrdCodeNm());
	   log.info("CommonController->인사vo야 잘 세팅됐냐? : " + vo);
	   
	   //권한정보 ㅎㅎ
	   SecurityContext context = SecurityContextHolder.getContext();
	   Authentication authentication = context.getAuthentication();
	   log.info("33?" + authentication.getAuthorities());
	   
	   //권한별 메뉴 리스트
	   List<AuthMenuVO> authMenuList = ppservice.authMenu();
	   
	   
	   Map<String, Object> map = new HashMap<String, Object>();
	   map.put("authentication", authentication);
	   map.put("authMenuList", authMenuList);
	   map.put("loginNo", principal.getName());
	   map.put("empNo", empNo);
	   
	   Map<String, Object> map2 = new HashMap<String, Object>();
	   map2.put("map", map);
	   map2.put("vo", vo);
	   
	   List<FileInfoVO> myFileList = service.fileSelect(empNo);
	   vo.setFileList(myFileList);
	   log.info("CommonController->vo야 정말로 잘 됐어? : " + vo);
	   
	   return map2;
   }
   
   /**
    * 내 계약정보
    * @param principal
    * @return ctrtCaseNm
    */
   @ResponseBody
   @GetMapping("/myCnthx")
   public CnthxVO myCnthx(Principal principal,String empNo){
//      String EmpNo = principal.getName();
      log.info("CommonController->계약정보empNo : " + empNo);
      
      CnthxVO cnthxVO = service.myCnthx(empNo);
      log.info("CommonController->계약정보cnthxVO : " + cnthxVO);
      
      return cnthxVO;
   }
   
   /**
    * 내 학력정보
    * @param principal
    * @return
    */
   @ResponseBody
   @GetMapping("/mtAcca")
   public Map<String, Object> myAcca(Principal principal,String empNo) {
//      String EmpNo = principal.getName();
      log.info("CommonController->empNo : " + empNo);
      AccaVO vo = service.myAcca(empNo);
      log.info("CommonController->vo : " + vo);
      CareerVO vo1 = service.myCareer(empNo);
      log.info("CommonController->vo : " + vo);
      
      Map<String, Object> map = new HashMap<String, Object>();
      map.put("vo", vo);
	  map.put("vo1", vo1);
      
      return map;
   }

   
   
   /**
    * 파일 미리보기
    * @param file
    * @return
    * @throws Exception
    */
   @ResponseBody
   @PostMapping(value ="/preview", produces ="application/json;charset=utf-8" )
   public String updateFile(MultipartFile file) throws Exception {
      log.info("updateFile->fileName : " + file.getOriginalFilename());
      log.info("updateFile->size : " + file.getSize());
      log.info("3333");
      
      //DB에 저장할 파일경로
      String savePath = "D:\\insightFile\\myimg\\"+ file.getOriginalFilename();
      file.transferTo(new File(savePath));
      log.info("2222");
      
      //실제 웹 물리적 경로
      String webURL = "/insightFile/myimg/" + file.getOriginalFilename();
      //forwarding(jsp파일경로?)(x)
      //redirect(x)
      //데이터(O)
      log.info("1111");
      return webURL;
   }
   
   
   /**
    * 내 이미지 update(파일 업로드), emp이미지경로(업데이트)
    * @param file
    * @return
    * @throws Exception
    */
   @ResponseBody
   @PostMapping(value = "/fileUpdate", produces = "application/json;charset=utf-8")
   public String fileUpdate(Principal principal, MultipartFile file,String empNo, HttpSession session) throws Exception {
      UUID uuid = UUID.randomUUID();
      String originFileName = file.getOriginalFilename();
      String uploadFileNmae = uuid.toString() + "_" + originFileName; 
      long fileSize = file.getSize();
      
      log.info("왔다!!!!!!!");
//      String EmpNo = principal.getName();
      String saveCateNo = "myimg"; 
      
      String savePath = "d:/insightFile/myimg/"+uploadFileNmae;
      
      FileInfoVO fileInfoVO = new FileInfoVO();
      fileInfoVO.setOrfiName(originFileName);
      fileInfoVO.setSvfiName("/insightFile/myimg/"+uploadFileNmae);
      fileInfoVO.setFileSize(fileSize);
      fileInfoVO.setFileUdter(empNo);
      fileInfoVO.setFileRoot(savePath);
      fileInfoVO.setFileSetting(saveCateNo);
      
      EmpVO empVO = new EmpVO();
      empVO.setEmpImg(fileInfoVO.getSvfiName());
      empVO.setEmpNo(empNo);
      int result = service.fileInsert(fileInfoVO, empVO);
      
      if(result > 0) {
         file.transferTo(new File(savePath));
         session.setAttribute("empVO2", empVO);
      }
      
      String webURL = "/insightFile/myimg/" + uploadFileNmae;
      
      return webURL;
   }
   
   /**
    * 직인설정하기
    * @param file
    * @param empNo
    * @return
    * @throws Exception
    */
   @ResponseBody
   @PostMapping(value = "/tempUpload", produces = "application/json;charset=utf-8")
   public String tempUpload(MultipartFile file, String empNo) throws Exception {
      
      log.info("파일"+file);
      log.info("번호"+empNo);
      
      UUID uuid = UUID.randomUUID();
      String originFileName = file.getOriginalFilename();
      String uploadFileNmae = uuid.toString() + "_" + originFileName; 
      long fileSize = file.getSize();
      
      String saveCateNo = "temp"; 
      
      String savePath = "d:/insightFile/temp/"+uploadFileNmae;
      
      FileInfoVO fileInfoVO = new FileInfoVO();
      fileInfoVO.setOrfiName(originFileName);
      fileInfoVO.setSvfiName("/insightFile/temp/"+uploadFileNmae);
      fileInfoVO.setFileSize(fileSize);
      fileInfoVO.setFileUdter(empNo);
      fileInfoVO.setFileRoot(savePath);
      fileInfoVO.setFileSetting(saveCateNo);
      
      EmpVO empVO = new EmpVO();
      empVO.setEmpImg(fileInfoVO.getSvfiName());
      empVO.setEmpNo(empNo);
      int result = service.fileInsert(fileInfoVO, empVO);
      log.info("result 테스트"+result);
      
      if(result > 0) {
         file.transferTo(new File(savePath));
         
      }
      
      String webURL = "/insightFile/temp/" + uploadFileNmae;
      log.info("webURL 테스트"+webURL);
      
      return webURL;
   }
   
	//인사정보 모달창 업데이트
	@ResponseBody
	@PostMapping("/insaupdate")
	public String insaUpdate(EmpVO empVO, Principal principal,HttpSession session){
		
		CnthxVO cnthxVO = service.myCnthx(empVO.getEmpNo());
		
		empVO.setCtrtCaseCode(cnthxVO.getCtrtCaseCode());
		
		log.info("수정 인사정보 잘 나오나?"+empVO);
		int result = service.updateInsa(empVO);
	      
	    String rslt = "success";
	    if(result == 0) {
	    	rslt = "fail";
	    	session.setAttribute("empVO", empVO);
	    }
	    
	    log.info("인사정보 인설트 성공했나? : " + rslt);
	    //forwarding

	    return rslt; // 여기에서 적절한 응답을 반환하도록 수정
	}
	//개인정보 모달창 업데이트
	@ResponseBody
	@PostMapping("/personupdate")
	public String personUpdate(EmpVO empVO, Principal principal,HttpSession session){
		
		log.info("수정 개인정보 잘 나오나?"+empVO);
		
		// 사원 비밀번호 암호화
		String password = passwordEncoder.encode(empVO.getEmpPass());
		empVO.setEmpPass(password);
		log.info("암호화 되었느냐?!!! : " + password);
		
		int result = service.updatePerson(empVO);
		
		String rslt = "success";
		if(result == 0) {
			rslt = "fail";
			session.setAttribute("empVO", empVO);
		}
		
		log.info("개인정보 인설트 성공했나? : " + rslt);
		//forwarding
		
		return rslt; // 여기에서 적절한 응답을 반환하도록 수정
	}
	//계약정보 모달창 업데이트
	@ResponseBody
	@PostMapping("/cnthxupdate")
	public String cnthxUpdate(CnthxVO cnthxVO, Principal principal,HttpSession session){
		
		log.info("수정 계약정보 잘 나오나?"+cnthxVO);
		
		EmpVO empVO = service.SelectEmp2(cnthxVO.getEmpNo());
		log.info("empVO사원정보 잘 가져왔니?"+empVO);
		
		empVO.setCtrtCaseCode(cnthxVO.getCtrtCaseCode());
		log.info("empVO에 계약정보 잘 세팅됨?"+empVO.getCtrtCaseCode());
		
		
		int insaupdate = service.updateInsa(empVO);
		log.info("empVO사원정보 잘 업데이트함?"+insaupdate);
		
		
		int result = service.updateCnthx(cnthxVO);
		
		String rslt = "success";
		if(result == 0) {
			rslt = "fail";
			session.setAttribute("cnthxVO", cnthxVO);
		}
		
		log.info("계약정보 인설트 성공했나? : " + rslt);
		//forwarding
		
		return rslt; // 여기에서 적절한 응답을 반환하도록 수정
	}
   
      //공지사항 등록
      @ResponseBody
      @PostMapping(value = "/notiInsert", produces = "application/json;charset=utf-8")
      public int notiInsert(
         @RequestParam(value = "file", required = false) MultipartFile file,
          @RequestParam("wriNo") String wriNo,
          @RequestParam("postTitle") String postTitle,
          @RequestParam("postCont") String postCont
      ) throws Exception {
         log.info("컨트롤러 1" + file);
         
         int result = noticeService.fileInsert(file,wriNo,postTitle,postCont);
         log.info("컨트롤러 2");
          return result;
      }
      
      // 공지사항 리스트 불러오기
      @ResponseBody
      @GetMapping(value="/notiList",produces = "application/json;charset=utf-8")
      public List<NoticeVO> notiList() {
         log.debug("<<공지사항 리스트 체크>> ", noticeService);
         return noticeService.notiList();
      }
      
      // 공지사항 1개 조회
      @ResponseBody
      @GetMapping(value="/notiSelect/{postNo}",produces = "application/json;charset=utf-8")
      public NoticeVO notiSelect(@PathVariable int postNo) {
         log.debug("<<공지사항 1개조회 >>");
         return noticeService.noticeSelect(postNo);
      }
      
      // 공지사항 수정
      @ResponseBody
      @PutMapping(value="/notiUpdate", produces = "application/json;charset=utf-8")
      public String notiUpdate(
              @RequestParam(value = "file", required = false) MultipartFile file,
              @RequestParam("postNo") int postNo,
              @RequestParam("wriNo") String wriNo,
              @RequestParam("postTitle") String postTitle,
              @RequestParam("fileNo") String fileNo,
              @RequestParam("postCont") String postCont
      ) {
          log.debug("<<공지사항 수정 >> postNo: " + postNo);
          int result = noticeService.fileUpdate(file, postNo, wriNo, postTitle, postCont, fileNo);
          return Integer.toString(result);
      }
      
      // 공지사항 삭제
      @ResponseBody
      @DeleteMapping(value="/notiDelete/{postNo}",produces = "application/json;charset=utf-8")
      public String notiDelete(@PathVariable int postNo) {
         NoticeVO noticeVO = new NoticeVO();
         noticeVO.setPostNo(postNo);
         return Integer.toString(noticeService.notiDelete(noticeVO));
      }
      
      // 출근 등록
      @ResponseBody
      @PostMapping(value="/gotoWork",produces = "application/json;charset=utf-8")
      public String gotoWork(@RequestBody WkHrVO wkHrVO) {
         log.debug("<<출근등록 컨트롤러 >>" + wkHrVO);
         return Integer.toString(service.gotoWork(wkHrVO));
      }
      
      // 퇴근 등록
      @ResponseBody
      @PutMapping(value="/leaveWork")
      public String leaveWork(WkHrVO wkHrVO, Principal principal) {
         // 접속한 아이디로
         String empNo = principal.getName();
         
         wkHrVO.setEmpNo(empNo);
         
         log.debug("<<퇴근등록 컨트롤러 >>" + wkHrVO);
         int result = service.leaveWork(wkHrVO);
         result += service.totalWorkTime(wkHrVO);
         log.debug("<<퇴근등록 컨트롤러 >>" + result);
         return Integer.toString(result);
      }
      
      // 출퇴근 정보 조회
      @ResponseBody
      @GetMapping(value="/commuteSelect/{empNo}", produces = "application/json;charset=utf-8")
      public WkHrVO commuteSelect(@PathVariable String empNo) {
         log.debug("<<출퇴근 정보 조회 컨트롤러>> " + empNo);
         return service.commuteSelect(empNo);
      }
      
      // 일정 리스트 불러오기
      @ResponseBody
      @GetMapping(value="/BbsList",produces = "application/json;charset=utf-8")
      public List<BbsVO> BbsList() {
         log.debug("<<일정 리스트 체크>> ", bbsService.BbsList());
         return bbsService.BbsList();
      }
      
      // 특정사원 일정 조회
      @ResponseBody
      @GetMapping(value="/BbsSelect/{empNo}", produces = "application/json;charset=utf-8")
      public List<BbsVO> BbsSelect(@PathVariable String empNo) {
    	  List<BbsVO> list = bbsService.BbsSelect(empNo);
    	  log.debug("<<특정사원 일정 조회 >> " , list);
    	  return list;
      }
      
      // 일정 등록
      @ResponseBody
      @PostMapping(value="/BbsInsert", produces = "application/json;charset=utf-8")
      public int BbsInsert(@RequestBody BbsVO bbsVO) {
    	  log.debug("<<일정 등록 컨트롤러 >> ", bbsVO);
    	  return bbsService.BbsInsert(bbsVO);
      }
      
      // 일정 수정
      @ResponseBody
      @PutMapping(value="/BbsUpdate", produces = "application/json;charset=utf-8")
      public int BbsUpdate(@RequestBody BbsVO bbsVO) {
    	  log.debug("<<일정 수정 컨트롤러>> ", bbsVO);
    	  return bbsService.BbsUpdate(bbsVO);
      }
      
      // 일정 삭제
      @ResponseBody
      @DeleteMapping(value="/BbsDelete/{bbsNo}",produces = "application/json;charset=utf-8")
      public String BbsDelete(@PathVariable int bbsNo) {
    	 BbsVO bbsVO = new BbsVO();
    	 bbsVO.setBbsNo(bbsNo);
         return Integer.toString(bbsService.BbsDelete(bbsVO));
      }
      
      //나의 이미지 가져오기
      @ResponseBody
      @GetMapping("/myImg")
      public String myImg(Principal principal){
    	  String empNo = principal.getName();
    	  String myImg = service.selectMyImg(empNo);
    	  
    	  log.info("empNo : {}", empNo);
    	  log.info("myImg : {}", myImg);
    	  
    	  return myImg;
      }
      
}