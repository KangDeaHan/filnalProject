package kr.or.ddit.salary.controller;

import java.util.List;
import java.util.Map;

import org.apache.commons.collections4.map.HashedMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.common.vo.EmpVO;
import kr.or.ddit.salary.service.SujiService;
import kr.or.ddit.salary.vo.SujiVO;
import lombok.Getter;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/suji")
public class SujiController {
	
	@Autowired
	private SujiService sujiService;
	
	@GetMapping("/start")
	public String getStart() {
		return "start2";
	}
	
	
	@ResponseBody
	@PostMapping("/ajaxSuji")
	public Map<String,Object> getData(@RequestBody SujiVO sujiVO) {
		log.debug("sujiVO {}",sujiVO); // log안에 {}를 찍으면 ,찍으면 객체로 나옴.
		
		int total = sujiService.getTotal();
		
		int sIndex = (sujiVO.getCurPage() -1)*sujiVO.getPageSize() +1;
		int eIndex = sujiVO.getCurPage()*sujiVO.getPageSize();
		sujiVO.setSIndex(sIndex);
		sujiVO.setEIndex(eIndex);
		
		List<EmpVO> empList= sujiService.getEmpOnePage(sujiVO);
		
		Map<String,Object> pageMap = new HashedMap<String, Object>();
		pageMap.put("total", total);
		pageMap.put("pageData", empList);
		
		
		log.debug("pageMap {}",pageMap);
		
		/* 
		    토탈갯수 : select
		  pageSize: 받아와야하는 값 
		  curPage:  받아와야 함
		  페이지수 : 계산가능 
		  
		*/
		
		return pageMap;
	}
	
	

}
