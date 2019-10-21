package com.kh.myapp.matchingresult.dao;

import java.util.List;

import com.kh.myapp.matchingresult.dto.ResultDTO;
import com.kh.myapp.request.dto.RequestDTO;

public interface MatchingDAO {
	
	//매칭 리스트 받기
	List<RequestDTO> getMatchingList();
	
	int insert(RequestDTO requestDTO);
	//매칭 리스트 받기2

	int update_result_status(RequestDTO requestDTO);
	
	//매칭결과 조회(회원)
	
	List<ResultDTO> list(String mformnum);

}
