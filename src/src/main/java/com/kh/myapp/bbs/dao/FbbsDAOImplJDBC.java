package com.kh.myapp.bbs.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;


import com.kh.myapp.bbs.dto.FbbsDTO;
import com.kh.myapp.bbs.dto.FrbbsDTO;

@Repository
public class FbbsDAOImplJDBC implements FbbsDAO{

	@Inject
	JdbcTemplate jt;
	
	//자유게시판 작성	
	@Override
	public int write(FbbsDTO fbbsDTO) {
		int cnt=0;
		StringBuffer sql = new StringBuffer();
		sql.append("insert into boardfree ");
		sql.append("(freebnum,freebtitle,freebid,freebname,freebhit,freebcontent, freebgroup) ");
		sql.append("values(boardfree_seq.nextval,?,?,?,0,?,boardfree_seq.currval) ");
		
		cnt = jt.update(sql.toString(),fbbsDTO.getFreebtitle(),fbbsDTO.getFreebid(),fbbsDTO.getFreebname(),fbbsDTO.getFreebcontent());
		
		return cnt;
	}
	//자유게시판 수정
	@Override
	public int modify(FbbsDTO fbbsDTO) {
		int cnt = 0;
		
		StringBuffer sql = new StringBuffer();			
		sql.append("update boardfree ");
		sql.append("   set freebtitle=?, freebudate=sysdate, freebcontent=? ");
		sql.append(" where freebnum=? ");
		
		cnt = jt.update(sql.toString(), 
				fbbsDTO.getFreebtitle(),fbbsDTO.getFreebcontent(),fbbsDTO.getFreebnum());	
		return cnt;
	}
	//자유게시판 삭제
	@Override
	public int delete(String freebnum) {
    int cnt = 0;
		
		StringBuffer sql = new StringBuffer();
		sql.append("delete from boardfree where freebnum = ? ");		
		
		cnt = jt.update(sql.toString(), freebnum);
		return cnt;
	}
	//자유게시판 보기
	@Override
	public FbbsDTO view(String freebnum) {
	
		FbbsDTO fbbsDTO = new FbbsDTO();
		
		StringBuffer sql = new StringBuffer();
		sql.append("select freebnum,freebtitle,freebid,freebname,freebcdate,freebudate, ");
		sql.append("       freebhit,freebcontent,freebgroup,freebstep,freebindent ");
		sql.append("  from boardfree ");
		sql.append(" where freebnum = ? ");
		
		fbbsDTO = jt.queryForObject(sql.toString(), new BeanPropertyRowMapper<FbbsDTO>(FbbsDTO.class), freebnum);
		
		//조회수 증가
				if(fbbsDTO.getFreebid() !=null ) {
					updateHit(freebnum);
				}
				
				return fbbsDTO;
	}
	//조회수증가
	private void updateHit(String freebnum) {
		
		StringBuffer sql = new StringBuffer();
		sql.append("update boardfree set freebhit = freebhit + 1 ");
		sql.append(" where freebnum = ? ");
		
		jt.update(sql.toString(), freebnum);
	}
	//자유게시판 목록보기
	//1)전체
	@Override
	public List<FbbsDTO> list() {
	List<FbbsDTO> list = new ArrayList<FbbsDTO>();		
	StringBuffer sql = new StringBuffer();
	
	sql.append("select freebnum,freebtitle,freebid,freebname,freebcdate,freebudate, ");
	sql.append("       freebhit,freebcontent,freebgroup,freebstep,freebindent ");
	sql.append("  from boardfree ");
	
	list = jt.query(sql.toString(), new RowMapper<FbbsDTO>() {

		@Override
		public FbbsDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
			FbbsDTO fbbsDTO = new FbbsDTO();
			fbbsDTO.setFreebnum(rs.getInt("freebnum"));
			fbbsDTO.setFreebtitle(rs.getString("freebtitle"));
			fbbsDTO.setFreebid(rs.getString("freebid"));
			fbbsDTO.setFreebname(rs.getString("freebname"));
			fbbsDTO.setFreebcdate(rs.getDate("freebcdate"));
			fbbsDTO.setFreebudate(rs.getDate("freebudate"));
			fbbsDTO.setFreebhit(rs.getInt("freebhit"));
			fbbsDTO.setFreebcontent(rs.getString("freebcontent"));
			fbbsDTO.setFreebgroup(rs.getInt("freebgroup"));
			fbbsDTO.setFreebstep(rs.getInt("freebstep"));
			fbbsDTO.setFreebindent(rs.getInt("freebindent"));
			return fbbsDTO;
		}
	});
	
	return list;
}
//2)검색어 없는 경우
	@Override
	public List<FbbsDTO> list(int starRec, int endRec) {
List<FbbsDTO> list = new ArrayList<FbbsDTO>();
		
		StringBuffer sql = new StringBuffer();
		
		sql.append("select t2.* ");
	  sql.append("from ( select row_number() over (order by freebgroup desc, freebstep asc) as num, t1.* ");
	  sql.append("         from boardfree t1 ) t2 ");
	  sql.append("where num between ? and ? ");
	  
		list = jt.query(sql.toString(), new RowMapper<FbbsDTO>() {

			@Override
			public FbbsDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
				FbbsDTO fbbsDTO = new FbbsDTO();
				fbbsDTO.setFreebnum(rs.getInt("freebnum"));
				fbbsDTO.setFreebtitle(rs.getString("freebtitle"));
				fbbsDTO.setFreebid(rs.getString("freebid"));
				fbbsDTO.setFreebname(rs.getString("freebname"));
				fbbsDTO.setFreebcdate(rs.getDate("freebcdate"));
				fbbsDTO.setFreebudate(rs.getDate("freebudate"));
				fbbsDTO.setFreebhit(rs.getInt("freebhit"));
				fbbsDTO.setFreebcontent(rs.getString("freebcontent"));
				fbbsDTO.setFreebgroup(rs.getInt("freebgroup"));
				fbbsDTO.setFreebstep(rs.getInt("freebstep"));
				fbbsDTO.setFreebindent(rs.getInt("freebindent"));
				
				return fbbsDTO;
			}
		},starRec,endRec);
	  
		return list;
	}
//3)검색어 있는경우
	@Override
	public List<FbbsDTO> list(int starRec, int endRec, String searchType, String keyword) {
		
List<FbbsDTO> list = new ArrayList<>();
		
		StringBuffer sql = new StringBuffer();
		
		sql.append("select t2.* ");
	  sql.append("from ( select row_number() over (order by freebgroup desc, freebstep asc) as num, t1.* ");
	  sql.append("         from boardfree t1 ");
		sql.append("        where freebnum > 0 "); 
					  switch(searchType) {
					  case	"TC" ://제목+내용
					  	sql.append("and freebtitle   	like '%' || ? || '%' ");
					  	sql.append(" or freebcontent 	like '%' || ? || '%' ");
					  	break;
					  case	"T" :	//제목
					  	sql.append("and freebtitle   	like '%' || ? || '%' ");	  
					  	break;
					  case	"C" :	//내용s
					  	sql.append("and freebcontent   like '%' || ? || '%' ");	  
					  	break;
					  case	"N" :	//작성자(별칭)
					  	sql.append("and freebname like '%' || ? || '%' ");		  
					  	break;
					  case	"I" :	//아이디
					  	sql.append("and freebid   		like '%' || ? || '%' ");		 	  	
					  	break;
					  	
					  default : // 제목 + 내용+ 작성자(별칭)
					  	sql.append("and freebtitle   	like '%' || ? || '%' ");
					  	sql.append(" or freebcontent 	like '%' || ? || '%' ");	 
					  	sql.append(" or freebname like '%' || ? || '%' ");	 	  	
					  	break;
					  }  
	  sql.append("    ) t2 ");
	  sql.append("where num between ? and ? ");
	  	  
		switch(searchType) {
		case "TC":
			list = jt.query(sql.toString(), 
											new BeanPropertyRowMapper<FbbsDTO>(FbbsDTO.class),
											keyword,keyword,starRec,endRec);				
			break;
		case "T" :
		case "C" :
		case "N" :
		case "I" :
			list = jt.query(sql.toString(), 
											new BeanPropertyRowMapper<FbbsDTO>(FbbsDTO.class),
											keyword,starRec,endRec);							
			break;
		default:
			list = jt.query(sql.toString(), 
											new BeanPropertyRowMapper<FbbsDTO>(FbbsDTO.class),
											keyword,keyword,keyword,starRec,endRec);							
			break;
		}	  
		
		return list;
	}

	//게시글 페이징
	//게시글 검색
	//게시글 답글
	
	//자유게시판 총계
		//1)검색어 없는경우	
	@Override
	public int totalRec() {
		
int cnt=0;
		
		StringBuffer sql = new StringBuffer();
		sql.append("select count(freebnum) toalcnt from boardfree ");
	  
		cnt =	jt.queryForObject(sql.toString(), Integer.class);

		return cnt;
	}
	//2)검색어 있는경우
	@Override
	public int searchTotalRec(String searchType, String keyword) {
		
	int totalRec = 0;
		
		StringBuffer sql = new StringBuffer();	
		sql.append("select count(freebnum) totalRec ");
	  sql.append("from ( select row_number() over (order by freebgroup desc, freebstep asc) as num, t1.* ");
	  sql.append("         from boardfree t1 ");
		sql.append("        where freebnum > 0 "); 
					  switch(searchType) {
					  case	"TC" ://제목+내용
					  	sql.append("and freebtitle   	like '%' || ? || '%' ");
					  	sql.append(" or freebcontent 	like '%' || ? || '%' ");
					  	break;
					  case	"T" :	//제목
					  	sql.append("and freebtitle   	like '%' || ? || '%' ");	  
					  	break;
					  case	"C" :	//내용
					  	sql.append("and freebcontent   like '%' || ? || '%' ");	  
					  	break;
					  case	"N" :	//작성자(별칭)
					  	sql.append("and freebname like '%' || ? || '%' ");		  
					  	break;
					  case	"I" :	//아이디
					  	sql.append("and freebid   		like '%' || ? || '%' ");		 	  	
					  	break;
					  	
					  default : // 제목 + 내용+ 작성자(별칭)
					  	sql.append("and freebtitle   	like '%' || ? || '%' ");
					  	sql.append(" or freebcontent 	like '%' || ? || '%' ");	 
					  	sql.append(" or freebname like '%' || ? || '%' ");	 	  	
					  	break;
					  }  
	  sql.append("    ) t2 ");
	  
	  
		switch(searchType) {
		case "TC":
			totalRec = jt.queryForObject( sql.toString(), 
																		Integer.class, 
																		keyword,keyword );	
			break;
		case "T" :
		case "C" :
		case "N" :
		case "I" :
			totalRec = jt.queryForObject( sql.toString(), 
																		Integer.class, 
																		keyword );	
			break;
		default:
			totalRec = jt.queryForObject( sql.toString(), 
																		Integer.class, 
																		keyword,keyword,keyword );			
			break;
		}	  
	  
		return totalRec;
	}
	@Override
	public int reply(FbbsDTO fbbsDTO) {
		// TODO Auto-generated method stub
		return 0;
	}
}

