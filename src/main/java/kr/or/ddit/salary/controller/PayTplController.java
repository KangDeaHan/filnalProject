package kr.or.ddit.salary.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.salary.service.PayTplService;
import kr.or.ddit.salary.vo.PayTplVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/salary")
@Controller
public class PayTplController {

	@Autowired
	PayTplService payTplService;
	
	//정산템플릿 목록 화면
	@GetMapping("/tmpList")
	public String tmpList() {
		return "salary/tmpList";
	}
	
	//정산템플릿 리스트 출력 ajax
	@GetMapping("/tmpListAjax")
	@ResponseBody
	public List<PayTplVO> tmpListAjax() {
		return payTplService.selectTplList();
	}
	
	/////////////// 입력 시작 ////////////////////
	//정산 템플릿 추가 input 작성 화면
	@GetMapping("/tmpInsert")
	public String tmpInsert() {
		return "salary/tmpInsert"; //fowarding 방식 (데이터를 넘길때, Model로 넘겨)
	}
	
	//템플릿 추가 insert처리 (form)
	@PostMapping("/tmpInsert")
	public String tmpInsertPost(@ModelAttribute PayTplVO payTplVO, RedirectAttributes redirAttr) {
		log.info("이거 payTplVO 값이 이거 찍오" + payTplVO);
		int insertRes = payTplService.insertTpl(payTplVO);
		log.info("이거 결과값임" + insertRes);
		
		redirAttr.addFlashAttribute("insertRes", insertRes);//sweet alert창 띄우기 위해 result결과 보내기
		
		return "redirect:/salary/tmpUpdate?ptNo="+payTplVO.getPtNo();
//		return "redirect:/salary/tmpUpdate?ptNo="+payTplVO.getPtNo()+"&result="+result;
		
	}
	/////////////// 입력 끝 ////////////////////
	
	/////////////// 수정 시작 /////////////////////
	//정산템플릿 변경 input 작성 화면
	//요청URL : /salary/tmpUpdate?ptNo=5  
	@GetMapping("/tmpUpdate")
	public String tmpUpdate(@RequestParam int ptNo, Model model) {
		log.info("ptNo입니까???? : " + ptNo);
		
		PayTplVO data = this.payTplService.selectTpl(ptNo);
		log.info("data : " + data);
		
		model.addAttribute("data", data);
		
		return "salary/tmpUpdate"; //forwarding으로 전송
	}
	
	//템플릿 변경 update처리 (ajax)
	@PutMapping("/tmpUpdate")
	@ResponseBody
	public String tmpUpdateAjax(@RequestBody PayTplVO payTplVO) {//ajax로 vo값 넘어옴
		log.info("payTplVO : " + payTplVO);
		
		int result = payTplService.updateTpl(payTplVO);
		log.info("업데이트 성공했나?" + result);
		
		if(result>0) {//성공
			return "success";
		}else {
			return "fail";
		}
		
	}
	/////////////// 수정 끝 /////////////////////
	
	/////////////// 삭제 시작 /////////////////////
	@DeleteMapping("/tmpDelete")
	@ResponseBody
	public String tmpDelete(@RequestBody PayTplVO payTplVO) {
		
		log.info("payTplVO 삭제 전 : " + payTplVO);
		int result = payTplService.deleteTpl(payTplVO);
		
		log.info("payTplVO 삭제 후 : " + payTplVO);
		
		if(result>0) {//성공
			return "success";
		}else {
			return "fail";
		}
	}
	/////////////// 삭제 끝 /////////////////////
	
	//update처리 (북마크 상태 변경)
	@PutMapping("/updateBmkStatus")
	@ResponseBody
	public String tmpUpdateBmk(@RequestBody PayTplVO payTplVO) {//ajax로 vo값 넘어옴
		//B0101 : Y
		//B0102 : N
		//payTplVO : PayTplVO(ptNo=6, ptNm=null, ptEpn=null, ptCdate=null, ptYn=null, ptBmkYn=B0101)
		log.info("payTplVO : " + payTplVO);
		
		int result = payTplService.updateBmkStatus(payTplVO);
		log.info("업데이트 성공했나?" + result);
		
		if(result>0) {//성공
			return payTplVO.getPtBmkYn();
		}else {
			return "fail";
		}
		
	}
	
	//급여정산 홈 - 북마크여부코드가 'B0101'인 것만 전체 출력하기 (Ajax)
	@GetMapping("/selectBmkOn")
	@ResponseBody
	public List<PayTplVO> selectBmkOnAjax(){
		return payTplService.selectBmkOn();
	}
	
	

}
