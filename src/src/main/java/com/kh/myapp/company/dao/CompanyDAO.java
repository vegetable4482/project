package com.kh.myapp.company.dao;

import java.util.List;

import com.kh.myapp.company.dto.CPasswdDTO;
import com.kh.myapp.company.dto.CompanyDTO;

public interface CompanyDAO {
	//업체 등록
	int insert(CompanyDTO companyDTO);
	
	//업체 수정 전 비밀번호 체크
	int modify_first(String cid,String cpw);
	
	//업체 수정
	int modify(CompanyDTO companyDTO);
	
	//기업 회원 상태 정보 수정
	int modify(String cid);
	
	//업체 삭제(회원용:탈퇴)
	int delete(String cid, String cpw);
	
	//업체 삭제(관리자용)
	int delete(String cid);
	
	//업체 개인 조회
	CompanyDTO getMember(String cid);
	
	//업체 목록 조회(관리용)
	List<CompanyDTO>getMemberList();
	
	//업체 비밀번호 변경
	int changePw(CPasswdDTO cpasswdDTO);
	
	//업체 아이디 중복확인
	int idcheck(String cid);
}
