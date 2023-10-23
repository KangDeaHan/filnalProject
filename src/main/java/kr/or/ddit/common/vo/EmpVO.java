package kr.or.ddit.common.vo;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.salary.vo.PdHistoryVO;
import kr.or.ddit.vo.AuthorAlwncVO;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class EmpVO {
	
	private String signFileNo;
	private String profileFileNo;
	private int empSalary;	//사원월급여
	private String stClfCd;
	private String enabled;
	private String grdCode;
	private String jcode;
	private String ptnCode;
	private String dtcode;
	private String bsWktime;
	private String entCaseCode;
	private String ctrtCaseCode;
	private String empMm;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date outDate;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date entDate;
	private String owner;
	private String acctNo;
	private String bankCode;
	private String empImg;
	private String ofcNo;
	private String cpNo;
	private String regn;
	private String empBrdt;
	private String empAddr3;
	private String empAddr2;
	private String empAddr1;
	private String empMail;
	private String genCode;
	private String empPass;
	private String empNm; 
	private String empNo; 
	private String workMethodCode;
	private int dcode;
	private String acenter;
	private String bcenter;
	private String ccenter;
	private String team;
	private String dnm;
	
	//rowNum
	private int    rnum;
	
	//정산대상자 리스트
	private List<String> checkedEmpList;
	
	//파일
	private MultipartFile file;
		
	//코드 네임
	private String genCodeNm; //성별코드
	private String bankCodeNm; //은행코드
	private String ctrtCaseNm; //계약유형(정규직, 계약직)
	private String entCaseNm; //입사유형(신입, 경력)
	private String dtCodeNm; // 직책 (팀장,실장,CEO)
	private String ptnCodeNm; //직위(사원,주임,대리...)
	private String jcodeNm; //직무(인사,영업,회계)
	private String grdCodeNm;//직급 or 연차 (1년차 ,2년차)
	private String stClfCdNm;// 재직상태 (재직, 휴직)
	private String workMethodCodeNm;//일하는방식 (고정근무 ,교대근무, 시차근무)
	
	//근속기간
	private int workday;
	
	//권한
	private List<AuthorAlwncVO> authList;

	//내 파일 리스트
	private List<FileInfoVO> fileList;
	
	//1 : N
	private List<AuthorAlwncVO> authoAlwncVOList;
	
	//1 : 1
	//계약변경이력정보 
	private CnthxVO cnthxVOList;
	
	//부서정보
	private DeptVO deptVOList;
	
	//복직정보 
	private String rsDate;
	private String rsApstCode;
	
	//급여정산
	private List<PdHistoryVO> payHistoryVO; //정산 지급항목, 금액 내역
	private List<PdHistoryVO> dedHistoryVO; //정산 공제항목, 금액 내역
	private int paySum;//지급금액 합
	private int dedSum;//공제금액 합
}
