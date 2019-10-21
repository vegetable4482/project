package com.kh.myapp.bbs.dao;

import java.util.List;

import com.kh.myapp.bbs.dto.FrbbsDTO;

public interface FrbbsDAO {

	//댓글 등록
		int write(FrbbsDTO frbbsDTO);
		
		//댓글 목록
		List<FrbbsDTO> list(String freebnum);
		List<FrbbsDTO> list(String freebnum,int startRec, int endRec);
		
		
		//댓글 수정
		int modify(FrbbsDTO frbbsDTO);
		
		
		//댓글 삭제
		int delete(String freernum);
		
		
		//댓글 호감 비호감
		int goodOrBad(String freernum, String goodOrBad);
		
		//대댓글 등록
		int reply(FrbbsDTO frbbsDTO);
		
		//대댓글 총계
		int replyTotalRec(String freebnum);
		
	}

