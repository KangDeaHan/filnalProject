package kr.or.ddit.setting.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.setting.vo.CompanyHoliVO;
import kr.or.ddit.setting.vo.CompanyInfoVO;

@Mapper
public interface CompHoliMapper {

	public List<CompanyHoliVO> compHoliSelect();

	public int compHoliUpdate(CompanyHoliVO companyHoliVO);
	
	public int compHoliUpdate2(int cohNo);

	public int compHoliAdd(CompanyHoliVO companyHoliVO);

	public int compHoliRemove(String cohNo);

	public int maxCohNoSelect();

	public int searchCompHoli(String cohNo);
}
