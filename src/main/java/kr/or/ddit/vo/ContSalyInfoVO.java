package kr.or.ddit.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ContSalyInfoVO {
	private String empNo;
	private int baseYr;
	private int baseSlry;
	private int mealAc;
	private int bonus;
	private int otAc;
}
