package com.kh.myapp.intbbs.service;



import java.util.List;

import org.springframework.ui.Model;

import com.kh.myapp.intbbs.dto.IntDTO;



public interface IntSVC {

	//게시글 작성
	 int write(IntDTO intDTO); 
	
	//게시글 수정
	int modify(IntDTO intDTO);
	//게시글 삭제
	int delete(String intbnum);
	//게시글 보기
	IntDTO view(String intbnum);
	
	//게시글 목록보기
//	void list(HttpServletRequest request, Model model);
	void list(String reqPage, Model model ,String addsearch);
	//1)전체
	List<IntDTO> list();
	//2)검색어 없는경우
	List<IntDTO> list(int starRec, int endRec);
	//3)검색어 있는경우
	List<IntDTO> list(int starRec, int endRec, String addsearch);
	
	//게시글 총계
	//1)검색어 없는경우
	int totalRec();
	//2)검색어 있는경우
	int searchTotalRec2(String addsearch);
	void reply(IntDTO intDTO);

	

	
}


