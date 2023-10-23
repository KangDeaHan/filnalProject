package kr.or.ddit.handler;

import java.util.ArrayList;
import java.util.List;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;

import kr.or.ddit.common.vo.messageVO;
import lombok.extern.slf4j.Slf4j;

//중계소(엔드포인트 /ws-chat)로 오는 메시지를 처리해 주는 사람

// Jackson 라이브러리인 ObjectMapper를 이용
// JSON <-> JAVA 변환을 편하게 사용하여 전송 데이터 구조를 잘 만들면
// 웬만한 필요한건 다 할 수 있음!
@Slf4j
public class SocketHandler extends TextWebSocketHandler {
	private static List<WebSocketSession> list = new ArrayList<WebSocketSession>();
	private ObjectMapper objMapper = new ObjectMapper();
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		log.info("## 누군가 접속");
		list.add(session);
	}
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		String uMsg = message.getPayload();
		log.info("요청 메시지 확인 : {} ", uMsg);
		
		messageVO msgVO = objMapper.readValue(uMsg, messageVO.class);
		log.info("메시지 변환 확인 : {}", msgVO);
	
		String retMsg = objMapper.writeValueAsString(msgVO);
		
		for (WebSocketSession webSocketSession : list) {
			webSocketSession.sendMessage(new TextMessage(retMsg));
		}
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		log.info("## 누군가 떠남");
		list.remove(session);
	}
	
}