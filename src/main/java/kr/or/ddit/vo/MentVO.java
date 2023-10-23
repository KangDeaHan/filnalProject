package kr.or.ddit.vo;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MentVO {
	private int mtNo;
	private int bbsNo;
	private String empNo;
	private String mtCont;
	private Date mtDate;
}
