package kr.or.ddit.setting.controller;

import java.io.File;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.setting.service.CompanyInfoService;
import kr.or.ddit.setting.vo.CompanyInfoVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/setting")
public class CompanyInfoController {
	
	@Autowired
	private CompanyInfoService companyInfoSVC;
	
	@ResponseBody
	@PostMapping(value = "/companyinfo/update", produces = "application/json;charset=utf-8")
	public String putCompanyInfo(@RequestBody CompanyInfoVO companyInfoVO) throws Exception {
		
		log.debug("companyInfoVO: {}",companyInfoVO);
		return Integer.toString(companyInfoSVC.updateData(companyInfoVO));
	}
	
	@ResponseBody
	@PostMapping("/getLogo")
	public String getLogo() {
		String logoSvfiName = companyInfoSVC.getLogo();
		log.info("logoSvfiName::" + logoSvfiName);
		
		return logoSvfiName;
	}
	
}
