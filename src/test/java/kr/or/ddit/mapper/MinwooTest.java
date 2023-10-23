package kr.or.ddit.mapper;

import java.util.List;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import kr.or.ddit.common.mapper.EmpMapper;
import kr.or.ddit.common.vo.EmpVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@ExtendWith(SpringExtension.class) //JUnit5 테스트 프레임워크 사용 의미
@ContextConfiguration("classpath:config/spring/root-context.xml")
public class MinwooTest {

	@Autowired
	private PasswordEncoder passwordEncoder;
	@Autowired
	private EmpMapper empMapper;
	
	
	@Test
	@DisplayName("suchEmp")
	//@Disabled
	public void suchEmp() {
		List<EmpVO> list = empMapper.suchEmp("테스트");
		log.info(list.toString());
//		assertEquals(1,empMapper.suchEmp("테스트"));
	}


	
}
