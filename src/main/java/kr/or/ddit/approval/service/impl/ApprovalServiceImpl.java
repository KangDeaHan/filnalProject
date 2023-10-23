package kr.or.ddit.approval.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.approval.mapper.ApprovalMapper;
import kr.or.ddit.approval.service.ApprovalService;
import kr.or.ddit.approval.vo.ApboxVO;
import kr.or.ddit.approval.vo.DocKindVO;
import kr.or.ddit.approval.vo.DocWriVO;
import kr.or.ddit.approval.vo.FixturesVO;
import kr.or.ddit.common.vo.DeptVO;
import kr.or.ddit.common.vo.TbNotiCheckVO;
import kr.or.ddit.common.vo.TbNotificationVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ApprovalServiceImpl implements ApprovalService {

	@Autowired
	ApprovalMapper approvalMapper;

	// 조직도
	@Override
	public List<DeptVO> organizationChartOne() {
		return approvalMapper.organizationChartOne();
	}
	
	// 조직도
	@Override
	public List<DeptVO> organizationChartTwo() {
		return approvalMapper.organizationChartTwo();
	}

	// 문서종류 가져오기
	@Override
	public DocKindVO selectDocKind(String dokKind) {
		return approvalMapper.selectDocKind(dokKind);
	}

	// 문서작성,비품,결제선
	@Transactional
	@Override
	public int docInsert(DocWriVO docVo, List<FixturesVO> fixList, List<ApboxVO> apboxList) {
		log.info("ApprovalServiceImpl -> docVo : " + docVo);
		log.info("ApprovalServiceImpl -> fixList : " + fixList);
		log.info("ApprovalServiceImpl -> apboxList : " + apboxList);
		int result = 0;

		
		int maxDocNo = approvalMapper.docMaxNoSelect() + 1;
		log.info("ApprovalServiceImpl -> maxDocNo : " + maxDocNo);

		docVo.setDftNo(maxDocNo);
		int docCnt = approvalMapper.docInsert(docVo);
		result += docCnt;

		
		for (FixturesVO fixVO : fixList) {
			fixVO.setDftNo(maxDocNo);
			int fixCnt = approvalMapper.fixInsert(fixVO);
			result += fixCnt;
		}
		

		for (ApboxVO apboxVO : apboxList) {
			apboxVO.setDftNo(maxDocNo);
			int apboxCnt = approvalMapper.apboxInsert(apboxVO);
			
			
			result += apboxCnt;
			
			//알림세팅
			String empNoid   = apboxVO.getEmpNo();
			String content = "비품신청내용입니다";
			String status  = "N";
			String url     = "/approval/workflow";
			String titel   = "비품신청 요청이 있습니다.";
			
			//알림 vo넣기
			TbNotificationVO tbNotificationVO = new TbNotificationVO();
			tbNotificationVO.setDftNo(maxDocNo);
			tbNotificationVO.setNtcnRcverEmpNo(empNoid);
			tbNotificationVO.setNtcnContent(content);
			tbNotificationVO.setNtcnUrl(url);
			tbNotificationVO.setNtcnReadStatus(status);
			tbNotificationVO.setNtcnTitle(titel);
			tbNotificationVO.setNtcnSenderEmpNo(docVo.getEmpNo());
			int cnt = approvalMapper.notificationInsert(tbNotificationVO);
			
			log.info("tbNotificationVO 잘 들어갔니???!!" + tbNotificationVO);
			log.info("cnt 잘 들어갔니???!!" + cnt);
		}

		log.info("ApprovalServiceImpl -> result : " + result);
		

		return result;
	}

	//내가할일(휴가)
	@Override
	public List<ApboxVO> myVacationDocList(String empNo) {
		return approvalMapper.myVacationDocList(empNo);
	}
	
	//내가할일(비품신청)
	@Override
	public List<ApboxVO> myDocList(String empNo) {
		return approvalMapper.myDocList(empNo);
	}
	
	//내가할일(근무신청)
	@Override
	public List<ApboxVO> myWorkDocList(String empNo) {
		return approvalMapper.myWorkDocList(empNo);
	}
	
	//내가할일(휴직)
	@Override
	public List<ApboxVO> myBkList(String empNo){
		return approvalMapper.myBkList(empNo);
	}
	
	//결제문서번호에 해당하는 결제자 출력
	@Override
	public List<ApboxVO> deptApboxList(ApboxVO DftNo) {
		return approvalMapper.deptApboxList(DftNo);
	}

	//결제선 Update
	@Override
	public int updateApbox(ApboxVO apboxVo) {
		return approvalMapper.updateApbox(apboxVo);
	}

	//중요문서 등록
	@Override
	public int updateImportant(ApboxVO apboxVo) {
		return approvalMapper.updateImportant(apboxVo);
	}
	
	//알림 INSERT
	@Override
	public int notificationInsert(TbNotificationVO tbNotificationVO) {
		return approvalMapper.notificationInsert(tbNotificationVO);
	}
	
	//알림 확인 INSERT
	@Transactional
	@Override
	public int notiCheckInsert(TbNotiCheckVO tbNotiCheckVO) {
		int result = 0;
		result += approvalMapper.notificationUpdate(tbNotiCheckVO);
		result += approvalMapper.notiCheckInsert(tbNotiCheckVO);
		return result;
	}

	//내 알림 SELECT
	@Override
	public List<TbNotificationVO> notificationSelect(String empNo) {
		return approvalMapper.notificationSelect(empNo);
	}
	//<!-- 알림 비품 SELECT -->
	@Override
	public List<TbNotificationVO> fixNotificationSelect(String empNo){
		return approvalMapper.fixNotificationSelect(empNo);
	}
	//<!-- 알림 근무 SELECT -->
	@Override
	public List<TbNotificationVO> workNotificationSelect(String empNo){
		return approvalMapper.workNotificationSelect(empNo);
	}
	//<!-- 알림 휴가 SELECT -->
	@Override
	public List<TbNotificationVO> vacationNotificationSelect(String empNo){
		return approvalMapper.vacationNotificationSelect(empNo);
	}

	//알림 UPDATE
	@Override
	public int notificationUpdate(TbNotiCheckVO tbNotiCheckVO) {
		return approvalMapper.notificationUpdate(tbNotiCheckVO);
	}

	// 나의 문서 상세정보 비품
	@Override
	public ApboxVO selectDetailInfo(ApboxVO apboxVO) {
		return approvalMapper.selectDetailInfo(apboxVO);
	}

	// 나의 문서 상세정보 휴가
	@Override
	public ApboxVO selectDetailVacationInfo(ApboxVO apboxVO) {
		return approvalMapper.selectDetailVacationInfo(apboxVO);
	}

	//나의 문서 상세정보  근무
	@Override
	public ApboxVO selectDetailWorkInfo(ApboxVO apboxVO) {
		return approvalMapper.selectDetailWorkInfo(apboxVO);
	}
	
	//나의 문서 상세정보 휴직
	@Override
	public ApboxVO selectDetailBkInfo(ApboxVO apboxVO) {
		return approvalMapper.selectDetailBkInfo(apboxVO);
	}
	
	//비품신청 상세정보List SELECT
	@Override
	public List<FixturesVO> selectMyFixList(String empNo) {
		return approvalMapper.selectMyFixList(empNo);
	}
	
	//비품신청 상세정보 SELECT
	@Override
	public ApboxVO selectMyFix(ApboxVO apboxVO) {
		return approvalMapper.selectMyFix(apboxVO);
	}
	




}
