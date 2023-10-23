package kr.or.ddit.common.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.common.vo.FileInfoVO;
import kr.or.ddit.vo.NoticeVO;

public interface NoticeService {
	
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
	
	// 공지 등록 & 파일 등록
	public int fileInsert(MultipartFile file, String wriNo, String postTitle, String postCont);
	
	// 공지 수정 & 파일 등록
	public int fileUpdate(MultipartFile file, int postNo, String wriNo, String postTitle, String postCont, String fileNo);

}
