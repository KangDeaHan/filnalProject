package kr.or.ddit.vacation.vo;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class VacHoldVO {
	private int vhCngNo; //보유휴가번호
	private String empNo;//사원번호
	private int vhDaycnt;//보유 휴가 일수
	private int vacTypeNo; //휴가종류번호
	private String vhGiveDate; //부여 날짜
	private int vhGiveDays; //부여연차 일수 
	
	private String vaapDays; //휴가신청일수
	private String vacTypeUseDate; //사용가능한 연차
}
