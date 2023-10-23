package kr.or.ddit.setting.mapper;

import java.util.List;

import kr.or.ddit.common.vo.EmpVO;
import kr.or.ddit.common.vo.FileInfoVO;
import kr.or.ddit.vo.WorkVO;

public interface CompWorkMapper {

	List<WorkVO> workList();

	List<FileInfoVO> selectFileList();

	int workAdd(WorkVO workVO);

	WorkVO getWork(int wkNo);

	int workUp(WorkVO workVO);

	int workDel(int wkNo);

	String selectWokrAp();

	EmpVO selectWorkApEmp(String empNo);

	int workApUp(String empNo);

}
