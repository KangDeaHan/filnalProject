package kr.or.ddit.vacation.vo;


import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class VacationFormVO {
	private int dftNo;
	private String vaapEmp;
	private String vaapDays;
	private String vaapRsn;
	private String vaapApstCode;
	private String vaapRtRs;
	private String vaapCcSt;
	private Date vaapStart;
	private Date vaapEnd;
	private String vaapType;
	private int vacTypeNo;
	private Date vaapDate;
	private String empNo;
	private int vaapCode;
}
