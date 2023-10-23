package kr.or.ddit.salary.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class SujiVO {
	private int total;
	private int pageSize;
	private int pageCnt;
	private int curPage;
	private int sIndex;
	private int eIndex;
}
