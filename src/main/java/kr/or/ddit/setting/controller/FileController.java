package kr.or.ddit.setting.controller;

import java.io.File;
import java.security.Principal;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.common.vo.FileInfoVO;
import kr.or.ddit.setting.service.CompanyInfoService;
import kr.or.ddit.setting.vo.CompanyInfoVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/setting")
public class FileController {
	@Autowired
	private CompanyInfoService companyInfoSVC;
	
	/**
	 * 파일 미리보기
	 * @param file
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@PostMapping(value ="/file/preview", produces ="application/json;charset=utf-8" )
	public String updateFile(MultipartFile file) throws Exception {
		log.info("updateFile->fileName : " + file.getOriginalFilename());
		log.info("updateFile->size : " + file.getSize());
		
		//DB에 저장할 파일경로
		String savePath = "c:/myTool/sts3WS/insight/src/main/webapp/resources/images/setting/preview/"+ file.getOriginalFilename();
		file.transferTo(new File(savePath));
		
		//실제 웹 물리적 경로
		String webURL = "/settingFile/preview/" + file.getOriginalFilename();
		//forwarding(jsp파일경로?)(x)
		//redirect(x)
		//데이터(O)
		return webURL;
	}
	
	
	/**
	 * 회사 로고 update(파일 업로드)
	 * @param file
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@PostMapping(value = "/logoFile/fileUpdate", produces = "application/json;charset=utf-8")
	public String fileUpdate(Principal principal, MultipartFile file) throws Exception {
		UUID uuid = UUID.randomUUID();
		String originFileName = file.getOriginalFilename();
		String uploadFileNmae = uuid.toString() + "_" + originFileName; 
		long fileSize = file.getSize();
		String EmpNo = principal.getName();
		String saveCateNo = "logo"; 
		
		String savePath = "c:/myTool/sts3WS/insight/src/main/webapp/resources/images/setting/logo/"+uploadFileNmae;
		
		FileInfoVO fileInfoVO = new FileInfoVO();
		fileInfoVO.setOrfiName(originFileName);
		fileInfoVO.setSvfiName("/settingFile/logo/"+uploadFileNmae);
		fileInfoVO.setFileSize(fileSize);
		fileInfoVO.setFileUdter(EmpNo);
		fileInfoVO.setFileRoot(savePath);
		fileInfoVO.setFileSetting(saveCateNo);
		int result = companyInfoSVC.fileInsert(fileInfoVO);
		if(result > 0) {
			file.transferTo(new File(savePath));
		}
		
		String webURL = "/settingFile/logo/" + uploadFileNmae;
		return webURL;
	}
	
	/**
	 * 회사 직인 update(파일 업로드)
	 * @param file
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@PostMapping(value = "/sealFile/fileUpdate", produces = "application/json;charset=utf-8")
	public String sealUpdate(Principal principal, MultipartFile file) throws Exception {
		UUID uuid = UUID.randomUUID();
		String originFileName = file.getOriginalFilename();
		String uploadFileNmae = uuid.toString() + "_" + originFileName; 
		long fileSize = file.getSize();
		String EmpNo = principal.getName();
		String saveCateNo = "seal"; 
		
		String savePath = "c:/myTool/sts3WS/insight/src/main/webapp/resources/images/setting/seal/"+uploadFileNmae;
		
		FileInfoVO fileInfoVO = new FileInfoVO();
		fileInfoVO.setOrfiName(originFileName);
		fileInfoVO.setSvfiName("/settingFile/seal/"+uploadFileNmae);
		fileInfoVO.setFileSize(fileSize);
		fileInfoVO.setFileUdter(EmpNo);
		fileInfoVO.setFileRoot(savePath);
		fileInfoVO.setFileSetting(saveCateNo);
		int result = companyInfoSVC.fileInsert(fileInfoVO);
		if(result > 0) {
			file.transferTo(new File(savePath));
		}
		
		String webURL = "/settingFile/seal/" + uploadFileNmae;
		return webURL;
	}
	
}
