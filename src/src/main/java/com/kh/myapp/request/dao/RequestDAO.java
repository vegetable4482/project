package com.kh.myapp.request.dao;

import java.util.List;

import com.kh.myapp.request.dto.RequestDTO;

public interface RequestDAO {

	//견적신청
	int insert(RequestDTO requestDTO);
	
	//내견적조회(회원)
	RequestDTO getRequest(String formnum);
	
	//견적목록보기
	List<RequestDTO> list(String custid);
	
//견적 목록 조회(관리용)
	List<RequestDTO> getEstimateList();
	
	//견적 목록조회 (업체용)
	List<RequestDTO> clist(String cmembernum);
	
}
