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

import kr.or.ddit.salary.service.PayDedService;
import kr.or.ddit.salary.vo.PayDedVO;
import kr.or.ddit.salary.vo.PayTplVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/salary")
@Controller
public class PayDedController {
	
	@Autowired 
	PayDedService payDedService;
	
	//지급항목 리스트 화면
	@GetMapping("/payList")
	public String payList(@RequestParam int ptNo, Model model) {
		//http://localhost/salary/payList?ptNo=2
		//법정필수 항목
		List<PayDedVO> LawPayList = this.payDedService.selectLawPayList();
		
		
		
//		int PTMCount = this.payDedService.selectPTMCount(payDedVO);
		
		//ptmList에 있는 ptNo, pdNo와 주소표시줄 ptNo와 카드 토글키 id인 pdNo가 있으면, 
		//토글키를 on으로 한다.
		
		//추가한 항목
		List<PayDedVO> AddedPayList = this.payDedService.selectAddedPayList();
		
		log.info("LawPayList : " + LawPayList);
		log.info("AddedPayList : " + AddedPayList);
		
		model.addAttribute("LawPayList", LawPayList);
		model.addAttribute("AddedPayList", AddedPayList);
		
		return "salary/payList";
	}
	
	@ResponseBody
	@GetMapping("/payListAjax")
	public List<PayDedVO> payListAjax(@RequestParam int ptNo) {
		
		List<PayDedVO> PTMList = this.payDedService.selectPTMList(ptNo); //ptNo에 따른 pdNo 리스트 
		log.info("PTMList :" + PTMList);
		return PTMList;
	}
	
	///////////////////////////////////////
	//지급항목 추가 화면
	@GetMapping("/payInsert")
	public String payInsert() {
		return "salary/payInsert";
	}
	
	//지급항목 추가 insert 처리 (form태그 post 전송)
	@PostMapping("/payInsert")    
	public String payInsertPost(@RequestParam int ptNo, @ModelAttribute PayDedVO payDedVO, RedirectAttributes redirAttr) {
		log.info("ptNo : " + ptNo);
		
		log.info("payInsert 폼태그로 넘어온 값 : "+ payDedVO);
		int result = this.payDedService.insertPD(payDedVO);
		log.info("payInsert DB처리 후 넘어온 값 : "+ payDedVO);
		log.info("payInsert 결과값" + result);
		
		String insertRes;
		if (result >0) {
			insertRes = "insert 성공";
		} else {
			insertRes = "insert 실패";
		}
		
		payDedVO.setPtNo(ptNo);
		
		redirAttr.addFlashAttribute("insertRes", insertRes);//sweet alert창 띄우기 위해 result결과 보내기
		
		return "redirect:/salary/payList?ptNo="+ptNo;
	}
	////////////////////////////////////////
	
	//지급항목 변경 input 화면
	//http://localhost/salary/payUpdate?ptNo=5&pdNo=30
	@GetMapping("/payUpdate") 
	public String payUpdate(@RequestParam int pdNo, Model model) {
		log.info("get방식 payUpdate에 왔다");
		PayDedVO payDedVO = payDedService.selectPD(pdNo);
		
		model.addAttribute("data", payDedVO);
		log.info("payDedVO : " + payDedVO);
		
		return "salary/payUpdate";
	}
	
	//지급항목 변경 update 처리 (form태그 post 전송) //form태그는 get, post밖에 안됨
	@PostMapping("/payUpdate") 
	public String payUpdatePut(@RequestParam int ptNo, @ModelAttribute PayDedVO payDedVO, RedirectAttributes redirAttr) {
		log.info("payUpdate 폼태그로 넘어온 값 : ", payDedVO);
		int result = this.payDedService.updatePD(payDedVO);
		log.info("payUpdate DB처리 후 넘어온 값 : ", payDedVO);
		log.info("payUpdate 결과값" + result);
		
		String updateRes;
		if (result >0) {
			updateRes = "update 성공";
		} else {
			updateRes = "update 실패";
		}
		
		redirAttr.addFlashAttribute("updateRes", updateRes);//sweet alert창 띄우기 위해 result결과 보내기
		
		return "redirect:/salary/payList?ptNo="+ptNo;
	}
	//////////////////////////////////////////////////
	
	//지급항목 삭제 delete 처리 
	@DeleteMapping("/payDelete")
	@ResponseBody
	public String payDelete(@RequestBody PayDedVO payDedVO) {
		
		log.info("payDedVO 삭제 전 : " + payDedVO);
		int result =  payDedService.deletePD(payDedVO);
		
		log.info("payDedVO 삭제 후 : " + payDedVO);
		
		if(result>0) {//성공
			return "success";
		}else {
			return "fail";
		}
	}
	
	////////////////////////////////////////////////////////////////////////////
	//공제항목 리스트 화면
	@GetMapping("/dedList")
	public String dedList(@RequestParam int ptNo, Model model) {
		//http://localhost/salary/payList?ptNo=2
		//법정필수 항목
		List<PayDedVO> LawDedList = this.payDedService.selectLawDedList();
		
//		List<PayDedVO> ptmList = this.payDedService.selectPTMList(ptNo);
		
		//ptmList에 있는 ptNo, pdNo와 주소표시줄 ptNo와 카드 토글키 id인 pdNo가 있으면, 
		//토글키를 on으로 한다.
		
		//추가한 항목
		List<PayDedVO> AddedDedList = this.payDedService.selectAddedDedList();
		
		log.info("LawDedList : " + LawDedList);
		log.info("AddedDedList : " + AddedDedList);
		
		model.addAttribute("LawDedList", LawDedList);
		model.addAttribute("AddedDedList", AddedDedList);
		
		return "salary/dedList";
	}
	
	@ResponseBody
	@GetMapping("/dedListAjax")
	public List<PayDedVO> dedListAjax(@RequestParam int ptNo) {
		
		List<PayDedVO> PTMList = this.payDedService.selectPTMList(ptNo); //ptNo에 따른 pdNo 리스트 
		log.info("PTMList :" + PTMList);
		return PTMList;
	}
	
	///////////////////////////////////////////////////////////////
	
	//공제항목 추가 화면
	@GetMapping("/dedInsert")
	public String dedInsert() {
		return "salary/dedInsert";
	}
	
	//공제항목 추가 insert 처리 (form태그 post 전송)
	@PostMapping("/dedInsert")    
	public String dedInsertPost(@RequestParam int ptNo, @ModelAttribute PayDedVO payDedVO, RedirectAttributes redirAttr) {
		log.info("ptNo : " + ptNo);
		
		log.info("dedInsert 폼태그로 넘어온 값 : "+ payDedVO);
		int result = this.payDedService.insertPD(payDedVO);
		log.info("dedInsert DB처리 후 넘어온 값 : "+ payDedVO);
		log.info("dedInsert 결과값" + result);
		
		String insertRes;
		if (result >0) {
			insertRes = "insert 성공";
		} else {
			insertRes = "insert 실패";
		}
		
		payDedVO.setPtNo(ptNo);
		
		redirAttr.addFlashAttribute("insertRes", insertRes);//sweet alert창 띄우기 위해 result결과 보내기
		
		return "redirect:/salary/dedList?ptNo="+ptNo;
	}
	/////////////////////////////////////////////////////////////
	
	//공제항목 변경 input 화면
	//http://localhost/salary/dedUpdate?ptNo=5&pdNo=30
	@GetMapping("/dedUpdate") 
	public String dedUpdate(@RequestParam int pdNo, Model model) {
		log.info("get방식 dedUpdate에 왔다");
		PayDedVO payDedVO = payDedService.selectPD(pdNo);
		
		model.addAttribute("data", payDedVO);
		log.info("payDedVO : " + payDedVO);
		
		return "salary/dedUpdate";
	}
	
	//공제항목 변경 update 처리 (form태그 post 전송)
	@PostMapping("/dedUpdate")
	public String dedUpdatePut(@RequestParam int ptNo, @ModelAttribute PayDedVO payDedVO, RedirectAttributes redirAttr) {
		log.info("dedUpdate 폼태그로 넘어온 값 : ", payDedVO);
		int result = this.payDedService.updatePD(payDedVO);
		log.info("dedUpdate DB처리 후 넘어온 값 : ", payDedVO);
		log.info("dedUpdate 결과값" + result);
		
		String updateRes;
		if (result >0) {
			updateRes = "update 성공";
		} else {
			updateRes = "update 실패";
		}
		
		redirAttr.addFlashAttribute("updateRes", updateRes);//sweet alert창 띄우기 위해 result결과 보내기
		
		return "redirect:/salary/dedList?ptNo="+ptNo;
	}
	//////////////////////////////////////////
	
	//공제항목 삭제 delete 처리 
	@DeleteMapping("/dedDelete")
	@ResponseBody
	public String dedDelete(@RequestBody PayDedVO payDedVO) {
		
		log.info("payDedVO 삭제 전 : " + payDedVO);
		int result =  payDedService.deletePD(payDedVO);
		
		log.info("payDedVO 삭제 후 : " + payDedVO);
		
		if(result>0) {//성공
			return "success";
		}else {
			return "fail";
		}
	}
	
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	//toggleData : {"pdNo":"3","isChecked":true,"ptNo":"2"}
	//지급공제항목 토글 on insert 추가	
	@ResponseBody
	@PostMapping("/togglePDItem")
	public String inDelPTM(@RequestBody PayDedVO payDedVO) {
		//PayDedVO(pdNo=3, pdNm=null, pdAmt=0, pdEpn=null, pdFml=null, pdLawYn=null, pdTaxYn=null
		//, pdType=null, isChecked=true, ptNo=2)
		//* isChecked=true(insert) / isChecked=false(delete)
		log.info("payDedVO ajax 넘어온 값 : " + payDedVO);
		
//		int ptNo = payDedVO.getPtNo();
//		int pdNo = payDedVO.getPdNo();
		
		int selectPTMCount = payDedService.selectPTMCount(payDedVO);
		
		log.info("selectPTMCount : " + selectPTMCount);
		
		int result =  0;
		
		if(payDedVO.getIsChecked().equals("true")) {
			
			if (selectPTMCount==0) { //PT_MAKE에 값이 없으면 insert
			
			    log.info("인서트 수행");
			    log.info("체크결과 : " + payDedVO.getIsChecked());
			    result = payDedService.insertPTM(payDedVO); 
			    log.info("insertPTM 결과값: " + result);
			}
		}else { //토글키 : "false"일때
			//delete 수행
			log.info("deletePTM 결과값: " + result);
			result = payDedService.deletePTM(payDedVO);
		}
		
		if(result>0) {//성공 
			return "success";
			
		}else {
			return "fail";
		}
	}
	
}
