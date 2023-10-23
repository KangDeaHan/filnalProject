package kr.or.ddit.sms.service.serviceImpl;

import java.util.HashMap;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Service;

import kr.or.ddit.common.vo.EmpVO;
import kr.or.ddit.sms.service.CoolSmsService;
import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;


@Service
public class CoolSmsServiceImpl implements CoolSmsService{
	public void sendSMS(EmpVO vo) {
		System.out.println(vo);
		String api_key = ""; // Api 키
	    String api_secret = ""; // Api secret
	    Message coolsms = new Message(api_key, api_secret);
	    // 4 params(to, from, type, text) are mandatory. must be filled
	    HashMap<String, String> params = new HashMap<String, String>();
	    params.put("to", vo.getCpNo()); 	// 수신 번호 (받는사람 번호)
	    params.put("from", "01074423311");	// 발신번호  (보내는 사람 번호)
	    params.put("type", "SMS");
	    params.put("text", "이름: "+vo.getEmpNm()+", 사번:"+vo.getEmpNo()+", 임시비밀번호: 1234, 반드시 비밀번호를 변경하세요.");
	    params.put("app_version", "test app 1.2"); // application name and version
	    try {
	    	//메세지 전송
	    	JSONObject obj = (JSONObject) coolsms.send(params);
	      	//보내진 이후에 해야할 행위들 작성
	    	System.out.println(obj.toString());
	    } catch (CoolsmsException e) {
	    	System.out.println(e.getMessage());
	    	System.out.println(e.getCode());
	    }
	}
}
