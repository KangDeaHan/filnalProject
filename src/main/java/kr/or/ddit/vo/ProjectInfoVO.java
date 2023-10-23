package kr.or.ddit.vo;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ProjectInfoVO {
	private int proNo;
	private String proClf;
	private String proNm;
	private int payAmt;
	private String ornt;
	private String chrgDept;
	private String chrgNm;
	private String chrgTel;
	private Date proSdate;
	private Date proEdate;
}
