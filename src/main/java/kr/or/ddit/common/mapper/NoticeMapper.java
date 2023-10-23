package kr.or.ddit.common.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.common.vo.EmpVO;
import kr.or.ddit.common.vo.FileInfoVO;
import kr.or.ddit.vo.NoticeVO;

@Mapper
public interface NoticeMapper {
	
	// 공지사항 등록
	public int notiInsert(NoticeVO noticeVO);
	
	// 리스트 불러오기
	public List<NoticeVO> notiList();
	
	// 공지사항 수정
	public int notiUpdate(NoticeVO noticeVO);
	
	// 공지사항 삭제
	public int notiDelete(NoticeVO noticeVO);
	
	// 1개 조회
	public NoticeVO noticeSelect(int postNo);
	
	// 파일 업로드
	public int fileInsert(FileInfoVO fileInfoVO);
}
