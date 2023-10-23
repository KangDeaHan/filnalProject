package kr.or.ddit.salary.service;

import java.util.List;

import kr.or.ddit.salary.vo.PayDedVO;

public interface PayDedService {
	
	// 지급항목 법정필수항목 전체 리스트 출력
	public List<PayDedVO> selectLawPayList();

	// 지급항목 추가한 항목 전체 리스트 출력
	public List<PayDedVO> selectAddedPayList();
	
	// 공제항목 법정필수항목 전체 리스트 출력
	public List<PayDedVO> selectLawDedList();
	
	// 공제항목 추가한 항목 전체 리스트 출력
	public List<PayDedVO> selectAddedDedList();
		
	//지급/공제항목 항목당 한건 검색
	public PayDedVO selectPD(int pdNo);
	
	//급여템플릿구성테이블에서 지급/공제항목 있는지 확인 (count)
	public int selectPTMCount(PayDedVO payDedVO);
	
	//급여템플릿구성테이블에서 지급/공제항목 있는지 확인 
	public List<PayDedVO> selectPTMList(int ptNo);
	
	// 지급/공제항목 추가
	public int insertPD(PayDedVO payDedVO);

	//지급/공제항목 변경
	public int updatePD(PayDedVO payDedVO);
	
	//지급/공제항목 삭제
	public int deletePD(PayDedVO payDedVO);
	
	//템플릿구성 추가
	public int insertPTM(PayDedVO payDedVO);
	
	//템플릿구성 삭제
	public int deletePTM(PayDedVO payDedVO);
}
