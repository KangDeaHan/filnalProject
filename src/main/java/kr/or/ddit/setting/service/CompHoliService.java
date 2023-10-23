package kr.or.ddit.setting.service;

import java.util.List;

import kr.or.ddit.setting.vo.CompanyHoliVO;

public interface CompHoliService {

	public List<CompanyHoliVO> compHoliSelect();
	
	public int compHoliUpdate(CompanyHoliVO companyHoliVO);

	public int compHoliUpdate2(int cohNo);

	public int compHoliAdd(CompanyHoliVO companyHoliVO);

	public int compHoliRemove(String cohNo);

	public int maxCohNoSelect();

	public int searchCompHoli(String cohNo);
}
