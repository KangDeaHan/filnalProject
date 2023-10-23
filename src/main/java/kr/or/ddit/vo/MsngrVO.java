package kr.or.ddit.vo;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MsngrVO {
	private int msngrNo;
	private String chttNo;
	private String empNo;
	private String msngrCont;
	private Date msngrWriDt;
}
