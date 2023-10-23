package kr.or.ddit.vo;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CmCodeVO {
	private String cmCode;
	private String parentCd;
	private String cmNm;
	private String cmAbst;
	private String cmUseYn;
	private int cmOtptSn;
	private Date cmRegDate;
	private Date cmWriDate;
	private String cmGroup;
	
	private String type;
}
