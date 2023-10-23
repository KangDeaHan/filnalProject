package kr.or.ddit.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class AuthMenuVO {
	private String authrtId;
	private String menuNo;
	private String menuReadCd;
	private String menuWriCd;
	private String menuDelCd;
}
