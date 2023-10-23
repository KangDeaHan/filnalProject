package kr.or.ddit.setting.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.common.vo.EmpVO;
import kr.or.ddit.setting.service.CompAuthService;
import kr.or.ddit.setting.service.CompWorkService;
import kr.or.ddit.vo.AcntAuthorVO;
import kr.or.ddit.vo.AuthMenuVO;
import kr.or.ddit.vo.AuthorAlwncVO;
import kr.or.ddit.vo.WorkVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/setting")
@Controller
public class CompAuthController {

	@Autowired
	CompAuthService compAuthSVC;
	
	@ResponseBody
	@PostMapping("/authAdd")
	public String authAdd(@RequestBody AcntAuthorVO acntAuthorVO) {
		log.info("acntAuthorVO::" + acntAuthorVO);
		
		int addAuth = compAuthSVC.authAdd(acntAuthorVO);
		log.debug("권한 추가 결과::" + addAuth);
		
		int addAuthMenu1 = 0;
		String[] menuNo1List = acntAuthorVO.getMenuNo1();
		for (String menuNo1 : menuNo1List) {
			AcntAuthorVO vo = new AcntAuthorVO();
			vo.setMenuNo(menuNo1);
			addAuthMenu1 += compAuthSVC.authMenuAdd1(vo);
		}
		log.debug("사용 가능 메뉴 개수::" + addAuthMenu1);
		
		int addAuthMenu2 = 0;
		String[] menuNo2List = acntAuthorVO.getMenuNo2();
		for (String menuNo2 : menuNo2List) {
			AcntAuthorVO vo = new AcntAuthorVO();
			vo.setMenuNo(menuNo2);
			addAuthMenu2 += compAuthSVC.authMenuAdd2(vo);
		}
		log.debug("사용 불가능 메뉴 개수::" + addAuthMenu2);
		
		int result = addAuth + addAuthMenu1 + addAuthMenu2;
		
		return Integer.toString(result);
	}
	
	@ResponseBody
	@GetMapping("/getAuthInfo/{authrtSn}")
	public Map<String, Object> getAuthInfo(@PathVariable int authrtSn) {
		log.info("authrtSn::" + authrtSn);
		
		AcntAuthorVO acntAuthorVO = compAuthSVC.getAuthInfo(authrtSn);
		log.info("acntAuthorVO::" + acntAuthorVO);
		
		String authrtId = acntAuthorVO.getAuthrtId();
		List<AuthMenuVO> authMenuVOList = compAuthSVC.getAuthMenu(authrtId);
		log.info("authMenuVO::" + authMenuVOList);
		
		List<EmpVO> authEmpList = compAuthSVC.getAuthEmpList(authrtId);
		
		Map<String, Object> authMap = new HashMap<String, Object>();
		
		authMap.put("acntAuthorVO", acntAuthorVO);
		authMap.put("authMenuVOList", authMenuVOList);
		authMap.put("authEmpList", authEmpList);
		
		log.info("authMap" + authMap);
		
		return authMap;
	}
	
	@ResponseBody
	@PostMapping("/authUp")
	public String authUp(@RequestBody AcntAuthorVO acntAuthorVO) {
		log.info("acntAuthorVO::" + acntAuthorVO);
		
		int updateAuth = compAuthSVC.authUp(acntAuthorVO);
		log.debug("updateAuth::" + updateAuth);
		
		int updateAuthMenu1 = 0;
		String[] menuNo1List = acntAuthorVO.getMenuNo1();
		String authrtId = acntAuthorVO.getAuthrtId();
		Map<String, String> map1 = new HashMap<String, String>();
		
		for (String menuNo1 : menuNo1List) {
			map1.put("menuNo1", menuNo1);
			map1.put("authrtId", authrtId);
			updateAuthMenu1 += compAuthSVC.authMenuUp1(map1);
		}
		log.debug("사용 가능 메뉴 개수::" + updateAuthMenu1);
		
		int updateAuthMenu2 = 0;
		String[] menuNo2List = acntAuthorVO.getMenuNo2();
		Map<String, String> map2 = new HashMap<String, String>();
		for (String menuNo2 : menuNo2List) {
			map2.put("menuNo2", menuNo2);
			map2.put("authrtId", authrtId);
			updateAuthMenu2 += compAuthSVC.authMenuUp2(map2);
		}
		log.debug("사용 불가능 메뉴 개수::" + updateAuthMenu2);
		
		int result = updateAuth + updateAuthMenu1 + updateAuthMenu2;
		
		return Integer.toString(result);
	}
	
	@ResponseBody
	@PostMapping("/authEmpAdd")
	public String authEmpAdd(@RequestBody List<String> dataList) {
		log.debug("dataList::" + dataList);
		
		String authrtId = dataList.get(0);
		String empNo = dataList.get(1);
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("authrtId", authrtId);
		map.put("empNo", empNo);
		
		int getResult = compAuthSVC.getAuthEmp(map);
		
		int result = 0;
		if(getResult == 1) {
			result = 0;
		} else if(getResult == 0) {
			result = compAuthSVC.authEmpAdd(map);
		}
		return Integer.toString(result);
	}
	
	@ResponseBody
	@PostMapping("/getAddEmp")
	public EmpVO getAddEmp(@RequestBody String empNo) {
		log.debug("empNo::" + empNo);
		
		EmpVO empVo = compAuthSVC.getAddEmp(empNo);
		
		return empVo;
	}
	
	@ResponseBody
	@PostMapping("/authEmpDel")
	public String authEmpDel(@RequestBody List<String> list) {
		log.debug("list::" + list);
		
		int delResult = compAuthSVC.authEmpDel(list);
		
		return Integer.toString(delResult);
	}
	
	@ResponseBody
	@PostMapping("/authDel")
	public String authDel(@RequestBody int authrtSn) {
		log.debug("authrtSn::" + authrtSn);
		
		AcntAuthorVO acntAuthorVO = compAuthSVC.getAuthInfo(authrtSn);
		String authrtId = acntAuthorVO.getAuthrtId();
		
		int result = 0;
		int result1 = compAuthSVC.getAuthEmpList2(authrtId);
		
		if(result1 > 0) {
			result = 0;
		} else if(result1 == 0) {
			result = compAuthSVC.authDel(authrtSn);
		}
		
		return Integer.toString(result);
	}
	
}
