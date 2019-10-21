package com.kh.myapp.matchingresult.service;

import java.util.List;

import com.kh.myapp.matchingresult.dto.ResultDTO;
import com.kh.myapp.request.dto.RequestDTO;

public interface MatchingSVC {
	
//	//매칭 리스트 받기
//	List<MatchingDTO> getMatchingList();

	//매칭 리스트 받기
	List<RequestDTO> getMatchingList();

	int insert(RequestDTO requestDTO); 
	
	
	//매칭결과 조회
	List<ResultDTO> list(String mformnum);
}
