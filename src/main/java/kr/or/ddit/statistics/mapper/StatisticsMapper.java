package kr.or.ddit.statistics.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.common.vo.DeptVO;
import kr.or.ddit.common.vo.EmpVO;
import kr.or.ddit.vo.CostStatsVO;
import kr.or.ddit.vo.EmpStatsVO;
import kr.or.ddit.vo.EmpmnStatsVO;

@Mapper //mybatis-scan 설정해 놓았기 때문에 생략가능
public interface StatisticsMapper {

	//남벼비율
	public List<Object> mFcount(List<String> labels);

	//분기별 직위별 평균 근무시간
	public List<EmpStatsVO> tltime(String ptnCode);

	//분기별 평균 출근시간
	public List<EmpStatsVO> setime(String quarter);

	//직급별 평균 급여
	public List<EmpStatsVO> salary(String ptnCode);

	//분기별 입사자 수
	public List<EmpStatsVO> incount();

	//분기별 퇴사자 수
	public List<EmpStatsVO> outcount();

	//분기별 채용관리 토탈
	public List<EmpmnStatsVO> employment();

	//부서 가져오기
	public List<DeptVO> dept();

	//부서별 평균연봉
	public List<EmpStatsVO> deptavgHansl();

	//코스트 토탈
	public List<CostStatsVO> cost();

	//년도별 남여 인원수
	public List<EmpStatsVO> yearMF();

	//년도별 직위별 평균 근무시간
	public List<EmpStatsVO> yeartltime(String ptnCode);

	//년도별 평균 출 퇴근시간
	public List<EmpStatsVO> yearsetime(String year);

	//년도별 지출
	public List<CostStatsVO> yearcost(String year);

	//년도별 채용관리 토탈
	public List<EmpmnStatsVO> yearemployment();
	
	


}