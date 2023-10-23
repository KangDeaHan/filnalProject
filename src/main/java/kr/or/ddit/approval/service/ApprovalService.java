package kr.or.ddit.approval.service;

import java.util.List;

import kr.or.ddit.approval.vo.ApboxVO;
import kr.or.ddit.approval.vo.DocKindVO;
import kr.or.ddit.approval.vo.DocWriVO;
import kr.or.ddit.approval.vo.FixturesVO;
import kr.or.ddit.common.vo.DeptVO;
import kr.or.ddit.common.vo.TbNotiCheckVO;
import kr.or.ddit.common.vo.TbNotificationVO;

public interface ApprovalService {

	//조직도
	public List<DeptVO> organizationChartOne();
	public List<DeptVO> organizationChartTwo();
	
	//문서종류 가져오기
	public DocKindVO selectDocKind(String dokKind);
	
	//문서작성
	public int docInsert(DocWriVO docVo, List<FixturesVO> fixList, List<ApboxVO> apboxList);
	
	//내가할일(비품신청)
	public List<ApboxVO> myDocList(String empNo);
	
	//내가할일(휴가)
	public List<ApboxVO> myVacationDocList(String empNo);
	
	//내가할일(근무)
	public List<ApboxVO> myWorkDocList(String empNo);
	
	//결제문서번호에 해당하는 결제자 출력
	public List<ApboxVO> deptApboxList(ApboxVO DftNo);
	
	//내가할일(휴직)
	public List<ApboxVO> myBkList(String empNo);
	
	//결제선 update
	public int updateApbox(ApboxVO apboxVo);
	
	//중요문서 등록
	public int updateImportant(ApboxVO apboxVo);
	
	//<!-- 알림 INSERT -->
	public int notificationInsert(TbNotificationVO tbNotificationVO);
	
	//<!-- 알림 확인 INSERT -->
	public int notiCheckInsert(TbNotiCheckVO tbNotiCheckVO);
	
	//내 알림 SELECT
	public List<TbNotificationVO> notificationSelect(String empNo);
	//<!-- 알림 비품 SELECT -->
	public List<TbNotificationVO> fixNotificationSelect(String empNo);
	//<!-- 알림 근무 SELECT -->
	public List<TbNotificationVO> workNotificationSelect(String empNo);
	//<!-- 알림 휴가 SELECT -->
	public List<TbNotificationVO> vacationNotificationSelect(String empNo);
	
	
	//알림 UPDATE
	public int notificationUpdate(TbNotiCheckVO tbNotiCheckVO);
	
	// 나의 문서 상세정보 
	public ApboxVO selectDetailInfo(ApboxVO apboxVO);
	// 나의 문서 상세정보 비품
	public ApboxVO selectDetailVacationInfo(ApboxVO apboxVO);
	//나의 문서 상세정보 근무
	public ApboxVO selectDetailWorkInfo(ApboxVO apboxVO);
	//나의 문서 상세정보 휴직
	public ApboxVO selectDetailBkInfo(ApboxVO apboxVO);
	
	//내가 신청한 비품신청 SELECT
	public List<FixturesVO> selectMyFixList(String empNo);
	
	//비품신청 상세정보 SELECT
	public ApboxVO selectMyFix(ApboxVO apboxVO);
	
}
