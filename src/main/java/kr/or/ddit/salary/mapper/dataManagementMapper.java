package kr.or.ddit.salary.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.common.vo.EmpVO;
import kr.or.ddit.salary.vo.SalaryCertVO;
import kr.or.ddit.setting.vo.CompanyInfoVO;

@Mapper
public interface dataManagementMapper {
	//사원 조회
	List<EmpVO> empList(String name);
	
	//empNo 선택에 따른 급여명세서 list(모달창에 출력) (파라미터 : empNo)
	//<select id="selectSCList" parameterType="SalaryCertVO" resultType="SalaryCertVO">
	public List<SalaryCertVO> selectSCList(SalaryCertVO salaryCertVO);
	
	//급여명세서 발급 INSERT (파라미터 : empNo, ptNo, prYr, prMth, scIsRsn)
	//<insert id="insertSC" parameterType="SalaryCertVO">
	public int insertSC(SalaryCertVO salaryCertVO);
	
	//급여명세서 출력 (파라미터 : scNo)
	//<select id="selectSalaryCert" parameterType="SalaryCertVO" resultType="SalaryCertVO">
	public List<SalaryCertVO> selectSalaryCert(SalaryCertVO salaryCertVO);
	
	//급여명세서 출력 (파라미터 : scNo) (개인용)
	//<select id="selectSalaryCert2" parameterType="SalaryCertVO" resultType="SalaryCertVO">
	public List<SalaryCertVO> selectSalaryCert2(SalaryCertVO salaryCertVO);
	
	//명세서 발급 내역 출력
	//<select id="selectScIssueList" resultType="SalaryCertVO" >
	public List<SalaryCertVO> selectScIssueList();
	
	//최신 연도, 누적 수령액 (파라미터 : empNo)
	//<select id="selectMaxPrYrSumNetAmt" parameterType="SalaryCertVO" resultType="SalaryCertVO">
	public SalaryCertVO selectMaxPrYrSumNetAmt(SalaryCertVO salaryCertVO);
	
	//연도별 누적 수령액 (파라미터 : empNo, prYr)
	//<select id="selectPrYrSumNetAmt" parameterType="SalaryCertVO" resultType="SalaryCertVO">
	public List<SalaryCertVO> selectPrYrSumNetAmt(SalaryCertVO salaryCertVO);

	//급여명세서 연도 선택
	public List<SalaryCertVO> loadYear(String empNo);
	
	//급여귀속연도,귀속월, 원천세액, 납세일자 리스트 (파라미터 : EMP_NO, 시작날짜(sdate), 끝날짜(edate))
	//<select id="selectTaxAmt" parameterType="SalaryCertVO" resultType="SalaryCertVO">
	public List<SalaryCertVO> selectTaxAmt(SalaryCertVO salaryCertVO);
	
	//과세총액 리스트 (파라미터 : EMP_NO, 시작날짜(sdate), 끝날짜(edate))
	//<select id="selectTotalTaxAmt" parameterType="SalaryCertVO" resultType="SalaryCertVO">
	public List<SalaryCertVO> selectTotalTaxAmt(SalaryCertVO salaryCertVO);
	
	//원천징수의무자 (회사정보) (회사명, 사업자등록번호, 사업장소재지, 대표자, 법인등록번호)
	//<select id="selectCompanyInfo" resultType="CompanyInfoVO">
	public CompanyInfoVO selectCompanyInfo();
	
	//납세자 (EMP) - 이름, 주민등록번호, 주소 (파라미터 : EMP_NO)
	//<select id="selectTaxpayer" parameterType="SalaryCertVO" resultType="EmpVO">
	public EmpVO selectTaxpayer(SalaryCertVO salaryCertVO);
	
	//소득증명서 발급 INSERT (파라미터 : scIsRsn, scType, empNo)
	//<insert id="insertINC" parameterType="SalaryCertVO">
	public int insertINC(SalaryCertVO salaryCertVO);
	
	//방금 발급된 증명서 발급사유, 발급일자 가져오기
	//<select id="selectScIsInfo" resultType="SalaryCertVO">
	public SalaryCertVO selectScIsInfo();
	
}
