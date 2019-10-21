package com.kh.myapp.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.myapp.bbs.dto.FrbbsDTO;
import com.kh.myapp.bbs.service.FrbbsSVC;
import com.kh.myapp.common.PageCriteria;
import com.kh.myapp.common.RecordCriteria;

@RestController
@RequestMapping("/rbbs")
public class FrbbsController {

	private static Logger logger = LoggerFactory.getLogger(FrbbsController.class);
	
	@Inject
	FrbbsSVC frbbsSVC;
	
	//응답헤더 지정
	HttpHeaders resHeaders;
	
	//댓글작성
	@PostMapping(value="", produces = "application/json")
	public ResponseEntity<String> write(@RequestBody(required = true) FrbbsDTO frbbsDTO){
		
		ResponseEntity<String> res = null;
		logger.info("write() 호출!");
		logger.info("frbbsDTO : " + frbbsDTO.toString()); 
		
		//필수값 체크
		if( frbbsDTO.getFreebnum() > 0 && 
				frbbsDTO.getFreerid() !=null &&
				frbbsDTO.getFreername() !=null &&
				frbbsDTO.getFreercontent() !=null) {
			
			frbbsSVC.write(frbbsDTO);
			res = new ResponseEntity<String>("success",HttpStatus.OK); //200			
		}else {
			res = new ResponseEntity<String>("fail",HttpStatus.BAD_REQUEST); //400
		}
			
		return res;
	}
	//댓글목록조회
	@GetMapping(value="/{page}/{freebnum}", produces = "application/json")
	public ResponseEntity<Map<String,Object>> list(@PathVariable String page,
									 @PathVariable(required = true) String freebnum){
		ResponseEntity<Map<String,Object>> res = null;
		Map<String,Object> map = new HashMap<>();
		
		try {
			RecordCriteria rc = new RecordCriteria(Integer.parseInt(page), 10);
			PageCriteria pc = new PageCriteria(rc, frbbsSVC.replyTotalRec(freebnum), 10);
			List<FrbbsDTO> list = frbbsSVC.list(freebnum, rc.getStartRecord(), rc.getEndRecord());
			
			map.put("item", list);
			map.put("pc",pc);
			res = new ResponseEntity<Map<String,Object>>(map, HttpStatus.OK);
		}catch (Exception e) {
			res = new ResponseEntity<Map<String,Object>>(HttpStatus.BAD_REQUEST);
		}
		
		return res;
	}
	
	//댓글수정
	@PutMapping(value="",produces = "application/json;charset=UTF-8")
	public ResponseEntity<String> modify(@RequestBody(required = true) FrbbsDTO frbbsDTO){
		ResponseEntity<String> res = null;
				
		if(frbbsDTO.getFreercontent() == null || String.valueOf(frbbsDTO.getFreernum()) == null ) {
			res = new ResponseEntity<String>("fail", HttpStatus.BAD_REQUEST);
			return res;
		}
		
		int cnt = frbbsSVC.modify(frbbsDTO);
		if(cnt == 1) {
			res = new ResponseEntity<String>("success",  HttpStatus.OK);
		}else {
			res = new ResponseEntity<String>("변경 실패!",  HttpStatus.BAD_REQUEST);
		}
		
		return res;
	}
	
	//댓글삭제
	@DeleteMapping(value="/{freernum}",produces = "application/json;charset=UTF-8")
	public ResponseEntity<String> delete(@PathVariable(required = true) String freernum){
		ResponseEntity<String> res = null;
		
		int cnt = frbbsSVC.delete(freernum);
		if(cnt == 1) {
			res = new ResponseEntity<String>("success",  HttpStatus.OK);
		}else {
			res = new ResponseEntity<String>("삭제 실패!",  HttpStatus.BAD_REQUEST);
		}
		
		return res;
	}
	
	//대댓글작성
	@PostMapping(value="/reply",produces = "application/json;charset=UTF-8")
	public ResponseEntity<String> reply(@RequestBody(required = true) FrbbsDTO frbbsDTO) {
		ResponseEntity<String> res = null;
		
		if(	String.valueOf(frbbsDTO.getFreernum()) == null ||
				frbbsDTO.getFreerid() == null ||
				frbbsDTO.getFreername() == null ||
				frbbsDTO.getFreercontent() == null ||
				frbbsDTO.getFreerrnum() == null ) {
			
			return new ResponseEntity<String>("필수값 누락!",  HttpStatus.BAD_REQUEST);		
		}
		
		if(frbbsSVC.reply(frbbsDTO) == 1) {
			res = new ResponseEntity<String>("success",  HttpStatus.OK);
		}else{
			res = new ResponseEntity<String>("대댓글 실패!",  HttpStatus.BAD_REQUEST);		
		};
		
		return res;
	}
	
	//호감, 비호감
	@PutMapping(value="/{freernum}/{freegoodOrbad}",produces = "application/json;charset=UTF-8")
	public ResponseEntity<String> goodOrbad(
			@PathVariable(required = true) String freernum,
			@PathVariable(required = true) String freegoodOrbad){
		
		ResponseEntity<String> res = null;
		
		if(frbbsSVC.goodOrBad(freernum, freegoodOrbad) ==1) {
			res = new ResponseEntity<String>("success",  HttpStatus.OK);
		}else{
			res = new ResponseEntity<String>("호감비호감 실패!",  HttpStatus.BAD_REQUEST);	
		};
		return res;
	}
	
}
