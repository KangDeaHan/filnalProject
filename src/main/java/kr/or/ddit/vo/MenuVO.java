package kr.or.ddit.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MenuVO {
	private String menuNo;
	private String parentMno;
	private String menuSe;
	private String menuNm;
	private int menuSno;
	private String menuDc;
	private String menuUrl;
	private String menuYnCd;
}
