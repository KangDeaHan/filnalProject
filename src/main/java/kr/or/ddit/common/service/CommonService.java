package kr.or.ddit.common.service;

import java.util.List;

import kr.or.ddit.common.vo.AccaVO;
import kr.or.ddit.common.vo.CnthxVO;
import kr.or.ddit.common.vo.EmpVO;
import kr.or.ddit.common.vo.FileInfoVO;
import kr.or.ddit.vo.CareerVO;
import kr.or.ddit.vo.WkHrVO;

public interface CommonService {
	
	//검색 기능
	public List<EmpVO> suchEmp(String keyword);
	
	//사원 한명 검색
	public EmpVO SelectEmp(String EmpNo);
	
	//사원 한명 검색(인사정보)
	public EmpVO SelectEmp2(String EmpNo);
	
	//내 계약정보
	public CnthxVO myCnthx(String EmpNo);
	
	//내 학력정보
	public AccaVO myAcca(String EmpNo);
	
	//내 경력정보
	public CareerVO myCareer(String EmpNo);
	
	//파일정보 insert
	public int fileInsert(FileInfoVO fileInfoVO,EmpVO empvo);
	
	//파일정보 select
	public List<FileInfoVO> fileSelect(String empNo);
	
	//인사정보 모달 업데이트
	public int updateInsa(EmpVO empVO);
	
	//개인정보 모달 업데이트
	public int updatePerson(EmpVO empVO);
	
	//계약정보 모달 업데이트
	public int updateCnthx(CnthxVO cnthxVO);
	
	// 출근 등록
	public int gotoWork(WkHrVO wkHrVO);
	
	// 퇴근 등록
	public int leaveWork(WkHrVO wkHrVO);
	
	// 총근무시간 업데이트
	public int totalWorkTime(WkHrVO wkHrVO);
	
	// 출퇴근정보 조회
	public WkHrVO commuteSelect(String empNo);

	//비밀번호 찾기
	public int findPW(EmpVO empVO);

	public void sendEmail(String email, String addr, String subject, String body);

	//나의 이미지 가져오기
	public String selectMyImg(String empNo);
}
