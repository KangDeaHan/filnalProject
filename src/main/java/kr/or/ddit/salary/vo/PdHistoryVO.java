package kr.or.ddit.salary.vo;


import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PdHistoryVO { 	// 급여정산내역
	
	private int pdNo;		// 급여항목번호(PK(복합키))
	private String scNo;	// 급여명세서번호(PK(복합키), FK)
	private String pdNm;	// 급여항목명
	private String pdType;	// 지급공제구분코드
	private int pdAmt;		// 금액
	private String pdTaxYn; // 과세여부코드 (과세, 비과세)
}
