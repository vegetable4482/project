package com.kh.myapp.controller;


import java.util.ArrayList;
import java.util.List;

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
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.myapp.common.Code;
import com.kh.myapp.company.dto.CompanyDTO;
import com.kh.myapp.matchingresult.dto.ResultDTO;
import com.kh.myapp.matchingresult.service.MatchingSVC;
import com.kh.myapp.request.dto.RequestDTO;
import com.kh.myapp.request.service.RequestSvc;

@Controller
@RequestMapping("/request")
public class RequestController {

	private static final Logger logger
	= LoggerFactory.getLogger(RequestController.class);
	
	@Inject
	private RequestSvc requestSvc;
	@Inject
	MatchingSVC matchingSvc;
	
	@ModelAttribute
	public void initData(Model model) {
		//공사유형
		List<Code> consttype = new ArrayList<>();
		consttype.add(new Code("아파트","아파트"));
		consttype.add(new Code("빌라","빌라"));
		consttype.add(new Code("주택","주택"));

		
		model.addAttribute("consttype", consttype);
		
		//인테리어스타일
		List<Code> conststyle = new ArrayList<>();
		conststyle.add(new Code("모던","모던"));
		conststyle.add(new Code("클래식","클래식"));
		conststyle.add(new Code("빈티지","빈티지"));
		conststyle.add(new Code("인더스트리얼","인더스트리얼"));
		conststyle.add(new Code("미니멀리즘","미니멀리즘"));
		
		model.addAttribute("conststyle", conststyle);
		
	}
	
	
	@GetMapping("/test")
	public String Test(Model model) {
		model.addAttribute("edto",new RequestDTO());
		return "/request/test";
	}
	
	//견적신청조회 양식
	@GetMapping("/requestForm")
	public String requestForm(Model model) {
		model.addAttribute("edto",new RequestDTO());
		return "/request/EBWriteForm";
	}
	
	//견적신청 처리
	@PostMapping("/request")
	public String request(@Valid @ModelAttribute("edto") RequestDTO requestDTO,
			BindingResult result,
			Model model) {
		
		logger.info(result.toString());
		if(result.hasErrors()) {
			logger.info("견적신청 오류발생");
			return "/request/requestForm";
			
		}
		logger.info(requestDTO.toString());
		int cnt = requestSvc.insert(requestDTO);
		logger.info(requestDTO.toString());
		
	  int cnt2 = matchingSvc.insert(requestDTO);
		if((cnt == 0 || cnt2 == 0)) {
			logger.info("견적신청 중에 문제가 발생하였습니다.");
			return "/request/EBWriteForm";
		}else {
			return "redirect:/";
		}
	}
	
	//내견적상세조회
	@GetMapping("/read/{formnum}")
	public String read(@PathVariable String formnum, Model model) {
		
		logger.info("mformnum" + formnum);
		RequestDTO requestDTO = requestSvc.getRequest(formnum);
		logger.info("requestDTO : " + requestDTO );
		List <ResultDTO> result =  matchingSvc.list(formnum);
		logger.info("resultDTO : " + result);
		
		model.addAttribute("requestDTO",requestDTO);
		model.addAttribute("result",result);
		
		return "/request/EBReadForm";
	}
	
	//견적목록
	@GetMapping("/requestMember/{custid:.+}")
	public String requestMember(@PathVariable String custid, Model model) {
		logger.info("custid:" + custid);
		
		List<RequestDTO> list = requestSvc.list(custid);
		model.addAttribute("requestDTO",list);
		logger.info("requestDTO:" + list);
		
		return "/request/EBListForm";		
	}
	
	
	
	
	//업체:내견적상세조회
	@GetMapping("/read/company/{formnum}")
	public String readCompany(@PathVariable String formnum,Model model) {
		RequestDTO requestDTO = requestSvc.getRequest(formnum);
		model.addAttribute("requestDTO",requestDTO);
		
		return "/request/CEBReadForm";
	}
	
	
	
	//업체:견적목록
	@GetMapping("/requestMember2/{cmembernum:.+}")
	public String requestCompany(@PathVariable String cmembernum, Model model) {
		logger.info("cmembernum:" + cmembernum);
		List<RequestDTO> list = requestSvc.clist(cmembernum);
		System.out.println("으아아아아");
		model.addAttribute("clist",list);
		logger.info("clist : " + list);
		
		return "/request/CEBListForm";		
	}
	
	
	

	
//관리자:견적서 목록 조회
	@GetMapping("/estimateList")
	public String estimate(Model model) {
		
		List<RequestDTO> list = requestSvc.getEstimateList();
		model.addAttribute("estimateList", list);
		
		logger.info(list.toString());
		
		return "/request/EmanageForm";
	}
	
	
	
}