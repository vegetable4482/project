package com.kh.myapp.matchingresult.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.kh.myapp.matchingresult.dto.ResultDTO;
import com.kh.myapp.request.dao.RequestDAO;
import com.kh.myapp.request.dto.RequestDTO;

@Repository
public class MatchingDAOImplXML implements MatchingDAO {

	private static final Logger logger = LoggerFactory.getLogger(MatchingDAOImplXML.class);
	
	@Inject
	private SqlSession sqlSession;
	RequestDAO requestDAO;
	ResultDTO resultDTO;

	@Override
	public List<RequestDTO> getMatchingList() {
		logger.info("MatchingDAOImplXML.getMatchingList 호출됨!");
				
		return sqlSession.selectList("mappers.matching-mapper.getMatchingList");
	}

	@Override
	public int insert(RequestDTO requestDTO) {
		sqlSession.insert("mappers.result-mapper.insert",requestDTO);
		return update_result_status(requestDTO);
	}
	@Override
	public int update_result_status(RequestDTO requestDTO) {
		
		return sqlSession.update("mappers.result-mapper.update_result_status",requestDTO);
	}

	@Override
	public List<ResultDTO> list(String mformnum) {
		logger.info(mformnum);
		return sqlSession.selectList("mappers.result-mapper.list", Integer.parseInt(mformnum));
	}


	

}
