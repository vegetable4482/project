package com.kh.myapp.intbbs.dao;

import java.util.List;

import com.kh.myapp.intbbs.dto.IntDTO;

public interface IntDAO {
//자유게시판 작성
int write(IntDTO intDTO);
//자유게시판 수정
int modify(IntDTO intDTO);
//자유게시판 삭제
int delete(String intbnum);
//자유게시판 보기
IntDTO view(String intbnum);

//자유게시판 목록보기
//1)전체
List<IntDTO> list();
//2)검색어 없는경우
List<IntDTO> list(int starRec, int endRec);
//3)검색어 있는경우
List<IntDTO> list(int starRec, int endRec, String addsearch);

  //게시글 페이징
	//게시글 검색
	//게시글 답글
int reply(IntDTO intDTO);
//게시글 총계
//1)검색어 없는경우
int totalRec();
//2)검색어 있는경우
int searchTotalRec(String searchType,String keyword);

int searchTotalRec2(String addsearch);




}


