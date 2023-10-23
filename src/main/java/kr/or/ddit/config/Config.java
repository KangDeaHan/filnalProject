package kr.or.ddit.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableScheduling;

@Configuration	//root-context에서 annotation-config 했기떄문에 쓸 수 있음
//이것만 하면,스프링 컨텍스트에서 지원하는 스케줄러를 사용할 수 있음
@EnableScheduling //기본제공 스케줄러를 사용하겠다, xml로(task어떠궁저쩌궁) 하면 씅질나빠짐
public class Config {

}
