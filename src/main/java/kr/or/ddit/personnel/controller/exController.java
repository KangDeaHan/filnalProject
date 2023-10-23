package kr.or.ddit.personnel.controller;


import java.io.File;
import java.io.IOException;
import java.lang.reflect.Field;
import java.security.Principal;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import kr.or.ddit.common.vo.AccaVO;
import kr.or.ddit.common.vo.CnthxVO;
import kr.or.ddit.common.vo.DeptVO;
import kr.or.ddit.common.vo.EmpVO;
import kr.or.ddit.excelupload.ExcelRead;
import kr.or.ddit.excelupload.ExcelReadOption;
import kr.or.ddit.personnel.service.MemberService;
import kr.or.ddit.sms.service.CoolSmsService;
import kr.or.ddit.vo.AsgmtVO;
import kr.or.ddit.vo.AuthorAlwncVO;
import kr.or.ddit.vo.CareerVO;
import kr.or.ddit.vo.CmCodeVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/ex")
public class exController {
	@Autowired
	MemberService ppservice;
	
	@Autowired
	CoolSmsService coolSmsService;
	
	//암호화
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	@GetMapping("/ph")
	public String phCtr(HttpServletRequest request, Model model) {
		String name = request.getParameter("name");
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		String email = request.getParameter("email");

		model.addAttribute("id",id);
		model.addAttribute("name",name);
		model.addAttribute("pw",pw);
		model.addAttribute("email",email);
		
		log.info("받은 데이터 :",model);
		
		return "hrm/personnelHome";
	}
	@GetMapping("/excel")
	public String excelUpload() {
		
		return("hrm/excelUpload");
	}
	
	
	//사원 여러명 추가하기
	@ResponseBody
	@PostMapping("/excelUploadAjax")
    public ModelAndView excelUploadAjax(MultipartHttpServletRequest request,Principal principal)  throws Exception{
        MultipartFile excelFile =request.getFile("excelFile");
        System.out.println("엑셀 파일 업로드 컨트롤러");
        if(excelFile==null || excelFile.isEmpty()){
            throw new RuntimeException("엑셀파일을 선택 해 주세요.");
        }
        
        File destFile = new File("D:\\insightFile"+excelFile.getOriginalFilename());
        log.info("트랜스하기전 파일"+destFile);
        try{
            excelFile.transferTo(destFile);
        }catch(IllegalStateException | IOException e){
            throw new RuntimeException(e.getMessage(),e);
        }
        log.info("트랜스후 파일"+excelFile);
        
        //Service 단에서 가져온 코드 
        ExcelReadOption excelReadOption1 = new ExcelReadOption();
        excelReadOption1.setFilePath(destFile.getAbsolutePath());
        excelReadOption1.setOutputColumns("A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","W");
        excelReadOption1.setStartRow(2);
        ExcelReadOption excelReadOption2 = new ExcelReadOption();
        excelReadOption2.setFilePath(destFile.getAbsolutePath());
        excelReadOption2.setOutputColumns("C","U","V","W","X","Y","Z","AA","AB");
        excelReadOption2.setStartRow(2);
        ExcelReadOption excelReadOption3 = new ExcelReadOption();
        excelReadOption3.setFilePath(destFile.getAbsolutePath());
        excelReadOption3.setOutputColumns("C","AC","AD","AE","AF","AG");
        excelReadOption3.setStartRow(2);
        ExcelReadOption excelReadOption4 = new ExcelReadOption();
        excelReadOption4.setFilePath(destFile.getAbsolutePath());
        excelReadOption4.setOutputColumns("C","AH","AI","AJ","AK","AL","AM","AN","AO");
        excelReadOption4.setStartRow(2);
        
        log.info("엑셀리드옵션1 세팅 후"+excelReadOption1);
        log.info("엑셀리드옵션2 세팅 후"+excelReadOption2);
        log.info("엑셀리드옵션3 세팅 후"+excelReadOption3);
        log.info("엑셀리드옵션4 세팅 후"+excelReadOption4);
        
        List<Map<String, String>>excelContent1 =ExcelRead.read(excelReadOption1);
        log.info("엑셀콘텐트1"+excelContent1);
        log.info("엑셀콘텐트1첫번째는?"+excelContent1.get(1));
        log.info("엑셀콘텐트1두번째는?"+excelContent1.get(2));
        
        List<Map<String, String>>excelContent2 =ExcelRead.read(excelReadOption2);
        log.info("엑셀콘텐트2"+excelContent2);
        log.info("엑셀콘텐트2첫번째는?"+excelContent2.get(1));
        log.info("엑셀콘텐트2두번째는?"+excelContent2.get(2));
        
        List<Map<String, String>>excelContent3 =ExcelRead.read(excelReadOption3);
        log.info("엑셀콘텐트3"+excelContent3);
        log.info("엑셀콘텐트3첫번째는?"+excelContent3.get(1));
        log.info("엑셀콘텐트3두번째는?"+excelContent3.get(2));
        
        List<Map<String, String>>excelContent4 =ExcelRead.read(excelReadOption4);
        log.info("엑셀콘텐트4"+excelContent4);
        log.info("엑셀콘텐트4첫번째는?"+excelContent4.get(1));
        log.info("엑셀콘텐트4두번째는?"+excelContent4.get(2));
        
        
        //List 객체들 만들기
        List<EmpVO> empVOList = new ArrayList<EmpVO>();
        log.info("비어있니?empVOList"+empVOList);
        
        List<CnthxVO> cnthxVOList = new ArrayList<CnthxVO>();
        log.info("비어있니?cnthxVOList"+cnthxVOList);
        
        List<AccaVO> accaVOList = new ArrayList<AccaVO>();
        log.info("비어있니?accaVOList"+accaVOList);
        
        List<CareerVO> careerVOList = new ArrayList<CareerVO>();
        log.info("비어있니?careerVOList"+careerVOList);
        
        List<AuthorAlwncVO> authorAlwncVOlist = new ArrayList<AuthorAlwncVO>();
        log.info("비어있니?authorAlwncVOlist"+authorAlwncVOlist);
        
        List<AsgmtVO> asgmtVOlist = new ArrayList<AsgmtVO>();//병철이 인사발령 엔티티 VO리스트
        log.info("비어있니?asgmtVOlist"+asgmtVOlist);
        
 /*       List<DeptVO> deptVOList = new ArrayList<DeptVO>();
        log.info("비어있니?deptVOList"+deptVOList);*/
        
        
        
        // 엑셀 첫 번째 행에서 열의 이름을 가져옵니다.
        Map<String, String> firstRow1 = excelContent1.get(0);
        log.info("firstRow1의 과연 첫번째열은?firstRow"+firstRow1);
        Map<String, String> firstRow2 = excelContent2.get(0);
        log.info("firstRow2의 과연 첫번째열은?firstRow"+firstRow2);
        Map<String, String> firstRow3 = excelContent3.get(0);
        log.info("firstRow2의 과연 첫번째열은?firstRow"+firstRow3);
        Map<String, String> firstRow4 = excelContent4.get(0);
        log.info("firstRow2의 과연 첫번째열은?firstRow"+firstRow4);
        //사원정보 엑셀데이터 매칭
        for (Map<String, String> excelRow1 : excelContent1.subList(1, excelContent1.size())) {
            EmpVO empVO = new EmpVO();
           

            // 열의 이름을 반복하면서 열의 이름을 EmpVO 필드 이름에 맞춰서 변경
            for (String columnName : excelRow1.keySet()) {
                // 열의 이름을 가져오고, 필드 이름에 맞게 변경합니다.
                String fieldName = mapColumnNameToFieldName1(columnName);

                try {
                    // EmpVO 클래스에서 필드 이름과 일치하는 필드 찾기
                    Field field = EmpVO.class.getDeclaredField(fieldName);
                    field.setAccessible(true);
                    if(field.getName().equals("dcode")) {
                    	
                    	int dcode = Integer.parseInt(excelRow1.get(columnName));
                    	// 해당 필드에 값을 설정
                    	field.set(empVO, dcode);
                    	
                    }else {
                    	
                    	// 해당 필드에 값을 설정
                    	field.set(empVO, excelRow1.get(columnName));
                    }

                } catch (NoSuchFieldException | IllegalAccessException e) {
                    // 필드를 찾을 수 없거나 접근할 수 없는 경우 예외 처리
                    e.printStackTrace();
                }
            }

            // empVO 객체를 리스트에 추가
            empVOList.add(empVO);
           
            
        }
        log.info("empVOList 잘 들어 갔니?????????? : " + empVOList);
        //데이트타입으로 변환하기 위해 필요
        
        DateFormat dateFormat = new SimpleDateFormat("EEE MMM dd HH:mm:ss z yyyy", Locale.ENGLISH);
        // 부서정보 엑셀데이터 매칭
        for (Map<String, String> excelRow2 : excelContent2.subList(1, excelContent2.size())) {
        	CnthxVO cnthxVO = new CnthxVO();
        	
        	// 열의 이름을 반복하면서 열의 이름을 cnthxVO 필드 이름에 맞춰서 변경
        	for (String columnName : excelRow2.keySet()) {
        		// 열의 이름을 가져오고, 필드 이름에 맞게 변경합니다.
        		String fieldName = mapColumnNameToFieldName2(columnName);
        		
        		try {
        			// CnthxVO 클래스에서 필드 이름과 일치하는 필드 찾기
        			Field field = CnthxVO.class.getDeclaredField(fieldName);
        			field.setAccessible(true);
        			
        			// 해당 필드에 값을 설정
        			if(field.getName().equals("blctSdate") || field.getName().equals("blctEdate") 
        					|| field.getName().equals("bwctSdate") || field.getName().equals("bwctEdate") 
        					|| field.getName().equals("prSdate") || field.getName().equals("prEdate") ) {
        				log.info("excelRow2.get(columnName)값이야"+ excelRow2.get(columnName));
        				Date parsedDate = dateFormat.parse(excelRow2.get(columnName));
        				log.info("parsedDate값이야!!"+ parsedDate);
        				
        				field.set(cnthxVO, parsedDate);
	        			}else if(field.getName().equals("bcntAmt")){
	        				int bcntAmt = Integer.parseInt(excelRow2.get(columnName));
	        				field.set(cnthxVO, bcntAmt);
	        			}else {
	
	                        // 해당 필드에 값을 설정
	                        field.set(cnthxVO, excelRow2.get(columnName));
        				
        			}
        		} catch (NoSuchFieldException | IllegalAccessException e) {
        			// 필드를 찾을 수 없거나 접근할 수 없는 경우 예외 처리
        			e.printStackTrace();
        		}
        	}
        	
        	// cnthxVO 객체를 리스트에 추가
        	cnthxVOList.add(cnthxVO);
        	
        }
        log.info("cnthxVOList 잘 들어 갔니?????????? : " + cnthxVOList);
        
        for (Map<String, String> excelRow3 : excelContent3.subList(1, excelContent3.size())) {
        	AccaVO accaVO = new AccaVO();
        	
        	// 열의 이름을 반복하면서 열의 이름을 AccaVO 필드 이름에 맞춰서 변경
        	for (String columnName : excelRow3.keySet()) {
        		// 열의 이름을 가져오고, 필드 이름에 맞게 변경합니다.
        		String fieldName = mapColumnNameToFieldName3(columnName);
        		
        		try {
        			// AccaVO 클래스에서 필드 이름과 일치하는 필드 찾기
        			Field field = AccaVO.class.getDeclaredField(fieldName);
        			field.setAccessible(true);
        			
        			// 해당 필드에 값을 설정
        			if(field.getName().equals("acEtdate") || field.getName().equals("acEdate") ) {
        				log.info("excelRow2.get(columnName)값이야"+ excelRow3.get(columnName));
        				Date parsedDate = dateFormat.parse(excelRow3.get(columnName));
        				log.info("parsedDate값이야(acca)!!"+ parsedDate);
        				
        				field.set(accaVO, parsedDate);
        			}else {
        				
        				// 해당 필드에 값을 설정
        				field.set(accaVO, excelRow3.get(columnName));
        				
        			}
        		} catch (NoSuchFieldException | IllegalAccessException e) {
        			// 필드를 찾을 수 없거나 접근할 수 없는 경우 예외 처리
        			e.printStackTrace();
        		}
        	}
        	
        	// AccaVO 객체를 리스트에 추가
        	accaVOList.add(accaVO);
        	
        }
        log.info("accaVOList 잘 들어 갔니?????????? : " + accaVOList);
        
        for (Map<String, String> excelRow4 : excelContent4.subList(1, excelContent4.size())) {
        	CareerVO careerVO = new CareerVO();
        	
        	// 열의 이름을 반복하면서 열의 이름을 careerVO 필드 이름에 맞춰서 변경
        	for (String columnName : excelRow4.keySet()) {
        		// 열의 이름을 가져오고, 필드 이름에 맞게 변경합니다.
        		String fieldName = mapColumnNameToFieldName4(columnName);
        		
        		try {
        			// CareerVO 클래스에서 필드 이름과 일치하는 필드 찾기
        			Field field = CareerVO.class.getDeclaredField(fieldName);
        			field.setAccessible(true);
        			
        			// 해당 필드에 값을 설정
        			if(field.getName().equals("caEtdate") || field.getName().equals("caEdate") ) {
        				log.info("excelRow4.get(columnName)값이야"+ excelRow4.get(columnName));
        				Date parsedDate = dateFormat.parse(excelRow4.get(columnName));
        				log.info("parsedDate값이야(acca)!!"+ parsedDate);
        				
        				field.set(careerVO, parsedDate);
        			}else {
        				
        				// 해당 필드에 값을 설정
        				field.set(careerVO, excelRow4.get(columnName));
        				
        			}
        		} catch (NoSuchFieldException | IllegalAccessException e) {
        			// 필드를 찾을 수 없거나 접근할 수 없는 경우 예외 처리
        			e.printStackTrace();
        		}
        	}
        	
        	// careerVO 객체를 리스트에 추가
        	careerVOList.add(careerVO);
        	
        }
        log.info("careerVOList 잘 들어 갔니?????????? : " + careerVOList);
        
		//데이터 세팅용
		List<DeptVO> deptvoList = ppservice.selectDept();
		log.info("deptvoList 잘 들어 갔니?????????? : " + deptvoList);
		
		List<CmCodeVO> cmCodevoList = ppservice.selectCmcode();
		log.info("cmCodevoList 잘 들어 갔니?????????? : " + cmCodevoList);
		

        
        //벨류값 변환 세팅하기
        for (EmpVO empVO : empVOList) {
        	AuthorAlwncVO authorAlwncVO = new AuthorAlwncVO();
        	AsgmtVO asgmtVO = new AsgmtVO();
        	
            String entCaseCode = ""; //입사유형 초기값 설정
            String stClfCd = ""; // 재직상태코드 초기값 설정
            String ptnCode = ""; // 직위코드  초기값 설정
            String genCode = ""; // 성별코드 초기값 설정
            String jcode = ""; // 직무코드 초기값 설정
            String grdCode = ""; // 직급코드 초기값 설정
            int dcode = 0; // 부서코드 초기값 설정
            String dtcode = ""; // 직책코드 초기값 설정
            String bankCode = ""; // 직책코드 초기값 설정
            String ctrtCaseCode = ""; // 직책코드 초기값 설정
            
            //폰번호 세팅
			
			 String cpNum = "0"+empVO.getCpNo(); empVO.setCpNo(cpNum);
			 
            
            // 로그인맴버권한 저장 세팅
    		String authrtId = "ROLE_MEMBER";
    		String auempNo = empVO.getEmpNo();
    		authorAlwncVO.setAuthrtId(authrtId);
    		authorAlwncVO.setEmpNo(auempNo);
    		
    		
    		// 사원 추가 비밀번호 암호화 및 사원번호 부서VO에 세팅
    		String password = passwordEncoder.encode(empVO.getEmpPass());
    		empVO.setEmpPass(password);
    		log.info("암호화 되었느냐?!!! : " + password);
            
    		
    		// stClfCdNm 값에 따라 stClfCd 값을 설정합니다.
    		for(CmCodeVO cmCodeVO : cmCodevoList) {
    			if(cmCodeVO.getCmGroup().equals("tenure")) {
    				if(cmCodeVO.getCmNm().equals(empVO.getStClfCdNm())) {
    					stClfCd = cmCodeVO.getCmCode();
    				}
    			}
    		}
    		// empVO 객체에 stClfCd 값을 설정합니다.
    		empVO.setStClfCd(stClfCd);
    		log.info("stClfCd 값 진짜 개어렵다!!: " + empVO.getStClfCd());
           
            // entCaseNm 값에 따라 entCaseCode 값을 설정합니다.
    		for(CmCodeVO cmCodeVO : cmCodevoList) {
    			if(cmCodeVO.getCmGroup().equals("join")) {
    				if(cmCodeVO.getCmNm().equals(empVO.getEntCaseNm())) {
    					entCaseCode = cmCodeVO.getCmCode();
    				}
    			}
    		}
            // empVO 객체에 entCaseCode 값을 설정합니다.
            empVO.setEntCaseCode(entCaseCode);
            log.info("entCaseCode 값 진짜 개어렵다!!: " + empVO.getEntCaseCode());
            
            // ptnCodeNm 값에 따라 ptnCode 값을 설정합니다.
            for(CmCodeVO cmCodeVO : cmCodevoList) {
            	if(cmCodeVO.getCmGroup().equals("spot")) {
            		if(cmCodeVO.getCmNm().equals(empVO.getPtnCodeNm())) {
            			ptnCode = cmCodeVO.getCmCode();
            		}
            	}
            }
            // empVO 객체에 ptnCode 값을 설정합니다.
            empVO.setPtnCode(ptnCode);
            log.info("ptnCode 값 진짜 개어렵다!!: " + empVO.getPtnCode());
            
            // genCodeNm 값에 따라 genCode 값을 설정합니다.
            for(CmCodeVO cmCodeVO : cmCodevoList) {
            	if(cmCodeVO.getCmGroup().equals("gender")) {
            		if(cmCodeVO.getCmNm().equals(empVO.getGenCodeNm())) {
            			genCode = cmCodeVO.getCmCode();
            		}
            	}
            }
            // empVO 객체에 genCode 값을 설정합니다.
            empVO.setGenCode(genCode);
            log.info("genCode 값 진짜 개어렵다!!: " + empVO.getGenCode());
           
            empVO.setRegn(empVO.getRegn().replaceAll("-", ""));
            log.info("empVO.getRegn 잘 세팅됨? : " + empVO.getRegn());
            
            // getJcodeNm 값에 따라 jcode 값을 설정합니다.
            for(CmCodeVO cmCodeVO : cmCodevoList) {
            	if(cmCodeVO.getCmGroup().equals("job")) {
            		if(cmCodeVO.getCmNm().equals(empVO.getJcodeNm())) {
            			jcode = cmCodeVO.getCmCode();
            		}
            	}
            }
            // empVO 객체에 jcode 값을 설정합니다.
            empVO.setJcode(jcode);
            log.info("jcode 값 진짜 개어렵다!!: " + empVO.getJcode());
            
            // grdCodeNm 값에 따라 grdCode 값을 설정합니다.
            for(CmCodeVO cmCodeVO : cmCodevoList) {
            	if(cmCodeVO.getCmGroup().equals("hobong")) {
            		if(cmCodeVO.getCmNm().equals(empVO.getGrdCodeNm())) {
            			grdCode = cmCodeVO.getCmCode();
            		}
            	}
            }
            // empVO 객체에 grdCode 값을 설정합니다.
            empVO.setGrdCode(grdCode);
            log.info("grdCode 값 진짜 개어렵다!!: " + empVO.getGrdCode());
            
            // dtCodeNm 값에 따라 dtcode 값을 설정합니다.
            for(CmCodeVO cmCodeVO : cmCodevoList) {
            	if(cmCodeVO.getCmGroup().equals("position")) {
            		if(cmCodeVO.getCmNm().equals(empVO.getDtCodeNm())) {
            			dtcode = cmCodeVO.getCmCode();
            		}
            	}
            }
            // empVO 객체에 dtcode 값을 설정합니다.
            empVO.setDtcode(dtcode);
            log.info("dtcode 값 진짜 개어렵다!!: " + empVO.getDtcode());
            
            // bankCodeNm 값에 따라 bankCode 값을 설정합니다.
            for(CmCodeVO cmCodeVO : cmCodevoList) {
            	if(cmCodeVO.getCmGroup().equals("bank")) {
            		if(cmCodeVO.getCmNm().equals(empVO.getBankCodeNm())) {
            			bankCode = cmCodeVO.getCmCode();
            		}
            	}
            }
            // empVO 객체에 bankCode 값을 설정합니다.
            empVO.setBankCode(bankCode);
            log.info("bankCode 값 진짜 개어렵다!!: " + empVO.getBankCode());
            
            
            // dnm 값에 따라 dcode 값을 설정합니다.
            for(DeptVO deptVO : deptvoList) {
            	if(deptVO.getDnm().equals(empVO.getDnm())) {
            		dcode = deptVO.getDcode();
            	}
            }
            // empVO 객체에 bankCode 값을 설정합니다.
            empVO.setDcode(dcode);
            log.info("Dcode 값 진짜 개어렵다!!: " + empVO.getDcode());
            
            // ctrtCaseNm 값에 따라 ctrtCaseCode 값을 설정합니다.
            for(CmCodeVO cmCodeVO : cmCodevoList) {
            	if(cmCodeVO.getCmGroup().equals("contract")) {
            		if(cmCodeVO.getCmNm().equals(empVO.getCtrtCaseNm())) {
            			ctrtCaseCode = cmCodeVO.getCmCode();
            		}
            	}
            }
            
    		// 병철이 인사발령 엔티티에 필요한 데이터 세팅
    		asgmtVO.setAsgmtPers(empVO.getEmpNo());
    		asgmtVO.setWriter(principal.getName());
    		asgmtVO.setAsgmtClf("신규 직원 추가");
    		asgmtVO.setAsgmtRsn("신규 직원 추가");
    		asgmtVO.setAsgmtMm("신규 직원 추가");
    		asgmtVO.setAsgmtCcst("C0102");
    		asgmtVO.setDcode(""+empVO.getDcode());
    		asgmtVO.setDtcode(empVO.getDtcode());
    		asgmtVO.setPtnCode(empVO.getPtnCode());
    		asgmtVO.setGrdCode(empVO.getGenCode());
    		asgmtVO.setJcode(empVO.getJcode());
    		
    		log.info("asgmtVO 잘 들어 갔냐? : " + asgmtVO);

            
            
            
            // empVO 객체에 ctrtCaseCode 값을 설정합니다.
            empVO.setCtrtCaseCode(ctrtCaseCode);
            log.info("ctrtCaseCode 값 진짜 개어렵다!!: " + empVO.getCtrtCaseCode());
            
            // 로그인 정보 authorAlwncVOlist에 값 넣기
            authorAlwncVOlist.add(authorAlwncVO);
            // 인사발령 정보 asgmtVOlist에 세팅
            asgmtVOlist.add(asgmtVO);
            log.info("asgmtVOlist 하나하나 잘 들어 갔냐? : " + asgmtVOlist);
            
        }
        
        for (CnthxVO cnthxVO : cnthxVOList) {
        	
        	String ctrtCaseCode = "";
        	
        	// CtrtCaseCodeNm 값에 따라 ctrtCaseCode 값을 설정합니다.
        	for(CmCodeVO cmCodeVO : cmCodevoList) {
        		if(cmCodeVO.getCmGroup().equals("contract")) {
        			if(cmCodeVO.getCmNm().equals(cnthxVO.getCtrtCaseCodeNm())) {
        				ctrtCaseCode = cmCodeVO.getCmCode();
        			}
        		}
        	}
        	// empVO 객체에 ctrtCaseCode 값을 설정합니다.
        	cnthxVO.setCtrtCaseCode(ctrtCaseCode);
        	log.info("ctrtCaseCode 값 진짜 개어렵다!!: " + cnthxVO.getCtrtCaseCode());
        	log.info("cnthxVOList 하나하나 잘 들어 갔냐?! : " + cnthxVOList);
        	
        	
        	
        }
        for (AccaVO accaVO : accaVOList) {
        	
        	String gradClf = "";
        	
        	// GradClfNm 값에 따라 ctrtCaseCode 값을 설정합니다.
        	for(CmCodeVO cmCodeVO : cmCodevoList) {
        		if(cmCodeVO.getCmGroup().equals("graduate")) {
        			if(cmCodeVO.getCmNm().equals(accaVO.getGradClfNm())) {
        				gradClf = cmCodeVO.getCmCode();
        			}
        		}
        	}
        	// empVO 객체에 gradClf 값을 설정합니다.
        	accaVO.setGradClf(gradClf);
        	log.info("ctrtCaseCode 값 진짜 개어렵다!!: " + accaVO.getGradClf());
        	log.info("accaVOList 하나하나 잘 들어 갔냐?! : " + accaVOList);
        	
        }
        
        log.info("empVOListㅈㅂㄷㅂㅈㄷ"+empVOList);
        int result = 0;
        result += ppservice.insertEmpList(empVOList);
        log.info("empVOList에 잘 들어갔냐? 제발!!!!!"+empVOList);
        log.info("empVOList의 result값"+result);
        // 문자 발송 API 잠시 막아놓음
		
//		 if(result > 0) {
//			 for (EmpVO vo : empVOList) {
//				 coolSmsService.sendSMS(vo); 
//			} 
//		}
		 
        result += ppservice.insertCnthxList(cnthxVOList);
        log.info("cnthxVOList에 잘 들어갔냐? 제발!!!!!"+cnthxVOList);
        log.info("cnthxVOList의 result값"+result);
        
        result += ppservice.insertAuthorAlwncVOList(authorAlwncVOlist);
        log.info("authorAlwncVOlist에 잘 들어갔냐?!"+authorAlwncVOlist);
        log.info("authorAlwncVOlist의 result값"+result);
        
        result += ppservice.insertAsgmtVOList(asgmtVOlist);
        log.info("asgmtVOlist 모두 들어 갔냐? : " + asgmtVOlist);
        log.info("asgmtVOlist의 result값"+result);
        
        result += ppservice.insertAccaVOList(accaVOList);
        log.info("accaVOList 모두 들어 갔냐? : " + accaVOList);
        log.info("accaVOList의 result값"+result);
        
        result += ppservice.insertCareerVOList(careerVOList);
        log.info("careerVOList 모두 들어 갔냐? : " + careerVOList);
        log.info("careerVOList의 result값"+result);
        
        
        
        
//        for(Map<String, String> article: excelContent){
//            System.out.println(article.get("A"));
//            System.out.println(article.get("B"));
//            System.out.println(article.get("C"));
//            System.out.println(article.get("D"));
//            System.out.println(article.get("E"));
//            System.out.println(article.get("F"));
//            System.out.println(article.get("G"));
//            System.out.println(article.get("H"));
//        }
        
        //userService.excelUpload(destFile); //서비스 부분을 삭제한다.
        
        //FileUtils.forceDelete(destFile.getAbsolutePath());
        
        ModelAndView view = new ModelAndView();
        view.setViewName("hrm/personnelHome");
        return view;
    }
	
	
	
	private String mapColumnNameToFieldName1(String columnName) {
	    // 열 이름을 매핑하기 위한 로직을 추가합니다.
	    if ("A".equals(columnName)) {
	        return "empNm"; 
	    } else if ("B".equals(columnName)) {
	        return "stClfCdNm"; 
	    } else if ("C".equals(columnName)) {
	        return "empNo"; 
		} else if ("D".equals(columnName)) {
			return "empPass"; 
		} else if ("E".equals(columnName)) {
			return "entCaseNm"; 
		} else if ("F".equals(columnName)) {
			return "ptnCodeNm"; 
		} else if ("G".equals(columnName)) {
			return "empMail"; 
		} else if ("H".equals(columnName)) {
			return "genCodeNm"; 
		} else if ("I".equals(columnName)) {
			return "cpNo"; 
		} else if ("J".equals(columnName)) {
			return "empAddr1"; 
		} else if ("K".equals(columnName)) {
			return "empAddr2"; 
		} else if ("L".equals(columnName)) {
			return "empAddr3"; 
		} else if ("M".equals(columnName)) {
			return "regn"; 
		} else if ("N".equals(columnName)) {
			return "jcodeNm"; 
		} else if ("O".equals(columnName)) {
			return "grdCodeNm"; 
		} else if ("P".equals(columnName)) {
			return "dnm"; 
		} else if ("Q".equals(columnName)) {
			return "dtCodeNm"; 
		} else if ("R".equals(columnName)) {
			return "bankCodeNm"; 
		} else if ("S".equals(columnName)) {
			return "acctNo"; 
		} else if ("T".equals(columnName)) {
			return "owner"; 
		} else if ("W".equals(columnName)) {
			return "ctrtCaseNm"; 
		}
	    // 그 외의 열 이름은 필드 이름과 직접 일치하도록 설정
	    return columnName;
	}
	private String mapColumnNameToFieldName2(String columnName) {
		
		if ("C".equals(columnName)) {
		    return "empNo"; 
		} else if ("U".equals(columnName)) {
			return "blctSdate"; 
		} else if ("V".equals(columnName)) {
			return "blctEdate"; 
		} else if ("W".equals(columnName)) {
			return "ctrtCaseCodeNm"; 
		} else if ("X".equals(columnName)) {
			return "bwctSdate"; 
		} else if ("Y".equals(columnName)) {
			return "bwctEdate"; 
		} else if ("Z".equals(columnName)) {
			return "prSdate"; 
		} else if ("AA".equals(columnName)) {
			return "prEdate"; 
		} else if ("AB".equals(columnName)) {
			return "bcntAmt"; 
			
		}
		// 그 외의 열 이름은 필드 이름과 직접 일치하도록 설정
	    return columnName;
		
	}
	private String mapColumnNameToFieldName3(String columnName) {
		
		if ("C".equals(columnName)) {
			return "empNo"; 
		} else if ("AC".equals(columnName)) {
			return "acNm"; //학교명
		} else if ("AD".equals(columnName)) {
			return "acEtdate"; //입학일자
		} else if ("AE".equals(columnName)) {
			return "acEdate"; //졸업일자
		} else if ("AF".equals(columnName)) {
			return "gradClfNm"; //졸업구분코드
		} else if ("AG".equals(columnName)) {
			return "maj"; //전공
		
		}
		// 그 외의 열 이름은 필드 이름과 직접 일치하도록 설정
		return columnName;
		
	}
	private String mapColumnNameToFieldName4(String columnName) {
		
		if ("C".equals(columnName)) {
			return "empNo"; 
		} else if ("AH".equals(columnName)) {
			return "caNm"; //회사명
		} else if ("AI".equals(columnName)) {
			return "caEtdate"; //입사일자
		} else if ("AJ".equals(columnName)) {
			return "caEdate"; //퇴사일자
		} else if ("AK".equals(columnName)) {
			return "caCntcase"; //계약유형
		} else if ("AL".equals(columnName)) {
			return "caDept"; // 부서
		} else if ("AM".equals(columnName)) {
			return "caDuty"; //직책
		} else if ("AN".equals(columnName)) {
			return "caJob"; // 직무
		} else if ("AO".equals(columnName)) {
			return "caGrd"; //직위
			
		}
		// 그 외의 열 이름은 필드 이름과 직접 일치하도록 설정
		return columnName;
		
	}
	


}
