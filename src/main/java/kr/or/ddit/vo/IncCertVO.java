package kr.or.ddit.vo;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class IncCertVO {
	private String cfNo;
	private String empNo;
	private String cfNm;
	private Date cfIsdate;
	private String isRsn;
}
