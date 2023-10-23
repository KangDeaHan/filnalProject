package kr.or.ddit.vacation.service;

import java.util.List;

import kr.or.ddit.common.vo.EmpVO;
import kr.or.ddit.vacation.vo.BkApplyVO;
import kr.or.ddit.vacation.vo.RsReqstVO;
import kr.or.ddit.vacation.vo.VacApplyVO;
import kr.or.ddit.vacation.vo.VacHoldVO;

public interface AdminVacationListService {

	//휴가 내역 조회
	public List<VacApplyVO> vacationSelectList();

	//휴직 내역 조회
	public List<BkApplyVO> bkSelectList();

	//복직 내역 조회
	public List<RsReqstVO> rsSelectList();
	
	//구성원 조회
	public List<EmpVO> empList();
	
	//연차 부여
	public int giveDaysInsert(VacHoldVO vacholdVO);
	
	//부여 연차 업데이트
	public int giveDaysUpdate(VacHoldVO vacholdVO);
}
