package kr.or.ddit.setting.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.common.vo.EmpVO;
import kr.or.ddit.common.vo.FileInfoVO;
import kr.or.ddit.setting.mapper.CompWorkMapper;
import kr.or.ddit.setting.service.CompWorkService;
import kr.or.ddit.vo.WorkVO;

@Service
public class CompWorkServiceImpl implements CompWorkService {
	
	@Autowired
	CompWorkMapper compWorkMapper;
	
	@Override
	public List<WorkVO> workList() {
		return compWorkMapper.workList();
	}

	@Override
	public List<FileInfoVO> selectFileList() {
		return compWorkMapper.selectFileList();
	}

	@Override
	public int workAdd(WorkVO workVO) {
		return compWorkMapper.workAdd(workVO);
	}

	@Override
	public WorkVO getWork(int wkNo) {
		return compWorkMapper.getWork(wkNo);
	}

	@Override
	public int workUp(WorkVO workVO) {
		return compWorkMapper.workUp(workVO);
	}

	@Override
	public int workDel(int wkNo) {
		return compWorkMapper.workDel(wkNo);
	}

	@Override
	public String selectWokrAp() {
		return compWorkMapper.selectWokrAp();
	}

	@Override
	public EmpVO selectWorkApEmp(String empNo) {
		return compWorkMapper.selectWorkApEmp(empNo);
	}

	@Override
	public int workApUp(String empNo) {
		return compWorkMapper.workApUp(empNo);
	}

	
}
