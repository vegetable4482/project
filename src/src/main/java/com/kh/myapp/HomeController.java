package com.kh.myapp;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.kh.myapp.rebbs.dto.REbbsDTO;
import com.kh.myapp.rebbs.service.REbbsSVC;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Autowired
	private REbbsSVC rEBbsSVC;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model) {		
		
		List<REbbsDTO> list = rEBbsSVC.list_main();
		model.addAttribute("reviewList", list);
		
		logger.info(list.toString());

		return "index";
	}
	
}
