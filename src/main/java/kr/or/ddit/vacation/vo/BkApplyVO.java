package kr.or.ddit.vacation.vo;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.approval.vo.ApboxVO;
import kr.or.ddit.common.vo.FileInfoVO;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BkApplyVO {	
	private int bkNo;
	private String empNo;
	private String bkCode;
	private String bkSdate;
	private String bkEdate;
	private String bkRsn;
	private String bkApstCode;
	private String bkCertYn;
	private String fileSetting;
	
	private String bkName;
	private int dftNo;
	private String empNm;
	
	private MultipartFile file;
	private String orignalFileName;
	
	private List<FileInfoVO> fileList;
	private int fileSn;
	private String orfiName;
	private String bkApDate;
	
	//내문서 결재자들
	private List<ApboxVO> apBoxList;
	
}
