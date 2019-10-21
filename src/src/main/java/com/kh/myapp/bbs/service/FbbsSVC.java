package com.kh.myapp.bbs.service;

import java.util.List;

import org.springframework.ui.Model;

import com.kh.myapp.bbs.dto.FbbsDTO;

public interface FbbsSVC {

	//게시글 작성
	 int write(FbbsDTO fbbsDTO); 
	
	//게시글 수정
	int modify(FbbsDTO fbbsDTO);
	//게시글 삭제
	int delete(String freebnum);
	//게시글 보기
	FbbsDTO view(String freebnum);
	
	//게시글 목록보기
//	void list(HttpServletRequest request, Model model);
	void list(String reqPage, String searchType, String keyword, Model model);
	//1)전체
	List<FbbsDTO> list();
	//2)검색어 없는경우
	List<FbbsDTO> list(int starRec, int endRec);
	//3)검색어 있는경우
	List<FbbsDTO> list(int starRec, int endRec, String searchType, String keyword);
	
	
	//게시글 총계
	//1)검색어 없는경우
	int totalRec();
	//2)검색어 있는경우
	int searchTotalRec(String searchType,String keyword);

	void reply(FbbsDTO fbbsDTO);

	

	
}


