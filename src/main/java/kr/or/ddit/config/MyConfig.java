package kr.or.ddit.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration //자바파일을 설정 파일로 변형시킴
@EnableWebMvc
public class MyConfig implements WebMvcConfigurer{

	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		System.out.println("여기가 잘 실행 되는가?");
		registry.addResourceHandler("/insightFile/**")             // 웹 접근 경로 
		        .addResourceLocations("file:///d:/insightFile/");  // 서버내 실제 경로
		
		registry.addResourceHandler("/settingFile/**")             // 웹 접근 경로 
        		.addResourceLocations("file:///c:/myTool/sts3WS/insight/src/main/webapp/resources/images/setting/");  // 서버내 실제 경로
	
		registry.addResourceHandler("/setting/vacation/**")
				.addResourceLocations("file:///d:/myTool/sts3WS/insight/src/main/webapp/resources/images/break/"); //학원pc

//		registry.addResourceHandler("/vacation/**")
//				.addResourceLocations("file:///d:/MyTool/STS3/sts3WS/insight/src/main/webapp/resources/images/break/");//노트북
//		
	
	}
	
}
