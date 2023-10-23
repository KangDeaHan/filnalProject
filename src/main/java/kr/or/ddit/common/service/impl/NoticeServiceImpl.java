package kr.or.ddit.common.service.impl;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.common.mapper.EmpMapper;
import kr.or.ddit.common.mapper.NoticeMapper;
import kr.or.ddit.common.service.NoticeService;
import kr.or.ddit.common.vo.EmpVO;
import kr.or.ddit.common.vo.FileInfoVO;
import kr.or.ddit.vo.NoticeVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class NoticeServiceImpl implements NoticeService {
   
   @Autowired
   NoticeMapper noticeMapper;
   
   @Autowired
   EmpMapper empMapper;
   
   @Override
   @Transactional
   public int fileInsert(FileInfoVO fileInfoVO) {
      
      int result = noticeMapper.fileInsert(fileInfoVO);
      
      return  result;
   }

   @Override
   public int notiInsert(NoticeVO noticeVO) {
      return noticeMapper.notiInsert(noticeVO);
   }

   @Override
   public List<NoticeVO> notiList() {
      return noticeMapper.notiList();
   }

   @Override
   public int notiUpdate(NoticeVO noticeVO) {
      return noticeMapper.notiUpdate(noticeVO);
   }

   @Override
   public int notiDelete(NoticeVO noticeVO) {
      return noticeMapper.notiDelete(noticeVO);
   }

   @Override
   public NoticeVO noticeSelect(int postNo) {
      return noticeMapper.noticeSelect(postNo);
   }

   @Override
   @Transactional
   public int fileInsert(MultipartFile file, String wriNo, String postTitle, String postCont) {
      
      log.info("file@@" + file);
      if(file!=null) {
       UUID uuid = UUID.randomUUID();
       String originFileName = file.getOriginalFilename();
       String uploadFileName = uuid.toString() + "_" + originFileName;

       log.debug("<<file>>" + file.getContentType());
       log.debug("<<file2>>" + file.getName());
       log.debug("<<file3>>" + file.getOriginalFilename());
       log.debug("<<file4>>" + file.getSize());
       long fileSize = file.getSize();
       String saveCateNo = "notice";

       String savePath = "d:/insightFile/notice/" + uploadFileName;

       try {
         file.transferTo(new File(savePath));
      } catch (IllegalStateException e) {
         // TODO Auto-generated catch block
         e.printStackTrace();   
      } catch (IOException e) {
         // TODO Auto-generated catch block
         e.printStackTrace();
      }
       log.info("<<<savePath 경로>>> " + savePath);

       FileInfoVO fileInfoVO = new FileInfoVO();
       fileInfoVO.setOrfiName(originFileName);
       fileInfoVO.setSvfiName("/insightFile/notice/" + uploadFileName);
       fileInfoVO.setFileSize(fileSize);
       fileInfoVO.setFileRoot(savePath);
       fileInfoVO.setFileSetting(saveCateNo);
       log.info("넘버 어디서 가져와" +fileInfoVO.getFileSn());

       EmpVO empVO = new EmpVO();
       empVO.setEmpImg(fileInfoVO.getSvfiName());
       empVO.setEmpNo(wriNo);

       fileInfoVO.setFileUdter(empVO.getEmpNo());
       log.info("<<<파일 정보>>>" + fileInfoVO);

       int result = noticeMapper.fileInsert(fileInfoVO);
       
       String webURL = "/insightFile/notice/" + uploadFileName;
       log.info("<<webURL 테스트>> " + webURL);
       NoticeVO noticeVO = new NoticeVO();
       noticeVO.setWriNo(wriNo);
       noticeVO.setPostTitle(postTitle);
       noticeVO.setPostCont(postCont);
       noticeVO.setFileNo(fileInfoVO.getFileSn()+"");
       int insertResult = noticeMapper.notiInsert(noticeVO);
      
      return insertResult;
      }else {
          NoticeVO noticeVO = new NoticeVO();
          noticeVO.setWriNo(wriNo);
          noticeVO.setPostTitle(postTitle);
          noticeVO.setPostCont(postCont);
          log.info("없이1");
          int result = noticeMapper.notiInsert(noticeVO);
          log.info("없이2");
         return  result;
      }
   }

	@Override
	@Transactional
	public int fileUpdate(MultipartFile file, int postNo, String wriNo, String postTitle, String postCont, String fileNo) {
		if(file!=null) {
		       UUID uuid = UUID.randomUUID();
		       String originFileName = file.getOriginalFilename();
		       String uploadFileName = uuid.toString() + "_" + originFileName;

		       log.debug("<<file>>" + file.getContentType());
		       log.debug("<<file2>>" + file.getName());
		       log.debug("<<file3>>" + file.getOriginalFilename());
		       log.debug("<<file4>>" + file.getSize());
		       long fileSize = file.getSize();
		       String saveCateNo = "notice";

		       String savePath = "d:/insightFile/notice/" + uploadFileName;

		       try {
		         file.transferTo(new File(savePath));
		      } catch (IllegalStateException e) {
		         // TODO Auto-generated catch block
		         e.printStackTrace();   
		      } catch (IOException e) {
		         // TODO Auto-generated catch block
		         e.printStackTrace();
		      }
		       log.info("<<<savePath 경로>>> " + savePath);

		       FileInfoVO fileInfoVO = new FileInfoVO();
		       fileInfoVO.setOrfiName(originFileName);
		       fileInfoVO.setSvfiName("/insightFile/notice/" + uploadFileName);
		       fileInfoVO.setFileSize(fileSize);
		       fileInfoVO.setFileRoot(savePath);
		       fileInfoVO.setFileSetting(saveCateNo);
		       log.info("넘버 어디서 가져와" +fileInfoVO.getFileSn());

		       EmpVO empVO = new EmpVO();
		       empVO.setEmpImg(fileInfoVO.getSvfiName());
		       empVO.setEmpNo(wriNo);

		       fileInfoVO.setFileUdter(empVO.getEmpNo());
		       log.info("<<<파일 정보>>>" + fileInfoVO);

		       int result = noticeMapper.fileInsert(fileInfoVO);
		       
		       String webURL = "/insightFile/notice/" + uploadFileName;
		       log.info("<<webURL 테스트>> " + webURL);
		       NoticeVO noticeVO = new NoticeVO();
		       noticeVO.setWriNo(wriNo);
		       noticeVO.setPostNo(postNo);
		       noticeVO.setPostTitle(postTitle);
		       noticeVO.setPostCont(postCont);
		       noticeVO.setFileNo(fileInfoVO.getFileSn()+"");
		       log.debug("<<postNo>>"+postNo);
		       log.debug(fileInfoVO.getFileSn()+"");
		       int res = noticeMapper.notiUpdate(noticeVO);
		       
		       return res;
		      }
				
				NoticeVO noticeVO = new NoticeVO();
			    noticeVO.setPostNo(postNo);
			    noticeVO.setWriNo(wriNo);
			    noticeVO.setPostTitle(postTitle);
			    noticeVO.setPostCont(postCont);
			    noticeVO.setFileNo(fileNo);
			    log.info("서비스업뎃" + noticeVO );
			    
			    int updateResult = noticeMapper.notiUpdate(noticeVO);
			    return updateResult;
	}


}