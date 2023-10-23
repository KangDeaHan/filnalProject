package kr.or.ddit.vo;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CertPosnVO {
	private int cpnNo;
	private String empNo;
	private String certCode;
	private String certClf;
	private String certIsuer;
	private String certNm;
	private String certNo;
	private Date isueDate;
}
