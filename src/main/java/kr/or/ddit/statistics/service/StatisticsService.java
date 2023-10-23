package kr.or.ddit.statistics.service;

import java.util.List;

import kr.or.ddit.common.vo.DeptVO;
import kr.or.ddit.common.vo.EmpVO;
import kr.or.ddit.vo.CostStatsVO;
import kr.or.ddit.vo.EmpStatsVO;
import kr.or.ddit.vo.EmpmnStatsVO;

public interface StatisticsService {

	//남녀 비율
	public List<Object> mFcount(List<String> labels);

	//분기별 직위별 평균근무시간
	public List<EmpStatsVO> tltime(String ptnCode);

	//분기별 평균 출퇴근시간
	public List<EmpStatsVO> setime(String quarter);

	//직급별 평균 급여
	public List<EmpStatsVO> salary(String ptnCode);

	//분기별 입사자수
	public List<EmpStatsVO> incount();

	//분기별 퇴사자 수
	public List<EmpStatsVO> outcount();

	//분기별 채용관리 토탈
	public List<EmpmnStatsVO> employment();

	//부서 가져오기
	public List<DeptVO> dept();

	//부서별 평균연봉
	public List<EmpStatsVO> deptavgHansl();

	//비용 토탈
	public List<CostStatsVO> cost();

	//년 남여 인원수
	public List<EmpStatsVO> yearMF();

	//년도별 직위별 평균 근무시간
	public List<EmpStatsVO> yeartltime(String ptnCode);

	//년도별 평균 출퇴근시간
	public List<EmpStatsVO> yearsetime(String year);

	//년도별 경비 지출
	public List<CostStatsVO> yearcost(String string);

	//년도별 채용관리 토탈
	public List<EmpmnStatsVO> yearemployment();

}
