package com.kh.myapp.rebbs.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.kh.myapp.rebbs.dto.REbbsDTO;



@Repository
public class REbbsDAOImplXML implements REbbsDAO {
	private static Logger logger = LoggerFactory.getLogger(REbbsDAOImplXML.class);
	
	@Inject
	SqlSession sqlSession; //SqlsessionTemplate 접근
	
	//게시글 작성
	@Override
	public int write(REbbsDTO rebbsDTO) {
		// TODO Auto-generated method stub
		return sqlSession.insert("mappers.rebbsdaoimplxml-mapper.write", rebbsDTO);
	}
	//게시글 수정
	@Override
	public int modify(REbbsDTO rebbsDTO) {
		// TODO Auto-generated method stub
		return sqlSession.update("mappers.rebbsdaoimplxml-mapper.modify",rebbsDTO);
	}
	//게시글 삭제
	@Override
	public int delete(String reviewbnum) {
		// TODO Auto-generated method stub
		return sqlSession.delete("mappers.rebbsdaoimplxml-mapper.delete",reviewbnum);
	}
	//게시글 보기
	@Override
	public REbbsDTO view(String reviewbnum) {
		REbbsDTO rebbsDTO = null;
		rebbsDTO = sqlSession.selectOne("mappers.rebbsdaoimplxml-mapper.view", reviewbnum);
		
		//조회수 증가
		updateHit(reviewbnum);
		
		return rebbsDTO;
	}
	//게시글 전체 목록
	@Override
	public List<REbbsDTO> list_main() {
		// TODO Auto-generated method stub
		return sqlSession.selectList("mappers.rebbsdaoimplxml-mapper.list_main");
	}

	// 조회수 증가
	private void updateHit(String reviewbnum) {
		sqlSession.update("mappers.rebbsdaoimplxml-mapper.updateHit", reviewbnum);
	}

	@Override
	public List<REbbsDTO> list() {
		// TODO Auto-generated method stub
		return sqlSession.selectList("mappers.rebbsdaoimplxml-mapper.list");
	}

	@Override
	public List<REbbsDTO> list(int starRec, int endRec) {
		Map<String,Object> map = new HashMap<>();
		map.put("starRec", starRec);
		map.put("endRec", endRec);
		return sqlSession.selectList("mappers.rebbsdaoimplxml-mapper.list2", map);
	}

	@Override
	public List<REbbsDTO> list(int starRec, int endRec, String searchType, String keyword) {
		Map<String,Object> map = new HashMap<>();
		map.put("starRec", starRec);
		map.put("endRec", endRec);
		map.put("searchType",searchType);
		map.put("keyword",keyword);
		logger.info("검색어있는경우"+map.toString());
		return sqlSession.selectList("mappers.rebbsdaoimplxml-mapper.list3", map);
	}

	@Override
	public int totalRec() {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("mappers.rebbsdaoimplxml-mapper.totalRec");
	}

	@Override
	public int searchTotalRec(String searchType, String keyword) {
		Map<String,Object> map = new HashMap<>();
		map.put("searchType",searchType);
		map.put("keyword",keyword);
		return sqlSession.selectOne("mappers.rebbsdaoimplxml-mapper.searchTotalRec",map);
	}
}
