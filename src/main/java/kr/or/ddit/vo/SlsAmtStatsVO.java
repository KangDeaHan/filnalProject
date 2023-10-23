package kr.or.ddit.vo;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class SlsAmtStatsVO {
	private int slsNo;
	private Date slsDate;
	private int slsAmt;
	private int slsExpnd;
	private int slsNtpf;
	private int slsThstrmNtpf;
}
