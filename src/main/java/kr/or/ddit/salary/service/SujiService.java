package kr.or.ddit.salary.service;

import java.util.List;

import kr.or.ddit.common.vo.EmpVO;
import kr.or.ddit.salary.vo.SujiVO;

public interface SujiService {
	
	public int getTotal();
	
	public List<EmpVO> getEmpOnePage(SujiVO sujiVO);
}
