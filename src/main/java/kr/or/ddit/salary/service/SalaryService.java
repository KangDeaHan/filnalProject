package kr.or.ddit.salary.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.common.vo.EmpVO;
import kr.or.ddit.salary.vo.PageVO;
import kr.or.ddit.salary.vo.PayDedVO;
import kr.or.ddit.salary.vo.PdHistoryVO;
import kr.or.ddit.salary.vo.SalaryCertVO;

public interface SalaryService {
	
	//사원정보 리스트 출력
	public List<EmpVO> selectEmpList(PageVO pageVO);
	
	//전체 글 수 조회
	public int getTotal(PageVO pageVO);
	
	//1명의 급여정산번호 insert
	public int insertPR(SalaryCertVO salaryCertVO);
	
	//정산대상자 명수
	public int selectEmpCnt(SalaryCertVO salaryCertVO);
	
	//salary_Cert 테이블에서 pt_no가 1번이고, pr_Yr, pr_Mth가 2023, 9인 사원 번호 리스트를 찾기. 
	public List<SalaryCertVO> selectCheckedEmpNoList(SalaryCertVO salaryCertVO);
		
	//한사람의 기본급 가져오는 쿼리 select
	public SalaryCertVO selectBaseSalary(SalaryCertVO salaryCertVO);
	
	//지급항목 - 기타수당 부분에 들어갈 내용 select
	public List<PayDedVO> selectOtherPay(SalaryCertVO salaryCertVO);
	
	//지급항목이력 추가 insert
	public int insertPayHistory(SalaryCertVO salaryCertVO);
	
	//초과근무수당 - 연장, 야간, 휴일별 금액 각각 산출
	public SalaryCertVO selectOverTimePay(SalaryCertVO salaryCertVO);
	
	//정산 지급항목 이력 - 기본급 insert 
	public int insertBasePay(SalaryCertVO salaryCertVO);
	
	//정산 지급항목 이력 - 초과근무수당 insert
	public int insertOvertimePay(SalaryCertVO salaryCertVO);
	
	//정산 지급항목 이력 - 기타수당 항목별로 insert
	public int insertOtherPay(SalaryCertVO salaryCertVO);
	
	//공제항목 - 법정 공제 항목 금액 전체 select (파라미터 : empNo, ptNo) 
	public List<SalaryCertVO> selectDedSummary(SalaryCertVO salaryCertVO);
	
	//공제항목 - 기타 공제 항목 금액 전체 select (파라미터 : empNo, ptNo) 
	public List<SalaryCertVO> selectOtherDed(SalaryCertVO salaryCertVO);
	
	//정산 공제항목 이력 - 공제항목 insert (법정공제항목, 기타공제항목 쿼리 동일)
	public int insertWageDed(SalaryCertVO salaryCertVO);
	
	//선택된 정산대상자 정보 조회  (wagePrev에서 사용) (파라미터 : empNo)
	public EmpVO selectCheckedEmpInfo(SalaryCertVO salaryCertVO);
	
	//정산이력 지급항목 조회 (파라미터 : scNo)
	public List<PdHistoryVO> selectPayHistory(SalaryCertVO salaryCertVO);
	
	//정산이력 공제항목 조회 (파라미터 : scNo)
	public List<PdHistoryVO> selectDedHistory(SalaryCertVO salaryCertVO);

	//정산이력 지급항목 갯수 조회 (파라미터 : scNo)
	public int selectPayCount(SalaryCertVO salaryCertVO);
	
	//정산이력 공제항목 갯수 조회 (파라미터 : scNo)
	public int selectDedCount(SalaryCertVO salaryCertVO);
	
	//정산 지급 합 (파라미터 : empNo)
	public int selectPaySum(SalaryCertVO salaryCertVO);
		
	//정산 공제 합 (파라미터 : empNo)
	public int selectDedSum(SalaryCertVO salaryCertVO);
	
	//정산 지급총액, 공제총액, 실지급액 UPDATE (파라미터 : pytlAmt, ddtlAmt, netAmt, empNo, ptNo, prYr, prMth)        
	public int updateFinalAmt(SalaryCertVO salaryCertVO);
	
	//급여정산 완료 페이지 (급여대장 요약) (wageRes) (파라미터 : prYr, prMth, ptNo)
	public SalaryCertVO selectSCSummary(SalaryCertVO salaryCertVO);
	
	//지난정산내역 리스트 출력 (pastPayRoll) parameter : prYr(키워드로 받아야 함, 기본값 : select한 가장최신연도)
	public List<SalaryCertVO> selectPastPayroll(SalaryCertVO salaryCertVO);
	
	//정산내역 중 가장 최근의 연도 추출 (pastPayroll)
	public int selectLatestPrYr();
	
	//정산내역 삭제 (pastPayroll) (파라미터 : ptNo, prYr, prMth) //같은 귀속연월의 급여정산이면 SC 여러줄 삭제 가능
	public int deletePayroll(SalaryCertVO salaryCertVO);
	
	//엑셀 다운로드 자료 리스트 (파라미터 : ptNo, prYr, prMth)
	public List<SalaryCertVO> selectExcelDownList(SalaryCertVO salaryCertVO);
	
}
