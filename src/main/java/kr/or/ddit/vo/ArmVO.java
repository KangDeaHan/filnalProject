package kr.or.ddit.vo;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ArmVO {
	private int armNo;
	private String armRcvr;
	private String armCont;
	private Date armTime;
	private String armStat;
}
