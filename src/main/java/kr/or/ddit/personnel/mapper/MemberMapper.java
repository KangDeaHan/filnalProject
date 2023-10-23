package kr.or.ddit.personnel.mapper;

import java.time.LocalDate;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.common.vo.AccaVO;
import kr.or.ddit.common.vo.CnthxVO;
import kr.or.ddit.common.vo.DeptVO;
import kr.or.ddit.common.vo.EmpVO;
import kr.or.ddit.common.vo.FileInfoVO;
import kr.or.ddit.vo.AsgmtVO;
import kr.or.ddit.vo.AuthMenuVO;
import kr.or.ddit.vo.AuthVO;
import kr.or.ddit.vo.AuthorAlwncVO;
import kr.or.ddit.vo.CareerVO;
import kr.or.ddit.vo.CmCodeVO;

@Mapper //mybatis-scan 설정해 놓았기 때문에 생략가능
public interface MemberMapper {
	

	//테스트용 2개 메소드
	public int insertAuth(AuthVO auth);	
	
	//실제 필요한 메소드는 요것만
	//<select id="read" resultMap="memberMap" parameterType="string">
	public EmpVO read(EmpVO empNo);
	
	//전체 사원 불러오기(병철)
	public List<EmpVO> memberList();
	
	//전체 사원 불러오기(우재)
	public List<EmpVO> empList();
	
	//전체 사원 불러오기(우재)
	public List<EmpVO> empList2();
	
	//사원추가(우재)
	public int insertEMP(EmpVO empVO);
	public int insertCnthx(CnthxVO cnthxVO);
	public int insertFileInfo(FileInfoVO fileInfoVO);
	public int insertAuthorAlwnc(AuthorAlwncVO authorAlwncVO);
	
	
	//사원 추가 메뉴 불러오기(우재)
	public List<DeptVO> selectDept();
	//사원 추가 메뉴 불러오기(우재)
	public List<CmCodeVO> selectCmcode();
	
	//사원리스트 추가(엑셀리스트로 사원추가하기, 우재)
	public int insertEmpList(List<EmpVO> empVOList);
	//사원리스트 추가(엑셀리스트로 사원추가하기(cnthxVOList), 우재)
	public int insertCnthxList(List<CnthxVO> cnthxVOList);
	//사원리스트 추가(엑셀리스트로 사원추가하기(authorAlwncVOList), 우재)
	public int insertAuthorAlwncVOList(List<AuthorAlwncVO> authorAlwncVOList);
	//사원리스트 추가(엑셀리스트로 사원추가하기(AsgmtVO), 우재)
	public int insertAsgmtVOList(List<AsgmtVO> asgmtVOList);
	//사원리스트 추가(엑셀리스트로 사원추가하기(AccaVO), 우재)
	public int insertAccaVOList(List<AccaVO> accaVOList);
	//사원리스트 추가(엑셀리스트로 사원추가하기(CareerVO), 우재)
	public int insertCareerVOList(List<CareerVO> careerVOList);
	
	//계약만료임박정보 조회(우재) 근로계약
	public List<CnthxVO> eDateEmp(@Param("startDate") LocalDate startDate, @Param("endDate") LocalDate endDate);
	//계약만료임박정보 조회(우재) 임금계약
	public List<CnthxVO> eDateEmp1(@Param("startDate") LocalDate startDate, @Param("endDate") LocalDate endDate);	
	//수습기간중인 인원 조회(우재) 임금계약
	public List<CnthxVO> eDateEmp2(Date currentDate);
	
	//부서정보 가져오기 (본부정보)
	public List<DeptVO> Acenter();
	
	//부서정보 가져오기 (부서정보)
	public List<DeptVO> Adept(String Anum);
	
	//부서정보 가져오기 (팀)
	public List<DeptVO> Ateam(String Anum2);
	
	//인사발령 대기상태 인설트
	public int asgmtInsert(List<AsgmtVO> assignmentList);
	
	//인사발령 목록 리스트
	public List<AsgmtVO> asgmtlist();
	
	//인사발령 목록 리스트
	public List<AsgmtVO> asgmtDetail(AsgmtVO asgmtVO);

	//현재 본부 부서 정보등
	public EmpVO nowdetail(String number);

	//취소 업데이트
	public int cancelupdate(AsgmtVO asgmtVo);

	//부서이름을 부서코드로 변환
	public int deptno(String string);

	//인사발령 승인  ccst 업데이트
	public int ccstUpdate(AsgmtVO asgmtVO);

	//인사발령 승인 EMP 업데이트
	public int sUpdate(EmpVO empVO);

	public List<AsgmtVO> test(String asgmtBC);

	//전 인사발령 정보
	public AsgmtVO beforeDetail(AsgmtVO asgmtVO2);

	//진행중
	//<select id="asgmtIng" resultType="AsgmtVO" parameterType="AsgmtVO">
	public List<AsgmtVO> asgmtIngCancel(AsgmtVO asgmtVO);

	
	//신입인사발령
	public int newInsert(AsgmtVO asgmtVO);

	//직위리스트
	public List<CmCodeVO> spotList();

	//직책 리스트
	public List<CmCodeVO> positionList();

	//조직 리스트
	public List<CmCodeVO> jobList();

	//직급 리스트
	public List<CmCodeVO> hobongList();

	//인사발령시 본부사람들 정보
	public List<EmpVO> memberList2(String team);

	//인사발령시 부서 리스트
	public List<DeptVO> deptList();

	//권한별 메뉴
	public List<AuthMenuVO> authMenu();

	// 코드 한글 변환
	public EmpVO change(EmpVO empVO);

	//부서정보 가져오기
	public List<DeptVO> deptList2();

}