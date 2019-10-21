package com.kh.myapp.qna.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.kh.myapp.common.FindCriteria;
import com.kh.myapp.common.PageCriteria;
import com.kh.myapp.common.RecordCriteria;
import com.kh.myapp.qna.dao.QnaDAO;
import com.kh.myapp.qna.dto.QnaDTO;

@Service
public class QnaSvcImpl implements QnaSvc {

	@Inject
	private QnaDAO qnaDAO;
	
		@Override
		public int qnainsert(QnaDTO qnaDTO) {
			
			return qnaDAO.qnainsert(qnaDTO);
		}
		@Override
		public QnaDTO view(String qnabnum) {
			
			return qnaDAO.view(qnabnum);
		}
		@Override
		public List<QnaDTO> list() {
			
			return qnaDAO.list();
		}
		@Override
		public List<QnaDTO> list(int startRec, int endRec) {
			
			return qnaDAO.list(startRec, endRec);
		}
		@Override
		public List<QnaDTO> list(int startRec, int endRec, String searchType, String keyword) {
			
			return qnaDAO.list(startRec, endRec, searchType, keyword);
		}
		@Override
		public int reply(QnaDTO qnaDTO) {
			
			return qnaDAO.reply(qnaDTO);
		}
		@Override
		public int totalRec() {
			
			return qnaDAO.totalRec();
		}
		@Override
		public int searchTotalRec(String searchType, String keyword) {
			
			return qnaDAO.searchTotalRec(searchType, keyword);
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
				totalRec = qnaDAO.totalRec();
				rc = new RecordCriteria(l_reqPage, NUM_PER_PAGE);
				pc = new PageCriteria(rc, totalRec, PAGENUM_PER_PAGE);
				
				List<QnaDTO> list = qnaDAO.list(rc.getStartRecord(),rc.getEndRecord());
				
				model.addAttribute("list", list);
				model.addAttribute("pc", pc);
			}else {	
		  //case2) 검색조건 있는경우
				totalRec = qnaDAO.searchTotalRec(searchType,keyword);
				
				rc = new FindCriteria(l_reqPage, NUM_PER_PAGE, searchType, keyword);
				pc = new PageCriteria(rc, totalRec, PAGENUM_PER_PAGE);
				
				List<QnaDTO> list = qnaDAO.list(rc.getStartRecord(),rc.getEndRecord(),
						                            searchType,keyword);
				
				model.addAttribute("list", list);
				model.addAttribute("pc", pc);	
			}		
		}
		
		
	}

