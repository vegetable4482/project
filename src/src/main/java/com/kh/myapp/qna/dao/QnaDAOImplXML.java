package com.kh.myapp.qna.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.kh.myapp.qna.dto.QnaDTO;

@Repository
public class QnaDAOImplXML implements QnaDAO {

	private static final Logger logger = LoggerFactory.getLogger("QnaDAOImplXML.class");
	
	@Inject
	private SqlSession sqlSession;
	
	@Override
	public int qnainsert(QnaDTO qnaDTO) {
		
		logger.info("QnaDAOImplXML.qnainsert 호출됨!");
		return sqlSession.insert("mappers.qblist-mapper.qnainsert",qnaDTO);
	}
	@Override
	public QnaDTO view(String qnabnum) {
		
		return sqlSession.selectOne("mappers.qblist-mapper.view",qnabnum);
		
	}
	@Override
	public List<QnaDTO> list() {
		
		return sqlSession.selectList("mappers.qblist-mapper.list");
	
	}
	
	@Override
	public List<QnaDTO> list(int startRec, int endRec) {
		
		Map<String,Object> map = new HashMap<>();
		map.put("startRec",startRec);
		map.put("endRec",endRec);
		return sqlSession.selectList("mappers.qblist-mapper.list2",map);

	}
	@Override
	public List<QnaDTO> list(int startRec, int endRec, String searchType, String keyword) {
		Map<String,Object> map = new HashMap<>();
		map.put("startRec",startRec);
		map.put("endRec",endRec);
		map.put("searchType",searchType);
		map.put("keyword",keyword);
		return sqlSession.selectList("mappers.qblist-mapper.list3",map);

	}
	@Override
	public int reply(QnaDTO qnaDTO) {
		return sqlSession.insert("mappers.qblist-mapper.reply",qnaDTO);
		
	}
	@Override
	public int totalRec() {

		return sqlSession.selectOne("mappers.qblist-mapper.totalRec");

	}
	@Override
	public int searchTotalRec(String searchType, String keyword) {
		
		Map<String,Object> map = new HashMap<>();
		map.put("searchType",searchType);
		map.put("keyword",keyword);
		return sqlSession.selectOne("mappers.qblist-mapper.searchTotalRec",map);
		
	}
	

}