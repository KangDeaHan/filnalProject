package kr.or.ddit.vacation.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.approval.vo.ApboxVO;
import kr.or.ddit.approval.vo.DocWriVO;
import kr.or.ddit.common.vo.EmpVO;
import kr.or.ddit.common.vo.FileInfoVO;
import kr.or.ddit.vacation.vo.BkApplyVO;
import kr.or.ddit.vacation.vo.RsReqstVO;
import kr.or.ddit.vacation.vo.VacationFormVO;

@Mapper
public interface CusBkApplyMapper {
	
	//사원조회
	public EmpVO EmpSelect(String empNo);
	//휴직 신청
	public int insertBkApply(BkApplyVO bkApplyVO);
	public int insertBkApply1(BkApplyVO bkApplyVO);
	//신청 내역 조회
	public List<BkApplyVO> getSelect(String empNo);
	//신청내역 모달에 띄우기
	public BkApplyVO bkSelectOne(int bkNo);
	
	//파일정보 insert
	public int fileInsert(FileInfoVO fileInfoVO);
	
	public int fileSnSelect();
	
	//fileInfo 내용 전부 가져오기
	public FileInfoVO fileInfo(int FileSn);
	
	//모달 내용업데이트
	public int bkUpdate(BkApplyVO bkApplyVO);
	public int bkFileUpdate(BkApplyVO bkApplyVO);
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
	// 문서작성테이블에 담긴 DFT_NO 조회 
	public int WriSelect();
	
	// 복직 결재 신청하는데 일단 문서 작성 테이블에 담기
	public int WriInsert(DocWriVO docWriVO);
	
	// <!-- 결제선 INSERT -->
	public int apboxInsert(ApboxVO apboxVO);
	
	//상태코드 업데이트
	public int apstCodeUpdate(int rsNo);
	/////////////////

	///////휴직결재///////
	// 문서작성테이블에 담긴 DFT_NO 조회 
	public int bkWriSelect();
	
	// 휴직 결재 신청하는데 일단 문서 작성 테이블에 담기
	public int bkWriInsert(DocWriVO docWriVO);
	
	// <!-- 결제선 INSERT -->
	public int bkApboxInsert(ApboxVO apboxVO);
	
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
