package kr.or.ddit.vo;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class EmpmnStatsVO {
	private int empmnNo;        //통계번호
	private Date empmnDate;     //통계날짜
	private int empmnEcnyp;     //입사자
	private int empmnRetp;      //퇴사자
	
	private int empmnApplp;		//지원자
	private int empmnApplpNew;  //신입지원자
	private int empmnApplpOld;  //경력지원자
	private int empmnApplM;     //남자 지원자
	private int empmnApplF;     //여자 지원자
	
	
	private int empmnHanslNew;    //신입연봉
	private int empmnHanslOld;    //경력직연봉
	
	//최종 합격자 학력
	private String empmnLacdH; //고졸 
	private String empmnLacdU; //대졸
	private String empmnLacdG; //대학원
	private String empmnLacdD; //석박사
}
