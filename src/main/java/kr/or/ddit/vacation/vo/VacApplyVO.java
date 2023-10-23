package kr.or.ddit.vacation.vo;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class VacApplyVO {
	private int vaapCode;
	private String empNo;
	private int vhCngNo;
	private String vaapEmp;
	private String vaapApEmp;
	private int vaapDays;
	private String vaapRsn;
	private String vaapApstCode;
	private String vaapApDate;
	private String vaapRtRs;
	private String vaapCcSt;
	private Date vaapCcDate;
	private String vaapStart;
	private String vaapEnd;
	private String vaapType; 
	private int vacTypeNo;
	private String vaapDate;
	private String vacTypeName;

	private String vhInfo;
	private String vacTypeUseDate;
	private String totalDays;
	private int dftNo;
	private String totaldays2;
}
