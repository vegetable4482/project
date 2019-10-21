package com.kh.myapp.rebbs.dao;

import java.util.List;

import com.kh.myapp.rebbs.dto.REbbsDTO;


public interface REbbsDAO {
	//게시글 작성
	int write(REbbsDTO rebbsDTO);
	//게시글 수정
	int modify(REbbsDTO rebbsDTO);
	//게시글 삭제
	int delete(String reviewbnum);
	//게시글 보기
	REbbsDTO view(String reviewbnum);
	
	
	List<REbbsDTO> list_main();
	//게시글 목록보기
	//1)전체
	List<REbbsDTO> list();
	//2)검색어 없는경우
	List<REbbsDTO> list(int starRec, int endRec);
	//3)검색어 있는경우
	List<REbbsDTO> list(int starRec, int endRec, String searchType, String keyword);
	
	//게시글 총계
	//1)검색어 없는경우
	int totalRec();
	//2)검색어 있는경우
	int searchTotalRec(String searchType,String keyword);
	
	
	//게시글 별점
	
	
}
