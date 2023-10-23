package kr.or.ddit.setting.service;

import java.util.List;

import kr.or.ddit.common.vo.FileInfoVO;
import kr.or.ddit.vacation.vo.VacTypeVO;

public interface CompVacService {

	List<FileInfoVO> selectFileList();

	int vacTypeAdd(VacTypeVO vacTypeVO);

	VacTypeVO getVacType(int vacTypeNo);

	List<VacTypeVO> vacTypeList();

	int vacTypeUp(VacTypeVO vacTypeVO);

	int vacTypeDel(String vacTypeNo);

}
