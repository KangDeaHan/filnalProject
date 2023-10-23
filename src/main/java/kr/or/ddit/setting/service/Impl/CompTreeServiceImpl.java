package kr.or.ddit.setting.service.Impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.setting.mapper.CompTreeMapper;
import kr.or.ddit.setting.service.CompTreeService;
import kr.or.ddit.vo.CmCodeVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class CompTreeServiceImpl implements CompTreeService {
	
	@Autowired
	CompTreeMapper compTreeMapper;

	@Override
	public int deptAdd(Map<String, Object> addMap) {
		return compTreeMapper.deptAdd(addMap);
	}

	@Override
	public int deptUp(Map<String, Object> upMap) {
		return compTreeMapper.deptUp(upMap);
	}

	@Override
	public int deptDel(int id) {
		return compTreeMapper.deptDel(id);
	}

	@Override
	public int checkEmp(int sel) {
		return compTreeMapper.checkEmp(sel);
	}

	@Override
	public List<CmCodeVO> selectPtn() {
		return compTreeMapper.selectPtn();
	}

	@Override
	public int checkPtnEmp(String sel) {
		return compTreeMapper.checkPtnEmp(sel);
	}

	@Override
	public int ptnAdd(CmCodeVO cmCodeVO) {
		return compTreeMapper.ptnAdd(cmCodeVO);
	}

	@Override
	public int ptnUp(CmCodeVO cmCodeVO) {
		return compTreeMapper.ptnUp(cmCodeVO);
	}

	@Override
	public int ptnDel(CmCodeVO cmCodeVO) {
		return compTreeMapper.ptnDel(cmCodeVO);
	}

	@Override
	public List<CmCodeVO> selectPosition() {
		return compTreeMapper.selectPosition();
	}

	@Override
	public int checkPositionEmp(String sel) {
		return compTreeMapper.checkPositionEmp(sel);
	}

	@Override
	public int positionAdd(CmCodeVO cmCodeVO) {
		return compTreeMapper.positionAdd(cmCodeVO);
	}

	@Override
	public int positionUp(CmCodeVO cmCodeVO) {
		return compTreeMapper.positionUp(cmCodeVO);
	}

	@Override
	public int positionDel(CmCodeVO cmCodeVO) {
		return compTreeMapper.positionDel(cmCodeVO);
	}

	@Override
	public List<CmCodeVO> selectJob() {
		return compTreeMapper.selectJob();
	}

	@Override
	public int checkJobEmp(String sel) {
		return compTreeMapper.checkJobEmp(sel);
	}

	@Override
	public int jobAdd(CmCodeVO cmCodeVO) {
		return compTreeMapper.jobAdd(cmCodeVO);
	}

	@Override
	public int jobUp(CmCodeVO cmCodeVO) {
		return compTreeMapper.jobUp(cmCodeVO);
	}

	@Override
	public int jobDel(CmCodeVO cmCodeVO) {
		return compTreeMapper.jobDel(cmCodeVO);
	}

	@Override
	public List<CmCodeVO> selectGrd() {
		return compTreeMapper.selectGrd();
	}

	@Override
	public int checkGrdEmp(String sel) {
		return compTreeMapper.checkGrdEmp(sel);
	}

	@Override
	public int grdAdd(CmCodeVO cmCodeVO) {
		return compTreeMapper.grdAdd(cmCodeVO);
	}

	@Override
	public int grdUp(CmCodeVO cmCodeVO) {
		return compTreeMapper.grdUp(cmCodeVO);
	}

	@Override
	public int grdDel(CmCodeVO cmCodeVO) {
		return compTreeMapper.grdDel(cmCodeVO);
	}

}
