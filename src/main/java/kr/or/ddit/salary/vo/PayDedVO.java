package kr.or.ddit.salary.vo;


import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PayDedVO {			// 지급공제항목
	
	private int pdNo;			// 지급공제번호(PK)
	private String pdNm;		// 지급공제명
	private int pdAmt;			// 지급공제금액		
	private String pdEpn;		// 지급공제설명		
	private String pdFml;		// 산출식		
	private String pdYn;		// 정산포함여부	
	private String pdLawYn;		// 법정필수여부코드 (법정필수, 기타수당, 기타공제)
	private String pdTaxYn;		// 과세여부코드 (과세, 비과세)
	private String pdType;		// 지급공제구분코드 (지급, 공제)
	
	//PT_MAKE 필요 컬럼
	private String isChecked;
	private int ptNo; 			// 급여템플릿번호
	private int ptmNo; 			// 급여템플릿구성번호
	
	public PayDedVO() {
		this.pdAmt = 0;
	}
		
	//서브쿼리 삽입시 필요한 값 생성
	private String empNo;		// 정산대상자번호
	private String empNm;		// 정산대상자이름
}
