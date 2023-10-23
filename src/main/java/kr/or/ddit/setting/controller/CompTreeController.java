package kr.or.ddit.setting.controller;

import java.util.ArrayList;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.approval.service.ApprovalService;
import kr.or.ddit.common.vo.DeptVO;
import kr.or.ddit.setting.service.CompTreeService;
import kr.or.ddit.vo.CmCodeVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/setting")
@Controller
public class CompTreeController {

	@Autowired
	CompTreeService compTreeSVC;
	
	@Autowired
	ApprovalService approvalSVC;
	
	/**
	 * 조직도 출력 
	 * @return
	 */
	@ResponseBody
	@GetMapping("/organizationChart")
	public Map<String,List<DeptVO>> organizationChart(){
		Map<String,List<DeptVO>> map = new HashMap();
		
		List<DeptVO> one = approvalSVC.organizationChartOne();
		List<DeptVO> two = approvalSVC.organizationChartTwo();
		
		map.put("one", one);
		map.put("two", two);
		
		log.info("이것은 One입니다" +one);
		log.info("이것은 Two입니다" +two);
		
		return map;
	}
	
	//조직도 설정 저장버튼 클릭시
	@ResponseBody
	@PostMapping(value = "/compTreeUp", produces = "application/json;charset=utf-8")
	public String compTreeUpdate(@RequestBody List<Object> pendingChanges) {
		
		log.debug("pendingChanges::"+pendingChanges);
		
		int insert = 0;
		int update = 0;
		int delete = 0;
		
		for (Object object : pendingChanges) {
			if (object instanceof Map) {
	            Map<String, Object> change = (Map<String, Object>) object;
	            String type = (String) change.get("type");

	            if (type.equals("add")) {
	                // 추가 작업 수행
	            	if(change.get("parent").equals("root")) {
	            		change.put("parent", "");
	                }
	            	log.debug("숫자로바꿀수잇는지::"+ Integer.parseInt((String)change.get("id")));	            	
	            	//log.debug("숫자로바꿀수잇는지::"+ (String)change.get("id"));
	            	
	                int id = Integer.parseInt((String)change.get("id"));
	                int parent = Integer.parseInt((String)change.get("parent"));
	                String text = (String) change.get("text");
	                
	                Map<String, Object> addMap = new HashMap<String, Object>();
	                addMap.put("id", id);
	                addMap.put("parent", parent);
	                addMap.put("text", text);
	                
	                insert += compTreeSVC.deptAdd(addMap);

	                // 추가 작업 수행 로직 추가
	            } else if (type.equals("update")) {
	                // 업데이트 작업 수행
	                int id = Integer.parseInt((String) change.get("id"));
	                String text = (String) change.get("text");
	                
	                Map<String, Object> upMap = new HashMap<String, Object>();
	                upMap.put("id", id);
	                upMap.put("text", text);
	                
	                update += compTreeSVC.deptUp(upMap);

	            } else if (type.equals("delete")) {
	                // 삭제 작업 수행
	                int id = Integer.parseInt((String) change.get("id"));
	                
	                delete += compTreeSVC.deptDel(id);

	            }
	        }
		}
		
		log.info("result : " + insert + "+" + update + "+" + delete);
		int result = insert + update + delete;
		
		return Integer.toString(result);
	}
	
	//부서 삭제 전 사용중 여부 확인
	@ResponseBody
	@PostMapping("/checkEmp")
	public String checkEmp(@RequestBody int sel) {
		log.debug("sel:::"+sel);
		
		String result = Integer.toString(compTreeSVC.checkEmp(sel));
		log.info("result:::" + result);
		
		return result;
	}
	
	//직위 출력
	@ResponseBody
	@GetMapping("/selectPtn")
	public List<CmCodeVO> selectPtn() {
		
		List<CmCodeVO> list = new ArrayList<CmCodeVO>(); 
		list = compTreeSVC.selectPtn();
		log.info("list:::" + list);
		
		return list;
	}
	
	//직위 삭제 전 사용중 여부 확인
	@ResponseBody
	@PostMapping("/checkPtnEmp")
	public String checkPtnEmp(@RequestBody String sel) {
		log.info("seltest:::"+sel);
		
		int result = compTreeSVC.checkPtnEmp(sel);
		log.info("result:::" + result);
		
		return result + "";
	}
	
	//직위설정 저장버튼 클릭시
	@ResponseBody
	@PostMapping("/ptnUp")
	public String ptnUp(@RequestBody List<CmCodeVO> CmCodeList) {
		
		log.info("CmCodeList:::" + CmCodeList);
		
		int insert = 0;
		int update = 0;
		int delete = 0;
		
		for (CmCodeVO cmCodeVO : CmCodeList) {
			if(cmCodeVO.getType().equals("add")) {
				insert += compTreeSVC.ptnAdd(cmCodeVO);
			}
			if(cmCodeVO.getType().equals("update")) {
				update += compTreeSVC.ptnUp(cmCodeVO);
			}
			if(cmCodeVO.getType().equals("delete")) {
				delete += compTreeSVC.ptnDel(cmCodeVO);
			}
		}
		
		log.info("result : " + insert + "+" + update + "+" + delete);
		int result = insert + update + delete;
		
		return result+"";
	}
	
	//직책 출력
	@ResponseBody
	@GetMapping("/selectPosition")
	public List<CmCodeVO> selectPosition() {
		
		List<CmCodeVO> list = new ArrayList<CmCodeVO>(); 
		list = compTreeSVC.selectPosition();
		log.info("list:::" + list);
		
		return list;
	}
	
	//직책 삭제 전 사용중 여부 확인
	@ResponseBody
	@PostMapping("/checkPositionEmp")
	public String checkPositionEmp(@RequestBody String sel) {
		log.info("seltest:::"+sel);
		
		int result = compTreeSVC.checkPositionEmp(sel);
		log.info("result:::" + result);
		
		return result + "";
	}
	
	//직책설정 저장버튼 클릭시
	@ResponseBody
	@PostMapping("/positionSave")
	public String positionSave(@RequestBody List<CmCodeVO> CmCodeList) {
		
		log.info("CmCodeList:::" + CmCodeList);
		
		int insert = 0;
		int update = 0;
		int delete = 0;
		
		for (CmCodeVO cmCodeVO : CmCodeList) {
			if(cmCodeVO.getType().equals("add")) {
				insert += compTreeSVC.positionAdd(cmCodeVO);
			}
			if(cmCodeVO.getType().equals("update")) {
				update += compTreeSVC.positionUp(cmCodeVO);
			}
			if(cmCodeVO.getType().equals("delete")) {
				delete += compTreeSVC.positionDel(cmCodeVO);
			}
		}
		
		log.info("result : " + insert + "+" + update + "+" + delete);
		int result = insert + update + delete;
		
		return result+"";
	}
	
	//직무 출력
	@ResponseBody
	@GetMapping("/selectJob")
	public List<CmCodeVO> selectJob() {
		
		List<CmCodeVO> list = new ArrayList<CmCodeVO>(); 
		list = compTreeSVC.selectJob();
		log.info("list:::" + list);
		
		return list;
	}
	
	//직무 삭제 전 사용중 여부 확인
	@ResponseBody
	@PostMapping("/checkJobEmp")
	public String checkJobEmp(@RequestBody String sel) {
		log.info("seltest:::"+sel);
		
		int result = compTreeSVC.checkJobEmp(sel);
		log.info("result:::" + result);
		
		return result + "";
	}
	
	//직무설정 저장버튼 클릭시
	@ResponseBody
	@PostMapping("/jobSave")
	public String jobSave(@RequestBody List<CmCodeVO> CmCodeList) {
		
		log.info("CmCodeList:::" + CmCodeList);
		
		int insert = 0;
		int update = 0;
		int delete = 0;
		
		for (CmCodeVO cmCodeVO : CmCodeList) {
			if(cmCodeVO.getType().equals("add")) {
				insert += compTreeSVC.jobAdd(cmCodeVO);
			}
			if(cmCodeVO.getType().equals("update")) {
				update += compTreeSVC.jobUp(cmCodeVO);
			}
			if(cmCodeVO.getType().equals("delete")) {
				delete += compTreeSVC.jobDel(cmCodeVO);
			}
		}
		
		log.info("result : " + insert + "+" + update + "+" + delete);
		int result = insert + update + delete;
		
		return result+"";
	}
	
	//직급 출력
	@ResponseBody
	@GetMapping("/selectGrd")
	public List<CmCodeVO> selectGrd() {
		
		List<CmCodeVO> list = new ArrayList<CmCodeVO>(); 
		list = compTreeSVC.selectGrd();
		log.info("list:::" + list);
		
		return list;
	}
	
	//직급 삭제 전 사용중 여부 확인
	@ResponseBody
	@PostMapping("/checkGrdEmp")
	public String checkGrdEmp(@RequestBody String sel) {
		log.info("seltest:::"+sel);
		
		int result = compTreeSVC.checkGrdEmp(sel);
		log.info("result:::" + result);
		
		return result + "";
	}
	
	//직급설정 저장버튼 클릭시
	@ResponseBody
	@PostMapping("/grdSave")
	public String grdSave(@RequestBody List<CmCodeVO> CmCodeList) {
		
		log.info("CmCodeList:::" + CmCodeList);
		
		int insert = 0;
		int update = 0;
		int delete = 0;
		
		for (CmCodeVO cmCodeVO : CmCodeList) {
			if(cmCodeVO.getType().equals("add")) {
				insert += compTreeSVC.grdAdd(cmCodeVO);
			}
			if(cmCodeVO.getType().equals("update")) {
				update += compTreeSVC.grdUp(cmCodeVO);
			}
			if(cmCodeVO.getType().equals("delete")) {
				delete += compTreeSVC.grdDel(cmCodeVO);
			}
		}
		
		log.info("result : " + insert + "+" + update + "+" + delete);
		int result = insert + update + delete;
		
		return result+"";
	}

}
