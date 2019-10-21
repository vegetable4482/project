package com.kh.myapp.rebbs.service;


import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.kh.myapp.common.FindCriteria;
import com.kh.myapp.common.PageCriteria;
import com.kh.myapp.common.RecordCriteria;
import com.kh.myapp.rebbs.dao.REbbsDAO;
import com.kh.myapp.rebbs.dto.REbbsDTO;


@Service
public class REbbsSVCImpl implements REbbsSVC{
	
	private static Logger logger = LoggerFactory.getLogger(REbbsSVCImpl.class);
	
	@Inject
	@Qualifier("REbbsDAOImplXML")
	REbbsDAO rebbsDAO;
	
	@Override
	public int write(REbbsDTO rebbsDTO) {
		//파일첨부 존재 하면 파일 시스템에 업로드
		if(!rebbsDTO.getFile().isEmpty()) {
			//첨부파일 업로드 실패하면 0반환
			if(!fileUpload(rebbsDTO)) {
				System.out.println("파일업로드 실패!!");
				return 0;
			}
		}
		System.out.println(rebbsDTO);
		return rebbsDAO.write(rebbsDTO);
	}
	
	private boolean fileUpload(REbbsDTO rebbsDTO) {
		
		boolean isUpload = false; //파일 업로드 성공유무
		
		String reviewrandomFn = null; //내부관리 파일명(난수파일명)
		String revieworiginFn = null; //사용자upload 파일명
		//첨부파일이 살제 저장되는 위치 지정
		String fileLocation 
			= "D:\\JAVA\\workspace\\zipzoong2\\src\\main\\webapp\\resources\\img\\reupload";
		
		reviewrandomFn = UUID.randomUUID().toString(); //중복없는 파일명생성 위함.
		revieworiginFn = rebbsDTO.getFile().getOriginalFilename();
		
		//초기파일명에서 확장자추출
		int pos = revieworiginFn.lastIndexOf(".");
		String ext = revieworiginFn.substring(pos);
		reviewrandomFn = reviewrandomFn + ext;
		
		//메모리상의 파일을 파일객체로 변환
		File tmpFile = new File(fileLocation, reviewrandomFn);
		
		//실제물리적인 파일로 지정된 위치에 파일 생성
		try {
			// 파일시스템에 파일쓰기
			rebbsDTO.getFile().transferTo(tmpFile);
			//memberDTO 갱신
			rebbsDTO.setFile(null);
			rebbsDTO.setRevieworiginFn(revieworiginFn);
			rebbsDTO.setReviewrandomFn(reviewrandomFn);
			isUpload = true;
			
		} catch (IllegalStateException | IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return isUpload;
	}
	
	@Override
	public int modify(REbbsDTO rebbsDTO) {
		//파일첨부 존재 하면 파일 시스템에 업로드
		if(!rebbsDTO.getFile().isEmpty()) {
			//첨부파일 업로드 실패하면 0반환
			if(!fileUpload(rebbsDTO)) {
				System.out.println("파일업로드 실패!!");
				return 0;
			}
		}
		System.out.println(rebbsDTO);
		return rebbsDAO.modify(rebbsDTO);
	}

	@Override
	public int delete(String reviewbnum) {
		// TODO Auto-generated method stub
		return rebbsDAO.delete(reviewbnum);
	}

	@Override
	public REbbsDTO view(String reviewbnum) {
		// TODO Auto-generated method stub
		return  rebbsDAO.view(reviewbnum);
	}
	
	@Override
	public List<REbbsDTO> list_main() {
		// TODO Auto-generated method stub
		return rebbsDAO.list_main();
	}
	@Override
	public List<REbbsDTO> list() {
		// TODO Auto-generated method stub
		return rebbsDAO.list();
	}

	@Override
	public List<REbbsDTO> list(int starRec, int endRec) {
		// TODO Auto-generated method stub
		return rebbsDAO.list(starRec, endRec);
	}

	@Override
	public List<REbbsDTO> list(int starRec, int endRec, String searchType, String keyword) {
		// TODO Auto-generated method stub
		return rebbsDAO.list(starRec, endRec, searchType, keyword);
	}

	@Override
	public int totalRec() {
		// TODO Auto-generated method stub
		return rebbsDAO.totalRec();
	}

	@Override
	public int searchTotalRec(String searchType, String keyword) {
		// TODO Auto-generated method stub
		return rebbsDAO.searchTotalRec(searchType, keyword);
	}
	@Override
	public void list(String reqPage, String searchType, String keyword, Model model) {
		
		
		final int NUM_PER_PAGE = 10;				//한페이지에 보여줄 레코드수
		final int PAGENUM_PER_PAGE = 10; 	  //한페이지에 보여줄 페이지수
		
		int totalRec = 0;										//전체레코드 수
	
		RecordCriteria rc = null;						//한페이지에 보여줄 레코드수 계산하는 클래스
		PageCriteria pc = null;							//한페이지에 보여줄 페이징 계산하는 클래스
		FindCriteria fc = null;							//PageCriteira + 검색타입, 검색어
	
		int l_reqPage = 0;

		//요청 페이지정보가 없으면 1로 초기화 한다.
		if(reqPage  == null || reqPage.trim().isEmpty()) {
			l_reqPage = 1;
		}else {
			l_reqPage = Integer.parseInt(reqPage);
		}
				
		//case1) 검색조건 없는경우
		if(keyword  == null || keyword.trim().isEmpty()) {
			
			//전체레코드수 계산해오기
			totalRec = rebbsDAO.totalRec();
			rc = new RecordCriteria(l_reqPage, NUM_PER_PAGE);
			pc = new PageCriteria(rc, totalRec, PAGENUM_PER_PAGE);
			
			List<REbbsDTO> list = rebbsDAO.list(rc.getStartRecord(),rc.getEndRecord());
			
			model.addAttribute("list", list);
			model.addAttribute("pc", pc);
		}else {	
	  //case2) 검색조건 있는경우
			totalRec = rebbsDAO.searchTotalRec(searchType,keyword);
			
			rc = new FindCriteria(l_reqPage, NUM_PER_PAGE, searchType, keyword);
			pc = new PageCriteria(rc, totalRec, PAGENUM_PER_PAGE);
			
			List<REbbsDTO> list = rebbsDAO.list(rc.getStartRecord(),rc.getEndRecord(),
					                            searchType,keyword);
			
			model.addAttribute("list", list);
			model.addAttribute("pc", pc);	
		}			
	}		

}
