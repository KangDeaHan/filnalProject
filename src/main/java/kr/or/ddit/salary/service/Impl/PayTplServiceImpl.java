package kr.or.ddit.salary.service.Impl;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.salary.mapper.PayTplMapper;
import kr.or.ddit.salary.service.PayTplService;
import kr.or.ddit.salary.vo.PayTplVO;

@Service
public class PayTplServiceImpl implements PayTplService {
	
	//DI, IoC
	@Autowired
	private PayTplMapper payTplMapper;

	
	//템플릿 목록 (전체 검색)
	@Override
	public List<PayTplVO> selectTplList() {
		return this.payTplMapper.selectTplList();
	}
	
	//한 건 검색
	@Override
	public PayTplVO selectTpl(int ptNo) {
		return this.payTplMapper.selectTpl(ptNo);
	}
	
	//템플릿 추가
	@Override
	public int insertTpl(PayTplVO payTplVO) {
		return payTplMapper.insertTpl(payTplVO);
	}

	//템플릿 변경
	@Override
	public int updateTpl(PayTplVO payTplVO) {
		return payTplMapper.updateTpl(payTplVO);
	}

	//템플릿 삭제
	@Override
	public int deleteTpl(PayTplVO payTplVO) {
		return this.payTplMapper.deleteTpl(payTplVO);
	}
	
	//템플릿 북마크 상태 변경
	@Override
	public int updateBmkStatus(PayTplVO payTplVO) {
		return this.payTplMapper.updateBmkStatus(payTplVO);
	}
	
	//급여정산 홈 - 북마크여부코드가 'B0101'인 것만 전체 출력하기
	@Override
	public List<PayTplVO> selectBmkOn() {
		return this.payTplMapper.selectBmkOn();
	}
	
}
