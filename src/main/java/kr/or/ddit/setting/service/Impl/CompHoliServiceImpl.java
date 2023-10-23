package kr.or.ddit.setting.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.setting.mapper.CompHoliMapper;
import kr.or.ddit.setting.service.CompHoliService;
import kr.or.ddit.setting.vo.CompanyHoliVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class CompHoliServiceImpl implements CompHoliService {

	@Autowired
	private CompHoliMapper compHoliMapper;
	
	@Override
	public List<CompanyHoliVO> compHoliSelect() {
		return compHoliMapper.compHoliSelect();
	}

	@Override
	public int compHoliUpdate(CompanyHoliVO companyHoliVO ) {
		log.debug("리스트:::" + companyHoliVO);
		return compHoliMapper.compHoliUpdate(companyHoliVO);
	}

	@Override
	public int compHoliUpdate2(int cohNo) {
		return compHoliMapper.compHoliUpdate2(cohNo);
	}

	@Override
	public int compHoliAdd(CompanyHoliVO companyHoliVO) {
		return compHoliMapper.compHoliAdd(companyHoliVO);
	}

	@Override
	public int compHoliRemove(String cohNo) {
		return compHoliMapper.compHoliRemove(cohNo);
	}

	@Override
	public int maxCohNoSelect() {
		return compHoliMapper.maxCohNoSelect();
	}

	@Override
	public int searchCompHoli(String cohNo) {
		return compHoliMapper.searchCompHoli(cohNo);
	}

}
