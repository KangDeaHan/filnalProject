package kr.or.ddit.salary.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.common.vo.EmpVO;
import kr.or.ddit.salary.vo.PageVO;
import kr.or.ddit.salary.vo.PayDedVO;
import kr.or.ddit.salary.vo.PdHistoryVO;
import kr.or.ddit.salary.vo.SalaryCertVO;

@Mapper
public interface SalaryMapper {

	//사원정보 리스트 출력
	//<select id="selectEmpList" resultType="EmpVO">
	public List<EmpVO> selectEmpList(PageVO pageVO);
	
	//전체 글 수 조회
	//<select id="getTotal" resultType="int">
	public int getTotal(PageVO pageVO);
	
	//1명의 급여정산번호 insert
	//<insert id="insertPR" parameterType="SalaryCertVO">
	public int insertPR(SalaryCertVO salaryCertVO);
	
	//정산대상자 명수
	//<select id="selectEmpCnt" parameterType="SalaryCertVO" resultType="int">
	public int selectEmpCnt(SalaryCertVO salaryCertVO);
	
	//salary_Cert 테이블에서 pt_no가 1번이고, pr_Yr, pr_Mth가 2023, 9인 사원 번호 리스트를 찾기.
	//<select id="selectCheckedEmpNoList" parameterType="SalaryCertVO" resultType="SalaryCertVO">
	public List<SalaryCertVO> selectCheckedEmpNoList(SalaryCertVO salaryCertVO);
	
	//한사람의 기본급 가져오는 쿼리 select
	//<select id="selectBaseSalary" parameterType="SalaryCertVO" resultType="SalaryCertVO">
	public SalaryCertVO selectBaseSalary(SalaryCertVO salaryCertVO);
	
	//지급항목 - 요약 부분에 들어갈 내용 select
	//<select id="selectOtherPay" parameterType="SalaryCertVO" resultType="PayDedVO">
	public List<PayDedVO> selectOtherPay(SalaryCertVO salaryCertVO);
	
	//지급항목이력 추가 insert
	//<insert id="insertPayHistory" parameterType="SalaryCertVO">
	public int insertPayHistory(SalaryCertVO salaryCertVO);
	
	//초과근무수당 - 연장, 야간, 휴일별 금액 각각 산출
	//<select id="selectOverTimePay" parameterType="SalaryCertVO" resultType="SalaryCertVO">
	public SalaryCertVO selectOverTimePay(SalaryCertVO salaryCertVO);
	
	//정산 지급항목 이력 - 기본급 insert 
	//<insert id="insertBasePay" parameterType="SalaryCertVO">
	public int insertBasePay(SalaryCertVO salaryCertVO);
	
	//정산 지급항목 이력 - 초과근무수당 insert
	//<insert id="insertOvertimePay" parameterType="SalaryCertVO">
	public int insertOvertimePay(SalaryCertVO salaryCertVO);
	
	//정산 지급항목 이력 - 기타수당 항목별로 insert
	//<insert id="insertOtherPay" parameterType="SalaryCertVO">
	public int insertOtherPay(SalaryCertVO salaryCertVO);
	
	//공제항목 - 법정 공제 항목 금액 전체 select (파라미터 : empNo, ptNo) 
	// / 결과값 : empNo, empNm, dpdntNum(부양가족수), totalTaxAmt(과세총액), pdNo, pdNm, pdAmt, pdLawYn
	//<select id="selectDedSummary" parameterType="SalaryCertVO" resultType="SalaryCertVO">
	public List<SalaryCertVO> selectDedSummary(SalaryCertVO salaryCertVO);
	
	//공제항목 - 기타 공제 항목 금액 전체 select (파라미터 : empNo, ptNo) 
	// / 결과값 : empNo, empNm, dpdntNum(부양가족수), totalTaxAmt(과세총액), pdNo, pdNm, pdAmt, pdLawYn   
	//<select id="selectOtherDed" parameterType="SalaryCertVO" resultType="SalaryCertVO">
	public List<SalaryCertVO> selectOtherDed(SalaryCertVO salaryCertVO);
	
	//정산 공제항목 이력 - 공제항목 insert (법정공제항목, 기타공제항목 쿼리 동일) (파라미터 : pdNm, empNo, ptNo, prYr, prMth, pdAmt (SalaryCertVO))
	//<insert id="insertWageDed" parameterType="SalaryCertVO">
	public int insertWageDed(SalaryCertVO salaryCertVO);
	
	//선택된 정산대상자 정보 조회  (wagePrev에서 사용) (파라미터 : empNo)
	//<select id="selectCheckedEmpInfo" parameterType="SalaryCertVO" resultMap="empMap">
	public EmpVO selectCheckedEmpInfo(SalaryCertVO salaryCertVO);
	
	//정산이력 지급항목 조회 (파라미터 : scNo)
	//<select id="selectPayHistory" parameterType="SalaryCertVO" resultType="PdHistoryVO">
	public List<PdHistoryVO> selectPayHistory(SalaryCertVO salaryCertVO);
	
	//정산이력 공제항목 조회 (파라미터 : scNo)
	//<select id="selectDedHistory" parameterType="SalaryCertVO" resultType="PdHistoryVO">
	public List<PdHistoryVO> selectDedHistory(SalaryCertVO salaryCertVO);

	//정산이력 지급항목 갯수 조회 (파라미터 : scNo)
	//<select id="selectPayCount" parameterType="SalaryCertVO" resultType="int">
	public int selectPayCount(SalaryCertVO salaryCertVO);
	
	//정산이력 공제항목 갯수 조회 (파라미터 : scNo)
	//<select id="selectDedCount" parameterType="SalaryCertVO" resultType="int">
	public int selectDedCount(SalaryCertVO salaryCertVO);
	
	//정산 지급 합 (파라미터 : empNo)
	//<select id="selectPaySum" parameterType="SalaryCertVO" resultType="int">
	public int selectPaySum(SalaryCertVO salaryCertVO);
	
	//정산 공제 합 (파라미터 : empNo)
	//<select id="selectDedSum" parameterType="SalaryCertVO" resultType="int">
	public int selectDedSum(SalaryCertVO salaryCertVO);
	
	//정산 지급총액, 공제총액, 실지급액 UPDATE (파라미터 : pytlAmt, ddtlAmt, netAmt, empNo, ptNo, prYr, prMth)        
	//<update id="updateFinalAmt" parameterType="SalaryCertVO">
	public int updateFinalAmt(SalaryCertVO salaryCertVO);
	
	//급여정산 완료 페이지 (급여대장 요약) (wageRes) (파라미터 : prYr, prMth, ptNo)
	//<select id="selectSCSummary" parameterType="SalaryCertVO" resultType="SalaryCertVO">
	public SalaryCertVO selectSCSummary(SalaryCertVO salaryCertVO);
	
	//지난정산내역 리스트 출력 (pastPayRoll) parameter : prYr(키워드로 받아야 함, 기본값 : select한 가장최신연도)
	//<select id="selectPastPayroll" parameterType="SalaryCertVO" resultType="SalaryCertVO">
	public List<SalaryCertVO> selectPastPayroll(SalaryCertVO salaryCertVO);
	
	//정산내역 중 가장 최근의 연도 추출 (pastPayroll)
	//<select id="selectLatestPrYr" resultType="int">
	public int selectLatestPrYr();
	
	//정산내역 삭제 (pastPayroll) (파라미터 : ptNo, prYr, prMth) //같은 귀속연월의 급여정산이면 SC 여러줄 삭제 가능
	//<delete id="deletePayroll" parameterType="SalaryCertVO">
	public int deletePayroll(SalaryCertVO salaryCertVO);
	
	//엑셀 다운로드 자료 리스트 (파라미터 : ptNo, prYr, prMth)
	//<select id="selectExcelDownList" parameterType="SalaryCertVO" resultType="SalaryCertVO">
	public List<SalaryCertVO> selectExcelDownList(SalaryCertVO salaryCertVO);
	
}
