package kr.or.ddit.vacation.vo;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class RsReqstVO {
	private int rsNo;
	private int bkNo;
	private String empNo;
	private String rsDate;
	private String rsResn;
	
	private String rsApstCode;
	private int dftNo;
	private int fileSn;
	private String fileSetting;
	
	private String dnm;
	private String empNm;
	private String ptnCode;
	private String dcode;
	
}
