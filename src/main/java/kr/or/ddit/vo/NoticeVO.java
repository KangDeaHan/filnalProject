package kr.or.ddit.vo;

import java.util.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.common.vo.FileInfoVO;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class NoticeVO {
	// 글번호
	private int postNo;
	// 관리자 (사원번호)
	private String wriNo;
	// 글분류
	private String postClf;
	// 글제목
	private String postTitle;
	// 글내용
	private String postCont;
	// 작성일자
	private Date wriDate;
	// 첨부파일번호
	private String fileNo;
	
	// 파일 객체들
	private MultipartFile file;
	// 파일 경로
	private String fileRoot;
	private String orfiName; //원본파일이름
	private String svfiName; //저장파일이름 UUID
	
	// 사원명
	private String empNm;
	// 사원 이미지
	private String empImg;
}
