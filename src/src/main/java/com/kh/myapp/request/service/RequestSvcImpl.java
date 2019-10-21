package com.kh.myapp.request.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.kh.myapp.request.dao.RequestDAO;
import com.kh.myapp.request.dto.RequestDTO;

@Service
public class RequestSvcImpl implements RequestSvc {

	@Inject
	private RequestDAO requestDAO;
	
	@Override
	public int insert(RequestDTO requestDTO) {

		return requestDAO.insert(requestDTO);
	}

	@Override
	public RequestDTO getRequest(String formnum) {
		
		return requestDAO.getRequest(formnum);
	}
	
	@Override
	public List<RequestDTO> list(String custid) {
		
		return requestDAO.list(custid);
	}
	@Override
	public List<RequestDTO> getEstimateList() {
		
		return requestDAO.getEstimateList();
	}

	@Override
	public List<RequestDTO> clist(String cmembernum) {
		
		return requestDAO.clist(cmembernum);
	}

}
