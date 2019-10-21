package com.kh.myapp.controller;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
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

import com.kh.myapp.rebbs.dto.REbbsDTO;
import com.kh.myapp.rebbs.service.REbbsSVC;



@Controller
@RequestMapping("/rebbs")
public class RebbsController {

	private static Logger logger = LoggerFactory.getLogger(RebbsController.class);
	
	@Inject
	REbbsSVC rebbsSVC;
	
	@ModelAttribute
	public void initData(Model model) {
	// 평점 옵션
	Map<Integer, String> ratingOptions = new HashMap<>();
	ratingOptions.put(0, "☆☆☆☆☆");
	ratingOptions.put(1, "★☆☆☆☆");
	ratingOptions.put(2, "★★☆☆☆");
	ratingOptions.put(3, "★★★☆☆");
	ratingOptions.put(4, "★★★★☆");
	ratingOptions.put(5, "★★★★★");
	model.addAttribute("ratingOptions", ratingOptions);
	}

	//글쓰기양식
	@GetMapping("/write")
	public String write(Model model) { 
		logger.info("write 호출됨!");
		
	model.addAttribute("rebbsDTO", new REbbsDTO());
		return "/rebbs/reviewwriteForm";
	}
	
	//글쓰기처리
	@PostMapping("/write")
	public String writeOk(
			@Valid @ModelAttribute("rebbsDTO") REbbsDTO rebbsDTO, BindingResult result) {
		
		logger.info("writeOk 호출됨!");
		logger.info("rebbsDTO : " + rebbsDTO.toString());
		logger.info("회원 이미지 첨부 파일명 : " + rebbsDTO.getFile().getOriginalFilename());
	
		if(result.hasErrors()) {
			return "/rebbs/reviewwriteForm";
		}
		
		rebbsSVC.write(rebbsDTO);
		
		return "redirect:/rebbs/list";
	}
	
//	//글목록조회
//	@GetMapping("/list")
//	public String list(HttpServletRequest request, Model model) {
//		logger.info("list 호출됨!");
//		bbsSVC.list(request, model);
//		return "/bbs/list";
//	}
	
	@GetMapping({"/list",
							 "/list/{reqPage}",
							 "/list/{reqPage}/{searchType}",
							 "/list/{reqPage}/{searchType}/{keyword}"})
	public String list2(
			@PathVariable(required=false) String reqPage, 
			@PathVariable(required=false) String searchType,
			@PathVariable(required=false) String keyword,Model model) {
		
		logger.info("list 호출됨!");
		rebbsSVC.list(reqPage, searchType, keyword, model);
		return "/rebbs/reviewlist";
	}
	
	//글 상세조회
	@GetMapping("/read/{page}/{reviewbnum}")
	public String read(@PathVariable String reviewbnum, 
										 @PathVariable String page,
										 Model model) {
		
		REbbsDTO rebbsDTO = rebbsSVC.view(reviewbnum);		
		model.addAttribute("rebbsDTO", rebbsDTO);
		model.addAttribute("page", page);
		return "/rebbs/reviewreadForm";
	}
	
	//글 삭제처리
	@GetMapping("/delete/{page}/{reviewbnum}")
	public String delete(@PathVariable String reviewbnum,
											 @PathVariable String page) {
		logger.info("delete 호출됨!");				
		rebbsSVC.delete(reviewbnum);
		return "redirect:/rebbs/list/"+page;
	}
	
	//글 수정처리
	@PostMapping("/modify/{page}")
	public String modify(@Valid @ModelAttribute REbbsDTO rebbsDTO,
											 BindingResult result,
											 @PathVariable String page) {
		logger.info("modify 호출됨!");	
		logger.info("rebbsDTO : " + rebbsDTO.toString());
		logger.info("회원 이미지 첨부 파일명 : " + rebbsDTO.getFile().getOriginalFilename());
		
		if(result.hasErrors()) {
			logger.info("result "+result.toString());
			return "/rebbs/reviewreadForm";
		}		
//		logger.info("bbsDTO: " + bbsDTO);
		rebbsSVC.modify(rebbsDTO);
		return "redirect:/rebbs/read/"+page+"/"+rebbsDTO.getReviewbnum();
	}
	
}