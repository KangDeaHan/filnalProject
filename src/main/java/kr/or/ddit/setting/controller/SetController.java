package kr.or.ddit.setting.controller;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.approval.service.ApprovalService;
import kr.or.ddit.common.vo.DeptVO;
import kr.or.ddit.common.vo.EmpVO;
import kr.or.ddit.common.vo.FileInfoVO;
import kr.or.ddit.personnel.service.MemberService;
import kr.or.ddit.setting.service.CompAuthService;
import kr.or.ddit.setting.service.CompHoliService;
import kr.or.ddit.setting.service.CompTreeService;
import kr.or.ddit.setting.service.CompVacService;
import kr.or.ddit.setting.service.CompWorkService;
import kr.or.ddit.setting.service.CompanyInfoService;
import kr.or.ddit.setting.vo.CompanyHoliVO;
import kr.or.ddit.setting.vo.CompanyInfoVO;
import kr.or.ddit.vacation.service.CusMainService;
import kr.or.ddit.vacation.vo.VacTypeVO;
import kr.or.ddit.vo.AcntAuthorVO;
import kr.or.ddit.vo.AuthMenuVO;
import kr.or.ddit.vo.MenuVO;
import kr.or.ddit.vo.WorkVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/setting")
@Controller
public class SetController {
	
	@Autowired
	CompanyInfoService companyInfoSVC;
	@Autowired
	CompHoliService compHoliSVC;
	@Autowired
	CompTreeService compTreeSVC;
	@Autowired
	CompVacService compVacSVC;
	@Autowired
	CompWorkService compWorkSVC;
	@Autowired
	CompAuthService compAuthSVC;
	@Autowired
	MemberService ppservice;

	@GetMapping("/test")
	public String test() {
		return "setting/test";
	}
	
	@GetMapping("/setmain")
	public String setMain() {
		return "setting/setmain";
	}
	
	@ResponseBody
	@GetMapping("/asideAjax")
	public Map<String, Object> asideAjax() {
	      //권한정보 ㅎㅎ
        SecurityContext context = SecurityContextHolder.getContext();
        Authentication authentication = context.getAuthentication();
        log.info("33?" + authentication.getAuthorities());

      //권한별 메뉴 리스트
      List<AuthMenuVO> authMenuList = ppservice.authMenu();
		
      Map<String, Object> map = new HashMap<String , Object>();
      
      map.put("authMenuList", authMenuList);
      map.put("authentication", authentication);

      return map;
	}
	
	@GetMapping(value="/companyinfo", produces = "application/json;charset=utf-8")
	public String companyInfo(Principal principal,Model model) {
		CompanyInfoVO companyInfoVO = companyInfoSVC.selectData();
		log.debug("companyInfoVO는? : " + companyInfoVO);
		
		String EmpNo = principal.getName();
		List<FileInfoVO> myFileList = companyInfoSVC.logoFileSelect(EmpNo);
		companyInfoVO.setFileList(myFileList);
		model.addAttribute("companyInfoVO", companyInfoVO);
		
		return "setting/companyinfo";
	}
	
	@GetMapping("/companyseal")
	public String companySeal(Principal principal,Model model) {
		CompanyInfoVO companyInfoVO = new CompanyInfoVO();
		String EmpNo = principal.getName();
		List<FileInfoVO> myFileList = companyInfoSVC.sealFileSelect(EmpNo);
		companyInfoVO.setFileList(myFileList);
		model.addAttribute("companyInfoVO", companyInfoVO);
		
		return "setting/companyseal";
	}
	
	@GetMapping("/companyholiday")
	public String companyHoliday(Model model) {
		List<CompanyHoliVO> list = compHoliSVC.compHoliSelect();
		log.debug("compHoliVO는? : " + list);
		
		model.addAttribute("companyHoliVO", list);
		
		return "setting/companyholiday";
	}
	
	@GetMapping("/compTree")
	public String compTree() {
		return "setting/compTree";
	}
	
	@GetMapping("/setWork")
	public String compWork(Model model) {
		
		List<WorkVO> workList = compWorkSVC.workList();
		log.info("workList::" + workList);
		model.addAttribute("workList", workList);
		
		List<FileInfoVO> fileInfoList = compWorkSVC.selectFileList();
		log.info("fileInfoList:::" + fileInfoList);
		model.addAttribute("fileInfoList", fileInfoList);
		
		String empNo = compWorkSVC.selectWokrAp();
		
		EmpVO empVo = compWorkSVC.selectWorkApEmp(empNo);
		log.info("empVo::" + empVo);
		model.addAttribute("empVo", empVo);
		
		return "setting/setWork";
	}
	
	@GetMapping("/setVacation")
	public String compVacation(Model model) {
		
		List<VacTypeVO> vacTypeList = compVacSVC.vacTypeList();
		log.info("vacTypeList:::" + vacTypeList);
		model.addAttribute("vacTypeList", vacTypeList);
		
		List<FileInfoVO> fileInfoList = compVacSVC.selectFileList();
		log.info("fileInfoList:::" + fileInfoList);
		model.addAttribute("fileInfoList", fileInfoList);
		
		return "setting/setVacation";
	}
	
	@GetMapping("/setAuth")
	public String setAuth(Model model) {
		
		List<AcntAuthorVO> authList1 = compAuthSVC.getAuthList1();
		log.info("기본 권한 리스트::" + authList1);
		model.addAttribute("authList1", authList1);
		
		List<AcntAuthorVO> authList2 = compAuthSVC.getAuthList2();
		log.info("커스텀 권한 리스트::" + authList2);
		model.addAttribute("authList2", authList2);
		
		List<MenuVO> menuList1 = compAuthSVC.getMenuList1();
		log.info("상위 메뉴 리스트::" + menuList1);
		model.addAttribute("menuList1", menuList1);
		
		List<MenuVO> menuList2 = compAuthSVC.getMenuList2();
		log.info("메뉴 리스트::" + menuList2);
		model.addAttribute("menuList2", menuList2);
		
		return "setting/setAuth";
	}
	
	@GetMapping("/setContact")
	public String setContact() {
		return "setting/setContact";
	}
	
	
}
