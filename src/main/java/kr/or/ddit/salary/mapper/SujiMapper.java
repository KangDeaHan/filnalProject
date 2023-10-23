package kr.or.ddit.salary.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.common.vo.EmpVO;
import kr.or.ddit.salary.vo.SujiVO;

@Mapper
public interface SujiMapper {

	public int getTotal();
	
	public List<EmpVO> getEmpOnePage(SujiVO sujiVO);
}
