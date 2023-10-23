package kr.or.ddit.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.access.AccessDeniedHandler;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class CustomAccessDeniedHandler  implements AccessDeniedHandler{

	@Override
	public void handle(HttpServletRequest request, HttpServletResponse response,
		             	AccessDeniedException accessDeniedException) throws IOException, ServletException {
		  
		//에러 로그 확인
		log.debug("Denied Reason:" + accessDeniedException.getMessage());
		
		response.sendRedirect("/security/accessError");
	}
}