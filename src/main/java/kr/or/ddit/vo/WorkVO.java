package kr.or.ddit.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class WorkVO {
	private int wkNo;  // 근무코드
	private String wkNm;	// 근무명
	private String wkDescr;	// 근무설명
	private String wkYn;	// 근무사용여부
	private String wkScd;	// 일정공유여부
	private String wkNight;	// 야간허용여부
	private String wkHd;	// 휴일허용여부
	private String wkStime;	// 출근시간
	private String wkEtime;	// 퇴근시간
	private int wkWtime;	// 주 근무시간
	private String wkDay;	// 일하는 요일
	private String imgRoot; // 이미지경로
}
