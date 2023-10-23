package kr.or.ddit.vo;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class EmpStatsVO {
	private int empStatsNo;
	private Date empStatsDate;
	private int empPer;
	private int empMper;
	private int empFper;
	private int empAvrgAge;
	private int empEcnyAge;
	private int empAvrgSalary;
	private double avrgWorkHr;
	private double avrgAttendTime;
	private double avrgLvffcTime;
	private String ptnCode;
	
	private int quarter;
	private int count;
	
	private int year;
	
	private int deptHansl1;
	private int deptHansl2;
	private int deptHansl3;
	private int deptHansl4;
	
	
	private String dateday; //    요일
	private String yearSalary;
}   
