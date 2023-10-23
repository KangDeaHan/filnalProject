package kr.or.ddit.vo;

import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class AcntAuthorVO {
	private String authrtId;
	private String authrtNm;
	private String authrtExpln;
	private String authrtBaYn;
	private int	authrtSn;
	private String authrtYn;
	private String imgRoot;
	
	private String[] menuNo1;
	private String[] menuNo2;
	private String menuNo;
	
}
