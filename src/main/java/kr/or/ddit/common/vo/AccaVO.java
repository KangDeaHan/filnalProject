package kr.or.ddit.common.vo;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class AccaVO {
	private String empNo;
	private String acNm;
	private Date acEtdate;
	private Date acEdate;
	private String gradClf;
	private String maj;
	
	//공통코드
	private String gradClfNm;
}
