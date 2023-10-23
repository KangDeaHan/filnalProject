package kr.or.ddit.setting.service;

import java.util.List;

import kr.or.ddit.common.vo.FileInfoVO;
import kr.or.ddit.setting.vo.CompanyInfoVO;

public interface CompanyInfoService {

	public int updateData(CompanyInfoVO companyInfoVO);
	
	public int updateFile(CompanyInfoVO companyInfoVO);
	
	public CompanyInfoVO selectData();
	
	//파일정보 insert
	public int fileInsert(FileInfoVO fileInfoVO);
	
	//파일정보 select
	public List<FileInfoVO> logoFileSelect(String empNo);
	
	public List<FileInfoVO> sealFileSelect(String empNo);

	public String getLogo();
}
