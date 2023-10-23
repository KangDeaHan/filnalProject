package kr.or.ddit.vo;

import java.util.List;

import kr.or.ddit.common.vo.DeptVO;
import kr.or.ddit.common.vo.EmpVO;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class AsgmtVO {
	private int    asgmtNo;
	private String asgmtPers;
	private String writer;
	private String asgmtClf;
	private String asgmtRsn;
	private String asgmtMm;
	private String asgmtDate;
	private String fwrDate;
	private String lwrDate;   
	private String asgmtCcst;
	private String dtcode; //직책
	private String ptnCode; //직위
	private String jcode; //직무
	private String grdCode; //연차 호봉
	private String dcode; // 본부 부서 팀
	private String personCount;
	private String empImg;
	
	private String acenter;
	private String bcenter;
	private String ccenter;
	
	
	private EmpVO empVO;
	private EmpVO VO;
	private List<EmpVO> empVOList;
	
	
}
