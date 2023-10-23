package kr.or.ddit.vo;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CostStatsVO {
	private int costNo;
	private Date costDate;
	private int costBsrp;
	private int costFe;
	private int costPe;
	private int costFxte;
}
