package kr.or.ddit.common.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailSender;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.common.mapper.EmpMapper;
import kr.or.ddit.common.service.CommonService;
import kr.or.ddit.common.vo.AccaVO;
import kr.or.ddit.common.vo.CnthxVO;
import kr.or.ddit.common.vo.EmpVO;
import kr.or.ddit.common.vo.FileInfoVO;
import kr.or.ddit.vo.CareerVO;
import kr.or.ddit.vo.WkHrVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class CommonServiceImpl implements CommonService{

	@Autowired
	EmpMapper empMapper;
	
	@Autowired
	private MailSender mailSender;

	
	//사원 리스트
	@Override
	public List<EmpVO> suchEmp(String keyword) {
		log.info("keyword : " + keyword);
		List<EmpVO> list = empMapper.suchEmp(keyword);
		log.info("list : " + list);
		
		return list;
	}

	//사원 한명 찾기
	@Override
	public EmpVO SelectEmp(String EmpNo) {
		log.info("EmpNo : " + EmpNo);
		EmpVO Vo = empMapper.SelectEmp(EmpNo);
		log.info("Vo : " + Vo);
		
		return Vo;
	}
	//사원 한명 검색(인사정보)
	@Override
	public EmpVO SelectEmp2(String EmpNo) {
		log.info("EmpNo : " + EmpNo);
		EmpVO Vo = empMapper.SelectEmp2(EmpNo);
		log.info("Vo : " + Vo);
		
		return Vo;
	}

	//내 계약정보
	@Override
	public CnthxVO myCnthx(String EmpNo) {
		log.info("ServiceImpl->EmpNo"+EmpNo);
		CnthxVO list = empMapper.myCnthx(EmpNo);
		log.info("ServiceImpl->list"+list);
		
		return list;
	}

	//내 학력정보
	@Override
	public AccaVO myAcca(String EmpNo) {
		log.info("ServiceImpl->EmpNo"+EmpNo);
		AccaVO vo = empMapper.myAcca(EmpNo);
		log.info("ServiceImpl->vo"+vo);
		return vo;
	}
	//내 경력정보
	@Override
	public CareerVO myCareer(String EmpNo) {
		log.info("ServiceImpl->EmpNo"+EmpNo);
		CareerVO vo = empMapper.myCareer(EmpNo);
		log.info("ServiceImpl->vo"+vo);
		return vo;
	}

	//나의 파일정보 insert
	@Override
	@Transactional
	public int fileInsert(FileInfoVO fileInfoVO, EmpVO empVO) {
		log.info("서비스 인포 인설트"+fileInfoVO);
		int result = this.empMapper.fileInsert(fileInfoVO);
		
		log.info("ServiceImpl->result"+result);
		int fileEmpResult = this.empMapper.updateFileEmp(empVO);
		log.info("서비스 emp 업데이트"+fileEmpResult);
		
	    if (result > 0 && fileEmpResult > 0) {
	        // 두 개의 데이터베이스 삽입이 모두 성공한 경우
	        // 추가 작업을 수행하거나 성공 메시지를 로그에 기록할 수 있습니다.
	        log.info("사원 정보와 fileInfo 정보가 성공적으로 삽입,수정되었습니다.");
	        return 1; // 또는 성공을 나타내는 다른 값
	    } else {
	        // 실패한 경우 예외 처리 또는 에러 처리를 수행합니다.
	        String errorMessage = "사원 정보 또는 fileInfo 정보를 삽입,수정하는데 실패했습니다. " +
	            "File Result: " + result + ", Emp Result: " + fileEmpResult;
	        log.error(errorMessage);
	        throw new RuntimeException(errorMessage);
	    }
	}

	
	
	//나의 파일정보 select
	@Override
	public List<FileInfoVO> fileSelect(String empNo) {
		log.info("ServiceImpl->empNo"+empNo);
		List<FileInfoVO> list = empMapper.fileSelect(empNo);
		log.info("ServiceImpl->list"+list);
		return list;
	}
	//인사정보 모달 업데이트
	@Override
	public int updateInsa(EmpVO empVO) {
		log.info("ServiceImpl->인사정보 empVO 전 : "+empVO);
		int result = this.empMapper.updateInsa(empVO);
		log.info("ServiceImpl->인사정보 empVO 후 : "+empVO);
		if (result > 0) {
	        log.info("인사 정보가 성공적으로 삽입,수정되었습니다.");
	        return 1; // 또는 성공을 나타내는 다른 값
	    } else {
	        // 실패한 경우 예외 처리 또는 에러 처리를 수행합니다.
	        String errorMessage = "인사정보를 삽입,수정하는데 실패했습니다. " +
	            "인사정보 Result: " + result;
	        log.error(errorMessage);
	        throw new RuntimeException(errorMessage);
	    }
	}
	//개인정보 모달 업데이트

	@Override
	public int updatePerson(EmpVO empVO) {
		log.info("ServiceImpl->개인정보 empVO 전 : "+empVO);
		int result = this.empMapper.updatePerson(empVO);
		log.info("ServiceImpl->개인정보 empVO 후 : "+empVO);
		if (result > 0) {
			log.info("개인정보가 성공적으로 삽입,수정되었습니다.");
			return 1; // 또는 성공을 나타내는 다른 값
		} else {
			// 실패한 경우 예외 처리 또는 에러 처리를 수행합니다.
			String errorMessage = "개인정보를 삽입,수정하는데 실패했습니다. " +
					"개인정보 Result: " + result;
			log.error(errorMessage);
			throw new RuntimeException(errorMessage);
		}
	}
	//계약정보 모달 업데이트
	@Override
	public int updateCnthx(CnthxVO cnthxVO) {
		log.info("ServiceImpl->계약정보 cnthxVO 전 : "+cnthxVO);
		int result = this.empMapper.updateCnthx(cnthxVO);
		log.info("ServiceImpl->계약정보 cnthxVO 후 : "+cnthxVO);
		if (result > 0) {
			log.info("계약정보가 성공적으로 삽입,수정되었습니다.");
			return 1; // 또는 성공을 나타내는 다른 값
		} else {
			// 실패한 경우 예외 처리 또는 에러 처리를 수행합니다.
			String errorMessage = "계약정보를 삽입,수정하는데 실패했습니다. " +
					"계약정보 Result: " + result;
			log.error(errorMessage);
			throw new RuntimeException(errorMessage);
		}
	}
	
	
	// 출근 등록
	@Override
	public int gotoWork(WkHrVO wkHrVO) {
		return empMapper.gotoWork(wkHrVO);
	}

	// 퇴근 등록
	@Override
	public int leaveWork(WkHrVO wkHrVO) {
		return empMapper.leaveWork(wkHrVO);
	}
	
	// 출퇴근정보조회 (특정사원)
	@Override
	public WkHrVO commuteSelect(String empNo) {
		return empMapper.commuteSelect(empNo);
	}

	//비밀번호 찾기
	@Override
	@Transactional
	public int findPW(EmpVO empVO) {
		
		
		
		int result = empMapper.findPw(empVO);
		
		log.info("서비스 1번" + result);
		log.info("ddd" +empVO.getEmpPass());
		log.info("ddd" +empVO.getEmpNo());
		result += empMapper.updatePw(empVO);
		log.info("서비스 2번" + result);

		return result;
	}

	public void sendEmail(String toAddress, String fromAddress,
			String subject, String msgBody) {
	SimpleMailMessage smm = new SimpleMailMessage();
	smm.setFrom(fromAddress);
	smm.setTo(toAddress);
	smm.setSubject(subject);
	smm.setText(msgBody);
	
	mailSender.send(smm);
	}

	@Override
	public String selectMyImg(String empNo) {
		
		return empMapper.selectMyImg(empNo);
	}

	@Override
	public int totalWorkTime(WkHrVO wkHrVO) {
		return empMapper.totalWorkTime(wkHrVO);
	}

}
