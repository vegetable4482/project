package com.kh.myapp.member.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.kh.myapp.member.dto.MemberDTO;
import com.kh.myapp.member.dto.PasswdDTO;


@Repository
public class MemberDAOImplXML implements MemberDAO{
	
	private static final Logger logger
		= LoggerFactory.getLogger("MemberDAOImplXML.class");

	@Inject
	private SqlSession sqlSession;
	
	@Override
	public int insert(MemberDTO memberDTO) {
		logger.info("MemberDAOImplXML.insert 호출됨!");
		
		return sqlSession.insert("mappers.member-mapper.insert", memberDTO);
	}
	@Override
	public int modify_first(String id ,String pw) {
		logger.info("MemberDAOImplXML.modify_first 호출됨!");
		Map<String,String> map = new HashMap<>();
		map.put("id", id);
		map.put("pw", pw);
		return sqlSession.selectOne("mappers.member-mapper.modify_first",map);
	}
	@Override
	public int modify(MemberDTO memberDTO) {
		logger.info("MemberDAOImplXML.modify 호출됨!");
		return sqlSession.update("mappers.member-mapper.modify", memberDTO);
	}

	@Override
	public int delete(String id, String pw) {
		logger.info("MemberDAOImplXML.delete 호출됨!");		
		Map<String,String> map = new HashMap<>();
		map.put("id", id);
		map.put("pw", pw);
		return sqlSession.delete("mappers.member-mapper.delete", map);
	}
	//관리자용
	@Override
	public int delete(String id) {
		logger.info("MemberDAOImplXML.delete 관리자용 호출됨!");		
		return sqlSession.delete("mappers.member-mapper.adminDelete", id);
	}

	@Override
	public MemberDTO getMember(String id) {
		logger.info("MemberDAOImplXML.getMember 호출됨!");
		
		return sqlSession.selectOne("mappers.member-mapper.getMember", id);
	}

	@Override
	public List<MemberDTO> getMemberList() {
		logger.info("MemberDAOImplXML.getMemberList 호출됨!");
		return sqlSession.selectList("mappers.member-mapper.getMemberList");
	}

	@Override
	public int changePw(PasswdDTO passwdDTO) {
		logger.info("MemberDAOImplXML.changePw 호출됨!");
		return sqlSession.update("mappers.member-mapper.changePw", passwdDTO);
	}
	
	@Override
	public int idcheck(String id) {
		logger.info("MemberDAOImplXML.idcheck 호출됨!");
		return sqlSession.selectOne("mappers.member-mapper.idcheck", id);
	}

}