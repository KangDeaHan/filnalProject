package kr.or.ddit.common.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CnthxVO {
	private int cnthxNo;
	private String empNo;
	private String cntWriter;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date blctSdate;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date blctEdate;
	private String ctrtCaseCode;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date bwctSdate;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date bwctEdate;
	private int bcntAmt;
	private int bfex;
	private String bincClf;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date cngDate;
	private String cngMm;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date prSdate;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date prEdate;
	private String cntEditor;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date editDate;
	private String delyn;
	
	//공통코드
	private String ctrtCaseCodeNm;
	private String delynNm;
	
}
