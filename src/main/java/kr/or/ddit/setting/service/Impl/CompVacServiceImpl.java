package kr.or.ddit.setting.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.common.vo.FileInfoVO;
import kr.or.ddit.setting.mapper.CompVacMapper;
import kr.or.ddit.setting.service.CompVacService;
import kr.or.ddit.vacation.vo.VacTypeVO;

@Service
public class CompVacServiceImpl implements CompVacService {

	@Autowired
	CompVacMapper compVacMapper;
	
	@Override
	public List<FileInfoVO> selectFileList() {
		return compVacMapper.selectFileList();
	}

	@Override
	public int vacTypeAdd(VacTypeVO vacTypeVO) {
		return compVacMapper.vacTypeAdd(vacTypeVO);
	}

	@Override
	public VacTypeVO getVacType(int vacTypeNo) {
		return compVacMapper.getVacType(vacTypeNo);
	}

	@Override
	public List<VacTypeVO> vacTypeList() {
		return compVacMapper.vacTypeList();
	}

	@Override
	public int vacTypeUp(VacTypeVO vacTypeVO) {
		return compVacMapper.vacTypeUp(vacTypeVO);
	}

	@Override
	public int vacTypeDel(String vacTypeNo) {
		return compVacMapper.vacTypeDel(vacTypeNo);
	}

}
