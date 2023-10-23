package kr.or.ddit.personnel.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.security.Principal;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.common.vo.CnthxVO;
import kr.or.ddit.common.vo.DeptVO;
import kr.or.ddit.common.vo.EmpVO;
import kr.or.ddit.common.vo.FileInfoVO;
import kr.or.ddit.personnel.service.MemberService;
import kr.or.ddit.sms.service.CoolSmsService;
import kr.or.ddit.vo.AsgmtVO;
import kr.or.ddit.vo.AuthMenuVO;
import kr.or.ddit.vo.AuthorAlwncVO;
import kr.or.ddit.vo.CmCodeVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/personnel")
@Controller
public class PpController {
	
	@Autowired
	MemberService ppservice;
	
	@Autowired
	CoolSmsService coolSmsService;
	//암호화
	@Autowired
	BCryptPasswordEncoder passwordEncoder; 

	
	

	

	
	// 사원 리스트 조회 컨트롤러
	@GetMapping("/emp")
	public String ph(Model model) {
		
		List<EmpVO> emplist = ppservice.empList();
		log.info("emplist : " + emplist);

		//계약상태리스트
		List<EmpVO> emplist2 = ppservice.empList2();	
		log.info("emplist2 : " + emplist2);

		//권한정보 ㅎㅎ
        SecurityContext context = SecurityContextHolder.getContext();
        Authentication authentication = context.getAuthentication();
        log.info("33?" + authentication.getAuthorities());

		//권한별 메뉴 리스트
		List<AuthMenuVO> authMenuList = ppservice.authMenu();   
		
        
        model.addAttribute("authMenuList",authMenuList);
        model.addAttribute("authentication", authentication);
		
		model.addAttribute("emplist",emplist);
		model.addAttribute("emplist2", emplist2);
		log.info("리스트"+model);
				
				
		return"hrm/personnelHome";
	}
	

	//만료임박계약정보 조회(우재)근로계약
    @GetMapping("/edate")
    public ResponseEntity<List<CnthxVO>> edateEmp() {
        LocalDate currentDate = LocalDate.now();

        // 10일 이내로 종료되는 사원 리스트 가져오기
        List<CnthxVO> edateMb = ppservice.eDateEmp(currentDate, currentDate.plusDays(10));

        // Date 타입을 LocalDate로 변환
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        for (CnthxVO cnthxVO : edateMb) {
            Date contractEndDate = cnthxVO.getBlctEdate();
            
            // Date 타입을 LocalDate로 변환
            LocalDate contractEndLocalDate = LocalDate.parse(sdf.format(contractEndDate));
            
            // LocalDate를 Date로 변환
            Date contractEndDate1 = Date.from(contractEndLocalDate.atStartOfDay(ZoneId.systemDefault()).toInstant());

            // cnthxVO에 Date를 설정
            cnthxVO.setBlctEdate(contractEndDate1);
        }

        return ResponseEntity.ok(edateMb);
    }
    //만료임박계약정보 조회(우재)임금계약
    @GetMapping("/edate1")
    public ResponseEntity<List<CnthxVO>> edateEmp1() {
    	LocalDate currentDate = LocalDate.now();
    	
    	// 10일 이내로 종료되는 사원 리스트 가져오기
    	List<CnthxVO> edateMb1 = ppservice.eDateEmp1(currentDate, currentDate.plusDays(10));
    	 
    	// Date 타입을 LocalDate로 변환
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    	for (CnthxVO cnthxVO : edateMb1) {
    		Date salaryContractEndDate = cnthxVO.getBwctEdate();
    		
    		// Date 타입을 LocalDate로 변환
    		LocalDate salaryContractEndLocalDate = LocalDate.parse(sdf.format(salaryContractEndDate));
    		
    		// LocalDate를 Date로 변환
    		Date salaryContractEndDate1 = Date.from(salaryContractEndLocalDate.atStartOfDay(ZoneId.systemDefault()).toInstant());
    		
    		// cnthxVO에 Date를 설정
    		cnthxVO.setBwctEdate(salaryContractEndDate1);
    	}
    	
    	return ResponseEntity.ok(edateMb1);
    }
    //수습기간중인 인원 조회(우재) 임금계약
    @GetMapping("/edate2")
    public ResponseEntity<List<CnthxVO>> getEmployeesInProbation() {
        Date currentDate = new Date();
        List<CnthxVO> edateMb2 = ppservice.eDateEmp2(currentDate);
        
        return ResponseEntity.ok(edateMb2);
    }
	
	
	//사원전체 엑셀파일로 다운로드
//    @PostMapping("/downloadExcel")
//    @ResponseBody
//    public String downloadExcel(HttpServletResponse response) {
//        // 서비스를 통해 직원 데이터를 가져옴
//        List<EmpVO> employeeList = ppservice.empList();
//
//        log.info("데이터 잘 받아왔냐?"+employeeList);
//        // 엑셀 파일 생성
//        String filePath = "D:/insightFile/employee_list.xlsx"; //D:/insightFile/employee_list.xlsx 다운로드 경로
//         
//        ppservice.generateExcelFile(employeeList, filePath, response);
//
//       
//        return "/insightFile/employee_list.xlsx";
//    }
	
	
	// 계약상태 리스트 컨트롤러
	@ResponseBody   // 아작스 사용시 필요
	@GetMapping("/empA")
	public List<EmpVO> ph1() {
		List<EmpVO> emplist2 = ppservice.empList2();		
		log.info("리스트!!!계약정보포함"+emplist2);		
		return emplist2;
	}

		
	// 사원추가화면 컨트롤러
	@GetMapping("/empadd")
	public String empAdd(Model model) {
		
		List<CmCodeVO> cmCodeMn = ppservice.selectCmcode();
		log.info("CM 정보 나와라!!"+cmCodeMn);		
		
		List<DeptVO> deptMn = ppservice.selectDept();
		log.info("부서 정보 나와라!!"+deptMn);		
		
		model.addAttribute("cmCodelist",cmCodeMn);
		model.addAttribute("deptlist",deptMn);
		log.info("CM,부서 리스트 잘 들어갔냐?"+model);		
		
		
		return"hrm/empAdd";
	}

	//사원추가 1명 하기 컨트롤러
	@ResponseBody
	@PostMapping("/empadd")
	public String empAdd2(EmpVO empVO, Principal principal, AsgmtVO asgmtVO
			, FileInfoVO fileInfoVO
			,MultipartFile file,AuthorAlwncVO authorAlwncVO) throws IllegalStateException, IOException {
		
		//병철 추가
		asgmtVO.setAsgmtPers(empVO.getEmpNo());
		asgmtVO.setWriter(principal.getName());
		asgmtVO.setAsgmtClf("신규 직원 추가");
		asgmtVO.setAsgmtRsn("신규 직원 추가");
		asgmtVO.setAsgmtMm("신규 직원 추가");
		asgmtVO.setAsgmtCcst("C0102");
		
		
		
		// 로그인맴버권한 저장 세팅
		String authrtId = "ROLE_MEMBER";
		authorAlwncVO.setEmpNo(empVO.getEmpNo());
		authorAlwncVO.setAuthrtId(authrtId);
		log.info("로그인맴버아이디 잘 들어왔냐?!!! : " + authorAlwncVO.getAuthrtId());
		log.info("로그인맴버넘버 잘 들어왔냐?!!! : " + authorAlwncVO.getEmpNo());
		

		
		// 사원 추가 비밀번호 암호화 및 사원번호 부서VO에 세팅
		String password = passwordEncoder.encode(empVO.getEmpPass());
		empVO.setEmpPass(password);
		log.info("암호화 되었느냐?!!! : " + password);
		
		
		
		log.info("empAdd2->empVO : " + empVO);
		CnthxVO cnthxVO = empVO.getCnthxVOList();
		cnthxVO.setEmpNo(empVO.getEmpNo());
	    log.info("EmpVO야 제발 데이터야 들어와 : " + empVO, cnthxVO);
	    //계약유형정보 세팅
	    log.info("CtrtCaseCode야 들어있니? : " + empVO.getCtrtCaseCode());
	    empVO.setCtrtCaseCode(cnthxVO.getCtrtCaseCode());
	    log.info("CtrtCaseCode야 잘 세팅됐냐? : " + empVO.getCtrtCaseCode());
	    
	    
	    
	    //파일 업로드
		UUID uuid = UUID.randomUUID();
		log.info("유유아이디" + uuid);
		String originFileName = file.getOriginalFilename();
		log.info("오리지널파일네임" + originFileName);
		String uploadFileNmae = uuid.toString() + "_" + originFileName; 
		log.info("업로드파일네임" + uploadFileNmae);
		long fileSize = file.getSize();
		String saveCateNo = "myimg";
		
		String savePath = "d:/insightFile/myimg/"+uploadFileNmae;
		
		file.transferTo(new File(savePath));
		log.info("savePath경로" + savePath);
		
		fileInfoVO.setOrfiName(originFileName);
		fileInfoVO.setSvfiName("/insightFile/myimg/"+uploadFileNmae);
		fileInfoVO.setFileSize(fileSize);
		fileInfoVO.setFileRoot(savePath);
		fileInfoVO.setFileSetting(saveCateNo);
		
	    fileInfoVO.setFileUdter(empVO.getEmpNo());
	    log.info("파일정보 : "+fileInfoVO);
	    empVO.setEmpImg(fileInfoVO.getSvfiName());
	    log.info("empVO 파일경로!!!!!! : "+empVO.getEmpImg());
	    

	    int result = this.ppservice.insertEMP(empVO, cnthxVO, fileInfoVO,authorAlwncVO);
	    log.info("empAdd2 제대로 맵핑좀 되라 : " + result);
	    result += ppservice.newInsert(asgmtVO);
	    
	    if(result > 0 ) {
	    	coolSmsService.sendSMS(empVO);
	    }
	    
	    String rslt = "success";
	    if(result == 0) {
	    	rslt = "fail";
	    }
	    
	    log.info("인설트 성공했나? : " + rslt);
	    //forwarding

	    return rslt; // 여기에서 적절한 응답을 반환하도록 수정
	}
	
	//사원추가하기(파일 업로드,미리보기) 컨트롤러
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
		
		//DB에 저장할 파일경로
		String savePath = "D:\\insightFile\\myimg\\"+ file.getOriginalFilename();
		log.debug("pppp"+ savePath + "pppp");
		
		file.transferTo(new File(savePath));
		
		//실제 웹 물리적 경로
		String webURL = "/insightFile/myimg/" + file.getOriginalFilename();
		//forwarding(jsp파일경로?)(x)
		//redirect(x)
		//데이터(O)
		return webURL;
	}
	
	// 사원 개인정보
	@GetMapping("/personInfo")
	public String personInfo() {
		
		return "hrm/PsIf";
	}
	
//	//사원추가 옵션 목록 select컨트롤러
//	@GetMapping("/empadd3")
//	public String deptAdd(Model model) {
//		
//		
//		return("hrm/empAdd");
//	}
	
	
	
	
	//인사발령 페이지 이동
	@GetMapping("/Appointments")
	public String Appointments(Principal principal, Model model) throws Exception {
	        log.info("쳌쳌, 사용자 이름: " + principal.getName());
	        String empNo  = principal.getName();
	        

//	        //권한정보 ㅎㅎ
//	        SecurityContext context = SecurityContextHolder.getContext();
//	        Authentication authentication = context.getAuthentication();
//	        log.info("33?" + authentication.getAuthorities());
	       
	        
	        List<AsgmtVO> asgmtVOlist = ppservice.asgmtlist();
//	        List<DeptVO> deptList = ppservice.deptList();
	        List<DeptVO> deptList = ppservice.deptList2();

	        log.info("부서리스트22 " + deptList );
	        log.info("체크리스트 " + asgmtVOlist );
	        
	        model.addAttribute("asgmtVOlist", asgmtVOlist);
	        model.addAttribute("empNo", empNo);
	        model.addAttribute("deptList", deptList);
	      
	        
		return "hrm/Appointments";
	}
	

	//인사발령 수정 페이지 이동
	@PostMapping("/Appointmentset")
	public String Appointmentset(Model model,Principal Principal ,@RequestParam String team, @RequestParam String promotion, @RequestParam String date,@RequestParam String note, @RequestParam String rsn) {
		// 로그인한 정보 가져오기!!
        //List<EmpVO> memberlist = ppservice.memberList();
		// 작성자 정보를 넣을꺼임
		// 로그인한 정보 가져오기!!
		
		//선택된 팀 가져오기
		List<EmpVO> memberlist = null;
		if(team.equals("0")) {
			memberlist = ppservice.memberList();
		}else {
			memberlist = ppservice.memberList2(team);
		}
		
		
		String empNo = Principal.getName();
		
		//부서정보(본부) 가져오기
		List<DeptVO> Acenterlist = ppservice.Acenter();

		//부서정보 가져오기
		model.addAttribute("empNo", empNo );
		model.addAttribute("Acenterlist", Acenterlist );
		model.addAttribute("memberList",memberlist);
		model.addAttribute("team", team);
		model.addAttribute("promotion", promotion);
		model.addAttribute("date", date);
		model.addAttribute("note", note);
		model.addAttribute("rsn", rsn);
		
		//직위 리스트
		List<CmCodeVO> spotList = ppservice.spotList();
		model.addAttribute("spotList", spotList);
		
		//조직
		List<CmCodeVO> jobList = ppservice.jobList();
		model.addAttribute("jobList", jobList);
		
		//직책
		List<CmCodeVO> positionList = ppservice.positionList();
		model.addAttribute("positionList", positionList);
		
		//직급
		List<CmCodeVO> hobongList = ppservice.hobongList();
		model.addAttribute("hobongList", hobongList);
		
		//forwarding
		return "hrm/Appointmentset";
		
	}
	
	@ResponseBody
	@GetMapping("/pDpm/{Anum}") //본부 ajax시
	public List<DeptVO> pDpm(@PathVariable String Anum) { 
		
		//부서정보(부서) 가져오기
		List<DeptVO> deptlist = ppservice.Adept(Anum);
		log.info("deptlist : " + deptlist);
		
		return deptlist;
	}
	
	@ResponseBody
	@GetMapping("/pDpm2/{Anum2}")  // 부서 ajax시
	public List<DeptVO> pDpm2(@PathVariable String Anum2) {
		
		
		
//		//부서정보(팀) 가져오기
		List<DeptVO> teamlist = ppservice.Ateam(Anum2);
		log.info("teamlist : " + teamlist);
		
		return teamlist;
	}
	
	@ResponseBody
	@PostMapping(value="Appointment", consumes = MediaType.APPLICATION_JSON_VALUE)
	public int Appointmentput(@RequestBody List<Map<String, String>> rowData, DeptVO deptVO, EmpVO empVO, AsgmtVO asgmtVO) throws Exception {
		
	        int insert = ppservice.asgmtInsert(rowData, deptVO, empVO, asgmtVO);
//	        excel(rowData, deptVO, empVO, asgmtVO);
	        
		return insert;
	}
	
	public void excel(List<Map<String, String>> empNoList) throws Exception{
		
		XSSFWorkbook xssfWb = null; 
		XSSFSheet xssfSheet = null; 
		XSSFRow xssfRow = null; 
		XSSFCell xssfCell = null;
			
		log.info("이거뭥밍" + empNoList.toString());
		
		try {
			int rowNo = 0; // 행의 갯수 
			
			xssfWb = new XSSFWorkbook(); //XSSFWorkbook 객체 생성
			xssfSheet = xssfWb.createSheet("인사발령"); // 워크시트 이름 설정
			
			// 폰트 스타일
			XSSFFont font = xssfWb.createFont();
			font.setFontName(HSSFFont.FONT_ARIAL); // 폰트 스타일
			font.setFontHeightInPoints((short)20); // 폰트 크기
			font.setBold(true); // Bold 설정
			
			//테이블 셀 스타일
			CellStyle cellStyle = xssfWb.createCellStyle();
			xssfSheet.setColumnWidth(0, (xssfSheet.getColumnWidth(0))+(short)2048); // 0번째 컬럼 넓이 조절
			
			cellStyle.setFont(font); // cellStyle에 font를 적용
			//셀병합
			xssfSheet.addMergedRegion(new CellRangeAddress(0, 1, 0, 4)); //첫행, 마지막행, 첫열, 마지막열 병합

			//날짜생성
			SimpleDateFormat date =  new SimpleDateFormat("yyyy-MM-dd");
			String todayDate = date.format(new Date());
			
			// 타이틀 생성
			xssfRow = xssfSheet.createRow(rowNo++); // 행 객체 추가
			xssfCell = xssfRow.createCell((short) 0); // 추가한 행에 셀 객체 추가
			xssfCell.setCellStyle(cellStyle); // 셀에 스타일 지정
			xssfCell.setCellValue(todayDate+"인사발령"); // 데이터 입력
			
			xssfSheet.createRow(rowNo++);
			xssfRow = xssfSheet.createRow(rowNo++);  // 빈행 추가
			xssfRow = xssfSheet.createRow(rowNo++);
			xssfCell = xssfRow.createCell((short) 0);
			xssfCell.setCellValue("사원번호");
			xssfCell = xssfRow.createCell((short) 1);
			xssfCell.setCellValue("사원이름");
			xssfCell = xssfRow.createCell((short) 2);
			xssfCell.setCellValue("본부");
			xssfCell = xssfRow.createCell((short) 3);
			xssfCell.setCellValue("부서");
			xssfCell = xssfRow.createCell((short) 4);
			xssfCell.setCellValue("팀");
			xssfCell = xssfRow.createCell((short) 5);
			xssfCell.setCellValue("조직");
			xssfCell = xssfRow.createCell((short) 6);
			xssfCell.setCellValue("직책");
			xssfCell = xssfRow.createCell((short) 7);
			xssfCell.setCellValue("직위");
			xssfCell = xssfRow.createCell((short) 8);
			xssfCell.setCellValue("직급");
			xssfCell = xssfRow.createCell((short) 9);
			
		    for (Map<String, String> rowDataItem : empNoList) {

		        String EMP_NO = rowDataItem.get("empNo");	//발령자 사원번호

		        
		        log.info("이거 뭐냐구!@!");
		        EmpVO empVO = new EmpVO(); 
		        empVO.setEmpNo(EMP_NO);
		        log.info("이거 뭐냐구!@!" + empVO.toString());

		        
		        EmpVO change = ppservice.change(empVO);
		        log.info("변환후" + change.toString());
				xssfRow = xssfSheet.createRow(rowNo++);
				xssfCell = xssfRow.createCell((short) 0);
				xssfCell.setCellValue(change.getEmpNo());
				xssfCell = xssfRow.createCell((short) 1);
				xssfCell.setCellValue(change.getEmpNm());
				xssfCell = xssfRow.createCell((short) 2);
				xssfCell.setCellValue(change.getAcenter());
				xssfCell = xssfRow.createCell((short) 3);
				xssfCell.setCellValue(change.getBcenter());
				xssfCell = xssfRow.createCell((short) 4);
				xssfCell.setCellValue(change.getCcenter());
				xssfCell = xssfRow.createCell((short) 5);
				xssfCell.setCellValue(change.getJcode());
				xssfCell = xssfRow.createCell((short) 6);
				xssfCell.setCellValue(change.getDtcode());
				xssfCell = xssfRow.createCell((short) 7);
				xssfCell.setCellValue(change.getPtnCode());
				xssfCell = xssfRow.createCell((short) 8);
				xssfCell.setCellValue(change.getGrdCode());
				xssfCell = xssfRow.createCell((short) 9);
		    }
			//
			String localFile = "d:/insightFile/excel/" + todayDate + ".xlsx";
			
			File file = new File(localFile);
			FileOutputStream fos = null;
			fos = new FileOutputStream(file);
			xssfWb.write(fos);
			if (fos != null) fos.close();
		}catch(Exception e){
	        	
		}
	}
	
	 
	

	@GetMapping("/test")
	@ResponseBody
	public Map<String, String> bcTest() {
		
		List<AsgmtVO> twoList = ppservice.test("202309113");
		
		// 원하는 1줄 모습으로 변경!, 처음만 귀찮음, 또 써먹을 곳이 생김!
		Map<String, String> oneVO = new HashMap<String, String>();
		oneVO.put("preAsgmt", twoList.get(0).getAsgmtCcst());
		oneVO.put("preDtcode", twoList.get(0).getDtcode());
		oneVO.put("preGrdCode", twoList.get(0).getGrdCode());
		oneVO.put("preJcode", twoList.get(0).getJcode());
		oneVO.put("postAsgmt", twoList.get(1).getAsgmtCcst());
		oneVO.put("postDtcode", twoList.get(1).getDtcode());
		oneVO.put("postGrdCode", twoList.get(1).getGrdCode());
		oneVO.put("postJcode", twoList.get(1).getJcode());
		
		
		return oneVO;
		
		
	}
	
	
	//완료
	@GetMapping("/asgmtDetail")
	public String asgmtUpdate(
	    @RequestParam("writer") String writer,
	    @RequestParam("fwrDate") String fwrDate,
	    @RequestParam("ccst") String ccst,
	    @RequestParam("asgmtclf") String asgmtclf,
	    @RequestParam("lwrDate") String lwrDate,
	    Model model) {
	    
		
		
	    AsgmtVO asgmtVO = new AsgmtVO();
	    asgmtVO.setWriter(writer);
	    asgmtVO.setFwrDate(fwrDate);
	    asgmtVO.setAsgmtCcst(ccst);
	    asgmtVO.setLwrDate(lwrDate);
	    asgmtVO.setAsgmtClf(asgmtclf);
	    
	    
	    log.info("VOVO" + asgmtVO);
	    
	    List<AsgmtVO> asgmtDetailList =  ppservice.asgmtDetail(asgmtVO);
	
	    model.addAttribute("asgmtDetailList", asgmtDetailList);
	    log.debug("값이??"+ asgmtDetailList);
	    
	    
	   
	    
	    
	    return "hrm/asgmtDetail";
	}
	
	//진행
	@GetMapping("/asgmtDetailIng")
	public String asgmtUpdateIng(
			@RequestParam("writer") String writer,
			@RequestParam("fwrDate") String fwrDate,
			@RequestParam("ccst") String ccst,
			@RequestParam("asgmtclf") String asgmtclf,
			@RequestParam("lwrDate") String lwrDate,
			Model model) {
		
		
		
		AsgmtVO asgmtVO = new AsgmtVO();
		asgmtVO.setWriter(writer);
		asgmtVO.setFwrDate(fwrDate);
		asgmtVO.setAsgmtCcst(ccst);
		asgmtVO.setLwrDate(lwrDate);
		asgmtVO.setAsgmtClf(asgmtclf);
		
		
		log.info("VOVO" + asgmtVO);
		
		List<AsgmtVO> asgmtDetailList =  ppservice.asgmtIngCancel(asgmtVO);

		model.addAttribute("asgmtDetailList", asgmtDetailList);
		log.debug("값이??"+ asgmtDetailList);
		
		
		
		
		return "hrm/asgmtDetailIng";
	}
	
	//취소
	@GetMapping("/asgmtDetailCancel")
	public String asgmtUpdateCancel(
			@RequestParam("writer") String writer,
			@RequestParam("fwrDate") String fwrDate,
			@RequestParam("ccst") String ccst,
			@RequestParam("asgmtclf") String asgmtclf,
			@RequestParam("lwrDate") String lwrDate,
			Model model) {
		
		
		
		AsgmtVO asgmtVO = new AsgmtVO();
		asgmtVO.setWriter(writer);
		asgmtVO.setFwrDate(fwrDate);
		asgmtVO.setAsgmtCcst(ccst);
		asgmtVO.setLwrDate(lwrDate);
		asgmtVO.setAsgmtClf(asgmtclf);
		
		
		log.info("VOVO" + asgmtVO);
		
		List<AsgmtVO> asgmtDetailList =  ppservice.asgmtIngCancel(asgmtVO);
		model.addAttribute("asgmtDetailList", asgmtDetailList);
		log.debug("값이??"+ asgmtDetailList);
		

		return "hrm/asgmtDetailCancel";
	}
	
	@ResponseBody
	@PostMapping(value="/cancel", consumes = MediaType.APPLICATION_JSON_VALUE)
	public int cancel(@RequestBody List<Map<String, String>> empNoList) {
		
		int update = ppservice.cancelupdate(empNoList);
		
		return update;
	}
	
	@ResponseBody
	@PostMapping("/sUpdate")
	public int sUpdate(@RequestBody List<Map<String, String>> empNoList) throws Exception {
		
		log.info("인사발령 업데이트 체크"+ empNoList);
		excel(empNoList);
		int update = ppservice.sUpdate(empNoList);
				
		
		
		return update;
	}
	
	
		
	
	
	
	
	
	
}
