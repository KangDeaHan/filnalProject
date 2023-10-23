package kr.or.ddit.vo;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PensionVO {
	private int psNo;
	private String empNo;
	private Date calSdate;
	private String psCase;
	private Date psSdate;
	private String psBank;
	private String psAcnt;
	private String psSt;
	private Date psMid;
	private int psMlast;
	private Date psEnd;
}
