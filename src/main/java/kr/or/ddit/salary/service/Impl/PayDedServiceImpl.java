package kr.or.ddit.salary.service.Impl;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.salary.mapper.PayDedMapper;
import kr.or.ddit.salary.service.PayDedService;
import kr.or.ddit.salary.vo.PayDedVO;

@Service
public class PayDedServiceImpl implements PayDedService {
	
	@Autowired
	PayDedMapper payDedMapper;
	
	// 지급항목 법정필수항목 전체 리스트 출력
	@Override
	public List<PayDedVO> selectLawPayList() {
		return payDedMapper.selectLawPayList();
	}

	// 지급항목 추가한 항목 전체 리스트 출력
	@Override
	public List<PayDedVO> selectAddedPayList() {
		return payDedMapper.selectAddedPayList();
	}
	
	// 공제항목 법정필수항목 전체 리스트 출력
	@Override
	public List<PayDedVO> selectLawDedList() {
		return payDedMapper.selectLawDedList();
	}
	// 공제항목 법정필수항목 전체 리스트 출력
	@Override
	public List<PayDedVO> selectAddedDedList() {
		return payDedMapper.selectAddedDedList();
	}	
	
	// 지급/공제항목 항목당 한건 검색
	@Override
	public PayDedVO selectPD(int pdNo) {
		return payDedMapper.selectPD(pdNo);
	}
	
	//급여템플릿구성테이블에서 지급/공제항목 있는지 확인 (count)
	@Override
	public int selectPTMCount(PayDedVO payDedVO) {
		return payDedMapper.selectPTMCount(payDedVO);
	}
	
	@Override
	public List<PayDedVO> selectPTMList(int ptNo) {
		return payDedMapper.selectPTMList(ptNo);
	}
	
	// 지급/공제항목 추가
	@Override
	public int insertPD(PayDedVO payDedVO) {
		return payDedMapper.insertPD(payDedVO);
	}
	
	//지급/공제항목 변경
	@Override
	public int updatePD(PayDedVO payDedVO) {
		return payDedMapper.updatePD(payDedVO);
	}
	
	//지급/공제항목 삭제
	@Override
	public int deletePD(PayDedVO payDedVO) {
		return payDedMapper.deletePD(payDedVO);
	}
	
	//템플릿구성 추가
	@Override
	public int insertPTM(PayDedVO payDedVO) {
		return payDedMapper.insertPTM(payDedVO);
	}
	
	//템플릿구성 삭제
	@Override
	public int deletePTM(PayDedVO payDedVO) {
		return payDedMapper.deletePTM(payDedVO);
	}

	

	
		
		
	




}
