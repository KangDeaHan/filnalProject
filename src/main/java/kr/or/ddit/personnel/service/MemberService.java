package kr.or.ddit.personnel.service;

import java.time.LocalDate;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.common.vo.AccaVO;
import kr.or.ddit.common.vo.CnthxVO;
import kr.or.ddit.common.vo.DeptVO;
import kr.or.ddit.common.vo.EmpVO;
import kr.or.ddit.common.vo.FileInfoVO;
import kr.or.ddit.vo.AsgmtVO;
import kr.or.ddit.vo.AuthMenuVO;
import kr.or.ddit.vo.AuthorAlwncVO;
import kr.or.ddit.vo.CareerVO;
import kr.or.ddit.vo.CmCodeVO;

public interface MemberService {
	//메소드 시그니처
	
	//회원정보 가져오기
	public EmpVO read(EmpVO empNo);
	
	//전체 회원 정보 가져오기(병철이)
	public List<EmpVO> memberList();
	
	//전체 사원 정보 가져오기(우재)
	public List<EmpVO> empList();
	
	//전체 사원 정보 불러오기(우재)
	public List<EmpVO> empList2();
	
	//전체 회원 정보 엑셀 다운(우재)
	public void generateExcelFile(List<EmpVO> employeeList, String filePath, HttpServletResponse response);
	
	//만료임박계약정보 조회(우재)근로계약
	public List<CnthxVO> eDateEmp(LocalDate startDate, LocalDate endDate);
	
	//만료임박계약정보 조회(우재)임금계약
	public List<CnthxVO> eDateEmp1(LocalDate startDate, LocalDate endDate);
	
	//수습기간중인 인원 조회(우재) 임금계약
	List<CnthxVO> eDateEmp2(Date currentDate);
	
	//인사발령 업데이트
	public int therr(DeptVO deptVO, EmpVO empVO, AsgmtVO asgmtVO);

	//부서정보 가져오기 (본부정보)
	public List<DeptVO> Acenter();

	//부서정보 가져오기 (부서정보)
	public List<DeptVO> Adept(String Anum);

	//부서정보 가져오기 (팀정보)
	public List<DeptVO> Ateam(String Anum2);

	//인사발령 대기상태 인설
	public int asgmtInsert(List<Map<String, String>> rowData, DeptVO deptVO, EmpVO empVO, AsgmtVO asgmtVO);

	//인사발령 목록 리스트
	public List<AsgmtVO> asgmtlist();

	
	//사원 추가하기(우재)
	public int insertEMP(EmpVO empVO,CnthxVO cnthxVO,FileInfoVO fileInfoVO,AuthorAlwncVO authorAlwncVO);
	//사원 추가 메뉴 불러오기(우재)
	public List<DeptVO> selectDept();
	//사원 추가 메뉴 불러오기(우재)
	public List<CmCodeVO> selectCmcode();
	
	//사원리스트 추가(엑셀리스트로 사원추가하기, 우재)
	public int insertEmpList(List<EmpVO> empVOList);
	//사원리스트 추가(엑셀리스트로 사원추가하기(cnthxVOList), 우재)
	public int insertCnthxList(List<CnthxVO> cnthxVOList);
	//사원리스트 추가(엑셀리스트로 사원추가하기(AuthorAlwncVO), 우재)
	public int insertAuthorAlwncVOList(List<AuthorAlwncVO> authorAlwncVOList);
	//사원리스트 추가(엑셀리스트로 사원추가하기(AsgmtVO), 우재)
	public int insertAsgmtVOList(List<AsgmtVO> asgmtVOList);
	//사원리스트 추가(엑셀리스트로 사원추가하기(AccaVO), 우재)
	public int insertAccaVOList(List<AccaVO> accaVOList);
	//사원리스트 추가(엑셀리스트로 사원추가하기(CareerVO), 우재)
	public int insertCareerVOList(List<CareerVO> careerVOList);
	

	//현재 본부 부서 등 현재정보
	public EmpVO nowdetail(String number);

	//발령 취소 업데이트
	public int cancelupdate(List<Map<String, String>> empNoList);

	//인사발령 업데이트
	public int sUpdate(List<Map<String, String>> empNoList);

	
	public List<AsgmtVO> test(String asgmtBC);

	//전 인사발령정보
	public AsgmtVO beforeDetail(AsgmtVO asgmtVO2);

	//발령 상세보기
	public List<AsgmtVO> asgmtDetail(AsgmtVO asgmtVO);


	//인사발령 진행중
	public List<AsgmtVO> asgmtIngCancel(AsgmtVO asgmtVO);

	//신입인사발령
	public int newInsert(AsgmtVO asgmtVO);

	//직위리스트
	public List<CmCodeVO> spotList();

	//직책 리스트
	public List<CmCodeVO> positionList();

	//직무 리스트
	public List<CmCodeVO> jobList();

	//직급 리스트
	public List<CmCodeVO> hobongList();

	//인사발령시 본부사람들 정보
	public List<EmpVO> memberList2(String team);

	//인사발령시 어디 부서있는지 선택
	public List<DeptVO> deptList();

	//권한별 메뉴 리스트
	public List<AuthMenuVO> authMenu();

	//코드 한글 변환
	public EmpVO change(EmpVO empVO);

	//부서정보 가져오기
	public List<DeptVO> deptList2();
}
