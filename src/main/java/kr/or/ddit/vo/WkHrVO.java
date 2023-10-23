package kr.or.ddit.vo;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class WkHrVO {
	private Date waDate;
	private String empNo;
	private Date whStime;
	private Date whEtime;
	private String wkCode;
	private int whTltime;
	
}
