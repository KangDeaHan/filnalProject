package kr.or.ddit.vo;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BbsVO {
	private int bbsNo;			// 일정번호
	private String empNo;		// 사번
	private String bbsClf;		// 글분류
	private String bbsTitle;	// 제목
	private String bbsCont;		// 내용
	private Date bbsStime;		// 시작일
	private Date bbsEtime;		// 종료일
	private String bbsColor;	// 색상
	private String bbsAllday;	// 종일여부
}
