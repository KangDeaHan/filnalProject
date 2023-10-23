package kr.or.ddit.common.vo;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class FileInfoVO {
	private int fileSn; //파일 순번
	private String orfiName; //원본파일이름
	private String svfiName; //저장파일이름 UUID
	private long fileSize; //파일크기
	private Date svDate;  //저장날짜
	private String fileUdter; //파일 등록자
	private String fileRoot;  //파일경로
	private String fileSetting; //카테고리별 넘버
}
