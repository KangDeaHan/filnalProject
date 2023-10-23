package kr.or.ddit.vacation.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class VacTypeVO {
	private int vacTypeNo; // 휴가 종류 번호
	private String vacTypeName; // 휴가 명
	private String vacTypeExp; // 휴가 지급방식
	private String vacTypeUseDate; // 사용가능 일수
	private String vhInfo; //휴가 정보
	private String imgRoot; // 이미지 경로
	private String vacTypeTime; // 사용 단위 코드
	private String vacTypeHoli; // 휴일 포함 여부
	private String vacTypeSal; // 급여 포함 여부 코드
	private String vacTypeGender; // 적용 성별
	private String vacTypeFile; // 증명자료 제출 여부
	private String vacTypeYn; // 사용 여부
	private int dftNo; //기안문서번호
	
	private String totalDays; //연차 총 사용 가능 일수 
}
