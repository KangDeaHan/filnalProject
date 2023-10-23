package kr.or.ddit.salary.service.Impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.common.vo.EmpVO;
import kr.or.ddit.salary.mapper.SalaryMapper;
import kr.or.ddit.salary.service.SalaryService;
import kr.or.ddit.salary.vo.PageVO;
import kr.or.ddit.salary.vo.PayDedVO;
import kr.or.ddit.salary.vo.PdHistoryVO;
import kr.or.ddit.salary.vo.SalaryCertVO;

@Service
public class SalaryServiceImpl implements SalaryService {

	@Autowired
	private SalaryMapper salaryMapper;
	
	//사원정보 리스트 출력
	@Override
	public List<EmpVO> selectEmpList(PageVO pageVO) {
		return salaryMapper.selectEmpList(pageVO);
	}
	
	//전체 글 수 조회
	@Override
	public int getTotal(PageVO pageVO) {
		return salaryMapper.getTotal(pageVO);
	}
	
	//1명의 급여정산번호 insert
	@Override
	public int insertPR(SalaryCertVO salaryCertVO) {
		return salaryMapper.insertPR(salaryCertVO);
	}
	
	//정산대상자 명수
	@Override
	public int selectEmpCnt(SalaryCertVO salaryCertVO) {
		return salaryMapper.selectEmpCnt(salaryCertVO);
	}
	
	//salary_Cert 테이블에서 pt_no가 1번이고, pr_Yr, pr_Mth가 2023, 9인 사원 번호 리스트를 찾기. 
	@Override
	public List<SalaryCertVO> selectCheckedEmpNoList(SalaryCertVO salaryCertVO) {
		return salaryMapper.selectCheckedEmpNoList(salaryCertVO);
	}
	
	//지급항목 - 요약 부분에 들어갈 내용 select
	@Override
	public List<PayDedVO> selectOtherPay(SalaryCertVO salaryCertVO) {
		return salaryMapper.selectOtherPay(salaryCertVO);
	}
	
	//한사람의 기본급 가져오는 쿼리 select
	@Override
	public SalaryCertVO selectBaseSalary(SalaryCertVO salaryCertVO) {
		return salaryMapper.selectBaseSalary(salaryCertVO);
	}

	//지급항목이력 추가 insert
	@Override
	public int insertPayHistory(SalaryCertVO salaryCertVO) {
		return salaryMapper.insertPayHistory(salaryCertVO);
	}
	
	//초과근무수당 - 연장, 야간, 휴일별 금액 각각 산출
	@Override
	public SalaryCertVO selectOverTimePay(SalaryCertVO salaryCertVO) {
		return salaryMapper.selectOverTimePay(salaryCertVO);
	}

	//정산 지급항목 이력 - 기본급 insert 
	@Override
	public int insertBasePay(SalaryCertVO salaryCertVO) {
		return salaryMapper.insertBasePay(salaryCertVO);
	}
	
	//정산 지급항목 이력 - 초과근무수당 insert
	@Override
	public int insertOvertimePay(SalaryCertVO salaryCertVO) {
		return salaryMapper.insertOvertimePay(salaryCertVO);
	}
	
	//정산 지급항목 이력 - 기타수당 항목별로 insert
	@Override
	public int insertOtherPay(SalaryCertVO salaryCertVO) {
		return salaryMapper.insertOtherPay(salaryCertVO);
	}

	//공제항목 - 법정 공제 항목 금액 전체 select (파라미터 : empNo, ptNo) 
	@Override
	public List<SalaryCertVO> selectDedSummary(SalaryCertVO salaryCertVO) {
		return salaryMapper.selectDedSummary(salaryCertVO);
	}
	
	//공제항목 - 기타 공제 항목 금액 전체 select (파라미터 : empNo, ptNo) 
	@Override
	public List<SalaryCertVO> selectOtherDed(SalaryCertVO salaryCertVO) {
		return salaryMapper.selectOtherDed(salaryCertVO);
	}

	//정산 공제항목 이력 - 공제항목 insert (법정공제항목, 기타공제항목 쿼리 동일)
	@Override
	public int insertWageDed(SalaryCertVO salaryCertVO) {
		return salaryMapper.insertWageDed(salaryCertVO);
	}
	
	//선택된 정산대상자 정보 조회  (wagePrev에서 사용) (파라미터 : empNo)
	@Override
	public EmpVO selectCheckedEmpInfo(SalaryCertVO salaryCertVO) {
		return salaryMapper.selectCheckedEmpInfo(salaryCertVO);
	}
	
	//정산이력 지급항목 조회 (파라미터 : scNo)
	@Override
	public List<PdHistoryVO> selectPayHistory(SalaryCertVO salaryCertVO) {
		return salaryMapper.selectPayHistory(salaryCertVO);
	}
	
	//정산이력 공제항목 조회 (파라미터 : scNo)
	@Override
	public List<PdHistoryVO> selectDedHistory(SalaryCertVO salaryCertVO) {
		return salaryMapper.selectDedHistory(salaryCertVO);
	}
	
	//정산이력 지급항목 갯수 조회 (파라미터 : scNo)
	@Override
	public int selectPayCount(SalaryCertVO salaryCertVO) {
		return salaryMapper.selectPayCount(salaryCertVO);
	}
	
	//정산이력 공제항목 갯수 조회 (파라미터 : scNo)
	@Override
	public int selectDedCount(SalaryCertVO salaryCertVO) {
		return salaryMapper.selectDedCount(salaryCertVO);
	}
	
	//정산 지급 합 (파라미터 : empNo)
	@Override
	public int selectPaySum(SalaryCertVO salaryCertVO) {
		return salaryMapper.selectPaySum(salaryCertVO);
	}
	
	//정산 공제 합 (파라미터 : empNo)
	@Override
	public int selectDedSum(SalaryCertVO salaryCertVO) {
		return salaryMapper.selectDedSum(salaryCertVO);
	}
	
	//정산 지급총액, 공제총액, 실지급액 UPDATE (파라미터 : pytlAmt, ddtlAmt, netAmt, empNo, ptNo, prYr, prMth)        
	@Override
	public int updateFinalAmt(SalaryCertVO salaryCertVO) {
		return salaryMapper.updateFinalAmt(salaryCertVO);
	}
	
	//급여정산 완료 페이지 (급여대장 요약) (wageRes) (파라미터 : prYr, prMth, ptNo)
	@Override
	public SalaryCertVO selectSCSummary(SalaryCertVO salaryCertVO) {
		return salaryMapper.selectSCSummary(salaryCertVO);
	}

	//지난정산내역 리스트 출력 (pastPayRoll) parameter : prYr(키워드로 받아야 함, 기본값 : select한 가장최신연도)
	@Override
	public List<SalaryCertVO> selectPastPayroll(SalaryCertVO salaryCertVO) {
		return salaryMapper.selectPastPayroll(salaryCertVO);
	}
	
	//정산내역 중 가장 최근의 연도 추출 (pastPayroll)
	@Override
	public int selectLatestPrYr() {
		return salaryMapper.selectLatestPrYr();
	}
	
	//정산내역 삭제 (pastPayroll) (파라미터 : ptNo, prYr, prMth) //같은 귀속연월의 급여정산이면 SC 여러줄 삭제 가능
	@Override
	public int deletePayroll(SalaryCertVO salaryCertVO) {
		return salaryMapper.deletePayroll(salaryCertVO);
	}
	
	//엑셀 다운로드 자료 리스트 (파라미터 : ptNo, prYr, prMth)
	@Override
	public List<SalaryCertVO> selectExcelDownList(SalaryCertVO salaryCertVO) {
		return salaryMapper.selectExcelDownList(salaryCertVO);
	}
	
	
	
	
			

		
		
		

			
	
}
