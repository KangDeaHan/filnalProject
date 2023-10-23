package kr.or.ddit.vo;

import lombok.ToString;

import lombok.Setter;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Getter;

@Getter
@Setter
@ToString
public class WkApVO {
	private int waNo;			// 넘버
	private String waAper;		// 신청자
	private String waRver;		// 승인자
	private Date waDate;		// 근무일
	private Date waApdate;		// 신청일자
	private String waArsn;		// 신청사유
	@DateTimeFormat(pattern = "yyyy-MM-dd hh:mm:ss")
	private Date waStime;		// 근무시작시간
	@DateTimeFormat(pattern = "yyyy-MM-dd hh:mm:ss")
	private Date waEtime;		// 근무종료시간
	private boolean waAllday;	// 종일여부
	private int waExtime;		// 연장근무시간
	private int waNightime;		// 야간근무시간
	private int hdtime;			// 휴일근무시간
	private String waType;		// 근무유형
	private String ewApst;		// 결재상태
	private int waTltime;		// 기본휴게시간
	private Date ewAdate;		// 결재일자
	private String ewRejrsn;	// 반려사유
	private String waDel;		// 근무신청삭제여부코드
	private String wkColor;		// 근무유형별 색상
	
	private String empNm;			// 사원이름
	private String empNo;			// 사원번호
	private String empImg;			// 사원이미지
	private String profileFileNo;	// 프로필파일넘버
	private String dnm;				// 부서명
	private int dftNo;				// 문서번호 
	private String apbPro; 			// 결재상태
}
