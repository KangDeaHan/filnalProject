package kr.or.ddit.salary.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

//페이징 관련 정보 + 게시글 데이터 
@Getter
@Setter
@ToString
public class PageVO {
	//전체글 수(record) 
	private int total;			//164
	//현재 페이지 번호 
	private int currentPage;
	//전체 페이지 수 
	private int pageCnt;		//totalPages 17
	//시작 페이지 번호
	private int startPage;
	//한 화면에 보여질 행의 수
	private int pageSize;//기본은 10행
	//종료 페이지 번호
	private int endPage;
	//검색어
	private String keyword;
	//검색조건
	private String condition;
	
	
}

