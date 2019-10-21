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
import com.kh.myapp.intbbs.dto.IntDTO;
import com.kh.myapp.intbbs.service.IntSVC;

@Controller
@RequestMapping("/intbbs")
public class IntController {

	private static Logger logger = LoggerFactory.getLogger(IntController.class);
	
	@Inject
	IntSVC intSVC;
	
	@ModelAttribute
	public void initData2(Model model) {
		//검색유형
		logger.info("검색 호출됨2!");
		List<Code> addsearch = new ArrayList<>();
		
		addsearch.add(new Code("BAA","아파트+전체+전체"));
		addsearch.add(new Code("CAA","빌라+전체+전체"));
		addsearch.add(new Code("DAA","주택+전체+전체"));
		addsearch.add(new Code("ABA","전체+모던+전체"));
		addsearch.add(new Code("ACA","전체+클래식+전체"));
		addsearch.add(new Code("ADA","전체+빈티지+전체"));
		addsearch.add(new Code("AEA","전체+인더스트리얼+전체"));
		addsearch.add(new Code("AFA","전체+미니멀리즘+전체"));
		addsearch.add(new Code("AAB","전체+전체+30평이하"));
		addsearch.add(new Code("AAC","전체+30평~60평+전체"));
		addsearch.add(new Code("AAD","전체+60평이상+전체"));
		addsearch.add(new Code("BBA","아파트+모던+전체"));
		addsearch.add(new Code("CBA","빌라+모던+전체"));
		addsearch.add(new Code("DBA","주택+모던+전체"));
		addsearch.add(new Code("BCA","아파트+클래식+전체"));
		addsearch.add(new Code("CCA","빌라+클래식+전체"));
		addsearch.add(new Code("DCA","주택+클래식+전체"));
		addsearch.add(new Code("BDA","아파트+빈티지+전체"));
		addsearch.add(new Code("CDA","빌라+빈티지+전체"));
		addsearch.add(new Code("DDA","주택+빈티지+전체"));
		addsearch.add(new Code("BEA","아파트+인더스트리얼+전체"));
		addsearch.add(new Code("CEA","빌라+인더스트리얼+전체"));
		addsearch.add(new Code("DEA","주택+인더스트리얼+전체"));
		addsearch.add(new Code("BFA","아파트+미니멀리즘+전체"));
		addsearch.add(new Code("CFA","빌라+미니멀리즘+전체"));
		addsearch.add(new Code("DFA","주택+미니멀리즘+전체"));
		addsearch.add(new Code("ABB","전체+모던+30평이하"));
		addsearch.add(new Code("ACB","전체+클래식+30평이하"));
		addsearch.add(new Code("ADB","전체+빈티지+30평이하"));
		addsearch.add(new Code("AEB","전체+인더스트리얼+30평이하"));
		addsearch.add(new Code("AFB","전체+미니멀리즘+30평이하"));
		addsearch.add(new Code("ABC","전체+모던+30~60평"));
		addsearch.add(new Code("ACC","전체+클래식+30평60평"));
		addsearch.add(new Code("ADC","전체+빈티지+30평60평"));
		addsearch.add(new Code("AEC","전체+인더스트리얼+30평60평"));
		addsearch.add(new Code("AFC","전체+미니멀리즘+30평60평"));
		addsearch.add(new Code("ABD","전체+모던+60평이상"));
		addsearch.add(new Code("ACD","전체+클래식+60평이상"));
		addsearch.add(new Code("ADD","전체+빈티지+60평이상"));
		addsearch.add(new Code("AED","전체+인더스트리얼+60평이상"));
		addsearch.add(new Code("AFD","전체+미니멀리즘+60평이상"));
		addsearch.add(new Code("BAB","아파트+전체+30평 이하"));
		addsearch.add(new Code("CAB","빌라+전체+30평 이하"));
		addsearch.add(new Code("DAB","주택+전체+30평 이하"));
		addsearch.add(new Code("BAC","아파트+전체+30평~60평"));
		addsearch.add(new Code("CAC","빌라+전체+30평~60평"));
		addsearch.add(new Code("DAC","주택+전체+30평~60평"));
		addsearch.add(new Code("BAD","아파트+전체+60평이상"));
		addsearch.add(new Code("CAD","빌라+전체+60평이상"));
		addsearch.add(new Code("DAD","주택+전체+60평이상"));
		addsearch.add(new Code("BBB","아파트+모던+30평이하"));
		addsearch.add(new Code("CBB","빌라+모던+30평이하"));
		addsearch.add(new Code("DBB","주택+모던+30평이하"));
		addsearch.add(new Code("BCB","아파트+클래식+30평이하"));
		addsearch.add(new Code("CCB","빌라+클래식+30평이하"));
		addsearch.add(new Code("DCB","주택+클래식+30평이하"));
		addsearch.add(new Code("BDB","아파트+빈티지+30평이하"));
		addsearch.add(new Code("CDB","빌라+빈티지+30평이하"));
		addsearch.add(new Code("DDB","주택+빈티지+30평이하"));
		addsearch.add(new Code("BEB","아파트+인더스트리얼+30평이하"));
		addsearch.add(new Code("CEB","빌라+인더스트리얼+30평이하"));
		addsearch.add(new Code("DEB","주택+인더스트리얼+30평이하"));
		addsearch.add(new Code("BFB","아파트+미니멀리즘+30평이하"));
		addsearch.add(new Code("CFB","빌라+미니멀리즘+30평이하"));
		addsearch.add(new Code("DFB","주택+미니멀리즘+30평이하"));
		addsearch.add(new Code("BBC","아파트+모던+30평~60평"));
		addsearch.add(new Code("CBC","빌라+모던+30평~60평"));
		addsearch.add(new Code("DBC","주택+모던+30평~60평"));
		addsearch.add(new Code("BCC","아파트+클래식+30평~60평"));
		addsearch.add(new Code("CCC","빌라+클래식+30평~60평"));
		addsearch.add(new Code("DCC","주택+클래식+30평~60평"));
		addsearch.add(new Code("BDC","아파트+빈티지+30평~60평"));
		addsearch.add(new Code("CDC","빌라+빈티지+30평~60평"));
		addsearch.add(new Code("DDC","주택+빈티지+30평~60평"));
		addsearch.add(new Code("BEC","아파트+인더스트리얼+30평~60평"));
		addsearch.add(new Code("CEC","빌라+인더스트리얼+30평~60평"));
		addsearch.add(new Code("DEC","주택+인더스트리얼+30평~60평"));
		addsearch.add(new Code("BFC","아파트+미니멀리즘+30평~60평"));
		addsearch.add(new Code("CFC","빌라+미니멀리즘+30평~60평"));
		addsearch.add(new Code("DFC","주택+미니멀리즘+30평~60평"));
		addsearch.add(new Code("BBD","아파트+모던+60평이상"));
		addsearch.add(new Code("CBD","빌라+모던+60평이상"));
		addsearch.add(new Code("DBD","주택+모던+60평이상"));
		addsearch.add(new Code("BCD","아파트+클래식+60평이상"));
		addsearch.add(new Code("CCD","빌라+클래식+60평이상"));
		addsearch.add(new Code("DCD","주택+클래식+60평이상"));
		addsearch.add(new Code("BDD","아파트+빈티지+60평이상"));
		addsearch.add(new Code("CDD","빌라+빈티지+60평이상"));
		addsearch.add(new Code("DDD","주택+빈티지+60평이상"));
		addsearch.add(new Code("BED","아파트+인더스트리얼+60평이상"));
		addsearch.add(new Code("CED","빌라+인더스트리얼+60평이상"));
		addsearch.add(new Code("DED","주택+인더스트리얼+60평이상"));
		addsearch.add(new Code("BFD","아파트+미니멀리즘+60평이상"));
		addsearch.add(new Code("CFD","빌라+미니멀리즘+60평이상"));
		addsearch.add(new Code("DFD","주택+미니멀리즘+60평이상"));
		model.addAttribute("addsearch", addsearch);
	}
	
	//글쓰기양식
	@GetMapping("/intwriteForm")
	public String write(Model model) { 
		logger.info("intwriteForm 호출됨!");
		
		model.addAttribute("intDTO", new IntDTO());
		return "/intbbs/intwriteForm";
	}
	
	//글쓰기처리
	@PostMapping("/intwrite")
	public String writeOk(
			@Valid @ModelAttribute("intDTO") IntDTO intDTO, BindingResult result) {
		
//		logger.info("intDTO : " + intDTO.toString());
		logger.info("회원 이미지 첨부 파일명 : " + intDTO.getFile().getOriginalFilename());

		
		logger.info("글쓰기 처리결과:"+ result);
		logger.info("intwriteOk 호출됨!");
	
//		if(result.hasErrors()) {
//			return "/bbs/intwriteForm";
//		}

		intSVC.write(intDTO);
		
		logger.info("intwriteOk2 호출됨!");
		return "redirect:/intbbs/intlist";
	}
	
	//글목록조회
	@GetMapping({"/intlist",
							 "/intlist/{reqPage}",
							 "/intlist/{reqPage}/{addsearch}"})
	public String intlist(
			@PathVariable(required=false) String reqPage, 
			@PathVariable(required=false) String addsearch,Model model){
		logger.info("intlist 호출됨!");
		
		

		List<IntDTO> intDTO = intSVC.list();
		System.out.println("intDTO:" + intDTO);
		System.out.println("intDTO갯수:" + intDTO.size());
		model.addAttribute("intDTO", intDTO);

		
		System.out.println("reqPage : " + reqPage);
		System.out.println("addsearch : " + addsearch);
		
		intSVC.list(reqPage, model, addsearch);
		return "/intbbs/intlist";
	}
	
	//글 상세조회
	@GetMapping("/intread/{page}/{intbnum}")
	public String read(@PathVariable String intbnum, 
										 @PathVariable String page,
										 Model model) {
		
		IntDTO intDTO = intSVC.view(intbnum);		
		model.addAttribute("intDTO", intDTO);
		model.addAttribute("page", page);
//		logger.info("intDTO" + intDTO);
		return "/intbbs/intreadForm";
	}
	
	//글 삭제처리
	@GetMapping("/intdelete/{page}/{intbnum}")
	public String delete(@PathVariable String intbnum,
											 @PathVariable String page) {
		logger.info("delete 호출됨!");				
		intSVC.delete(intbnum);
		return "redirect:/intbbs/intlist/"+page;
	}
	
	//글 수정처리
	@PostMapping("/modify2/{page}")
	public String modify(@Valid @ModelAttribute IntDTO intDTO,
											 BindingResult result,
											 @PathVariable String page) {
		logger.info("modify2 호출됨!");	
		if(result.hasErrors()) {
			logger.info("result "+result.toString());
			return "/intbbs/readForm2";
		}		
//		logger.info("intbbsDTO: " + intbbsDTO);
		intSVC.modify(intDTO);
		return "redirect:/intbbs/read/"+page+"/"+intDTO.getIntbnum();
	}
	
	//답글 양식
	@GetMapping("/reply2/{page}/{intbnum}")
	public String reply(@PathVariable String intbnum, 
											@PathVariable String page,
											Model model) {
		
		IntDTO intDTO = intSVC.view(intbnum);
		model.addAttribute("intDTO",intDTO);
		model.addAttribute("page", page);
		return "/intbbs/replyForm2";
	}
	
	//답글 처리
	@PostMapping("/reply2")
	public String reply(@Valid @ModelAttribute IntDTO intDTO, BindingResult result) {
		logger.info("reply 호출됨!");
		if(result.hasErrors()) {
			logger.info(result.toString());
			return "/bbs2/replyForm2";
		}
		
		intSVC.reply(intDTO);
		
		return "redirect:/intbbs2/list2";
	}
}
















