package kr.or.ddit.salary.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PayTplVO {			// 급여 템플릿
	
	private int ptNo;			// 급여템플릿번호(PK)
	private String ptNm;		// 템플릿명
	private String ptEpn;		// 템플릿설명
	private String ptCdate;		// 템플릿생성일자
	private String ptYn;		// 사용여부코드
	private String ptBmkYn;		// 북마크여부코드
	
}
