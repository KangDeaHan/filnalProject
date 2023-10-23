package kr.or.ddit.vacation.serviceImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.approval.mapper.ApprovalMapper;
import kr.or.ddit.approval.vo.ApboxVO;
import kr.or.ddit.approval.vo.DocWriVO;
import kr.or.ddit.common.vo.TbNotificationVO;
import kr.or.ddit.vacation.mapper.CusMainMapper;
import kr.or.ddit.vacation.service.CusMainService;
import kr.or.ddit.vacation.vo.BkApplyVO;
import kr.or.ddit.vacation.vo.VacApplyVO;
import kr.or.ddit.vacation.vo.VacHoldVO;
import kr.or.ddit.vacation.vo.VacTypeVO;
import kr.or.ddit.vacation.vo.VacationFormVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class CusMainServiceImpl implements CusMainService{
	
	@Autowired
	private CusMainMapper cusMainMapper;
	
	@Autowired
	private ApprovalMapper approvalMapper;

	@Override
	public List<VacTypeVO> vacType(String empNo) {
		return cusMainMapper.vacType(empNo);
	}

	@Override
	public int insertVacApply(VacApplyVO vacApplyVO) {
		return cusMainMapper.insertVacApply(vacApplyVO);
	}
	
	@Override
	public int insertVacApply1(VacationFormVO vacationFormVO) {
		return cusMainMapper.insertVacApply1(vacationFormVO);
	}

	@Override
	public List<VacApplyVO> selectApplyList(String empNo) {
		return cusMainMapper.selectApplyList(empNo);
	}

	@Override
	public VacApplyVO selectOneApply(VacApplyVO vacApplyVO) {
		return cusMainMapper.selectOneApply(vacApplyVO);
	}

	@Override
	public int deleteApply(int vaapCode) {
		return cusMainMapper.deleteApply(vaapCode);
	}

	@Override
	public int updateApply(VacApplyVO vacApplyVO) {
		return cusMainMapper.updateApply(vacApplyVO);
	}

	@Override
	public List<VacHoldVO> DetailAnnual(VacHoldVO vacHoldVO) {
		return cusMainMapper.DetailAnnual(vacHoldVO);
	}

	@Override
	public List<VacApplyVO> DetailAnnual2(VacApplyVO vacApplyVO) {
		return cusMainMapper.DetailAnnual2(vacApplyVO);
	}

	// 휴가 결재 신청하는데 일단 문서 작성 테이블에 담기
	@Transactional
	@Override
	public int WriInsert(DocWriVO docWriVO,VacationFormVO vacationFormVO, List<ApboxVO> apboxVO) {
		
		int result = 0;
		
		int dftNo =cusMainMapper.WriSelect(); //문서maxNo
		docWriVO.setDftNo(dftNo);
		vacationFormVO.setDftNo(dftNo);
		
		int cusCnt = cusMainMapper.WriInsert(docWriVO);
		
		int vacCnt = cusMainMapper.finalApply(vacationFormVO);//문서 작성 테이블에 담긴 값을 통해 휴가신청서에 insert
		
		for (ApboxVO vo : apboxVO) {
			vo.setDftNo(dftNo);
			int apboxCnt = cusMainMapper.apboxInsert(vo);// <!-- 결제선 INSERT -->
			result += apboxCnt;
			
			//알림세팅
			String empNoid   = vo.getEmpNo();
			String content = "휴가신청 요청이 있습니다.";
			String status  = "N";
			String url     = "/approval/workflow";
			String titel   = "휴가신청";
			
			//알림 vo넣기
			TbNotificationVO tbNotificationVO = new TbNotificationVO();
			tbNotificationVO.setDftNo(dftNo);
			tbNotificationVO.setNtcnRcverEmpNo(empNoid);
			tbNotificationVO.setNtcnContent(content);
			tbNotificationVO.setNtcnUrl(url);
			tbNotificationVO.setNtcnReadStatus(status);
			tbNotificationVO.setNtcnTitle(titel);
			tbNotificationVO.setNtcnSenderEmpNo(docWriVO.getEmpNo());
			int cnt = approvalMapper.notificationInsert(tbNotificationVO);
			
			log.info("tbNotificationVO 잘 들어갔니???!!" + tbNotificationVO);
			log.info("cnt 잘 들어갔니???!!" + cnt);
			
		}

		result += cusCnt + vacCnt;
		return result;
		

	}

	@Override
	public int apstCodeUpdate(int vaapCode) {
		return cusMainMapper.apstCodeUpdate(vaapCode);
	}

	@Override
	public int vaapCodeSelect() {
		return cusMainMapper.vaapCodeSelect();
	}

	@Override
	public VacApplyVO selectDftNo(int vaapCode) {
		return cusMainMapper.selectDftNo(vaapCode);
	}

	@Override
	public List<ApboxVO> selectApbox(ApboxVO apVO) {
		return cusMainMapper.selectApbox(apVO);
	}

	@Override
	public int apstMain2(String empNo) {
		return cusMainMapper.apstMain2(empNo);
	}
	@Override
	public int apstMain3(String empNo) {
		return cusMainMapper.apstMain3(empNo);
	}

	@Override
	public int insertVacApply2(VacationFormVO vacationFormVO) {
		return cusMainMapper.insertVacApply2(vacationFormVO);
	}


	

}
