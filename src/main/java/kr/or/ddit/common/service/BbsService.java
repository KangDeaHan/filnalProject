package kr.or.ddit.common.service;

import java.util.List;

import kr.or.ddit.vo.BbsVO;

public interface BbsService {
	
	// 리스트 출력
	public List<BbsVO> BbsList();
	
	// 조회
	public List<BbsVO> BbsSelect(String empNo);
	
	// 일정 등록
	public int BbsInsert(BbsVO bbsVO);
	
	// 일정 수정
	public int BbsUpdate(BbsVO bbsVO);
	
	// 일정 삭제
	public int BbsDelete(BbsVO bbsVO);
}
