package kr.or.ddit.common.vo;

import lombok.ToString;

import lombok.Setter;

import lombok.Getter;

@Getter
@Setter
@ToString
public class messageVO {
	private String getter; //받는사람
	private String setter; //보내는 사람
	private String massage; //메세지
	private String data; //데이타
	
}
