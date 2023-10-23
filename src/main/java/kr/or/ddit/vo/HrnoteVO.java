package kr.or.ddit.vo;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class HrnoteVO {
	private int noteNo;
	private String empNo;
	private String noteCont;
	private Date wriDate;
	private String writer;
	private String noteDelynCd;
}
