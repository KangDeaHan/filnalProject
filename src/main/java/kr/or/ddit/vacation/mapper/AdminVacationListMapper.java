package kr.or.ddit.vacation.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.common.vo.EmpVO;
import kr.or.ddit.vacation.vo.BkApplyVO;
import kr.or.ddit.vacation.vo.RsReqstVO;
import kr.or.ddit.vacation.vo.VacApplyVO;
import kr.or.ddit.vacation.vo.VacHoldVO;

@Mapper
public interface AdminVacationListMapper {

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
