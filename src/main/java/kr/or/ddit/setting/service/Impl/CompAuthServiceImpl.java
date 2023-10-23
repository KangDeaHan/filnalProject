package kr.or.ddit.setting.service.Impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.common.vo.EmpVO;
import kr.or.ddit.setting.mapper.CompAuthMapper;
import kr.or.ddit.setting.service.CompAuthService;
import kr.or.ddit.vo.AcntAuthorVO;
import kr.or.ddit.vo.AuthMenuVO;
import kr.or.ddit.vo.AuthorAlwncVO;
import kr.or.ddit.vo.MenuVO;

@Service
public class CompAuthServiceImpl implements CompAuthService {
	
	@Autowired
	CompAuthMapper compAuthMapper;

	@Override
	public List<AcntAuthorVO> getAuthList1() {
		return compAuthMapper.getAuthList1();
	}

	@Override
	public List<AcntAuthorVO> getAuthList2() {
		return compAuthMapper.getAuthList2();
	}

	@Override
	public List<MenuVO> getMenuList1() {
		return compAuthMapper.getMenuList1();
	}

	@Override
	public List<MenuVO> getMenuList2() {
		return compAuthMapper.getMenuList2();
	}

	@Override
	public int authAdd(AcntAuthorVO acntAuthorVO) {
		return compAuthMapper.authAdd(acntAuthorVO);
	}

	@Override
	public int authMenuAdd1(AcntAuthorVO menuNo1) {
		return compAuthMapper.authMenuAdd1(menuNo1);
	}

	@Override
	public int authMenuAdd2(AcntAuthorVO menuNo2) {
		return compAuthMapper.authMenuAdd2(menuNo2);
	}

	@Override
	public AcntAuthorVO getAuthInfo(int authrtSn) {
		return compAuthMapper.getAuthInfo(authrtSn);
	}

	@Override
	public List<AuthMenuVO> getAuthMenu(String authrtId) {
		return compAuthMapper.getAuthMenu(authrtId);
	}

	@Override
	public int authUp(AcntAuthorVO acntAuthorVO) {
		return compAuthMapper.authUp(acntAuthorVO);
	}

	@Override
	public int authMenuUp1(Map<String, String> map1) {
		return compAuthMapper.authMenuUp1(map1);
	}

	@Override
	public int authMenuUp2(Map<String, String> map2) {
		return compAuthMapper.authMenuUp2(map2);
	}

	@Override
	public int authEmpAdd(Map<String, String> map) {
		return compAuthMapper.authEmpAdd(map);
	}

	@Override
	public int getAuthEmp(Map<String, String> map) {
		return compAuthMapper.getAuthEmp(map);
	}

	@Override
	public List<EmpVO> getAuthEmpList(String authrtId) {
		return compAuthMapper.getAuthEmpList(authrtId);
	}

	@Override
	public EmpVO getAddEmp(String empNo) {
		return compAuthMapper.getAddEmp(empNo);
	}

	@Override
	public int authEmpDel(List<String> list) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("empNo", list.get(0));
		map.put("authrtId", list.get(1));
		
		return compAuthMapper.authEmpDel(map);
	}

	@Override
	public int authDel(int authrtSn) {
		return compAuthMapper.authDel(authrtSn);
	}

	@Override
	public int getAuthEmpList2(String authrtId) {
		return compAuthMapper.getAuthEmpList2(authrtId);
	}
	

}
