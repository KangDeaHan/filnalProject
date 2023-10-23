package kr.or.ddit.setting.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.CmCodeVO;

public interface CompTreeService {

	public int deptAdd(Map<String, Object> addMap);

	public int deptUp(Map<String, Object> upMap);

	public int deptDel(int id);

	public int checkEmp(int sel);

	public List<CmCodeVO> selectPtn();

	public int checkPtnEmp(String sel);

	public int ptnAdd(CmCodeVO cmCodeVO);

	public int ptnUp(CmCodeVO cmCodeVO);

	public int ptnDel(CmCodeVO cmCodeVO);

	public List<CmCodeVO> selectPosition();

	public int checkPositionEmp(String sel);

	public int positionAdd(CmCodeVO cmCodeVO);

	public int positionUp(CmCodeVO cmCodeVO);

	public int positionDel(CmCodeVO cmCodeVO);

	public List<CmCodeVO> selectJob();

	public int checkJobEmp(String sel);

	public int jobAdd(CmCodeVO cmCodeVO);

	public int jobUp(CmCodeVO cmCodeVO);

	public int jobDel(CmCodeVO cmCodeVO);

	public List<CmCodeVO> selectGrd();

	public int checkGrdEmp(String sel);

	public int grdAdd(CmCodeVO cmCodeVO);

	public int grdUp(CmCodeVO cmCodeVO);

	public int grdDel(CmCodeVO cmCodeVO);
	
}
