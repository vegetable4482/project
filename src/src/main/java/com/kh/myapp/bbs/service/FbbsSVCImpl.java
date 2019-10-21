package com.kh.myapp.bbs.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.kh.myapp.bbs.dao.FbbsDAO;
import com.kh.myapp.bbs.dto.FbbsDTO;
import com.kh.myapp.common.FindCriteria;
import com.kh.myapp.common.PageCriteria;
import com.kh.myapp.common.RecordCriteria;

@Service
public class FbbsSVCImpl implements FbbsSVC {

	@Inject
	@Qualifier("fbbsDAOImplJDBC")
	FbbsDAO fbbsDAO;

	@Override
	public int write(FbbsDTO fbbsDTO) {

		return fbbsDAO.write(fbbsDTO);
	}

	@Override
	public int modify(FbbsDTO fbbsDTO) {

		return fbbsDAO.modify(fbbsDTO);
	}

	@Override
	public int delete(String freebnum) {

		return fbbsDAO.delete(freebnum);
	}

	@Override
	public FbbsDTO view(String freebnum) {

		return fbbsDAO.view(freebnum);
	}

	@Override
	public List<FbbsDTO> list() {

		return fbbsDAO.list();
	}

	@Override
	public List<FbbsDTO> list(int starRec, int endRec) {

		return fbbsDAO.list(starRec, endRec);
	}

	@Override
	public List<FbbsDTO> list(int starRec, int endRec, String searchType, String keyword) {

		return fbbsDAO.list(starRec, endRec, searchType, keyword);
	}

	@Override
	public int totalRec() {

		return fbbsDAO.totalRec();
	}

	@Override
	public int searchTotalRec(String searchType, String keyword) {

		return fbbsDAO.searchTotalRec(searchType, keyword);
	}

	@Override
	public void list(String reqPage, String searchType, String keyword, Model model) {

		final int NUM_PER_PAGE = 10; // 한페이지에 보여줄 레코드수
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

		// case1) 검색조건 없는경우
		if (keyword == null || keyword.trim().isEmpty()) {

			// 전체레코드수 계산해오기
			totalRec = fbbsDAO.totalRec();
			rc = new RecordCriteria(l_reqPage, NUM_PER_PAGE);
			pc = new PageCriteria(rc, totalRec, PAGENUM_PER_PAGE);

			List<FbbsDTO> list = fbbsDAO.list(rc.getStartRecord(), rc.getEndRecord());

			model.addAttribute("list", list);
			model.addAttribute("pc", pc);
		} else {
			// case2) 검색조건 있는경우
			totalRec = fbbsDAO.searchTotalRec(searchType, keyword);

			rc = new FindCriteria(l_reqPage, NUM_PER_PAGE, searchType, keyword);
			pc = new PageCriteria(rc, totalRec, PAGENUM_PER_PAGE);

			List<FbbsDTO> list = fbbsDAO.list(rc.getStartRecord(), rc.getEndRecord(), searchType, keyword);

			model.addAttribute("list", list);
			model.addAttribute("pc", pc);
		}
	}

	@Override
	public void reply(FbbsDTO fbbsDTO) {
		// TODO Auto-generated method stub

	}

}
