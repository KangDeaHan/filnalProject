package kr.or.ddit.setting.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.common.vo.FileInfoVO;
import kr.or.ddit.setting.vo.CompanyInfoVO;


@Mapper
public interface CompanyInfoMapper {
	
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
