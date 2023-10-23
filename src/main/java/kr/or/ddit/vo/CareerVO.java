package kr.or.ddit.vo;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CareerVO {
	private int caNo;
	private String empNo;
	private String caNm;
	private String caClf;
	private String caCntcase;
	private Date caEtdate;
	private Date caEdate;
	private String caDept;
	private String caJob;
	private String caDuty;
	private String caGrd;
}
