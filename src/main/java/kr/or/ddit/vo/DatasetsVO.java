	package kr.or.ddit.vo;

import java.util.Arrays;
import java.util.List;

import lombok.Data;

@Data
public class DatasetsVO {
	private String label = "Visitors";
    private String barThickness = "10";
    private String backgroundColor;
    private String borderColor;
    private String pointRadius = "3";
    private String pointColor;
    private String pointStrokeColor = "rgba(60,141,188,1)";
    private String pointHighlightFill = "#fff";
    private String pointHighlightStroke = "rgba(60,141,188,1)";
//    private int[] data = {11, 48, 40, 19, 64, 27, 90, 85, 92};
    private List<Object> data = Arrays.asList(10, 20, 30);
    private String fill = "";
    private String lineTension = ".1";
    private String type;
//    private String maintainAspectRatio; //pie 추가
//    private String responsive;	//pie 추가
}
