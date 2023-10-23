package kr.or.ddit.vacation.service;

import java.util.List;

import kr.or.ddit.approval.vo.ApboxVO;
import kr.or.ddit.approval.vo.DocWriVO;
import kr.or.ddit.vacation.vo.BkApplyVO;
import kr.or.ddit.vacation.vo.VacApplyVO;
import kr.or.ddit.vacation.vo.VacHoldVO;
import kr.or.ddit.vacation.vo.VacTypeVO;
import kr.or.ddit.vacation.vo.VacationFormVO;


public interface CusMainService{
	List<VacTypeVO> vacType(String empNo);
	
	public int insertVacApply(VacApplyVO vacApplyVO);
	
	public List<VacApplyVO> selectApplyList(String empNo);
	
	public VacApplyVO selectOneApply(VacApplyVO vacApplyVO);
	
	public int deleteApply(int vaapCode);
	
	public int updateApply(VacApplyVO vacApplyVO);
	
	//연차상세 조회
	public List<VacHoldVO> DetailAnnual(VacHoldVO vacHoldVO);
	public List<VacApplyVO> DetailAnnual2(VacApplyVO vacApplyVO);
	
	 
	// 휴가 결재 신청하는데 일단 문서 작성 테이블에 담기  //상태 코드 업데이트
	public int WriInsert(DocWriVO docWriVO, VacationFormVO vacationFormVO, List<ApboxVO> apboxVO);
	
	public int apstCodeUpdate(int vaapCode);
	
	//결재선에 올리기위해 vaapCode select해오기
	public int vaapCodeSelect();
	
	//결재선에서 승인 반려 진행 상황에 따른 조회
	public VacApplyVO selectDftNo(int vaapCode);
	public List<ApboxVO> selectApbox(ApboxVO apVO);

	public int insertVacApply1(VacationFormVO vacationFormVO);

	//결재선 상태코드 "결재 완료"or"반려"로 변환
//	public List<ApboxVO> apstSelect(ApboxVO apboxVo);
//	public int apstUpdate(VacationFormVO vacationFormVO);
//	public int apstupdate2(VacApplyVO vacApplyVO);
	public int apstMain2(String empNo);
	public int apstMain3(String empNo);
	
	//결재선 신청할때 VAC_APPLY 테이블의 DFT_NO를 UPDATE
	public int insertVacApply2(VacationFormVO vacationFormVO);
}
