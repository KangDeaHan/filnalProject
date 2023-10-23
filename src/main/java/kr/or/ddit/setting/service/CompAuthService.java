package kr.or.ddit.setting.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.common.vo.EmpVO;
import kr.or.ddit.vo.AcntAuthorVO;
import kr.or.ddit.vo.AuthMenuVO;
import kr.or.ddit.vo.AuthorAlwncVO;
import kr.or.ddit.vo.MenuVO;

public interface CompAuthService {

	List<AcntAuthorVO> getAuthList1();

	List<AcntAuthorVO> getAuthList2();

	List<MenuVO> getMenuList1();

	List<MenuVO> getMenuList2();

	int authAdd(AcntAuthorVO acntAuthorVO);

	int authMenuAdd1(AcntAuthorVO menuNo1);

	int authMenuAdd2(AcntAuthorVO menuNo2);

	AcntAuthorVO getAuthInfo(int authrtSn);

	List<AuthMenuVO> getAuthMenu(String authrtId);

	int authUp(AcntAuthorVO acntAuthorVO);

	int authMenuUp1(Map<String, String> map1);

	int authMenuUp2(Map<String, String> map2);

	int authEmpAdd(Map<String, String> map);

	int getAuthEmp(Map<String, String> map);

	List<EmpVO> getAuthEmpList(String authrtId);

	EmpVO getAddEmp(String empNo);

	int authEmpDel(List<String> list);

	int authDel(int authrtSn);

	int getAuthEmpList2(String authrtId);



}
