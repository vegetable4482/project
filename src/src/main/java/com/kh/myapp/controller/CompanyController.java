package com.kh.myapp.controller;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.myapp.common.Code;
import com.kh.myapp.company.dto.CPasswdDTO;
import com.kh.myapp.company.dto.CompanyDTO;
import com.kh.myapp.company.service.CompanySvc;
import com.kh.myapp.login.service.LoginSvc;

@Controller
@RequestMapping("/company")
public class CompanyController {

	private static final Logger logger
	= LoggerFactory.getLogger(CompanyController.class);

	@Inject
	private CompanySvc companySvc;
	@Inject
	private LoginSvc loginSvc;

	@ModelAttribute
	public void initData(Model model) {
		//지역
		List<Code> constarea = new ArrayList<>();
		constarea.add(new Code("서울","서울"));
		constarea.add(new Code("경기","경기"));
		constarea.add(new Code("인천","인천"));
		constarea.add(new Code("대전","대전"));
		constarea.add(new Code("충북","충북"));
		constarea.add(new Code("충남","충남"));
		constarea.add(new Code("대구","대구"));
		constarea.add(new Code("부산","부산"));
		constarea.add(new Code("울산","울산"));
		constarea.add(new Code("제주","제주"));
		
		model.addAttribute("constarea",constarea);
		
//		//성별
//		List<Code> gender =new ArrayList<>();
//		gender.add(new Code("여성","여성"));
//		gender.add(new Code("남성","남성"));
//		
//		model.addAttribute("gender",gender);
	}
//회원가입 양식
	@GetMapping("/companyJoinForm")
	public String companyJoinForm(Model model) {
		logger.info("cJoinForm() 호출");
		model.addAttribute("cdto", new CompanyDTO());	
		return "/company/CjoinForm";
	}
	
	//회원등록 처리
	@PostMapping("/cmemberJoin")
	public String cmemberJoin(
			@Valid @ModelAttribute("cdto") CompanyDTO companyDTO,
			BindingResult result,
			Model model) {
			
		String viewName = null;
		
		logger.info("cmemberJoin()호출");
		logger.info(companyDTO.toString());
		
		logger.info(result.toString());
		if(result.hasErrors()) {
			logger.info("회원가입시 오류발생");
			return "/company/CjoinForm";
		}
		
		
		//회원등록
		int cnt = companySvc.insert(companyDTO);
		if(cnt == 1) {
			viewName = "redirect:/";
		}else {
			viewName = "/member/CjoinForm";
		}
		return viewName;
	}

	//아이디 중복체크
	@ResponseBody
	@RequestMapping("/cidcheck")
  public Map<Object,Object> cidcheck(@RequestBody String cid) {
		int count = 0;
   
		Map<Object, Object> map = new HashMap<Object, Object>();

    count = companySvc.idcheck(cid);  
    logger.info("count:" + count);   
    map.put("count", count);

    return map;
  }
	
	//업체 수정 전 비밀번호 체크
	@GetMapping("/cmemberFirstModify/{cid:.+}")
	public String cmemberFirstModify(@PathVariable String cid) {
		logger.info("cid:"+ cid);
		return "/member/cmemberFirstModifyForm";			
	}
	

	//업체 수정 전 비밀번호 체크 처리
	  @PostMapping("/cmemberFirstModify") 
	  public String cmemberFirstModify (@RequestParam String cid, @RequestParam("cpw") String cpw) { 
	  	int result = companySvc.modify_first(cid,cpw); 
	  	logger.info("cid: " + cid );
	  	logger.info("cpw: " + cpw );
	  	
	  	logger.info("result : " + result);
	  	if(result == 1 ) { 
	  		return "redirect:/company/cmemberModifyForm/"+cid;}
	  	else { 
	  		return "/member/cmemberFirstModifyForm"; } 
	  	}

	
	//업체수정
	@GetMapping("/cmemberModifyForm/{cid:.+}")
	public String cmemberModifyForm(@PathVariable String cid, Model model) {
		logger.info("cid:"+cid);
		
		CompanyDTO companyDTO = companySvc.getMember(cid);
		model.addAttribute("companyDTO", companyDTO);
		logger.info("companyDTO:"+ companyDTO);
		
		return "/member/CmodifyForm";
	}
	
	//업체수정처리
	@PostMapping("/cmemberModify")
	public String cmemberModify(CompanyDTO companyDTO, HttpSession session) {
		
		int result = companySvc.modify(companyDTO);
		logger.info("수정처리결과:"+ result);
		
		if(result == 1) {
			CompanyDTO cdto = loginSvc.getCompany(
					companyDTO.getCid(), ((CompanyDTO)session.getAttribute("user2")).getCpw());
			
			//기존 회원정보  제거 후 변경된 정보로 반영
			session.removeAttribute("user2");
			session.setAttribute("user2", cdto);
			
			return "redirect:/";
		}else {
			return "/company/cmemberModifyForm/"+companyDTO.getCid();
		}
	}
	
	//업체비밀번호 변경 양식
	@GetMapping("/companychangePwForm")
	public String companychangePwForm(Model model) {
		model.addAttribute("companypasswdDTO",new CPasswdDTO());
		
		return "/member/companychangePwForm";
	}
	
//업체비밀번호변경 처리
	@PostMapping("/companychangePw")
	public String changePw(@Valid @ModelAttribute CPasswdDTO cpasswdDTO,
			BindingResult result) {
		
		//바인딩 오류시
		if(result.hasErrors()) {
			logger.info(result.toString());
			return "/member/companychangePwForm";
		}
		
		//비밀번호변경
		int cnt = companySvc.changePw(cpasswdDTO);
		
		if(cnt == 1) {		
			return "redirect:/";
		}
		return "/member/companychangePwForm";
	}
	
	//업체탈퇴화면
	@GetMapping("/companyOutForm")
	public String companyOutForm() {
		
		return "/member/companyOutForm";
	}
	//업체삭제처리(회원용)
	@PostMapping("/companyOut")
	public String companyOut(
			@RequestParam("cid") String cid,
			@RequestParam("cpw") String cpw,
			HttpSession session) {
		
		int result = companySvc.delete(cid,cpw);
		logger.info("업체탈퇴처리결과:" + result);
		
		if(result == 1) {
			session.invalidate();
			return "redirect:/";
						
		}
		return "/member/companyOutForm";
	}
	
	
	//기업 목록 조회
	@GetMapping("/companyList")
	public String company(Model model) {
		
		List<CompanyDTO> list = companySvc.getMemberList();
		model.addAttribute("companyList", list);
		
		logger.info(list.toString());
		
		return "/company/CmanageForm";
	}
	
	//회원 승인 처리
	@GetMapping("/companyMemberModify/{cid:.+}")
	public String companyModify(@PathVariable String cid) {
		
		int result = companySvc.modify(cid);
		logger.info("기업회원승인쿼리실행수결과:"+ result);
		
		return "redirect:/company/companyList";
	}
	
	//기업 회원 삭제
	@GetMapping("/companyMemberDelete/{cid:.+}")
	public String companyDelete(@PathVariable String cid) {
		
		int result = companySvc.adminDelete(cid);
		logger.info("기업회원삭제쿼리실행수결과 : " + result);
		
		return "redirect:/company/companyList";
	}
}
