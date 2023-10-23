package kr.or.ddit.common.mapper;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.common.vo.AccaVO;
import kr.or.ddit.common.vo.CnthxVO;
import kr.or.ddit.common.vo.EmpVO;
import kr.or.ddit.common.vo.FileInfoVO;
import kr.or.ddit.vo.AuthorAlwncVO;
import kr.or.ddit.vo.CareerVO;
import kr.or.ddit.vo.WkHrVO;

@Mapper
public interface EmpMapper {
	//사원 추가
	public int insertEmp(EmpVO member);
	
	//권한 추가
	public int insertAuth(AuthorAlwncVO auth);	
	
	//권한 셀렉트
	public EmpVO read(String userid);
	
	//검색기능
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
	
	//파일정보 insert, emp update
	public int fileInsert(FileInfoVO fileInfoVO);
	public int updateFileEmp(EmpVO empVO);
	
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
	public int findPw(EmpVO empVO);
	//임시 비밀번호 업데이트
	public int updatePw(EmpVO empVO);
	
	//나의 이미지 가져오기
	public String selectMyImg(String empNo);
	
}


