package kr.or.ddit.salary.service;

import java.util.List;

import kr.or.ddit.salary.vo.PayTplVO;

public interface PayTplService {
	
	//템플릿 목록 (전체 검색)
	public List<PayTplVO> selectTplList();
	
	//한 건 검색
	public PayTplVO selectTpl(int ptNo);

	//템플릿 추가
	public int insertTpl(PayTplVO payTplVO);
	
	//템플릿 변경
	public int updateTpl(PayTplVO payTplVO);
	
	//템플릿 삭제
	public int deleteTpl(PayTplVO payTplVO);
	
	//템플릿 북마크 상태 변경
	public int updateBmkStatus(PayTplVO payTplVO);
	
	//급여정산 홈 - 북마크여부코드가 'B0101'인 것만 전체 출력하기
	public List<PayTplVO> selectBmkOn();
	
}
