package kr.or.ddit.setting.vo;

import java.util.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.common.vo.FileInfoVO;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CompanyInfoVO {
	private int coNo;
	private String coNm;
	private String coRep;
	private String coTelno;
	private String coEstdDate;
	private String coAddr;
	private String coAddr2;
	private int coNmpr;
	private String coInt;
	private String coRegno;
	private String corRegno;
	private String coTax;
	private String fileNo;
	
	private String empNm; //사원 이름
	
	//파일
	private MultipartFile file;
	
	//내 파일 리스트
	private List<FileInfoVO> fileList;
	
	//회사휴일목록
	private List<CompanyHoliVO> companyHoliVOList;
	//직인
	private String svfiName;
}
