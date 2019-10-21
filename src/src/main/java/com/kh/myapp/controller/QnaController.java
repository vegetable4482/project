package com.kh.myapp.controller;

import java.util.ArrayList;
import java.util.List;

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

import com.kh.myapp.common.Code;
import com.kh.myapp.qna.dto.QnaDTO;
import com.kh.myapp.qna.service.QnaSvc;

@Controller
@RequestMapping("/qna")
public class QnaController {

	private static final Logger logger
	= LoggerFactory.getLogger(QnaController.class);
	
	@Inject
	private QnaSvc qnaSvc;
	
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
	
	//1:1 문의글 양식
	@GetMapping("/main")
	public String qnamain() {
		
		return "/bbs/QBmainForm";
	}
	//1:1 문의글 양식
	@GetMapping("/writeForm")
	public String qna(Model model) {
		
		model.addAttribute("qnaDTO", new QnaDTO());
		return "/bbs/QBwriteForm";
	}

	//1:1 문의글 쓰기 처리
	@PostMapping("/write")
	public String writeOk(@Valid @ModelAttribute("qnaDTO") QnaDTO qnaDTO, BindingResult result) {
		logger.info("writeOk 호출됨!");
		
		if(result.hasErrors()) {
			return "/bbs/QBwriteForm";
		}
		
		qnaSvc.qnainsert(qnaDTO);
		
		return "redirect:/qna/list";
	}
	
	//글목록조회
	@GetMapping({"/list",
							 "/list/{reqPage}",
							 "/list/{reqPage}/{searchType}",
							 "/list/{reqPage}/{searchType}/{keyword}"})
				public String list2(
				@PathVariable(required=false) String reqPage, 
				@PathVariable(required=false) String searchType,
				@PathVariable(required=false) String keyword,Model model) {
				
				logger.info("list 호출됨!");
				qnaSvc.list(reqPage, searchType, keyword, model);
				return "/bbs/QBlistForm";
				}
	
	//글 상세조회
	@GetMapping("/read/{page}/{qnabnum}")
	public String read(@PathVariable String qnabnum, 
										 @PathVariable String page,
										 Model model) {
		
		QnaDTO qnaDTO = qnaSvc.view(qnabnum);		
		model.addAttribute("qnaDTO", qnaDTO);
		model.addAttribute("page", page);
		return "/bbs/QBreadForm";
	}
	
	//답글 양식
	@GetMapping("/reply/{page}/{qnabnum}")
	public String reply(@PathVariable String qnabnum, 
											@PathVariable String page,
											Model model) {
		
		QnaDTO qnaDTO = qnaSvc.view(qnabnum);
		model.addAttribute("qnaDTO",qnaDTO);
		model.addAttribute("page", page);
		return "/bbs/QBreplyForm";
	}
	//답글 처리
	@PostMapping("/reply")
	public String reply(@Valid @ModelAttribute QnaDTO qnaDTO, BindingResult result) {
		logger.info("reply 호출됨!");
		if(result.hasErrors()) {
			logger.info(result.toString());
			return "/bbs/QBreplyForm";
		}
		
		qnaSvc.reply(qnaDTO);
		
		return "redirect:/qna/list";
	}

}
