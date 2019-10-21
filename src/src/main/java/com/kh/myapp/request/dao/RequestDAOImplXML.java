package com.kh.myapp.request.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.kh.myapp.request.dto.RequestDTO;
@Repository
public class RequestDAOImplXML implements RequestDAO {

	
	private static final Logger logger
		= LoggerFactory.getLogger("RequestDAOImplXML.class");
	
	@Inject
	private SqlSession sqlSession;
	
	@Override
	public int insert(RequestDTO requestDTO) {

		logger.info("RequestDAOImplXML.insert 호출됨!");
		
		return sqlSession.insert("mappers.request-mapper.insert", requestDTO);
	}

	@Override
	public RequestDTO getRequest(String formnum) {

		logger.info("RequestDAOImplXML.getRequest 호출됨!");
		
		return sqlSession.selectOne("mappers.request-mapper.getRequest", formnum);
	}

	@Override
	public List<RequestDTO> list(String custid) {

logger.info("RequestDAOImplXML.list 호출됨!");
		
		return sqlSession.selectList("mappers.request-mapper.list", custid);
	}

	@Override
	public List<RequestDTO> getEstimateList() {
		
		logger.info("RequestDAOImplXML.getEstimateList 호출됨!");
		return sqlSession.selectList("mappers.request-mapper.getEstimateList");
	}

	@Override
	public List<RequestDTO> clist(String cmembernum) {
		
		return sqlSession.selectList("mappers.request-mapper.clist",cmembernum);
	}
	

}
