package kr.or.ddit.vo;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ChttVO {
	private int chttNo;
	private String chttTitle;
	private Date chttCrtDt;
	private int chttNmpr;
}
