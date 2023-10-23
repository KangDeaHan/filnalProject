package kr.or.ddit.approval.vo;

import java.sql.Date;
import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class FixturesVO {
	private int		 docIndex; 		  //컬럼 순번
	private int 	 dftNo; 		  //기안문서번호
	private String   subject; 		  //글제목
	private String   fixName; 		  //품명
	private String   fixStandard; 	  //규격
	private int 	 fixNumber; 	  //수량
	private int 	 fixUnitPrice; 	  //단가
	private int 	 fixPrice; 		  //굼액
	private String   fixUsage; 	 	  //용도
	private int      fixTotal; 		  //합계
	private Date 	 applicationDate; //신청날짜
	
	private String empNo;//사원번호
	private String empNm;//사원이름
	
	public List<ApboxVO> apboxList; //결제자 리스트
	
	
}

