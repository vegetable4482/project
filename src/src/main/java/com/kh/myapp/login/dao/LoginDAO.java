package com.kh.myapp.login.dao;

import com.kh.myapp.company.dto.CompanyDTO;
import com.kh.myapp.login.dto.AdministratorDTO;
import com.kh.myapp.member.dto.MemberDTO;

public interface LoginDAO {

	//회원 유무 체크
	int isMember(String id, String pw);
	
	//회원정보 가져오기
	MemberDTO getMember(String id, String pw);
	
	//업체 회원 유무 체크
	int isCompany(String cid, String cpw);
	
	//업체회원 정보 가져오기
	CompanyDTO getCompany(String cid,String cpw);
	
//관리자 유무 체크
	int isAdministrator(String aId, String aPw);
	
	//관리자 정보 가져오기
	AdministratorDTO getAdministrator(String aId, String aPw);
	
	
	
}
