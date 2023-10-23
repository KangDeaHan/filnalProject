package kr.or.ddit.personnel.service.Impl;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.DataFormat;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.apache.velocity.runtime.log.Log;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.common.vo.AccaVO;
import kr.or.ddit.common.vo.CnthxVO;
import kr.or.ddit.common.vo.DeptVO;
import kr.or.ddit.common.vo.EmpVO;
import kr.or.ddit.common.vo.FileInfoVO;
import kr.or.ddit.personnel.mapper.MemberMapper;
import kr.or.ddit.personnel.service.MemberService;
import kr.or.ddit.vo.AsgmtVO;
import kr.or.ddit.vo.AuthMenuVO;
import kr.or.ddit.vo.AuthorAlwncVO;
import kr.or.ddit.vo.CareerVO;
import kr.or.ddit.vo.CmCodeVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	MemberMapper memberMapper;
	
	//실제 필요한 메소드는 요것만
	@Override
	public EmpVO read(EmpVO empNo) {
		return this.memberMapper.read(empNo);
	}
	//사원추가
	@Override
	@Transactional
	public int insertEMP(EmpVO empVO, CnthxVO cnthxVO, FileInfoVO fileInfoVO, AuthorAlwncVO authorAlwncVO) {
	    int empResult = this.memberMapper.insertEMP(empVO);
	    int cnthxResult = this.memberMapper.insertCnthx(cnthxVO);
	    int fileInfoResult = this.memberMapper.insertFileInfo(fileInfoVO);
	    int authorAlwncResult = this.memberMapper.insertAuthorAlwnc(authorAlwncVO);

	    if (empResult > 0 && cnthxResult > 0 && fileInfoResult > 0 && authorAlwncResult > 0) {
	        // 두 개의 데이터베이스 삽입이 모두 성공한 경우
	        // 추가 작업을 수행하거나 성공 메시지를 로그에 기록할 수 있습니다.
	        log.info("사원 정보와 Cnthx 정보가 성공적으로 삽입되었습니다.");
	        return 1; // 또는 성공을 나타내는 다른 값
	    } else {
	        // 실패한 경우 예외 처리 또는 에러 처리를 수행합니다.
	        String errorMessage = "사원 정보 또는 Cnthx 정보를 삽입하는데 실패했습니다. " +
	            "Emp Result: " + empResult + ", Cnthx Result: " + cnthxResult + ", fileInfo Result: " + fileInfoResult;
	        log.error(errorMessage);
	        throw new RuntimeException(errorMessage);
	    }
	}
	
	//사원리스트 추가(엑셀리스트로 사원추가하기, 우재)
	@Override
	public int insertEmpList(List<EmpVO> empVOList) {
		for (EmpVO empVO : empVOList) {
			log.info("여기에 잘있냐 있으면 말이 안됨 : " + empVO.getEmpNo());
		}
		int empListResult = this.memberMapper.insertEmpList(empVOList);
			
		
		return empListResult;
	}
	//사원리스트 추가(엑셀리스트로 사원추가하기(cnthxVOList), 우재)
	@Override
	public int insertCnthxList(List<CnthxVO> cnthxVOList) {
		
		int cnthxListResult = this.memberMapper.insertCnthxList(cnthxVOList);
		
		
		return cnthxListResult;
	}
	@Override
	public int insertAuthorAlwncVOList(List<AuthorAlwncVO> authorAlwncVOList) {
		int authorAlwncVOListResult = this.memberMapper.insertAuthorAlwncVOList(authorAlwncVOList);
		
		
		return authorAlwncVOListResult;
	}
	@Override
	public int insertAsgmtVOList(List<AsgmtVO> asgmtVOList) {
		int asgmtVOListResult = this.memberMapper.insertAsgmtVOList(asgmtVOList);
		
		
		return asgmtVOListResult;
	}
	
	//사원리스트 추가(엑셀리스트로 사원추가하기(AccaVO), 우재)
	@Override
	public int insertAccaVOList(List<AccaVO> accaVOList) {
		int accaVOListResult = this.memberMapper.insertAccaVOList(accaVOList);
		
		
		return accaVOListResult;
	}
	//사원리스트 추가(엑셀리스트로 사원추가하기(CareerVO), 우재)
	@Override
	public int insertCareerVOList(List<CareerVO> careerVOList) {
		int careerVOListResult = this.memberMapper.insertCareerVOList(careerVOList);
		
		
		return careerVOListResult;
	}
	
	//사원 추가 메뉴 불러오기(우재)
	@Override
	public List<DeptVO> selectDept() {
		return this.memberMapper.selectDept();
	}
	@Override
	public List<CmCodeVO> selectCmcode() {
		return this.memberMapper.selectCmcode();
	}

	@Override
	public List<EmpVO> memberList() {
		// TODO Auto-generated method stub
		return this.memberMapper.memberList();
	}
	
	//전체 사원 리스트 불러오는 메소드
	@Override
	public List<EmpVO> empList() {
		// TODO Auto-generated method stub
		return this.memberMapper.empList();
	}
	
	//전체 사원 리스트 불러오는 메소드
	@Override
	public List<EmpVO> empList2() {
		// TODO Auto-generated method stub
		return this.memberMapper.empList2();
	}
	
    @Override
    public void generateExcelFile(List<EmpVO> employeeList, String filePath, HttpServletResponse response) {
        try (Workbook workbook = new XSSFWorkbook()) {
            Sheet sheet = workbook.createSheet("Employee Data");

            // 날짜 포맷 스타일을 설정
            CellStyle cellStyle = workbook.createCellStyle();
            DataFormat dataFormat = workbook.createDataFormat();
            cellStyle.setDataFormat(dataFormat.getFormat("yyyy-MM-dd")); // 날짜 포맷 지정
            
            // 열 헤더 생성
            Row headerRow = sheet.createRow(0);
            String[] headers = {"이름", "상태", "사번", "입사일", "퇴직일", "입사 유형", "직급", "직위", "조직", "주조직 직책", "이메일", "성별", "휴대전화"};
            for (int i = 0; i < headers.length; i++) {
                Cell cell = headerRow.createCell(i);
                cell.setCellValue(headers[i]);
            }

            // 데이터 채우기
            int rowNum = 1;
            for (EmpVO empVO : employeeList) {
                Row row = sheet.createRow(rowNum++);
                row.createCell(0).setCellValue(empVO.getEmpNm());
                row.createCell(1).setCellValue(empVO.getStClfCdNm());
                row.createCell(2).setCellValue(empVO.getEmpNo());
                // 날짜 셀에 스타일 적용
                Cell dateCell = row.createCell(3);
                dateCell.setCellValue(empVO.getEntDate());
                dateCell.setCellStyle(cellStyle); // 날짜 스타일 적용               
                Cell exitDateCell = row.createCell(4);
                exitDateCell.setCellValue(empVO.getOutDate());
                exitDateCell.setCellStyle(cellStyle); // 날짜 스타일 적용
                row.createCell(5).setCellValue(empVO.getEntCaseNm());
                row.createCell(6).setCellValue(empVO.getGrdCodeNm());
                row.createCell(7).setCellValue(empVO.getPtnCodeNm());
                row.createCell(8).setCellValue(empVO.getDeptVOList().getDnm());
                row.createCell(9).setCellValue(empVO.getDtCodeNm());
                row.createCell(10).setCellValue(empVO.getEmpMail());
                row.createCell(11).setCellValue(empVO.getGenCodeNm());
                row.createCell(12).setCellValue(empVO.getCpNo());
            }

            // 열 너비 지정 
            for (int columnIndex = 0; columnIndex < 13; columnIndex++) {
                sheet.setColumnWidth(columnIndex, 18 * 256); // 15 characters
            }
            // 파일 저장
            try (FileOutputStream outputStream = new FileOutputStream(filePath)) {
                workbook.write(outputStream);
                log.info("제대로들어와라 제발"+filePath);
            }

     
        } catch (Exception e) {
            e.printStackTrace();
            // 예외 처리 로직 추가
        }
    
        
    }
    
	//계약만료임박정보 조회(우재)근로계약
    @Override
    public List<CnthxVO> eDateEmp(LocalDate startDate, LocalDate endDate) {
    	
    	return memberMapper.eDateEmp(startDate, endDate);
    }
    //계약만료임박정보 조회(우재)임금계약
    @Override
    public List<CnthxVO> eDateEmp1(LocalDate startDate, LocalDate endDate) {
    	
    	return memberMapper.eDateEmp1(startDate, endDate);
    }
    //수습기간중인 인원 조회(우재) 임금계약
    @Override
    public List<CnthxVO> eDateEmp2(Date currentDate) {
        // currentDate를 사용하여 비즈니스 로직을 수행
        // 예를 들어, currentDate를 기준으로 수습 중인 인원을 조회하는 코드를 작성

        // Mapper를 호출하여 데이터베이스에서 필요한 정보를 가져옴
        List<CnthxVO> employeesInProbation = memberMapper.eDateEmp2(currentDate);

        // 필요한 로직을 수행하고, employeesInProbation을 필터링 또는 처리

        return employeesInProbation;
    }
	

	@Override
	@Transactional
	public int therr(DeptVO deptVO, EmpVO empVO, AsgmtVO asgmtVO) {

//		int s = memberMapper.empupdate(deptVO);
//		int a = memberMapper.deptupdate(empVO);
//		int c = memberMapper.asgmtVO(asgmtVO);
		
		return 0;
	}

	//부정정보 가져오기(본부,부서 팀)
	@Override
	public List<DeptVO> Acenter() {
		return this.memberMapper.Acenter();
	}

	@Override
	public List<DeptVO> Adept(String Anum) {
		return this.memberMapper.Adept(Anum);
	}

	@Override
	public List<DeptVO> Ateam(String Anum2) {
		return this.memberMapper.Ateam(Anum2);
	}
	//부서정보가져오기 끝

	
	//인사발령 대기상태 인설트
	@Transactional
	@Override
	public int asgmtInsert(List<Map<String, String>> rowData, DeptVO deptVO, EmpVO empVO, AsgmtVO asgmtVO) {
		
		List<AsgmtVO> assignmentList = new ArrayList<AsgmtVO>();
		
		int insert = 0;
	    for (Map<String, String> rowDataItem : rowData) {
	        String EMP_IMG = rowDataItem.get("EMP_IMG");  //프로필
	        String EMP_NM = rowDataItem.get("EMP_NM"); 	//발령자 이름
	        String EMP_NO = rowDataItem.get("EMP_NO");	//발령자 사원번호
	        String JCODE = rowDataItem.get("JCODE");	//직무 영업, 인사 등등
	        String PTN_CODE = rowDataItem.get("PTN_CODE"); // 직위// 사원 대리 과장
	        String DTCODE = rowDataItem.get("DTCODE"); // 직책//팀장 파트장
	        String GRD_CODE = rowDataItem.get("GRD_CODE"); //연차 호봉
	        String head = rowDataItem.get("head");   //조직장 여부 Y, N
	        String dcode= rowDataItem.get("DCODE");   //부서
	        
	        
	        //작성자
	        String WempNn = rowDataItem.get("WempNn");
	        String WempNo = rowDataItem.get("WempNo");
	        
	        //발령
	        String Apromotion = rowDataItem.get("Apromotion"); //발령종류
	        String Adate = rowDataItem.get("Adate"); //발려일
	        String note = rowDataItem.get("note");  //메모
	        String rsn = rowDataItem.get("rsn");  //메모
	        
	        asgmtVO = new AsgmtVO();
	        
	        asgmtVO.setAsgmtPers(EMP_NO); //발령대상
	        asgmtVO.setWriter(WempNo); //작성자
	        asgmtVO.setAsgmtClf(Apromotion);  //발령구분
	        asgmtVO.setAsgmtRsn(rsn); //발령사유
	        asgmtVO.setAsgmtMm(note); //발령메모
	        asgmtVO.setAsgmtDate(Adate); //발령일
	        asgmtVO.setAsgmtCcst("C0101"); //결재상태코드 대기중
	        asgmtVO.setDtcode(DTCODE);
	        asgmtVO.setPtnCode(PTN_CODE);
	        asgmtVO.setJcode(JCODE);
	        asgmtVO.setGrdCode(GRD_CODE);
	        asgmtVO.setDcode(dcode);
	        asgmtVO.setDtcode(DTCODE);
	        
	        assignmentList.add(asgmtVO);
	    }
	    
		log.info("assignmentList : " + assignmentList);
		
	    insert = memberMapper.asgmtInsert(assignmentList);
		
		
		return insert;
	}

	@Override
	public List<AsgmtVO> asgmtlist() {
		return memberMapper.asgmtlist();
	}
	
	@Override
	public EmpVO nowdetail(String number) {
		
		return memberMapper.nowdetail(number);
	}
	
	//인사발령 취소 
	@Transactional
	@Override
	public int cancelupdate(List<Map<String, String>> empNoList) {
		
		int update=0;
		
		
		for(Map<String, String> Data : empNoList) {
			AsgmtVO asgmtVO = new AsgmtVO();

			
			asgmtVO.setAsgmtPers(Data.get("empNo"));
			asgmtVO.setAsgmtRsn(Data.get("asgmtRsn"));
			asgmtVO.setAsgmtCcst("C0103");
			asgmtVO.setFwrDate(Data.get("fwrDate"));

			log.info("서비스 브이" + asgmtVO);
			
			
			update += memberMapper.cancelupdate(asgmtVO);
			
		}
		
		
		return update;
	}
	
	//인사발령 업데이트
	@Transactional
	@Override
	public int sUpdate(List<Map<String, String>> empNoList) {

		int update =0;
		
		
		for(Map<String, String> Data : empNoList) {
			AsgmtVO asgmtVO = new AsgmtVO();
			asgmtVO.setAsgmtCcst("C0102");
			asgmtVO.setAsgmtPers(Data.get("empNo"));
			asgmtVO.setFwrDate(Data.get("fwrDate"));
			
			update += memberMapper.ccstUpdate(asgmtVO) ;
			
			 int deptno=0;
			 String aCenterValue = Data.get("aCenter");
			 String bCenterValue = Data.get("bCenter");
			 String cCenterValue = Data.get("cCenter");
			 
			 if(cCenterValue.equals("") && !bCenterValue.equals("")) {
				 deptno = memberMapper.deptno(bCenterValue);
			 }else if(bCenterValue.equals("") && !aCenterValue.equals("")) {
				 deptno = memberMapper.deptno(aCenterValue);
			 } else if(!cCenterValue.equals("")) {
				 deptno = memberMapper.deptno(cCenterValue);
			 }
			
			log.info("이건뭔가요" + deptno);
			
			EmpVO empVO = new EmpVO();
			empVO.setEmpNo(Data.get("empNo"));
			empVO.setDcode(deptno);
			empVO.setPtnCode(Data.get("ptnCode")); //사원
			empVO.setGrdCode(Data.get("grdCode")); //호봉
			empVO.setJcode(Data.get("jCode"));  //직무
			empVO.setDtcode(Data.get("dtCode")); //직급
			
			log.info("EMPVO쳌" +empVO);
			
			update +=memberMapper.sUpdate(empVO);		
		}
		
		return update;
	}
	@Override
	public List<AsgmtVO> test(String asgmtBC) {
		return memberMapper.test(asgmtBC);
	}
	
	//전 인사발령 정보
	@Override
	public AsgmtVO beforeDetail(AsgmtVO asgmtVO2) {
		return memberMapper.beforeDetail(asgmtVO2);
	}
	//인사발령 성공 상세정보
	@Override
	public List<AsgmtVO> asgmtDetail(AsgmtVO asgmtVO) {
		
		return memberMapper.asgmtDetail(asgmtVO);

	}

	//인사발령 진행중
	@Override
	public List<AsgmtVO> asgmtIngCancel(AsgmtVO asgmtVO){
		return memberMapper.asgmtIngCancel(asgmtVO);
	}
	
	//신입 인사발령
	@Override
	public int newInsert(AsgmtVO asgmtVO) {
		return memberMapper.newInsert(asgmtVO);
	}
	
	//직위 리스트
	@Override
	public List<CmCodeVO> spotList() {
		return memberMapper.spotList();
	}
	//직책리스트
	@Override
	public List<CmCodeVO> positionList() {
		return memberMapper.positionList();
	}
	//조직리스트
	@Override
	public List<CmCodeVO> jobList() {
		return memberMapper.jobList();
	}
	//직급리스트
	@Override
	public List<CmCodeVO> hobongList() {
		return memberMapper.hobongList();
	}
	@Override
	public List<EmpVO> memberList2(String team) {
		return this.memberMapper.memberList2(team);
	}
	@Override
	public List<DeptVO> deptList() {
		// TODO Auto-generated method stub
		return memberMapper.deptList();
	}
	@Override
	public List<AuthMenuVO> authMenu() {
		// TODO Auto-generated method stub
		return memberMapper.authMenu();
	}
	@Override
	public EmpVO change(EmpVO empVO) {
		return memberMapper.change(empVO);
	}
	@Override
	public List<DeptVO> deptList2() {
		return memberMapper.deptList2();
	}
}