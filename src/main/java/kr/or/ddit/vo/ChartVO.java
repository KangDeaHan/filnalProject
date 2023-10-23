package kr.or.ddit.vo;

import java.util.List;

import lombok.Data;

@Data
public class ChartVO {
	
	
	private List<String> labels;
	private List<DatasetsVO> datasets;
}
