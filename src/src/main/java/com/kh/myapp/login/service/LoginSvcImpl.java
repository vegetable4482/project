package com.kh.myapp.login.service;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.kh.myapp.company.dto.CompanyDTO;
import com.kh.myapp.login.dao.LoginDAO;
import com.kh.myapp.login.dto.AdministratorDTO;
import com.kh.myapp.member.dto.MemberDTO;

@Service
public class LoginSvcImpl implements LoginSvc{

	@Inject
	@Qualifier("loginDAOImplXML")
	private LoginDAO loginDAO;
	
	@Override
	public int isMember(String id, String pw) {
		
		return loginDAO.isMember(id, pw);
		
	}

	@Override
	public MemberDTO getMember(String id, String pw) {
		
		return loginDAO.getMember(id, pw);
	}
	
	@Override
	public int isCompany(String cid, String cpw) {
		
		return loginDAO.isCompany(cid, cpw);
	}
	
	@Override
	public CompanyDTO getCompany(String cid, String cpw) {
		
		return loginDAO.getCompany(cid, cpw);
	} 
	
	@Override
	public int isAdministrator(String aId, String aPw) {

		return loginDAO.isAdministrator(aId, aPw);
	}

	@Override
	public AdministratorDTO getAdministrator(String aId, String aPw) {

		return loginDAO.getAdministrator(aId, aPw);
	}

}
