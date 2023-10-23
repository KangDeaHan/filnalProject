package kr.or.ddit.common.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class TbNotificationVO {
	private int ntcnId; //알림 시퀀스
	private String ntcnRcverEmpNo; //알림 수신인 사원번호
	private String ntcnContent; //얼림내용
	private String ntcnUrl; //알림주소
	private String ntcnDt;  //날짜 
	private String ntcnReadStatus; //읽음여부
	private String ntcnTitle; //알림제목
	private String ntcnSenderEmpNo; //알림 발신인 사원번호
	
	private String recEmpNm;//수신인이름
	private String SendEmpNm;//발신인이름
	private int dftNo;//발신인이름
	private String apbPro;//진행상태
	
	
}
