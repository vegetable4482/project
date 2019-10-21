package com.kh.myapp.login.dao;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.kh.myapp.company.dto.CompanyDTO;
import com.kh.myapp.login.dto.AdministratorDTO;
import com.kh.myapp.member.dto.MemberDTO;

@Repository
public class LoginDAOImplXML implements LoginDAO {

	private static final Logger logger
	= LoggerFactory.getLogger("LoginDAOImplXML.class");
	
	@Inject
	private SqlSession sqlSession;
	
	@Override
	public int isMember(String id, String pw) {
		logger.info("LoginDAOImplXML.isMember 호출됨!");
		Map<String,String> map = new HashMap<>();
		map.put("id", id);
		map.put("pw", pw);
		return sqlSession.selectOne("mappers.login-mapper.isMember", map);
	}

	@Override
	public MemberDTO getMember(String id, String pw) {
		logger.info("LoginDAOImplXML.getMember 호출됨!");
		Map<String,String> map = new HashMap<>();
		map.put("id", id);
		map.put("pw", pw);
		return sqlSession.selectOne("mappers.login-mapper.getMember", map);
	}

	@Override
	public int isCompany(String cid, String cpw) {
		logger.info("LoginDAOImplXML.isCompany 호출됨!");
		Map<String,String> map = new HashMap<>();
		map.put("cid", cid);
		map.put("cpw", cpw);
		return sqlSession.selectOne("mappers.login-mapper.isCompany", map);
	}
	@Override
	public CompanyDTO getCompany(String cid, String cpw) {
		
		logger.info("LoginDAOImplXML.getCompany 호출됨!");
		Map<String,String> map = new HashMap<>();
		map.put("cid", cid);
		map.put("cpw", cpw);
		return sqlSession.selectOne("mappers.login-mapper.getCompany", map);
	}
	
	@Override
	public int isAdministrator(String aId, String aPw) {
		logger.info("LoginDAOImplXML.isAdministrator 호출됨!");
		Map<String,String> map = new HashMap<>();
		map.put("aId", aId);
		map.put("aPw", aPw);
		return sqlSession.selectOne("mappers.login-mapper.isAdministrator", map);
	}
	
	@Override
	public AdministratorDTO  getAdministrator(String aId, String aPw) {
		
		logger.info("LoginDAOImplXML.getAdministrator 호출됨!");
		Map<String,String> map = new HashMap<>();
		map.put("aId", aId);
		map.put("aPw", aPw);
		return sqlSession.selectOne("mappers.login-mapper.getAdministrator", map);
	}
	
	
	
}
