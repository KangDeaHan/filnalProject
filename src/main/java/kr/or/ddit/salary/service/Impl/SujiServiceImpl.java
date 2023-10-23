package kr.or.ddit.salary.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.common.vo.EmpVO;
import kr.or.ddit.salary.mapper.SujiMapper;
import kr.or.ddit.salary.service.SujiService;
import kr.or.ddit.salary.vo.SujiVO;

@Service
public class SujiServiceImpl  implements SujiService{

	@Autowired
	private SujiMapper sujiMapper;
	
	@Override
	public int getTotal() {
		return sujiMapper.getTotal();
	}

	@Override
	public List<EmpVO> getEmpOnePage(SujiVO sujiVO) {
		return sujiMapper.getEmpOnePage(sujiVO);
	}

}
