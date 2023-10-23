package kr.or.ddit.vacation.serviceImpl;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.approval.mapper.ApprovalMapper;
import kr.or.ddit.approval.vo.ApboxVO;
import kr.or.ddit.approval.vo.DocWriVO;
import kr.or.ddit.common.vo.EmpVO;
import kr.or.ddit.common.vo.FileInfoVO;
import kr.or.ddit.common.vo.TbNotificationVO;
import kr.or.ddit.vacation.mapper.CusBkApplyMapper;
import kr.or.ddit.vacation.service.CusBkApplyService;
import kr.or.ddit.vacation.vo.BkApplyVO;
import kr.or.ddit.vacation.vo.RsReqstVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class CusBkApplyServiceImpl implements CusBkApplyService {
	
	@Autowired
	CusBkApplyService cusBkApplyService;
	
	@Autowired
	private CusBkApplyMapper cusBkMapper;
	
	@Autowired
	ApprovalMapper approvalMapper; 

	@Override
	public EmpVO EmpSelect(String empNo) {
		return cusBkMapper.EmpSelect(empNo);
	}

	@Override
	public int insertBkApply(BkApplyVO bkApplyVO) {
		return cusBkMapper.insertBkApply(bkApplyVO);
	}
	@Override
	public int insertBkApply1(BkApplyVO bkApplyVO) {
		return cusBkMapper.insertBkApply1(bkApplyVO);
	}

	@Override
	public List<BkApplyVO> getSelect(String empNo) {
		return cusBkMapper.getSelect(empNo);
	}

	@Override
	public BkApplyVO bkSelectOne(int bkNo) {
		return cusBkMapper.bkSelectOne(bkNo);
	}

	@Override
	public int fileInsert(FileInfoVO fileInfoVO) {
			log.info("impl->fileInfoVO"+fileInfoVO);
			int result = cusBkMapper.fileInsert(fileInfoVO);
			log.info("impl--->list"+result);
		return result;
	}

	@Override
	public int fileSnSelect() {
		return cusBkMapper.fileSnSelect();
	}

	@Override
	public FileInfoVO fileInfo(int FileSn) {
		return cusBkMapper.fileInfo(FileSn);
	}
///////////////////////////일단여기 보류////////////////////
	@Override
	public int bkUpdate(BkApplyVO bkApplyVO) throws IllegalStateException, IOException {
		//bkApplyVO : BkApplyVO(bkNo=735, empNo=202309001, bkCode=null, bkSdate=2023-10-26, bkEdate=2023-10-27, bkRsn=zxczxczxc, bkApstCode=C0104
		//, bkCertYn=B0103, fileSetting=null, bkName=병역 휴직, dftNo=0, empNm=null, 
		//file=org.springframework.web.multipart.support.StandardMultipartHttpServletRequest$StandardMultipartFile@38a8c99f
		//, fileList=null, fileSn=0, orfiName=null)
		log.info("bkApplyVO : " + bkApplyVO);
		
		//리스트 별 수정
		int result = cusBkMapper.bkUpdate(bkApplyVO);
		
		
		//파일처리
//		if(bkApplyVO.getBkCertYn().equals("B0103")) {// 파일이 있을 때 파일 업로드 업데이트
			
//		}else {// B0103(제출)이 아닐 때  파일 삽입
		
			MultipartFile file = bkApplyVO.getFile();
				log.info("@파일 나오냐file",file);
			
			//고객이 파일을 선택했을 때
			if(file.getOriginalFilename().length()>0) {
				String empNo = bkApplyVO.getEmpNo();
				log.info("@empNo이야:"+empNo);
				
				UUID uuid = UUID.randomUUID();
				log.info("@uuid입니다."+uuid);
	
				String orignalFileName = file.getOriginalFilename();
				log.info("@orignalFileName입니다."+orignalFileName);
				String uploadFileName = uuid.toString() + "_" + orignalFileName;
				
				long fileSize = file.getSize();
				log.info("@fileSize입니다."+fileSize);
				
				String categoryNo = "vacation";
				String savePath = "d:/myTool/sts3WS/insight/src/main/webapp/resources/images/vacation/break/"+uploadFileName;
				
				log.info("@bkUpdate->savePath : " + savePath);
				
				FileInfoVO fileVO = new FileInfoVO();
				fileVO.setOrfiName(orignalFileName);
				fileVO.setSvfiName("/vacation/break/"+uploadFileName);
				fileVO.setFileSize(fileSize);
				fileVO.setFileUdter(empNo);
				fileVO.setFileRoot(savePath);
				fileVO.setFileSetting(categoryNo);
				
				log.info("@fileVO입니다."+fileVO);
				
				int result2 = cusBkApplyService.fileInsert(fileVO);
				if(result2>0) {
					file.transferTo(new File(savePath));
				}
				
				
				BkApplyVO applyVO = new BkApplyVO();
				applyVO.setFileSn(fileVO.getFileSn());
				log.info("applyVO의 sn값",applyVO);
								
				int fileSn = cusBkApplyService.fileSnSelect();
				
				log.info("bkUpdate->fileSn : " + fileSn);
				
				//UPDATE BK_APPLY SET FILE_SN = fileSn번호 WHERE BK_NO = bkApplyVO의 bkNo멤버변수값
				bkApplyVO.setFileSn(fileSn);
				
				result += this.cusBkMapper.bkFileUpdate(bkApplyVO);
				
				String webURL = "/vacation/break/"+uploadFileName;
			}
//		}
		
		return result;
	}

	@Override
	public FileInfoVO fileUpdate(FileInfoVO fileInfoVO) {
		return cusBkMapper.fileUpdate(fileInfoVO);
	}
///////////////////////////////////////////////
	@Override
	public EmpVO selectEmpInfo(String EmpNo) {
		return cusBkMapper.selectEmpInfo(EmpNo);
	}

	@Override
	public int insertReqst(RsReqstVO rsReqstVO) {
		return cusBkMapper.insertReqst(rsReqstVO);
	}

	@Override
	public List<RsReqstVO> selectRsList(String EmpNo) {
		return cusBkMapper.selectRsList(EmpNo);
	}

	@Override
	public RsReqstVO rsModalSelect(int rsNo) {
		return cusBkMapper.rsModalSelect(rsNo);
	}

	@Override
	public int rsModalUpdate(RsReqstVO rsReqstVO) {
		return cusBkMapper.rsModalUpdate(rsReqstVO);
	}
	@Transactional
	@Override
	public int WriInsert(DocWriVO docWriVO, List<ApboxVO> apboxVO) {
		
		int result = 0;
		
		int dftNo = cusBkMapper.WriSelect();//문서 maxno값 가져오기
		docWriVO.setDftNo(dftNo);
		
		int cusCnt = cusBkMapper.WriInsert(docWriVO);
		
		for(ApboxVO vo : apboxVO) {
			vo.setDftNo(dftNo);
			int apboxCnt = cusBkMapper.apboxInsert(vo);
			result += apboxCnt;
		}
		result +=cusCnt;
		
		ApboxVO apVO = new ApboxVO();
		apVO.setDftNo(docWriVO.getDftNo());
		
		return result;
	}

	@Override
	public int apstCodeUpdate(int rsNo) {
		return cusBkMapper.apstCodeUpdate(rsNo);
	}
	
	//휴직 결재선
	@Override
	public int bkWriInsert(DocWriVO docWriVO, List<ApboxVO> apboxVO) {
		
		int result= 0;
		
		int dftNo = cusBkMapper.bkWriSelect();
		docWriVO.setDftNo(dftNo);
		
		int cusCnt =cusBkMapper.bkWriInsert(docWriVO);
		for(ApboxVO vo : apboxVO) {
			vo.setDftNo(dftNo);
			int apboxCnt = cusBkMapper.bkApboxInsert(vo);
			result += apboxCnt;
			
			//알림세팅
			String empNoid   = vo.getEmpNo();
			String content = "휴가신청 요청이 있습니다.";
			String status  = "N";
			String url     = "/approval/workflow";
			String titel   = "휴가신청";
			
			//알림 vo넣기
			TbNotificationVO tbNotificationVO = new TbNotificationVO();
			tbNotificationVO.setDftNo(dftNo);
			tbNotificationVO.setNtcnRcverEmpNo(empNoid);
			tbNotificationVO.setNtcnContent(content);
			tbNotificationVO.setNtcnUrl(url);
			tbNotificationVO.setNtcnReadStatus(status);
			tbNotificationVO.setNtcnTitle(titel);
			tbNotificationVO.setNtcnSenderEmpNo(docWriVO.getEmpNo());
			int cnt = approvalMapper.notificationInsert(tbNotificationVO);
			
			log.info("tbNotificationVO 잘 들어갔니???!!" + tbNotificationVO);
			log.info("cnt 잘 들어갔니???!!" + cnt);
			
		}
		result +=cusCnt;
		
		ApboxVO apvo = new ApboxVO();
		apvo.setDftNo(docWriVO.getDftNo());
		
		return result;
	}

	@Override
	public int bkApstCodeUpdate(BkApplyVO bkApplyVO) {
		return cusBkMapper.bkApstCodeUpdate(bkApplyVO);
	}

	@Override
	public List<BkApplyVO> bkNo() {
		return cusBkMapper.bkNo();
	}

	@Override
	public int fileSn(int bkNo) {
		return cusBkMapper.fileSn(bkNo);
	}

	@Override
	public List<ApboxVO> apboxSelect(ApboxVO apboxVO) {
		return cusBkMapper.apboxSelect(apboxVO);
	}

	@Override
	public BkApplyVO dftNoSelect(int bkNo) {
		return cusBkMapper.dftNoSelect(bkNo);
	}

	
	//나의 문서 결재자 리스트
	@Override
	public List<ApboxVO> apBoxList(int dftNo) {
		return cusBkMapper.apBoxList(dftNo);
	}


}
