package com.kh.myapp.company.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.kh.myapp.company.dto.CPasswdDTO;
import com.kh.myapp.company.dto.CompanyDTO;

@Repository
public class CompanyDAOImplXML implements CompanyDAO {

	private static final Logger logger
	= LoggerFactory.getLogger("CompanyDAOImplXML.class");
	
	@Inject
	private SqlSession sqlSession;
	
	@Override
	public int insert(CompanyDTO companyDTO) {

	logger.info("CompanyDAOImplXML.insert 호출됨!");
		
		return sqlSession.insert("mappers.company-mapper.insert", companyDTO);
	}

	@Override
	public int modify_first(String cid, String cpw) {
		Map<String,String> map = new HashMap<>();
		map.put("cid", cid);
		map.put("cpw", cpw);
		return sqlSession.selectOne("mappers.company-mapper.modify_first", map);
	}
	
	@Override
	public int modify(CompanyDTO companyDTO) {

		logger.info("CompanyDAOImplXML.modify 호출됨!");
		
		return sqlSession.update("mappers.company-mapper.modify", companyDTO);
	
	}
		
	@Override
	public int modify(String cid) {
		
		return sqlSession.update("mappers.company-mapper.adminModify", cid);
	}
	
	@Override
	public int delete(String cid, String cpw) {

		logger.info("CompanyDAOImplXML.delete 호출됨!");		
		Map<String,String> map = new HashMap<>();
		map.put("cid", cid);
		map.put("cpw", cpw);
		return sqlSession.delete("mappers.company-mapper.delete", map);
	}
	
	@Override
	public int delete(String cid) {
		logger.info("CompanyDAOImplXML.adminDelete 관리자용 호출됨!");		
		return sqlSession.delete("mappers.company-mapper.adminDelete", cid);
	}

	@Override
	public CompanyDTO getMember(String cid) {
		logger.info("CompanyDAOImplXML.getMember 관리자용 호출됨!");		
		return sqlSession.selectOne("mappers.company-mapper.getMember", cid);
	}

	@Override
	public List<CompanyDTO> getMemberList() {
		logger.info("CompanyDAOImplXML.getMemberList 호출됨!");
		return sqlSession.selectList("mappers.company-mapper.getMemberList");
	}

	@Override
	public int changePw(CPasswdDTO cpasswdDTO) {
		logger.info("CompanyDAOImplXML.changePw 호출됨!");
		return sqlSession.update("mappers.company-mapper.changePw", cpasswdDTO);
	}

	@Override
	public int idcheck(String cid) {

	logger.info("CompanyDAOImplXML.idcheck 호출됨!");
		
		return sqlSession.selectOne("mappers.company-mapper.idcheck", cid);
	}


}
