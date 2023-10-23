package kr.or.ddit.statistics.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.common.vo.DeptVO;
import kr.or.ddit.common.vo.EmpVO;
import kr.or.ddit.statistics.service.StatisticsService;
import kr.or.ddit.vo.ChartVO;
import kr.or.ddit.vo.CostStatsVO;
import kr.or.ddit.vo.DatasetsVO;
import kr.or.ddit.vo.EmpStatsVO;
import kr.or.ddit.vo.EmpmnStatsVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/statistics")
@Controller
public class statisticsController {

	@Autowired
	StatisticsService statisticsService;
	
	@GetMapping("/employee")
	public String employee() {
		return "statistics/employee";
	}
	
	String[] colors = {"#CAF67C","#8CE2FD","#FFE08B","#61f2c4"}; //고졸 대졸 대학원 석박사
//	String[] colors = {"#fab039","#39fa60","#8c00ff","red"}; //고졸 대졸 대학원 석박사
	String[] ptncolors = {"#CAF67C","#8CE2FD","#FFE08B","#61f2c4","#ECD5E3","#ff83ce","gray"}; //사원~부장
	String[] quterColor = {"#53ec53", "#ADC8FF" ,"#FFD36F" , "#FDBAA8"}; //분기 년도별
	String[] salayColor = {"#CAF67C","#8CE2FD"};  //신입 , 경력 
	String[] useMoeny = {"#CAF67C","#8CE2FD","#FFE08B","#61f2c4"}; //출장 식비 경비 비품비
//	String[] useMoeny = {"#77f043","#fabb46","#9446fa","#ff70e0"}; //출장 식비 경비 비품비
	String[] mfColor = {"#53ec53", "#ADC8FF" ,"#FDBAA8","gray"}; //전체 , 남자 , 여자
//	String[] mfColor = {"#00ff1a","#3366FF","#ff2121","gray"}; //전체 , 남자 , 여자
//	String[] inout = {"#f6ff54","#69fc00", "#4026ff"}; //지원자 , 신입, 신경 
	String[] inout = {"#CAF67C","#8CE2FD","#FFE08B"}; //지원자 , 신입, 신경 
			
	///////////////////////분기별 ////////////////////////////////
	@ResponseBody
	@GetMapping("/MF")
	public ChartVO MF() {
		
		ChartVO chartVO = new ChartVO();
		DatasetsVO vo = new DatasetsVO();
		List<DatasetsVO> datasets = new ArrayList<DatasetsVO>();
		
		
		List<String> labels = new ArrayList<String>();
		labels.add("남성");
		labels.add("여성");
		chartVO.setLabels(labels);

		
		
		List<Object> data = statisticsService.mFcount(labels);
	

		vo.setData(data);
		datasets.add(vo);
		
		chartVO.setDatasets(datasets);
		
		return chartVO;
	}
	
	
	//직급별 근무시간
	@ResponseBody
	@GetMapping("/tltime")
	public ChartVO tltime() {
		ChartVO chartVO = new ChartVO(); // 차트
		List<DatasetsVO> datasetList = new ArrayList<DatasetsVO>(); //차트 마지막 넣는곳
		 //차트 분기 마다 값
		
		List<String> labels = new ArrayList<String>();
		labels.add("1분기");
		labels.add("2분기");
		labels.add("3분기");
		labels.add("4분기");
		chartVO.setLabels(labels);
		
		
		String ptnCode = null;
		String colorr = null;
		
		String[] ptnCodes= {"A0101","A0102","A0103","A0104","A0105","A0106"};
		for(int i=0; i<ptnCodes.length; i++) {
			DatasetsVO datasetsVO = new DatasetsVO();
			List<EmpStatsVO> empStatsVO = null;
			List<Object> data = new ArrayList<>();
			
			ptnCode = ptnCodes[i];
			colorr = ptncolors[i];
			datasetsVO.setBackgroundColor(colorr);
			datasetsVO.setBorderColor(colorr);
			
			log.info("사원 잘찍혀" + ptnCode);
			log.info("첫 데이터" +datasetsVO);
			
			empStatsVO = statisticsService.tltime(ptnCode); // 뭐리  분기 사원 평균시간 구해오는거
			datasetsVO.setLabel(empStatsVO.get(0).getPtnCode());
//			datasetsVO.setLabel(ptnCode); // 위에꺼 풀어줘야함 데이터 다 넣고
			
			log.info("쳌쳌" + empStatsVO);
			log.info("사이즈 체크 " + empStatsVO.size());
				for(int a=0; a<empStatsVO.size(); a++) {
					data.add(String.format("%.1f", empStatsVO.get(a).getAvrgWorkHr()));
				}

			datasetsVO.setData(data);
			log.info("들어간 데이터" + datasetsVO);
			
			
			
			datasetList.add(datasetsVO);
			log.info("데이터 리스트" + datasetList);
			log.info("차트 리스트" + chartVO);
			
			
		}	
		chartVO.setDatasets(datasetList);
		
		
		log.info("차트 데이터 결과본" + chartVO);
		
		return chartVO;
	}
	
	
	
	
	
	
	//평근 출 퇴근 시간
	@ResponseBody
	@GetMapping("/stime")
	public ChartVO stime() {
		ChartVO chartVO = new ChartVO(); // 차트
		List<DatasetsVO> datasetList = new ArrayList<DatasetsVO>(); //차트 마지막 넣는곳
		
		List<String> labels = new ArrayList<String>();
		labels.add("월");
		labels.add("화");
		labels.add("수");
		labels.add("목");
		labels.add("금");
		labels.add("토");
		labels.add("일");
		chartVO.setLabels(labels);
		
		String quarter = null;
		String color = null;
		
		String[] quarters = {"1", "2", "3", "4"};
		
		for(int i=0; i<quarters.length; i++) {
			DatasetsVO datasetsVO = new DatasetsVO();
			List<EmpStatsVO> empStatsVO = null;
			List<Object> data = new ArrayList<>();
			
			quarter = quarters[i];
			color = quterColor[i];
			
			datasetsVO.setBorderColor(color);
			datasetsVO.setBackgroundColor(color);
			datasetsVO.setPointColor(color);
			datasetsVO.setPointRadius("3");
			
			empStatsVO = statisticsService.setime(quarter);
			datasetsVO.setLabel(quarter+"분기");
			
			for(int a=0; a<empStatsVO.size(); a++) {
				data.add(String.format("%.1f", empStatsVO.get(a).getAvrgAttendTime()));
			}
			datasetsVO.setData(data);
			log.info("들어간 데이터" + datasetsVO);
			
			
			
			datasetList.add(datasetsVO);
			log.info("데이터 리스트" + datasetList);
			log.info("차트 리스트" + chartVO);
			
			
		}	
		chartVO.setDatasets(datasetList);
		
		
		log.info("차트 데이터 결과본" + chartVO);
		
		return chartVO;
	}
	//평근 퇴근 시간
	@ResponseBody
	@GetMapping("/etime")
	public ChartVO etime() {
		ChartVO chartVO = new ChartVO(); // 차트
		List<DatasetsVO> datasetList = new ArrayList<DatasetsVO>(); //차트 마지막 넣는곳
		
		List<String> labels = new ArrayList<String>();
		labels.add("월");
		labels.add("화");
		labels.add("수");
		labels.add("목");
		labels.add("금");
		labels.add("토");
		labels.add("일");
		chartVO.setLabels(labels);
		
		String quarter = null;
		String color = null;
		
		String[] quarters = {"1", "2", "3", "4"};
		
		for(int i=0; i<quarters.length; i++) {
			DatasetsVO datasetsVO = new DatasetsVO();
			List<EmpStatsVO> empStatsVO = null;
			List<Object> data = new ArrayList<>();
			
			quarter = quarters[i];
			color = quterColor[i];
			
			datasetsVO.setBorderColor(color);
			datasetsVO.setBackgroundColor(color);
			datasetsVO.setPointColor(color);
			datasetsVO.setPointRadius("3");
			
			empStatsVO = statisticsService.setime(quarter);
			datasetsVO.setLabel(quarter+"분기");
			
			for(int a=0; a<empStatsVO.size(); a++) {
				data.add(String.format("%.1f", empStatsVO.get(a).getAvrgLvffcTime()));
			}
			datasetsVO.setData(data);
			log.info("들어간 데이터" + datasetsVO);
			
			
			
			datasetList.add(datasetsVO);
			log.info("데이터 리스트" + datasetList);
			log.info("차트 리스트" + chartVO);
			
			
		}	
		chartVO.setDatasets(datasetList);
		
		
		log.info("차트 데이터 결과본" + chartVO);
		
		return chartVO;
	}
		
		

	//직급별 평균 연봉
	@ResponseBody
	@GetMapping("/avgSalary")
	public ChartVO avgSalary() {
		ChartVO chartVO = new ChartVO(); // 차트
		List<DatasetsVO> datasetList = new ArrayList<DatasetsVO>(); //차트 마지막 넣는곳
		DatasetsVO datasetsVO = new DatasetsVO();
		List<EmpStatsVO> empStatsVO = null;
		List<Object> data = new ArrayList<>();
		
		List<String> labels = new ArrayList<String>();
		labels.add("사원");
		labels.add("주임");
		labels.add("대리");
		labels.add("과장");
		labels.add("차장");
		labels.add("부장");
		chartVO.setLabels(labels);
		
		String ptnCode = null;
		String color = null;
		
	
			empStatsVO =statisticsService.salary(ptnCode);
			log.info("가져와라 연봉" + empStatsVO);
			for (int i = 0; i < empStatsVO.size(); i++) {
			    double value = Double.parseDouble(empStatsVO.get(i).getYearSalary());
			    String formattedValue = String.format("%.1f", value);
			    color = ptncolors[i];
			    
			    data.add(formattedValue);
			    
			}

			datasetsVO.setData(data);
			datasetsVO.setLabel("직급별 연봉");
			log.info("VO@@데이터" + datasetsVO);
			
			datasetList.add(datasetsVO);
			
			chartVO.setDatasets(datasetList);
			
			
			log.info("차트 데이터 결과본555" + chartVO);
			return chartVO;
		}
	
	
	// 분기별 입사자 수 --emp에서 가져옴
	@ResponseBody
	@GetMapping("/inpeople")
	public ChartVO entDate() {
		ChartVO chartVO = new ChartVO();
		List<DatasetsVO> datasetList = new ArrayList<DatasetsVO>(); //차트 마지막 넣는곳
		DatasetsVO datasetsVO = new DatasetsVO();
		List<Object> data = new ArrayList<>();
		
		List<String> labels = new ArrayList<String>();
		labels.add("1분기");
		labels.add("2분기");
		labels.add("3분기");
		labels.add("4분기");
		chartVO.setLabels(labels);
		
//		List<EmpStatsVO>empStatsVOList = statisticsService.incount(); 
		List<EmpmnStatsVO> empmnStatsVOList = statisticsService.employment();
		for(int i=0; i<empmnStatsVOList.size(); i++) {
			data.add(empmnStatsVOList.get(i).getEmpmnEcnyp());
		}
		datasetsVO.setLabel("입사자수");
		datasetsVO.setData(data);
		datasetsVO.setBackgroundColor(inout[0]);
		datasetsVO.setBorderColor(inout[0]);
		datasetsVO.setPointColor(inout[0]);
		datasetsVO.setPointRadius("3");
		log.info("입사자VO " + datasetsVO );
		
		datasetList.add(datasetsVO);
		
		chartVO.setDatasets(datasetList);
		
		return chartVO;
	}
	
	// 분기별 퇴사자자 수 --emp에서 가져옴
	@ResponseBody
	@GetMapping("/outpeople")
	public ChartVO outDate() {
		ChartVO chartVO = new ChartVO();
		List<DatasetsVO> datasetList = new ArrayList<DatasetsVO>(); //차트 마지막 넣는곳
		DatasetsVO datasetsVO = new DatasetsVO();
		List<Object> data = new ArrayList<>();
		
		List<String> labels = new ArrayList<String>();
		labels.add("1분기");
		labels.add("2분기");
		labels.add("3분기");
		labels.add("4분기");
		chartVO.setLabels(labels);
		
//		List<EmpStatsVO>empStatsVOList = statisticsService.outcount(); 
		List<EmpmnStatsVO> empmnStatsVOList = statisticsService.employment();
		for(int i=0; i<empmnStatsVOList.size(); i++) {
			data.add(empmnStatsVOList.get(i).getEmpmnRetp());
		}
		datasetsVO.setLabel("퇴사자 수");
		datasetsVO.setData(data);
		datasetsVO.setBackgroundColor(inout[1]);
		datasetsVO.setBorderColor(inout[1]);
		datasetsVO.setPointColor(inout[1]);
		datasetsVO.setPointRadius("3");
		log.info("입사자VO222 " + datasetsVO );
		
		datasetList.add(datasetsVO);
		
		chartVO.setDatasets(datasetList);
		
		return chartVO;
	}
	
	//지원자 수
	@ResponseBody
	@GetMapping("/employmentApplicant")
	public ChartVO employmentApplicant() {
		ChartVO chartVO = new ChartVO();
		List<DatasetsVO> datasetList = new ArrayList<DatasetsVO>(); //차트 마지막 넣는곳
		DatasetsVO datasetsVO = new DatasetsVO();
		DatasetsVO datasetsVO2 = new DatasetsVO();
		DatasetsVO datasetsVO3 = new DatasetsVO();
		List<Object> data = new ArrayList<>();
		List<Object> data2 = new ArrayList<>();
		List<Object> data3 = new ArrayList<>();
		
		List<String> labels = new ArrayList<String>();
		labels.add("1분기");
		labels.add("2분기");
		labels.add("3분기");
		labels.add("4분기");
		chartVO.setLabels(labels);

		List<EmpmnStatsVO> empmnStatsVOList = statisticsService.employment();
		for(int i=0; i<empmnStatsVOList.size(); i++) {
			data.add(empmnStatsVOList.get(i).getEmpmnApplp());
			data2.add(empmnStatsVOList.get(i).getEmpmnApplpNew());
			data3.add(empmnStatsVOList.get(i).getEmpmnApplpOld());
		}
		
		
		
		datasetsVO.setData(data);
		datasetsVO2.setData(data2);
		datasetsVO3.setData(data3);
		
		datasetsVO.setLabel("지원자 수");
		datasetsVO2.setLabel("신입 지원자수");
		datasetsVO3.setLabel("경력 지원자수");
		
		
		datasetsVO.setType("line");
		datasetsVO2.setType("bar");
		datasetsVO3.setType("bar");
		

		
		datasetsVO.setBackgroundColor (inout[0]);
		datasetsVO2.setBackgroundColor(inout[1]);
		datasetsVO3.setBackgroundColor(inout[2]);
		
		datasetsVO.setBorderColor (inout[0]);
		datasetsVO2.setBorderColor(inout[1]);
		datasetsVO3.setBorderColor(inout[2]);
		
		datasetsVO.setPointColor(inout[0]);
		datasetsVO.setPointRadius("3");
		
		datasetsVO2.setPointColor(inout[1]);
		datasetsVO2.setPointRadius("3");
		
		datasetsVO3.setPointColor(inout[2]);
		datasetsVO3.setPointRadius("3");
		
		
		datasetList.add(datasetsVO);
		datasetList.add(datasetsVO2);
		datasetList.add(datasetsVO3);
		
		chartVO.setDatasets(datasetList);
		
		return chartVO;
	}
	
	//입사지원자 평균 희망연봉
	@ResponseBody
	@GetMapping("/avgHansl")
	public ChartVO avgHansl(){
		ChartVO chartVO = new ChartVO();
		List<DatasetsVO> datasetList = new ArrayList<DatasetsVO>(); //차트 마지막 넣는곳
		DatasetsVO datasetsVO = new DatasetsVO();
		DatasetsVO datasetsVO2 = new DatasetsVO();
		List<Object> data = new ArrayList<>();
		List<Object> data2 = new ArrayList<>();
		
		List<String> labels = new ArrayList<String>();
		labels.add("1분기");
		labels.add("2분기");
		labels.add("3분기");
		labels.add("4분기");
		chartVO.setLabels(labels);
		

		List<EmpmnStatsVO> empmnStatsVOList = statisticsService.employment();
		for(int i=0; i<empmnStatsVOList.size(); i++) {
			data.add(empmnStatsVOList.get(i).getEmpmnHanslNew());
			data2.add(empmnStatsVOList.get(i).getEmpmnHanslOld());
		}
		
		datasetsVO.setData(data);
		datasetsVO2.setData(data2);
		
		datasetsVO.setLabel("신입 희망 연봉");
		datasetsVO2.setLabel("경력 희망 연봉");
		
		datasetsVO.setBackgroundColor(salayColor[0]);
		datasetsVO2.setBackgroundColor(salayColor[1]);
		datasetsVO.setBorderColor(salayColor[0]);
		datasetsVO2.setBorderColor(salayColor[1]);
		
		datasetList.add(datasetsVO);
		datasetList.add(datasetsVO2);
		
		chartVO.setDatasets(datasetList);
		
		return chartVO;
	}
	
	//입사자들 최종학력
	@ResponseBody
	@GetMapping("/empmnLacd")
	public ChartVO empmnLacd() {
	    ChartVO chartVO = new ChartVO();
	    List<DatasetsVO> datasetList = new ArrayList<>();
	    List<String> labels = new ArrayList<>();
	    labels.add("1분기");
	    labels.add("2분기");
	    labels.add("3분기");
	    labels.add("4분기");
	    chartVO.setLabels(labels);
	    
	    String color = null;
	    
	    List<EmpmnStatsVO> empmnStatsVOList = statisticsService.employment();
	    String[] Labels = {"고등학교", "대학교", "대학원", "석/박사"};
	    
	    for (int i = 0; i < Labels.length; i++) {
	        DatasetsVO datasetsVO = new DatasetsVO();
	        datasetsVO.setLabel(Labels[i]);
	        List<Object> data = new ArrayList<>();
	        
	        for (EmpmnStatsVO statsVO : empmnStatsVOList) {
	        	color = colors[i];
	            switch (i) {
	                case 0:
	                    data.add(statsVO.getEmpmnLacdH());
	                    break;
	                case 1:
	                    data.add(statsVO.getEmpmnLacdU());
	                    break;
	                case 2:
	                    data.add(statsVO.getEmpmnLacdG());
	                    break;
	                case 3:
	                    data.add(statsVO.getEmpmnLacdD());
	                    break;
	            }
	        }
	        
	        datasetsVO.setData(data);
	        datasetsVO.setBackgroundColor(color);
	        datasetsVO.setBorderColor(color);
	        datasetList.add(datasetsVO);
	    }
	    
	    chartVO.setDatasets(datasetList);
	    
	    return chartVO;
	}
	
	//부서별 평균 연봉
	/*
	 * @ResponseBody
	 * 
	 * @GetMapping("/deptavgHansl") public ChartVO deptavgHansl() { ChartVO chartVO
	 * = new ChartVO(); List<DatasetsVO> datasetList = new ArrayList<>();
	 * List<String> labels = new ArrayList<>(); labels.add("2020년");
	 * labels.add("2021년"); labels.add("2022년"); labels.add("2023년");
	 * chartVO.setLabels(labels);
	 * 
	 * List<EmpStatsVO> empmnStatsVOList = statisticsService.deptavgHansl();
	 * 
	 * String[] labels2 = {"개발본부", "기술본부", "영업본부", "관리본부"}; String[] colors =
	 * {"red", "blue", "green", "yellow"};
	 * 
	 * for (int i = 0; i < labels2.length; i++) { DatasetsVO datasetsVO = new
	 * DatasetsVO(); List<Object> data = new ArrayList<>();
	 * 
	 * for (EmpStatsVO empStatsVO : empmnStatsVOList) { switch (i) { case 0:
	 * data.add(empStatsVO.getDeptHansl1()); break; case 1:
	 * data.add(empStatsVO.getDeptHansl2()); break; case 2:
	 * data.add(empStatsVO.getDeptHansl3()); break; case 3:
	 * data.add(empStatsVO.getDeptHansl4()); break; } }
	 * 
	 * datasetsVO.setData(data); datasetsVO.setLabel(labels2 [i]);
	 * datasetsVO.setBackgroundColor(colors[i]);
	 * datasetsVO.setBorderColor(colors[i]);
	 * 
	 * datasetList.add(datasetsVO); }
	 * 
	 * chartVO.setDatasets(datasetList);
	 * 
	 * return chartVO; }
	 */
	
	@ResponseBody
	@GetMapping("/cost")
	public ChartVO cost() {
		ChartVO chartVO = new ChartVO();
	    List<DatasetsVO> datasetList = new ArrayList<>();
	    List<String> labels = new ArrayList<>();
	    labels.add("1분기");
	    labels.add("2분기");
	    labels.add("3분기");
	    labels.add("4분기");
	    chartVO.setLabels(labels);
	    
	    String color  = null;
	   
	    List<CostStatsVO> costVOList = statisticsService.cost();
	    String[] labels2 = {"출장비", "식비" , "개인경비" , "비품비"};
	    
	    for(int i=0; i<costVOList.size(); i++) {
	        DatasetsVO datasetsVO = new DatasetsVO();
	        List<Object> data = new ArrayList<>();
	        
	        for(CostStatsVO costVO : costVOList) {
	        	color = useMoeny[i];
	        	switch (i) {
	        	
				case 0:
					data.add(costVO.getCostBsrp()/10000);
					break;
				case 1:
					data.add(costVO.getCostFe()/10000);
					break;
				case 2:
					data.add(costVO.getCostPe()/10000);
					break;
				case 3:
					data.add(costVO.getCostFxte()/10000);
					break;
				}
	        }
	        
	        
	        
	        datasetsVO.setData(data);
			datasetsVO.setLabel(labels2[i]);
	        datasetsVO.setBackgroundColor(color);
	        datasetsVO.setBorderColor(color);

	        datasetList.add(datasetsVO);
	    }

	    chartVO.setDatasets(datasetList);
	    log.info("######" + chartVO);
		
		return chartVO;
	}
	
	///////////////분기별 끝///////////////////
	
	
	//////////////////////////연도별 ////////////////////////////////////////////
	
	@ResponseBody
	@GetMapping("/yearMF")
	public ChartVO yearMF() {
		ChartVO chartVO = new ChartVO();
		List<DatasetsVO> datasetList = new ArrayList<DatasetsVO>();
	    List<String> labels = new ArrayList<>();
	    labels.add("2020년");
	    labels.add("2021년");
	    labels.add("2022년");
	    labels.add("2023년");
	    chartVO.setLabels(labels);
		
		
		List<EmpStatsVO> empStatsVOList = statisticsService.yearMF();
		String[] labels2 = {"총 인원수 ", "남성", "여성"};
		String color = null;
		String[] type= {"line", "bar", "bar"};
 		
		for(int i=0; i<empStatsVOList.size(); i++) {
	        DatasetsVO datasetsVO = new DatasetsVO();
	        List<Object> data = new ArrayList<>();
	        
	        for(EmpStatsVO vo : empStatsVOList) {
	        	color = mfColor[i];
	        	switch (i) {
				case 0:
					data.add(vo.getEmpPer());
					datasetsVO.setLabel(labels2[i]);
			        datasetsVO.setBackgroundColor(color);
			        datasetsVO.setBorderColor(color);
			        datasetsVO.setPointColor(color);
			        datasetsVO.setPointRadius("3");
			        datasetsVO.setType(type[i]);
					break;
				case 1:
					data.add(vo.getEmpMper());
					datasetsVO.setLabel(labels2[i]);
			        datasetsVO.setBackgroundColor(color);
			        datasetsVO.setBorderColor(color);
			        datasetsVO.setPointColor(color);
			        datasetsVO.setPointRadius("3");
			        datasetsVO.setType(type[i]);
					break;
				case 2:
					data.add(vo.getEmpFper());
					datasetsVO.setLabel(labels2[i]);
			        datasetsVO.setBackgroundColor(color);
			        datasetsVO.setBorderColor(color);
			        datasetsVO.setPointColor(color);
			        datasetsVO.setPointRadius("3");
			        datasetsVO.setType(type[i]);
					break;
				}
	        }

	        datasetsVO.setData(data);

	        datasetList.add(datasetsVO);
		}
		chartVO.setDatasets(datasetList);
		
		return chartVO;
	}
	
	
	
	//직급별 근무시간
	@ResponseBody
	@GetMapping("/yeartltime")
	public ChartVO yeartltime() {
		ChartVO chartVO = new ChartVO(); // 차트
		List<DatasetsVO> datasetList = new ArrayList<DatasetsVO>(); //차트 마지막 넣는곳
		 //차트 분기 마다 값
		
		List<String> labels = new ArrayList<String>();
	    labels.add("2020년");
	    labels.add("2021년");
	    labels.add("2022년");
	    labels.add("2023년");
		chartVO.setLabels(labels);
		
		
		String ptnCode = null;
		String colorr = null;
		
		String[] ptnCodes= {"A0101","A0102","A0103","A0104","A0105","A0106"};
		
		for(int i=0; i<ptnCodes.length; i++) {
			
			DatasetsVO datasetsVO = new DatasetsVO();
			List<EmpStatsVO> empStatsVO = null;
			List<Object> data = new ArrayList<>();
			
			ptnCode = ptnCodes[i];
			colorr = ptncolors[i];
			datasetsVO.setBackgroundColor(colorr);
			datasetsVO.setBorderColor(colorr);
			log.info("사원 잘찍혀" + ptnCode);
			log.info("첫 데이터" +datasetsVO);
			
			empStatsVO = statisticsService.yeartltime(ptnCode); // 뭐리  분기 사원 평균시간 구해오는거
			datasetsVO.setLabel(empStatsVO.get(0).getPtnCode());
//			datasetsVO.setLabel(ptnCode); // 위에꺼 풀어줘야함 데이터 다 넣고
			
			log.info("쳌쳌" + empStatsVO);
			log.info("사이즈 체크 " + empStatsVO.size());
				for(int a=0; a<empStatsVO.size(); a++) {
					data.add(String.format("%.1f", empStatsVO.get(a).getAvrgWorkHr()));
				}

			datasetsVO.setData(data);
			log.info("들어간 데이터" + datasetsVO);
			
			
			
			datasetList.add(datasetsVO);
			log.info("데이터 리스트" + datasetList);
			log.info("차트 리스트" + chartVO);
			
			
		}	
		chartVO.setDatasets(datasetList);
		
		
		log.info("차트 데이터 결과본" + chartVO);
		
		return chartVO;
	}
	
	
	//평근 출 퇴근 시간
	@ResponseBody
	@GetMapping("/yearstime")
	public ChartVO yearstime() {
		ChartVO chartVO = new ChartVO(); // 차트
		List<DatasetsVO> datasetList = new ArrayList<DatasetsVO>(); //차트 마지막 넣는곳
		
		List<String> labels = new ArrayList<String>();
		labels.add("월");
		labels.add("화");
		labels.add("수");
		labels.add("목");
		labels.add("금");
		labels.add("토");
		labels.add("일");
		chartVO.setLabels(labels);
		
		String year = null;
		String color = null;
		
		
		String[] years = {"2020", "2021", "2022", "2023"};
		
		for(int i=0; i<years.length; i++) {
			color = quterColor[i];
			DatasetsVO datasetsVO = new DatasetsVO();
			List<EmpStatsVO> empStatsVO = null;
			List<Object> data = new ArrayList<>();
			
			year = years[i];
			color = quterColor[i];
			
			datasetsVO.setBorderColor(color);
			datasetsVO.setBackgroundColor(color);
			datasetsVO.setPointColor(color);
			datasetsVO.setPointRadius("3");
			
			empStatsVO = statisticsService.yearsetime(year);
			datasetsVO.setLabel(year+"년");
			
			for(int a=0; a<empStatsVO.size(); a++) {
				data.add(String.format("%.1f", empStatsVO.get(a).getAvrgAttendTime()));
			}
			datasetsVO.setData(data);
			log.info("들어간 데이터" + datasetsVO);
			
			datasetList.add(datasetsVO);
			log.info("데이터 리스트" + datasetList);
			log.info("차트 리스트" + chartVO);
			
		}	
		chartVO.setDatasets(datasetList);
		
		
		log.info("차트 데이터 결과본" + chartVO);
		
		return chartVO;
	}
	//평근 퇴근 시간
	@ResponseBody
	@GetMapping("/yearetime")
	public ChartVO yearetime() {
		ChartVO chartVO = new ChartVO(); // 차트
		List<DatasetsVO> datasetList = new ArrayList<DatasetsVO>(); //차트 마지막 넣는곳
		
		List<String> labels = new ArrayList<String>();
		labels.add("월");
		labels.add("화");
		labels.add("수");
		labels.add("목");
		labels.add("금");
		labels.add("토");
		labels.add("일");
		chartVO.setLabels(labels);
		
		String year = null;
		String color = null;
		
		
		String[] years = {"2020", "2021", "2022", "2023"};
		
		for(int i=0; i<years.length; i++) {
			
			DatasetsVO datasetsVO = new DatasetsVO();
			List<EmpStatsVO> empStatsVO = null;
			List<Object> data = new ArrayList<>();
			
			year = years[i];
			color = quterColor[i];
			
			datasetsVO.setBorderColor(color);
			datasetsVO.setBackgroundColor(color);
			datasetsVO.setPointColor(color);
			datasetsVO.setPointRadius("3");
			
			empStatsVO = statisticsService.yearsetime(year);
			datasetsVO.setLabel(year+"년");
			
			for(int a=0; a<empStatsVO.size(); a++) {
				data.add(String.format("%.1f", empStatsVO.get(a).getAvrgLvffcTime()));
			}
			datasetsVO.setData(data);
			log.info("들어간 데이터" + datasetsVO);
			
			
			
			datasetList.add(datasetsVO);
			log.info("데이터 리스트" + datasetList);
			log.info("차트 리스트" + chartVO);
			
			
		}	
		chartVO.setDatasets(datasetList);
		
		
		log.info("차트 데이터 결과본" + chartVO);
		
		return chartVO;
	}
	
	@ResponseBody
	@GetMapping("/yearcost")
	public ChartVO yearcost() {
		ChartVO chartVO = new ChartVO();
	    List<DatasetsVO> datasetList = new ArrayList<>();
	    List<String> labels = new ArrayList<>();
	    labels.add("2020년");
	    labels.add("2021년");
	    labels.add("2022년");
	    labels.add("2023년");
	    chartVO.setLabels(labels);
	    
	    
	    String[] labels2 = {"출장비", "식비" , "개인경비" , "비품비"};
	    
	    for(int i=0; i<labels2.length; i++) {
	    	List<CostStatsVO> costVOList = statisticsService.yearcost(labels.get(i).split("년")[0]);
	        DatasetsVO datasetsVO = new DatasetsVO();
	        List<Object> data = new ArrayList<>();
	        
	        for(CostStatsVO costVO : costVOList) {
	        	
	        	switch (i) {
				case 0:
					data.add(costVO.getCostBsrp()/10000);
					break;
				case 1:
					data.add(costVO.getCostFe()/10000);
					break;
				case 2:
					data.add(costVO.getCostPe()/10000);
					break;
				case 3:
					data.add(costVO.getCostFxte()/10000);
					break;
				}
	        }
	        
	        
	        
	        datasetsVO.setData(data);
			datasetsVO.setLabel(labels2[i]);
	        datasetsVO.setBackgroundColor(useMoeny[i]);
	        datasetsVO.setBorderColor(useMoeny[i]);

	        datasetList.add(datasetsVO);
	    }

	    chartVO.setDatasets(datasetList);
	    log.info("######" + chartVO);
		
		return chartVO;
	}	
	
	
	
	
	
	
	
	
	
	
	
	// 년도별 입사자 수 --emp에서 가져옴
	@ResponseBody
	@GetMapping("/yearinpeople")
	public ChartVO yearentDate() {
		ChartVO chartVO = new ChartVO();
		List<DatasetsVO> datasetList = new ArrayList<DatasetsVO>(); //차트 마지막 넣는곳
		DatasetsVO datasetsVO = new DatasetsVO();
		List<Object> data = new ArrayList<>();
		
		List<String> labels = new ArrayList<String>();
	    labels.add("2020년");
	    labels.add("2021년");
	    labels.add("2022년");
	    labels.add("2023년");
		chartVO.setLabels(labels);
		
//		List<EmpStatsVO>empStatsVOList = statisticsService.incount(); 
		List<EmpmnStatsVO> empmnStatsVOList = statisticsService.yearemployment();
		for(int i=0; i<empmnStatsVOList.size(); i++) {
			data.add(empmnStatsVOList.get(i).getEmpmnEcnyp());
		}
		datasetsVO.setLabel("입사자수");
		datasetsVO.setData(data);
		datasetsVO.setBackgroundColor(inout[0]);
		datasetsVO.setBorderColor(inout[0]);
		datasetsVO.setPointColor(inout[0]);
		datasetsVO.setPointRadius("3");
		log.info("입사자VO " + datasetsVO );
		
		datasetList.add(datasetsVO);
		
		chartVO.setDatasets(datasetList);
		
		return chartVO;
	}
	
	// 년도별별 퇴사자자 수 --emp에서 가져옴
	@ResponseBody
	@GetMapping("/yearoutpeople")
	public ChartVO yearoutDate() {
		ChartVO chartVO = new ChartVO();
		List<DatasetsVO> datasetList = new ArrayList<DatasetsVO>(); //차트 마지막 넣는곳
		DatasetsVO datasetsVO = new DatasetsVO();
		List<Object> data = new ArrayList<>();
		
		List<String> labels = new ArrayList<String>();
	    labels.add("2020년");
	    labels.add("2021년");
	    labels.add("2022년");
	    labels.add("2023년");
		chartVO.setLabels(labels);
		
//		List<EmpStatsVO>empStatsVOList = statisticsService.outcount(); 
		List<EmpmnStatsVO> empmnStatsVOList = statisticsService.yearemployment();
		for(int i=0; i<empmnStatsVOList.size(); i++) {
			data.add(empmnStatsVOList.get(i).getEmpmnRetp());
		}
		datasetsVO.setLabel("퇴사자 수");
		datasetsVO.setData(data);
		datasetsVO.setBackgroundColor(inout[1]);
		datasetsVO.setBorderColor(inout[1]);
		datasetsVO.setPointColor(inout[1]);
		datasetsVO.setPointRadius("3");
		log.info("입사자VO222 " + datasetsVO );
		
		datasetList.add(datasetsVO);
		
		chartVO.setDatasets(datasetList);
		
		return chartVO;
	}
	
	//지원자 수
	@ResponseBody
	@GetMapping("/yearemploymentApplicant")
	public ChartVO yearemploymentApplicant() {
		ChartVO chartVO = new ChartVO();
		List<DatasetsVO> datasetList = new ArrayList<DatasetsVO>(); //차트 마지막 넣는곳
		DatasetsVO datasetsVO = new DatasetsVO();
		DatasetsVO datasetsVO2 = new DatasetsVO();
		DatasetsVO datasetsVO3 = new DatasetsVO();
		List<Object> data = new ArrayList<>();
		List<Object> data2 = new ArrayList<>();
		List<Object> data3 = new ArrayList<>();
		
		List<String> labels = new ArrayList<String>();
	    labels.add("2020년");
	    labels.add("2021년");
	    labels.add("2022년");
	    labels.add("2023년");
		chartVO.setLabels(labels);

		List<EmpmnStatsVO> empmnStatsVOList = statisticsService.yearemployment();
		for(int i=0; i<empmnStatsVOList.size(); i++) {
			data.add(empmnStatsVOList.get(i).getEmpmnApplp());
			data2.add(empmnStatsVOList.get(i).getEmpmnApplpNew());
			data3.add(empmnStatsVOList.get(i).getEmpmnApplpOld());
		}
		
		
		
		datasetsVO.setData(data);
		datasetsVO2.setData(data2);
		datasetsVO3.setData(data3);
		
		datasetsVO.setLabel("지원자 수");
		datasetsVO2.setLabel("신입 지원자수");
		datasetsVO3.setLabel("경력 지원자수");
		
		
		datasetsVO.setType("line");
		datasetsVO2.setType("bar");
		datasetsVO3.setType("bar");
		
		datasetsVO.setBackgroundColor (inout[0]);
		datasetsVO2.setBackgroundColor(inout[1]);
		datasetsVO3.setBackgroundColor(inout[2]);
		
		datasetsVO.setBorderColor (inout[0]);
		datasetsVO2.setBorderColor(inout[1]);
		datasetsVO3.setBorderColor(inout[2]);
		
		datasetsVO.setPointColor(inout[0]);
		datasetsVO.setPointRadius("3");
		
		datasetsVO2.setPointColor(inout[1]);
		datasetsVO2.setPointRadius("3");
		
		datasetsVO3.setPointColor(inout[2]);
		datasetsVO3.setPointRadius("3");
		
		
		datasetList.add(datasetsVO);
		datasetList.add(datasetsVO2);
		datasetList.add(datasetsVO3);
		
		chartVO.setDatasets(datasetList);
		
		return chartVO;
	}
	
	//입사지원자 평균 희망연봉
	@ResponseBody
	@GetMapping("/yearavgHansl")
	public ChartVO yearavgHansl(){
		ChartVO chartVO = new ChartVO();
		List<DatasetsVO> datasetList = new ArrayList<DatasetsVO>(); //차트 마지막 넣는곳
		DatasetsVO datasetsVO = new DatasetsVO();
		DatasetsVO datasetsVO2 = new DatasetsVO();
		List<Object> data = new ArrayList<>();
		List<Object> data2 = new ArrayList<>();
		
		List<String> labels = new ArrayList<String>();
	    labels.add("2020년");
	    labels.add("2021년");
	    labels.add("2022년");
	    labels.add("2023년");
		chartVO.setLabels(labels);
		

		List<EmpmnStatsVO> empmnStatsVOList = statisticsService.yearemployment();
		for(int i=0; i<empmnStatsVOList.size(); i++) {
			data.add(empmnStatsVOList.get(i).getEmpmnHanslNew());
			data2.add(empmnStatsVOList.get(i).getEmpmnHanslOld());
		}
		
		datasetsVO.setData(data);
		datasetsVO2.setData(data2);
		
		datasetsVO.setLabel("신입 희망 연봉");
		datasetsVO2.setLabel("경력 희망 연봉");
		
		datasetsVO.setBackgroundColor(salayColor[0]);
		datasetsVO2.setBackgroundColor(salayColor[1]);
		datasetsVO.setBorderColor(salayColor[0]);
		datasetsVO2.setBorderColor(salayColor[1]);
		
		datasetList.add(datasetsVO);
		datasetList.add(datasetsVO2);
		
		chartVO.setDatasets(datasetList);
		
		return chartVO;
	}
	
	//입사자들 최종학력
	@ResponseBody
	@GetMapping("/yearempmnLacd")
	public ChartVO yearempmnLacd() {
	    ChartVO chartVO = new ChartVO();
	    List<DatasetsVO> datasetList = new ArrayList<>();
	    List<String> labels = new ArrayList<>();
	    labels.add("2020년");
	    labels.add("2021년");
	    labels.add("2022년");
	    labels.add("2023년");
	    chartVO.setLabels(labels);
	    
	    List<EmpmnStatsVO> empmnStatsVOList = statisticsService.yearemployment();
	    
	    String[] Labels = {"고등학교", "대학교", "대학원", "석/박사"};
	    
	    for (int i = 0; i < Labels.length; i++) {
	        DatasetsVO datasetsVO = new DatasetsVO();
	        datasetsVO.setLabel(Labels[i]);
	        List<Object> data = new ArrayList<>();
	        
	        for (EmpmnStatsVO statsVO : empmnStatsVOList) {
	            switch (i) {
	                case 0:
	                    data.add(statsVO.getEmpmnLacdH());
	                    break;
	                case 1:
	                    data.add(statsVO.getEmpmnLacdU());
	                    break;
	                case 2:
	                    data.add(statsVO.getEmpmnLacdG());
	                    break;
	                case 3:
	                    data.add(statsVO.getEmpmnLacdD());
	                    break;
	            }
	        }
	        
	        datasetsVO.setData(data);
	        datasetsVO.setBackgroundColor(colors[i]);
	        datasetsVO.setBorderColor(colors[i]);
	        datasetList.add(datasetsVO);
	    }
	    
	    chartVO.setDatasets(datasetList);
	    
	    return chartVO;
	}
	
	
	//////////////연도별 끝///////////////////
	
	@ResponseBody
	@GetMapping("/employeeAjax")
	public ChartVO employeeAjax() {
		ChartVO chartVO = new ChartVO();
		List<DatasetsVO> datasets = new ArrayList<DatasetsVO>();
		DatasetsVO vo = new DatasetsVO();
		DatasetsVO vo2 = new DatasetsVO();
		
//		int[]data = {10,20,30,40,50,60,70,80,90};
		
//		vo2.setData(data);
		
		datasets.add(vo);
		datasets.add(vo2);
		
		
		chartVO.setDatasets(datasets);		
		
		log.info("chartVO : " + chartVO);
		
		return chartVO;
	}
	
	@GetMapping("/employee2")
	public String employee2() {
		
		return "statistics/employee2";
	}
	
	@GetMapping("/expense")
	public String expense() {
		return "statistics/expense";
	}
	
}
