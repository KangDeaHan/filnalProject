package kr.or.ddit.vacation.serviceImpl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.common.vo.EmpVO;
import kr.or.ddit.vacation.mapper.AdminVacationListMapper;
import kr.or.ddit.vacation.service.AdminVacationListService;
import kr.or.ddit.vacation.vo.BkApplyVO;
import kr.or.ddit.vacation.vo.RsReqstVO;
import kr.or.ddit.vacation.vo.VacApplyVO;
import kr.or.ddit.vacation.vo.VacHoldVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class AdminVacationListServiceImpl implements AdminVacationListService {
	
	@Autowired
	private AdminVacationListMapper adminMapper;


	@Override
	public List<VacApplyVO> vacationSelectList() {
		// TODO Auto-generated method stub
		return adminMapper.vacationSelectList();
	}


	@Override
	public List<BkApplyVO> bkSelectList() {
		return adminMapper.bkSelectList();
	}


	@Override
	public List<RsReqstVO> rsSelectList() {
		return adminMapper.rsSelectList();
				
	}


	@Override
	public List<EmpVO> empList() {
		return adminMapper.empList();
	}


	@Override
	public int giveDaysInsert(VacHoldVO vacholdVO) {
		return adminMapper.giveDaysInsert(vacholdVO);
	}


	@Override
	public int giveDaysUpdate(VacHoldVO vacholdVO) {
		return adminMapper.giveDaysUpdate(vacholdVO);
	}
}
