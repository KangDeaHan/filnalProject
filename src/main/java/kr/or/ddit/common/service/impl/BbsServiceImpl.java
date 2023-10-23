package kr.or.ddit.common.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.common.mapper.BbsMapper;
import kr.or.ddit.common.service.BbsService;
import kr.or.ddit.vo.BbsVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service 
public class BbsServiceImpl implements BbsService {
	
	@Autowired
	BbsMapper bbsMapper;

	@Override
	public List<BbsVO> BbsList() {
		return bbsMapper.BbsList();
	}

	@Override
	public List<BbsVO> BbsSelect(String empNo) {
		return bbsMapper.BbsSelect(empNo);
	}

	@Override
	public int BbsInsert(BbsVO bbsVO) {
		return bbsMapper.BbsInsert(bbsVO);
	}

	@Override
	public int BbsUpdate(BbsVO bbsVO) {
		return bbsMapper.BbsUpdate(bbsVO);
	}

	@Override
	public int BbsDelete(BbsVO bbsVO) {
		return bbsMapper.BbsDelete(bbsVO);
	}

}
