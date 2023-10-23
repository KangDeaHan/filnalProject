package kr.or.ddit.vo;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class AcslogVO {
	private int acsNo;
	private String empNo;
	private Date acsDt;
	private String acsIp;
}
