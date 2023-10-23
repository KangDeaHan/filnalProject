package kr.or.ddit.vo;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class TaskStVO {
	private int taskNo;
	private String proNo;
	private String empNo;
	private Date taskSdate;
	private Date taskEdate;
	private int taskTime;
	private String taskCont;
	private Date wriDate;
	private String taskPri;
	private int taskPrgs;
}
