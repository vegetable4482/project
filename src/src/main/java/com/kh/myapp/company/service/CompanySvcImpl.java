package com.kh.myapp.company.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.kh.myapp.company.dao.CompanyDAO;
import com.kh.myapp.company.dto.CPasswdDTO;
import com.kh.myapp.company.dto.CompanyDTO;

@Service
public class CompanySvcImpl implements CompanySvc {

	@Inject
	@Qualifier("companyDAOImplXML")
	private CompanyDAO companyDAO;
	
	@Override
	public int insert(CompanyDTO companyDTO) {

		return companyDAO.insert(companyDTO);
	}

	@Override
	public int modify_first(String cid, String cpw) {
		
		return companyDAO.modify_first(cid, cpw);
	}
	
	@Override
	public int modify(CompanyDTO companyDTO) {

		return companyDAO.modify(companyDTO);
	}
	
	@Override
	public int modify(String cid) {
		
		return companyDAO.modify(cid);
	}

	@Override
	public int delete(String cid, String cpw) {

		return companyDAO.delete(cid,cpw);
	}

	@Override
	public int adminDelete(String cid) {

		return companyDAO.delete(cid);
	}

	@Override
	public CompanyDTO getMember(String cid) {

		return companyDAO.getMember(cid);
	}

	@Override
	public List<CompanyDTO> getMemberList() {

		return companyDAO.getMemberList();
	}

	@Override
	public int changePw(CPasswdDTO cpasswdDTO) {

		return companyDAO.changePw(cpasswdDTO);
	}

	@Override
	public int idcheck(String cid) {

		return companyDAO.idcheck(cid);
	}


}
