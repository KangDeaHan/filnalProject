package kr.or.ddit.common.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class DeptVO {
	private int    dcode;
	private int uprDcode;
	private String dnm;
	private String empNo;
	private String dabst;
	private String delynCd;
	
	//부서에 사원이름
	private String deptName;
}

