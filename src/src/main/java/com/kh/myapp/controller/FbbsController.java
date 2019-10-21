package com.kh.myapp.controller;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
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

import com.kh.myapp.bbs.dao.FbbsDAO;
import com.kh.myapp.bbs.dto.FbbsDTO;
import com.kh.myapp.bbs.service.FbbsSVC;
import com.kh.myapp.common.Code;

@Controller
@RequestMapping("/fbbs")
public class FbbsController {

	private static Logger logger = LoggerFactory.getLogger(FbbsController.class);
	
	@Inject
	FbbsSVC fbbsSVC;
	
	@ModelAttribute
	public void initData(Model model) {
		//검색유형
		List<Code> searchType = new ArrayList<>();
		searchType.add(new Code("TC","제목+내용"));
		searchType.add(new Code("T","제목"));
		searchType.add(new Code("C","내용"));
		searchType.add(new Code("N","작성자"));
		searchType.add(new Code("I","아이디"));
		model.addAttribute("searchType", searchType);
	}
	
	//글쓰기양식
	@GetMapping("/writeForm")
	public String write(Model model) { 
		logger.info("write 호출됨!");
		
		model.addAttribute("fbbsDTO", new FbbsDTO());
		return "/fbbs/writeForm";
	}
	
	//글쓰기처리
	@PostMapping("/write")
	public String writeOk(
			@Valid @ModelAttribute("fbbsDTO") FbbsDTO fbbsDTO, BindingResult result) {
		
		logger.info("writeOk 호출됨!");
	
		if(result.hasErrors()) {
			return "/fbbs/writeForm";
		}
		
		fbbsSVC.write(fbbsDTO);
		
		return "redirect:/fbbs/list";
	}
	

	@GetMapping({"/list",
							 "/list/{reqPage}",
							 "/list/{reqPage}/{searchType}",
							 "/list/{reqPage}/{searchType}/{keyword}"})
	public String list2(
			@PathVariable(required=false) String reqPage, 
			@PathVariable(required=false) String searchType,
			@PathVariable(required=false) String keyword,Model model) {
		
		logger.info("list 호출됨!");
		fbbsSVC.list(reqPage, searchType, keyword, model);
		return "/fbbs/list";
	}
	
	//글 상세조회
	@GetMapping("/read/{page}/{freebnum}")
	public String read(@PathVariable String freebnum, 
										 @PathVariable String page,
										 Model model) {
		
		FbbsDTO fbbsDTO = fbbsSVC.view(freebnum);		
		model.addAttribute("fbbsDTO", fbbsDTO);
		model.addAttribute("page", page);
		return "/fbbs/readForm";
	}
	
	//글 삭제처리
	@GetMapping("/delete/{page}/{freebnum}")
	public String delete(@PathVariable String freebnum,
											 @PathVariable String page) {
		logger.info("delete 호출됨!");				
		fbbsSVC.delete(freebnum);
		return "redirect:/fbbs/list/"+page;
	}
	
	//글 수정처리
	@PostMapping("/modify/{page}")
	public String modify(@Valid @ModelAttribute FbbsDTO fbbsDTO,
											 BindingResult result,
											 @PathVariable String page) {
		logger.info("modify 호출됨!");	
		if(result.hasErrors()) {
			logger.info("result "+result.toString());
			return "/fbbs/readForm";
		}		
//		logger.info("bbsDTO: " + bbsDTO);
		fbbsSVC.modify(fbbsDTO);
		return "redirect:/fbbs/read/"+page+"/"+fbbsDTO.getFreebnum();
	}
	
	
}
















