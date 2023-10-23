package kr.or.ddit.vo;

import java.util.Date;
import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MemberVO {
	private String userid;
	//실제 사용때는 웬만하면 암호는 담지 않는 것이 좋음!
	private String userpw;
	private String username;
	private boolean enabled;
	private Date regdate;
	
	private List<AuthVO> authList;
}