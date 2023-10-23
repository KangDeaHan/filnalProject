package kr.or.ddit.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import kr.or.ddit.common.mapper.EmpMapper;
import kr.or.ddit.common.vo.EmpVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class CustomUserDetailsService implements UserDetailsService {

	@Autowired
	private EmpMapper empMapper;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		log.info("사번 : {}",username);
	
		EmpVO empVO = empMapper.read(username);
		log.info("empVO : {}", empVO);
		
		if(empVO != null) {
			return new CustomUser(empVO);
		}else {
			throw new UsernameNotFoundException(username);
		}
	}
}