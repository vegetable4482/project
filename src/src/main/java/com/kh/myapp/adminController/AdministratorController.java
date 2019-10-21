package com.kh.myapp.adminController;



import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.myapp.login.dto.AdministratorDTO;
import com.kh.myapp.login.service.LoginSvc;



@Controller
@RequestMapping("/administrator")
public class AdministratorController {

	static private final Logger logger = LoggerFactory.getLogger(AdministratorController.class);
	

	@Inject
	private LoginSvc loginSvc;
	
	
	
	//로그인 폼 호출 로직
	@GetMapping("/adminMain")
	public String adminMain() {
		
		return "/administrator/adminMain";
	}
	
	//로그인 폼 호출 로직
	@GetMapping("/administratorLogin")
	public String administratorLogin() {
		
		return "/administrator/login";
	}
	
	//로그인 시도 관련 로직
	@PostMapping("/loginAccess")
	public String loginAccess(@RequestParam("aId") String aId,
														@RequestParam("aPw") String aPw,
														HttpSession session) {
	
		logger.info("관리자 로그인 시도 : id => {}, pw => {}", aId, aPw);
		
		//로그인 정보가 관리자면 adminCheck값이 1이 될 것.
		int adminCheck = loginSvc.isAdministrator(aId, aPw);
		
		//관리자 정보를 session에 저장함.
		if(adminCheck == 1) {
			AdministratorDTO adto = loginSvc.getAdministrator(aId, aPw);
			session.setAttribute("administrator", adto);
			
			logger.info("관리자 로그인 성공 : 관리자 {}님 환영합니다.", adto.getAName());
			
			return "redirect:/administrator/adminMain";
		
		} else {
			
			return "/administrator/login";
		}
		
	}
	
	//로그아웃 시도 관련 로직
	@GetMapping("/logoutAccess")
	public String logoutAccess(HttpSession session) {
		
		session.invalidate();
		
		return "redirect:/administrator/adminMain";
	}
	
}
