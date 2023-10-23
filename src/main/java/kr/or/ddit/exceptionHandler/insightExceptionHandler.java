package kr.or.ddit.exceptionHandler;

import java.io.IOException;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.NoHandlerFoundException;

@ControllerAdvice
public class insightExceptionHandler {
	
	
	 @ExceptionHandler(NoHandlerFoundException.class)
	  public String handle404(NoHandlerFoundException e){
	      return "/error/404error";
	  }
	   
	   
	  @ExceptionHandler(IOException.class)
	  public String ioException(IOException ex) {
	      return "/error/404error"; 
	  }

	   
	  @ExceptionHandler(Exception.class)
	  public String allException(Exception ex) {
	      return "/error/404error"; 
	  }
}
