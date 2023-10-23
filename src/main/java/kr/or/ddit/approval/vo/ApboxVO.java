package kr.or.ddit.approval.vo;

import java.util.Date;
import java.util.List;

import kr.or.ddit.common.vo.FileInfoVO;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ApboxVO {
	private String empNo;
	private int    dftNo;
	private String   apDate;
	private String rejRsn;
	private String arbSt;
	private String finAuthSt;
	private String serialNumber;
	private String apbPro;
	private String important;
	private String apbImportant;
	
	//비품신청란
	private int		 docIndex; 		  //컬럼 순번   
	private String   subject; 		  //글제목     
	private String   fixName; 		  //품명      
	private String   fixStandard; 	  //규격      
	private int 	 fixNumber; 	  //수량      
	private int 	 fixUnitPrice; 	  //단가      
	private int 	 fixPrice; 		  //굼액      
	private String   fixUsage; 	 	  //용도      
	private int      fixTotal; 		  //합계      
	private Date 	 applicationDate; //신청날짜    

	//휴가 신청
	private String vaapEmp; //휴가 신청자
	private String vaapDays; //휴가 신청일 수
	private String vaapRsn; //휴가 신청사유
	private String vaapApstCode; //휴가신청결재상태 코드
	private String vaapRtRs; //휴가신청 반려사유
	private String vaapCcSt; //휴가신청쉬소상태
	private String vaapStart; //휴가 시작일
	private String vaapEnd; //휴가 종료일
	private String vaapType; //당일 휴가 유형
	private int vacTypeNo; //휴가 종류 번호 (1=)
	private String vacTypeName; //휴가 종류 이름
	private String vaapDate; //휴가 신청일자
	
	//근무신청
	private int waNo; //근무신청 번호
	private String waAper; //신청자
	//private String waRver; //승인자
	private String waDate; //근무일
	private String waApdate; //신청일자
	private String waArsn; //신청사유
	private String waStime; //추가 출근시간
	private String waEtime; //추가 퇴근시간
	private String waAllday; //종일여부
	private int waExtime; //연장근무시간
	private int waNightime; //야간근무시간
	private int hdtime; //휴일근무시간
	private String waType; //근무유형코드
	private String ewApst; // 결재상태 코드
	private int waTltime; //총근무시간
	private String ewAdate; //결재일자
	private String ewRejrsn; //반려사유
	private String waDel; //근무신청삭제여부콛
	private String wkColor; //신청색
	
	//휴직신청
	private String bkCertYn; //휴직증빙자료 제출여부 코드
	private String fileSetting; //관리파일 번호
	private String orfiName; //원본파일이름
	private int fileSn; //파일순번
	private Date bkapDate; //휴직신청날짜
	private int bkNo; //휴직신청번호
	private String bkCode; //휴직코드
	private String bkNm; //휴직코드 이름
	private String bkSdate; //휴직 시작일
	private String bkEdate; //휴직 종료일
	private String bkRsn; //휴직 사유
	private String bkApstCode; //결재상태코드
	private String bkApstNm; //결쟈상태이름
	
	
	
	//부서 코드
	private String dtcodenm;
	
	//나의 이미지파일 경로
	private String myImg;
	private String signImg;
	
	//신청자
	private String empNm;
	private String fempNo;
	
	//문서작성종류
	private String dockind;
	
	//결제자들
	private List<ApboxVO> apboxEmpList;
	
	//나의 이미지 파일들
	public List<FileInfoVO> myFileList; 
	
	public String ptnCode;
	public String signFileNo;
}
