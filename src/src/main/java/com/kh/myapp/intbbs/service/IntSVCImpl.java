package com.kh.myapp.intbbs.service;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.kh.myapp.common.FindCriteria;
import com.kh.myapp.common.PageCriteria;
import com.kh.myapp.common.RecordCriteria;
import com.kh.myapp.intbbs.dao.IntDAO;
import com.kh.myapp.intbbs.dto.IntDTO;

@Service
public class IntSVCImpl implements IntSVC {

	@Inject
	@Qualifier("intDAOImplJDBC")
	IntDAO intDAO;

	@Override
	public int write(IntDTO intDTO) {
		//파일첨부 존재 하면 파일 시스템에 업로드
		if(!intDTO.getFile().isEmpty()) {
			//첨부파일 업로드 실패하면 0반환
			if(!fileUpload(intDTO)) {
				System.out.println("파일업로드 실패!!");
				return 0;
			}
		}
		System.out.println(intDTO);
		return intDAO.write(intDTO);
	}

	private boolean fileUpload(IntDTO intDTO) {
		
boolean isUpload = false; //파일 업로드 성공유무
		
		String randomFN = null; //내부관리 파일명(난수파일명)
		String originFN = null; //사용자upload 파일명
		//첨부파일이 살제 저장되는 위치 지정
		String fileLocation 
			= "D:\\JAVA\\workspace\\zipzoong2\\src\\main\\webapp\\resources\\img\\upload";
		
		randomFN = UUID.randomUUID().toString(); //중복없는 파일명생성 위함.
		originFN = intDTO.getFile().getOriginalFilename();
		
		//초기파일명에서 확장자추출
		int pos = originFN.lastIndexOf(".");
		String ext = originFN.substring(pos);
		randomFN = randomFN + ext;
		
		//메모리상의 파일을 파일객체로 변환
		File tmpFile = new File(fileLocation, randomFN);
		
		//실제물리적인 파일로 지정된 위치에 파일 생성
		try {
			// 파일시스템에 파일쓰기
			intDTO.getFile().transferTo(tmpFile);
			//memberDTO 갱신
			intDTO.setFile(null);
			intDTO.setOriginFn(originFN);
			intDTO.setRandomFn(randomFN);
			isUpload = true;
			
		} catch (IllegalStateException | IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return isUpload;
	}
	@Override
	public int modify(IntDTO intDTO) {
		
	
		return intDAO.modify(intDTO);
	}


	@Override
	public int delete(String intbnum) {

		return intDAO.delete(intbnum);
	}

	@Override
	public IntDTO view(String intbnum) {

		return intDAO.view(intbnum);
	}

	@Override
	public List<IntDTO> list() {

		return intDAO.list();
	}

	@Override
	public List<IntDTO> list(int starRec, int endRec) {

		return intDAO.list(starRec, endRec);
	}

	@Override
	public int totalRec() {

		return intDAO.totalRec();
	}

	@Override
	public void list(String reqPage, Model model, String addsearch) {

		final int NUM_PER_PAGE = 6; // 한페이지에 보여줄 레코드수
		final int PAGENUM_PER_PAGE = 10; // 한페이지에 보여줄 페이지수

		int totalRec = 0; // 전체레코드 수

		RecordCriteria rc = null; // 한페이지에 보여줄 레코드수 계산하는 클래스
		PageCriteria pc = null; // 한페이지에 보여줄 페이징 계산하는 클래스
		FindCriteria fc = null; // PageCriteira + 검색타입, 검색어

		int l_reqPage = 0;

		// 요청 페이지정보가 없으면 1로 초기화 한다.
		if (reqPage == null || reqPage.trim().isEmpty()) {
			l_reqPage = 1;
		} else {
			l_reqPage = Integer.parseInt(reqPage);
		}
		
		if (addsearch == null || addsearch.trim().isEmpty()) {
			System.out.println("여기들어온다");
			// 전체레코드수 계산해오기
			totalRec = intDAO.totalRec();
			rc = new RecordCriteria(l_reqPage, NUM_PER_PAGE);
			pc = new PageCriteria(rc, totalRec, PAGENUM_PER_PAGE);

			List<IntDTO> list = intDAO.list(rc.getStartRecord(), rc.getEndRecord());

			model.addAttribute("list", list);
			model.addAttribute("pc", pc);
		}
		System.out.println("addsearch2 :" + addsearch);
		if (!(addsearch == null)){
			// case3) 검색조건 있는경우
			totalRec = intDAO.searchTotalRec2(addsearch);
			
			rc = new FindCriteria(l_reqPage, NUM_PER_PAGE, addsearch);
			pc = new PageCriteria(rc, totalRec, PAGENUM_PER_PAGE);

			List<IntDTO> list = intDAO.list(rc.getStartRecord(), rc.getEndRecord(), addsearch);
			model.addAttribute("list", list);
			model.addAttribute("pc", pc);
		}
	}

	@Override
	public void reply(IntDTO intDTO) {
		// TODO Auto-generated method stub

	}

	@Override
	public int searchTotalRec2(String addsearch) {
		
		return intDAO.searchTotalRec2(addsearch);
	}

	@Override
	public List<IntDTO> list(int starRec, int endRec, String addsearch) {
		
		return intDAO.list(starRec, endRec, addsearch);
	}

}
