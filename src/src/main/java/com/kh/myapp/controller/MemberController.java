package com.kh.myapp.controller;

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

import com.kh.myapp.login.service.LoginSvc;
import com.kh.myapp.member.dto.MemberDTO;
import com.kh.myapp.member.dto.PasswdDTO;
import com.kh.myapp.member.service.MemberSvc;

@Controller
@RequestMapping("/member")
public class MemberController {

	private static final Logger logger
		= LoggerFactory.getLogger(MemberController.class);
	
	@Inject
	private MemberSvc memberSvc;
	@Inject
	private LoginSvc loginSvc;
	
	
	//회원가입 양식
	@GetMapping("/memberJoinForm")
	public String memberJoinForm(Model model) {
		logger.info("memberJoinForm() 호출");
		model.addAttribute("mdto", new MemberDTO());	
		return "/member/MjoinForm";
	}
	

	//회원등록 처리
	@PostMapping("/memberJoin")
	public String memberJoin(
			@Valid @ModelAttribute("mdto") MemberDTO memberDTO,
			BindingResult result,
			Model model) {

		String viewName = null;
		
		logger.info("memberJoin()호출");
		logger.info(memberDTO.toString());
		
		logger.info(result.toString());
		if(result.hasErrors()) {
			logger.info("회원가입시 오류발생");
			return "/member/MjoinForm";
		}
		
		//회원중복체크
		if(memberSvc.getMember(memberDTO.getId()) != null) {
			viewName = "/member/memberJoinForm";
			model.addAttribute("svr_msg", "중복된 아이디 입니다.");
			return viewName;
		}
		
		//회원등록
		int cnt = memberSvc.insert(memberDTO);
		if(cnt == 1) {
			viewName = "redirect:/";
			logger.info("회원등록 성공");
		}else {
			logger.info("회원등록 실패");
			viewName = "/member/memberJoinForm";
		}
		return viewName;
	}

	//아이디 중복체크
	@ResponseBody
	@RequestMapping("/idcheck")
  public Map<Object,Object> idcheck(@RequestBody String id) {
		int count = 0;
   
		Map<Object, Object> map = new HashMap<Object, Object>();

    count = memberSvc.idcheck(id);  
    logger.info("count:" + count);   
    map.put("count", count);

    return map;
  }


	//회원목록조회
	@GetMapping("/memberList")
	public String member(Model model) {
		
			List<MemberDTO> list = memberSvc.getMemberList();
			model.addAttribute("memberList", list);
		
			logger.info(list.toString());
			
		return "/member/MmanageForm";
	}
	
	//회원 수정 전 비밀번호 체크
	@GetMapping("/PWchkForm/{id:.+}")
	public String memberFirstModifyForm(@PathVariable String id) {
		logger.info("Pwchk id:"+ id);
		return "/member/PWchkForm";			
	}
	

	//회원 수정 전 비밀번호 체크 처리
	  @PostMapping("/PWchk") 
	  public String memberFirstModify (@RequestParam String id, @RequestParam("pw") String pw) { 
	  	int result = memberSvc.modify_first(id,pw); 
	  	logger.info("id: " + id );
	  	logger.info("pw: " + pw );
	  	logger.info("result : " + result);
	  	if(result == 1 ) { 
	  		return "redirect:/member/MmodifyForm/"+id;}
	  	else { 
	  		return "/member/PWchkForm"; } 
	  	}

	
	//회원수정
	@GetMapping("/MmodifyForm/{id:.+}")
	public String memberModifyForm(@PathVariable String id, Model model) {
		logger.info("id:"+id);
		
		MemberDTO memberDTO = memberSvc.getMember(id);
		model.addAttribute("memberDTO", memberDTO);
		logger.info("memberDTO:"+ memberDTO);
		
		return "/member/MmodifyForm";
	}
	
	//회원수정처리
	@PostMapping("/memberModify")
	public String memberModify(MemberDTO memberDTO, HttpSession session) {
		
		int result = memberSvc.modify(memberDTO);
		logger.info("수정처리결과:"+ result);
		
		if(result == 1) {
			MemberDTO mdto = loginSvc.getMember(
					memberDTO.getId(), ((MemberDTO)session.getAttribute("user")).getPw());
			
			//기존 회원정보  제거 후 변경된 정보로 반영
			session.removeAttribute("user");
			session.setAttribute("user", mdto);
			
			return "redirect:/";
		}else {
			return "/member/MmodifyForm/"+memberDTO.getId();
		}
	}
	//회원탈퇴화면
	@GetMapping("/MoutForm")
	public String memberOut() {
		
		return "/member/MoutForm";
	}
	//회원삭제처리(회원용)
	@PostMapping("/Mout")
	public String memberDelete(
			@RequestParam("id") String id,
			@RequestParam("pw") String pw,
			HttpSession session) {
		
		int result = memberSvc.delete(id,pw);
		logger.info("회원탈퇴처리결과:" + result);
		
		if(result == 2) {
			session.invalidate();
			return "redirect:/";
						
		}
		return "/member/MoutForm";
	}
	
	//회원삭제처리(관리자용)
	@GetMapping("/memberDelete/{id:.+}")
	public String memberDelete(@PathVariable String id) {
		
		int result = memberSvc.delete(id);
		logger.info("삭제처리결과:" + result);
		
		return "redirect:/member/memberList";
	}	
	
	
	//회원비밀번호 변경 양식
	@GetMapping("/PWmodifyForm")
	public String changePwForm(Model model) {

		model.addAttribute("passwdDTO",new PasswdDTO());
		return "/member/PWmodifyForm";
	}
	
	
	//회원비밀번호변경 처리
	@PostMapping("/changePw")
	public String changePw(@Valid @ModelAttribute PasswdDTO passwdDTO,
			BindingResult result) {
		
		//바인딩 오류시
		if(result.hasErrors()) {
			logger.info(result.toString());
			return "/member/PWmodifyForm";
		}
		
		//비밀번호변경
		int cnt = memberSvc.changePw(passwdDTO);
		
		if(cnt == 1) {		
			return "redirect:/";
		}
		return "/member/PWmodifyForm";
	}
	
}









