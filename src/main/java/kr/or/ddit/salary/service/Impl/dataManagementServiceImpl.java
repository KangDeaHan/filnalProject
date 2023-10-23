package kr.or.ddit.salary.service.Impl;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.common.vo.EmpVO;
import kr.or.ddit.salary.mapper.PayDedMapper;
import kr.or.ddit.salary.mapper.dataManagementMapper;
import kr.or.ddit.salary.service.PayDedService;
import kr.or.ddit.salary.service.dataManagementService;
import kr.or.ddit.salary.vo.PayDedVO;
import kr.or.ddit.salary.vo.SalaryCertVO;
import kr.or.ddit.setting.vo.CompanyInfoVO;

@Service
public class dataManagementServiceImpl implements dataManagementService {
	
	@Autowired
	dataManagementMapper dataManagementMapper;

	@Override
	public List<EmpVO> empList(String name) {
		return this.dataManagementMapper.empList(name);
	}
	
	//empNo 선택에 따른 급여명세서 list(모달창에 출력) (파라미터 : empNo)
	@Override
	public List<SalaryCertVO> selectSCList(SalaryCertVO salaryCertVO) {
		return dataManagementMapper.selectSCList(salaryCertVO);
	}

	//급여명세서 출력 (파라미터 : scNo)
	@Override
	public List<SalaryCertVO> selectSalaryCert(SalaryCertVO salaryCertVO) {
		return dataManagementMapper.selectSalaryCert(salaryCertVO);
	}
	
	//급여명세서 출력 (파라미터 : scNo) (개인용)
	@Override
	public List<SalaryCertVO> selectSalaryCert2(SalaryCertVO salaryCertVO) {
		return dataManagementMapper.selectSalaryCert2(salaryCertVO);
	}
	
	//급여명세서 발급 INSERT (파라미터 : empNo, ptNo, prYr, prMth, scIsRsn)
	@Override
	public int insertSC(SalaryCertVO salaryCertVO) {
		return dataManagementMapper.insertSC(salaryCertVO);
	}
	
	//명세서 발급 내역 출력
	@Override
	public List<SalaryCertVO> selectScIssueList() {
		return dataManagementMapper.selectScIssueList();
	}
	
	//최신 연도, 누적 수령액 (파라미터 : empNo)
	@Override
	public SalaryCertVO selectMaxPrYrSumNetAmt(SalaryCertVO salaryCertVO) {
		return dataManagementMapper.selectMaxPrYrSumNetAmt(salaryCertVO);
	}
	
	//연도별 누적 수령액 (파라미터 : empNo, prYr)
	@Override
	public List<SalaryCertVO> selectPrYrSumNetAmt(SalaryCertVO salaryCertVO) {
		return dataManagementMapper.selectPrYrSumNetAmt(salaryCertVO);
	}

	//급여명세서 연도 선택
	@Override
	public List<SalaryCertVO> loadYear(String empNo) {
		// TODO Auto-generated method stub
		return dataManagementMapper.loadYear(empNo);
	}
	
	//급여귀속연도,귀속월, 원천세액, 납세일자 리스트 (파라미터 : EMP_NO, 시작날짜(sdate), 끝날짜(edate))
	@Override
	public List<SalaryCertVO> selectTaxAmt(SalaryCertVO salaryCertVO) {
		return dataManagementMapper.selectTaxAmt(salaryCertVO);
	}

	//과세총액 리스트 (파라미터 : EMP_NO, 시작날짜(sdate), 끝날짜(edate))
	@Override
	public List<SalaryCertVO> selectTotalTaxAmt(SalaryCertVO salaryCertVO) {
		return dataManagementMapper.selectTotalTaxAmt(salaryCertVO);
	}

	//원천징수의무자 (회사정보) (회사명, 사업자등록번호, 사업장소재지, 대표자, 법인등록번호)
	@Override
	public CompanyInfoVO selectCompanyInfo() {
		return dataManagementMapper.selectCompanyInfo();
	}

	//납세자 (EMP) - 이름, 주민등록번호, 주소 (파라미터 : EMP_NO)
	@Override
	public EmpVO selectTaxpayer(SalaryCertVO salaryCertVO) {
		return dataManagementMapper.selectTaxpayer(salaryCertVO);
	}
	
	//소득증명서 발급 INSERT (파라미터 : scIsRsn, scType, empNo)
	@Override
	public int insertINC(SalaryCertVO salaryCertVO) {
		return dataManagementMapper.insertINC(salaryCertVO);
	}
	
	//방금 발급된 증명서 발급사유, 발급일자 가져오기
	@Override
	public SalaryCertVO selectScIsInfo() {
		return dataManagementMapper.selectScIsInfo();
	}
	

		

		

		



}
