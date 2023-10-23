package kr.or.ddit.statistics.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.common.vo.DeptVO;
import kr.or.ddit.common.vo.EmpVO;
import kr.or.ddit.statistics.mapper.StatisticsMapper;
import kr.or.ddit.statistics.service.StatisticsService;
import kr.or.ddit.vo.CostStatsVO;
import kr.or.ddit.vo.EmpStatsVO;
import kr.or.ddit.vo.EmpmnStatsVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class StatisticsServiceImpl implements StatisticsService {
	
	@Autowired
	StatisticsMapper statisticsMapper;


	//현재 남녀 인원수
	@Override
	public List<Object> mFcount(List<String> labels) {
		
		List<Object> result = statisticsMapper.mFcount(labels);
		log.info("statisticsMapper -> result" + result);
		return result;
	}

	//분기별 직급별 평균 근무시간
	@Override
	public List<EmpStatsVO> tltime(String ptnCode) {
		// TODO Auto-generated method stub
		return statisticsMapper.tltime(ptnCode);
	}


	//분기별 평균 출근시간
	@Override
	public List<EmpStatsVO> setime(String quarter) {
		// TODO Auto-generated method stub
		return statisticsMapper.setime(quarter);
	}

	//직급별 평균급여
	@Override
	public List<EmpStatsVO> salary(String ptnCode) {
		return statisticsMapper.salary(ptnCode);
	}

	//분기별 입사자 수
	@Override
	public List<EmpStatsVO> incount() {
		return statisticsMapper.incount();
	}

	//분기별 퇴사자 수
	@Override
	public List<EmpStatsVO> outcount() {
		return statisticsMapper.outcount();
	}

	//인원관리토탈정보
	@Override
	public List<EmpmnStatsVO> employment() {
		return statisticsMapper.employment();
	}

	//부서 가져오기
	@Override
	public List<DeptVO> dept() {
		return statisticsMapper.dept();
	}

	//부서별 평균연봉
	@Override
	public List<EmpStatsVO> deptavgHansl() {
		return statisticsMapper.deptavgHansl();
	}

	@Override
	public List<CostStatsVO> cost() {
		return statisticsMapper.cost();
	}

	@Override
	public List<EmpStatsVO> yearMF() {
		return statisticsMapper.yearMF();
	}

	//년도별 직위별 평균 근무시간
	@Override
	public List<EmpStatsVO> yeartltime(String ptnCode) {
		return statisticsMapper.yeartltime(ptnCode);
	}

	//년도별 평균 출퇴근시간
	@Override
	public List<EmpStatsVO> yearsetime(String year) {
		return statisticsMapper.yearsetime(year);
	}

	@Override
	public List<CostStatsVO> yearcost(String year) {
		return statisticsMapper.yearcost(year);
	}

	@Override
	public List<EmpmnStatsVO> yearemployment() {
		return statisticsMapper.yearemployment();
	}
	


	
}