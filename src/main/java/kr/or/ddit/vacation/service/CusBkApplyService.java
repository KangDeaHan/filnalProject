package kr.or.ddit.vacation.service;

import java.io.IOException;
import java.util.List;

import kr.or.ddit.approval.vo.ApboxVO;
import kr.or.ddit.approval.vo.DocWriVO;
import kr.or.ddit.common.vo.EmpVO;
import kr.or.ddit.common.vo.FileInfoVO;
import kr.or.ddit.vacation.vo.BkApplyVO;
import kr.or.ddit.vacation.vo.RsReqstVO;


public interface CusBkApplyService {
	
	//사원조회
	public EmpVO EmpSelect(String empNo);
	//휴직 신청
	public int insertBkApply(BkApplyVO bkApplyVO);
	//모달 휴직 신청
	public int insertBkApply1(BkApplyVO bkApplyVO);
	//신청 내역 조호
	public List<BkApplyVO> getSelect(String empNo);
	//신청내역 모달에 띄우기
	public BkApplyVO bkSelectOne(int bkNo);
	
	//파일정보 insert
	public int fileInsert(FileInfoVO fileInfoVO);
	
	//파일 순번 가져오기
	public int fileSnSelect();
	
	//fileInfo 내용 전부 가져오기
	public FileInfoVO fileInfo(int FileSn);
	
	//모달 내용업데이트
	public int bkUpdate(BkApplyVO bkApplyVO) throws IllegalStateException, IOException;
	public FileInfoVO fileUpdate(FileInfoVO fileInfoVO);
	
	//복직신청시 사원 자동 조회
	public EmpVO selectEmpInfo(String EmpNo);
	
	//복직 신청 insert
	public int insertReqst(RsReqstVO rsReqstVO);
	
	//복직 신청 내역 조회
	public List<RsReqstVO> selectRsList(String EmpNo);
	
	//복직 신청 모달 내역별 조회
	public RsReqstVO rsModalSelect(int rsNo);
	
	//복직 신청 모달 내역별 수정
	public int rsModalUpdate(RsReqstVO rsReqstVO);
	
	///////복직결재///////
	// 복직 결재 신청하는데 일단 문서 작성 테이블에 담기  //상태 코드 업데이트
	public int WriInsert(DocWriVO docWriVO,List<ApboxVO> apboxVO);
	
	//상태코드 업데이트
	public int apstCodeUpdate(int rsNo);
	/////////////////
	
	///////휴직결재///////
	// 문서작성테이블에 담긴 DFT_NO 조회 
	public int bkWriInsert(DocWriVO docWriVO,List<ApboxVO> apboxVO);
	
	//상태코드 업데이트
	public int bkApstCodeUpdate(BkApplyVO bkApplyVO);
	
	/////////////////
	public List<BkApplyVO> bkNo();
	
	public int fileSn(int bkNo);
	
	//결재선에서 승인 반려 진행 상황에 따른 조회
	public BkApplyVO dftNoSelect(int bkNo);
	public List<ApboxVO> apboxSelect(ApboxVO apboxVO);
	
	//내문서 결재자 리스트
	public List<ApboxVO> apBoxList(int dftNo);
}
