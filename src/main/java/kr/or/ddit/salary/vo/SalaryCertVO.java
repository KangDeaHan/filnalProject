package kr.or.ddit.salary.vo;


import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class SalaryCertVO { 	//급여명세서
	
	private int scNo; 		//급여명세서번호 (PK)
	private String empNo; 		//급여정산대상자(사원번호, FK)
	private int ptNo; 			//급여템플릿번호 (FK)
	private String scIsDate; 	//급여명세서발급일자 (Date)
	private int prYr; 			//급여정산귀속연도
	private int prMth; 			//급여정산귀속월
	private int pytlAmt; 		//지급총액
	private int ddtlAmt; 		//공제총액
	private int netAmt; 		//실지급액
	private String prFdate; 	//정산완료일자 (Date)
	private String finYn; 		//정산여부코드
	private String prPdate; 	//급여지급일자 (Date)
	private String prStlNm;		//급여정산명
	
	private String prYM; //급여정산 귀속년월
	
	//mapper에서 매개변수에 쓰일 변수
	private String pdNm; 		//급여항목이름
	private int pdAmt;			//급여항목금액
	private int pdNo;			//지급공제번호
	private String pdLawYn;		//법정필수여부코드 (법정필수, 기타수당, 기타공제)
	private String pdType;		//지급공제구분
	
	
	private int basePay;		//기본급
	private int basicHourWage;	//기본시급
	private int totalAdmitTime; //총 인정시간
	private int totalExtime; 	//연장근로시간
	private int totalNightime; //야간근로시간
	private int totalHdtime; 	//휴일근로시간
	
	private int overtimePay;	//초과근무수당 계산값
	private int nightimePay;	//연장근무수당 계산값
	private int hdtimePay;		//휴일근무수당 계산값
	private int totalExPay;		//연장근무수당 총합계 계산값

	private int totalTaxAmt;	//과세총액
	private int whdTaxAmt;		//원천세액 (withholding tax amount)
	
	private int scIsNo;			//급여명세서 발급 번호
	private String scIsRsn;		//급여명세서 발급사유
	private String scType;		//명세서종류
	
	private String incIsRsn; 	//소득증명서발급사유
	private String incIsDate;	//소득증명서발급일자
	
	private int prPdateMth;			//급여지급일 월
	private int prPdateDay;			//급여지급일 일
	private String prPdateWeekday;  //급여지급일 요일
	private int prFdateMth;			//급여정산완료 월
	private int prFdateDay;			//급여정산완료 일
	
	private int sumPytlAmt;		//급여대장 총 지급총액
	private int sumDdtlAmt;		//급여대장 총 공제총액
	private int sumNetAmt;		//급여대장 총 실지급액
	
	//사원
	private String dnm;			//부서명
	private String empBrdt;		//생년월일
	private int dpdntNum; 		//부양가족수
	private String empMail;		//정산대상자메일
	private String empNm;		//정산대상자이름
	private String entDate;
	private String outDate;
	private String dtcodeNm;
	private String ptnCodeNm;
	private String jcodeNm;
	private String grdCodeNm;
	private String stClfCdNm;	// 재직상태 (재직, 휴직)
	
	private String svfiName;	//파일
	
	private String sdate;		//시작날짜
	private String edate;		//끝날짜
	private String taxDate;		//납세일자

	
}
