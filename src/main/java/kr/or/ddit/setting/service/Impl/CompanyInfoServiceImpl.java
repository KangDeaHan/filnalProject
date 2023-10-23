package kr.or.ddit.setting.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Service;

import kr.or.ddit.common.vo.FileInfoVO;
import kr.or.ddit.setting.mapper.CompanyInfoMapper;
import kr.or.ddit.setting.service.CompanyInfoService;
import kr.or.ddit.setting.vo.CompanyInfoVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class CompanyInfoServiceImpl implements CompanyInfoService {
	
	@Autowired
	private CompanyInfoMapper companyInfoMapper;

	@Override
	public int updateData(CompanyInfoVO companyInfoVO) {
		return companyInfoMapper.updateData(companyInfoVO);
	}

	@Override
	public int updateFile(CompanyInfoVO companyInfoVO) {
		return companyInfoMapper.updateFile(companyInfoVO);
	}

	@Override
	public CompanyInfoVO selectData() {
		return companyInfoMapper.selectData();
	}

	//나의 파일정보 insert
	@Override
	public int fileInsert(FileInfoVO fileInfoVO) {
		log.info("ServiceImpl->fileInfoVO"+fileInfoVO);
		int result = companyInfoMapper.fileInsert(fileInfoVO);
		log.info("ServiceImpl->result"+result);
		return result;
	}

	//회사 로고 파일정보 select
	@Override
	public List<FileInfoVO> logoFileSelect(String empNo) {
		log.info("ServiceImpl->empNo"+empNo);
		List<FileInfoVO> list = companyInfoMapper.logoFileSelect(empNo);
		log.info("ServiceImpl->list"+list);
		return list;
	}
	
	//회사 직인 파일정보 select
	@Override
	public List<FileInfoVO> sealFileSelect(String empNo) {
		log.info("ServiceImpl->empNo"+empNo);
		List<FileInfoVO> list = companyInfoMapper.sealFileSelect(empNo);
		log.info("ServiceImpl->list"+list);
		return list;
	}

	@Override
	public String getLogo() {
		return companyInfoMapper.getLogo();
	}
	

}
