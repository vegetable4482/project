package com.kh.myapp.bbs.dao;

import java.util.List;

import com.kh.myapp.bbs.dto.FbbsDTO;
import com.kh.myapp.bbs.dto.FrbbsDTO;


public interface FbbsDAO {
//자유게시판 작성
int write(FbbsDTO fbbsDTO);
//자유게시판 수정
int modify(FbbsDTO fbbsDTO);
//자유게시판 삭제
int delete(String freebnum);
//자유게시판 보기
FbbsDTO view(String freebnum);

//자유게시판 목록보기
//1)전체
List<FbbsDTO> list();
//2)검색어 없는경우
List<FbbsDTO> list(int starRec, int endRec);
//3)검색어 있는경우
List<FbbsDTO> list(int starRec, int endRec, String searchType, String keyword);


    //게시글 페이징
	//게시글 검색
	//게시글 답글
int reply(FbbsDTO fbbsDTO);
//게시글 총계
//1)검색어 없는경우
int totalRec();
//2)검색어 있는경우
int searchTotalRec(String searchType,String keyword);




}


