package kr.or.ddit.vo;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class YearEsVO {
	private int esNo;
	private String empNo;
	private Date esDate;
	private int esAmt;
	private String esSt;
}
