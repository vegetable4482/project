package com.kh.myapp.matchingresult.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.kh.myapp.matchingresult.dao.MatchingDAO;
import com.kh.myapp.matchingresult.dto.ResultDTO;
import com.kh.myapp.member.dto.MemberDTO;
import com.kh.myapp.request.dto.RequestDTO;

@Service
public class MatchingSVCImpl implements MatchingSVC {

	@Inject
	private MatchingDAO matchingDAO;
	

	
//	@Override
//	public List<MatchingDTO> getMatchingList() {
//
//		return matchingDAO.getMatchingList();
//	}

	@Override
	public List<RequestDTO> getMatchingList() {
		
		return matchingDAO.getMatchingList();
	}
	

	public int insert(RequestDTO requestDTO) {
		
		return matchingDAO.insert(requestDTO);
	}


	@Override
	public List<ResultDTO> list(String mformnum) {
		
		return matchingDAO.list(mformnum);
	}

}
