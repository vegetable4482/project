package com.kh.myapp.qna.service;

import java.util.List;

import org.springframework.ui.Model;

import com.kh.myapp.qna.dto.QnaDTO;

public interface QnaSvc {
	//1:1문의작성
 int qnainsert(QnaDTO qnaDTO);
 
 //1:1문의보기
 QnaDTO view(String qnabnum);
 
 //1:1문의목록
void list(String reqPage, String searchType, String keyword, Model model);
 //전체
 List<QnaDTO> list();
 //검색어 없는경우
 List<QnaDTO> list(int startRec, int endRec);
 //검색어 있는 경우
 List<QnaDTO> list(int startRec, int endRec,String searchType,String keyword);
 
 
 //1:1문의 답글
 int reply(QnaDTO qnaDTO);

 //게시글 총계
 //1)검색어 없는 경우
 int totalRec();
 //2)검색어 있는 경우
 int searchTotalRec(String searchType,String keyword);

 
}
