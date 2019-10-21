package com.kh.myapp.intbbs.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.kh.myapp.intbbs.dto.IntDTO;

@Repository
public class IntDAOImplJDBC implements IntDAO{

	@Inject
	JdbcTemplate jt;
	
	//주거게시판 작성	
	@Override
	public int write(IntDTO intDTO) {
		int cnt=0;
		StringBuffer sql = new StringBuffer();
		sql.append("insert into boardinterior ");
		sql.append("(Intbnum, Intbtitle, Intbid, Intbname, Intbhit, Intbcontent, Intbgroup, Intbtype, Intbstyle, Intblandmeter, Intbarea, originFn, randomFn) ");
		sql.append("values(boardfreeInt_seq.nextval,?,?,?,0,?,boardfreeInt_seq.currval,?,?,?,?,?,?) ");
		
		cnt = jt.update(sql.toString(),
										intDTO.getIntbtitle(),
										intDTO.getIntbid(),
										intDTO.getIntbname(),
										intDTO.getIntbcontent(),
										intDTO.getIntbtype(),
										intDTO.getIntbstyle(),
										intDTO.getIntblandmeter(),
										intDTO.getIntbarea(),
										intDTO.getOriginFn(),
										intDTO.getRandomFn());
		
		return cnt;
	}
	//주거게시판 수정
	@Override
	public int modify(IntDTO intDTO) {
		int cnt = 0;
		
		StringBuffer sql = new StringBuffer();			
		sql.append("update boardinterior ");
		sql.append("   set intbtitle=?, intbudate=sysdate, intbcontent=? ");
		sql.append(" where intbnum=? ");
		
		cnt = jt.update(sql.toString(), 
				intDTO.getIntbtitle(),intDTO.getIntbcontent(),intDTO.getIntbnum());	
		return cnt;
	}
	//주거게시판 삭제
	@Override
	public int delete(String intbnum) {
    int cnt = 0;
		
		StringBuffer sql = new StringBuffer();
		sql.append("delete from BOARDINTERIOR where intbnum = ? ");		
		
		cnt = jt.update(sql.toString(), intbnum);
		return cnt;
	}
	//주거게시판 보기 안쪽 게시판 누르면 들어가
	@Override
	public IntDTO view(String intbnum) {
	
		IntDTO intDTO = new IntDTO();
		
		StringBuffer sql = new StringBuffer();
		sql.append("select intbnum,intbtitle,intbid,intbname,intbcdate,intbudate, ");
		sql.append("       intbhit,intbcontent,intbgroup,intbstep,intbindent,intbtype,intbstyle,intblandmeter,intbarea, originfn, randomfn");
		sql.append("  from BOARDINTERIOR ");
		sql.append(" where intbnum = ? ");
		
		intDTO = jt.queryForObject(sql.toString(), new BeanPropertyRowMapper<IntDTO>(IntDTO.class), intbnum);
		
		//조회수 증가
				if(intDTO.getIntbid() !=null ) {
					updateHit(intbnum);
				}
				
				return intDTO;
	}
	//조회수증가
	private void updateHit(String intbnum) {
		
		StringBuffer sql = new StringBuffer();
		sql.append("update BOARDINTERIOR set intbhit = intbhit + 1 ");
		sql.append(" where intbnum = ? ");
		
		jt.update(sql.toString(), intbnum);
	}
	//자유게시판 목록보기
	//1)전체
	@Override
	public List<IntDTO> list() {
	List<IntDTO> list = new ArrayList<IntDTO>();		
	StringBuffer sql = new StringBuffer();
	
	sql.append("select * ");
	sql.append("  from BOARDINTERIOR ");
	
	list = jt.query(sql.toString(), new RowMapper<IntDTO>() {

		@Override
		public IntDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
			IntDTO intDTO = new IntDTO();
			intDTO.setIntbnum(rs.getInt("intbnum"));
			intDTO.setIntbtitle(rs.getString("intbtitle"));
			intDTO.setIntbid(rs.getString("intbid"));
			intDTO.setIntbname(rs.getString("intbname"));
			intDTO.setIntbcdate(rs.getDate("intbcdate"));
			intDTO.setIntbudate(rs.getDate("intbudate"));
			intDTO.setIntbhit(rs.getInt("intbhit"));
			intDTO.setIntbcontent(rs.getString("intbcontent"));
			intDTO.setIntbgroup(rs.getInt("intbgroup"));
			intDTO.setIntbstep(rs.getInt("intbstep"));
			intDTO.setIntbindent(rs.getInt("intbindent"));
			intDTO.setIntbtype(rs.getString("intbtype"));
			intDTO.setIntbstyle(rs.getString("intbstyle"));
			intDTO.setIntblandmeter(rs.getString("intblandmeter"));
			intDTO.setIntbarea(rs.getString("intbarea"));
			intDTO.setOriginFn(rs.getString("originFn"));
			intDTO.setRandomFn(rs.getString("randomFn"));
			return intDTO;
		}
	});
	
	return list;
}
//2)검색어 없는 경우
	@Override
	public List<IntDTO> list(int starRec, int endRec) {
List<IntDTO> list = new ArrayList<IntDTO>();
		
		StringBuffer sql = new StringBuffer();
		
		sql.append("select t2.* ");
	  sql.append("from ( select row_number() over (order by intbgroup desc, intbstep asc) as num, t1.* ");
	  sql.append("         from BOARDINTERIOR t1 ) t2 ");
	  sql.append("where num between ? and ? ");
	  
		list = jt.query(sql.toString(), new RowMapper<IntDTO>() {

			@Override
			public IntDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
				IntDTO intDTO = new IntDTO();
				intDTO.setIntbnum(rs.getInt("intbnum"));
				intDTO.setIntbtitle(rs.getString("intbtitle"));
				intDTO.setIntbid(rs.getString("intbid"));
				intDTO.setIntbname(rs.getString("intbname"));
				intDTO.setIntbcdate(rs.getDate("intbcdate"));
				intDTO.setIntbudate(rs.getDate("intbudate"));
				intDTO.setIntbhit(rs.getInt("intbhit"));
				intDTO.setIntbcontent(rs.getString("intbcontent"));
				intDTO.setIntbgroup(rs.getInt("intbgroup"));
				intDTO.setIntbstep(rs.getInt("intbstep"));
				intDTO.setIntbindent(rs.getInt("intbindent"));
				intDTO.setIntbtype(rs.getString("intbtype"));
				intDTO.setIntbstyle(rs.getString("intbstyle"));
				intDTO.setIntblandmeter(rs.getString("intblandmeter"));
				intDTO.setIntbarea(rs.getString("intbarea"));
				intDTO.setOriginFn(rs.getString("originFn"));
				intDTO.setRandomFn(rs.getString("randomFn"));
				return intDTO;
			}
		},starRec,endRec);
	  
		return list;
	}
//3)검색어 있는경우4
	@Override
	public List<IntDTO> list(int starRec, int endRec, String addsearch) {
		
		List<IntDTO> list = new ArrayList<>();
		
		StringBuffer sql = new StringBuffer();
		sql.append("select t2.* ");
	  sql.append("from ( select row_number() over (order by intbgroup desc, intbstep asc) as num, t1.* ");
	  sql.append("         from BOARDINTERIOR t1 ");
		sql.append("        where intbnum > 0 "); 
		
					  switch(addsearch) {
					  case	"BAA" :// 아파트+전체+전체
					  	sql.append("and intbtype 	like '%' || '아파트' || '%' ");
					  	break;
					  case	"CAA" :	//빌라+전체+전체
					  	sql.append("and intbtype  	like '%' || '빌라' || '%' ");	  
					  	break;
					  case	"DAA" :	//주택+전체+전체
					  	sql.append("and intbtype   like '%' || '주택' || '%' ");	  
              break;
              //스타일만 선택
					  case	"ABA" :	//전체+모던+전체
					  	sql.append("and intbstyle like '%' || '모던' || '%' ");		  
					  	break;
					  case	"ACA" :	//전체+클래식+전체
					  	sql.append("and intbstyle like '%' || '클래식' || '%' ");		
					  	break;
					  case	"ADA" :	//전체+빈티지+전체
					  	sql.append("and intbstyle like '%' || '빈티지' || '%' ");		 
					  	break;
					  case	"AEA" :	//전체+인더스트리얼+전체
					  	sql.append("and intbstyle like '%' || '인더스트리얼' || '%' ");	
					  	break;
					  case	"AFA" :	//전체+미니멀리즘+전체
					  	sql.append("and intbstyle like '%' || '미니멀리즘' || '%' ");	
              break;
              //평수만 선택
					  case	"AAB" :	//전체+전체+30평이하
					  	sql.append("and intblandmeter like '%' || '30평이하' || '%' ");		
              break;
					  case	"AAC" :	//전체+30평~60평+전체
					  	sql.append("and intblandmeter like '%' || '30평60평' || '%' ");		
              break;
					  case	"AAD" :	//전체+60평이상+전체
					  	sql.append("and intblandmeter like '%' || '60평이상' || '%' ");		 
              break;
            
              //공간-스타일 선택
					  case	"BBA" :	//아파트+모던+전체
					  	sql.append("and intbtype like '%' || '아파트' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '모던' || '%' ");		  
              break;              
              case	"CBA" :	//빌라+모던+전체
					  	sql.append("and intbtype like '%' || '빌라' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '모던' || '%' ");		  
              break;
              case	"DBA" :	//주택+모던+전체
					  	sql.append("and intbtype like '%' || '주택' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '모던' || '%' ");		  
              break;
              
              //공간-스타일 선택
              case	"BCA" :	//아파트+클래식+전체
					  	sql.append("and intbtype like '%' || '아파트' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '클래식' || '%' ");	
              break;
              case	"CCA" :	//빌라+클래식+전체
					  	sql.append("and intbtype like '%' || '빌라' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '클래식' || '%' ");		
              break;
              case	"DCA" :	//주택+클래식+전체
					  	sql.append("and intbtype like '%' || '주택' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '클래식' || '%' ");		
              break;
              
              //공간-스타일 선택
              case	"BDA" :	//아파트+빈티지+전체
					  	sql.append("and intbtype like '%' || '아파트' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '빈티지' || '%' ");		
              break;
              case	"CDA" :	//빌라+빈티지+전체
					  	sql.append("and intbtype like '%' || '빌라' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '빈티지' || '%' ");		 
              break;
              case	"DDA" :	//주택+빈티지+전체
					  	sql.append("and intbtype like '%' || '주택' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '빈티지' || '%' ");		  
              break;
              
              //공간-스타일 선택
              case	"BEA" :	//아파트+인더스트리얼+전체
					  	sql.append("and intbtype like '%' || '아파트' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '인더스트리얼' || '%' ");		
              break;
              case	"CEA" :	//빌라+인더스트리얼+전체
					  	sql.append("and intbtype like '%' || '빌라' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '인더스트리얼' || '%' ");		  
              break;
              case	"DEA" :	//주택+인더스트리얼+전체
					  	sql.append("and intbtype like '%' || '주택' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '인더스트리얼' || '%' ");		 
              break;
              
              //공간-스타일 선택
              case	"BFA" :	//아파트+미니멀리즘+전체
					  	sql.append("and intbtype like '%' || '아파트' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '미니멀리즘' || '%' ");	
              break;
              case	"CFA" :	//빌라+미니멀리즘+전체
					  	sql.append("and intbtype like '%' || '빌라' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '미니멀리즘' || '%' ");		
              break;
              case	"DFA" :	//주택+미니멀리즘+전체
					  	sql.append("and intbtype like '%' || '주택' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '미니멀리즘' || '%' ");		  
              break;
              
              //스타일-평수 선택
              case	"ABB" :	//전체+모던+30평이하
					  	sql.append("and intbstyle like '%' || '모던' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '30평이하' || '%' ");		
              break;
              case	"ACB" :	//전체+클래식+30평이하
					  	sql.append("and intbstyle like '%' || '클래식' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '30평이하' || '%' ");	
              break;
              case	"ADB" :	//전체+빈티지+30평이하
					  	sql.append("and intbstyle like '%' || '빈티지' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '30평이하' || '%' ");	
              break;
              case	"AEB" :	//전체+인더스트리얼+30평이하
					  	sql.append("and intbstyle like '%' || '인더스트리얼' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '30평이하' || '%' ");		
              break;
              case	"AFB" :	//전체+미니멀리즘+30평이하
					  	sql.append("and intbstyle like '%' || '미니멀리즘' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '30평이하' || '%' ");		
              break;
              
              //스타일-평수 선택
              case	"ABC" :	//전체+모던+30~60평
					  	sql.append("and intbstyle like '%' || '모던' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '30평~60평' || '%' ");		
              break;
              case	"ACC" :	//전체+클래식+30평60평
					  	sql.append("and intbstyle like '%' || '클래식' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '30평~60평' || '%' ");	
              break;
              case	"ADC" :	//전체+빈티지+30평60평
					  	sql.append("and intbstyle like '%' || '빈티지' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '30평~60평' || '%' ");	
              break;
              case	"AEC" :	//전체+인더스트리얼+30평60평
					  	sql.append("and intbstyle like '%' || '인더스트리얼' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '30평~60평' || '%' ");	
              break;
              case	"AFC" :	//전체+미니멀리즘+30평60평
					  	sql.append("and intbstyle like '%' || '미니멀리즘' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '30평~60평' || '%' ");		
              break;
              
              //스타일-평수 선택
              case	"ABD" :	//전체+모던+60평이상
					  	sql.append("and intbstyle like '%' || '모던' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '60평이상' || '%' ");		
              break;
              case	"ACD" :	//전체+클래식+60평이상
					  	sql.append("and intbstyle like '%' || '클래식' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '60평이상' || '%' ");		
              break;
              case	"ADD" :	//전체+빈티지+60평이상
					  	sql.append("and intbstyle like '%' || '빈티지' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '60평이상' || '%' ");	
              break;
              case	"AED" :	//전체+인더스트리얼+60평이상
					  	sql.append("and intbstyle like '%' || '인더스트리얼' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '60평이상' || '%' ");		  
              break;
              case	"AFD" :	//전체+미니멀리즘+60평이상
					  	sql.append("and intbstyle like '%' || '미니멀리즘' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '60평이상' || '%' ");		  
              break;
              
              //공간-평수 선택
              case	"BAB" :	//아파트+전체+30평 이하
					  	sql.append("and intbtype like '%' || '모던' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '30평이하' || '%' ");		 
              break;
              case	"CAB" :	//빌라+전체+30평 이하
					  	sql.append("and intbtype like '%' || '클래식' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '30평이하' || '%' ");		
              break;
              case	"DAB" :	//주택+전체+30평 이하
					  	sql.append("and intbtype like '%' || '빈티지' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '30평이하' || '%' ");		  
              break;

              //공간-평수 선택
              case	"BAC" :	//아파트+전체+30평~60평
					  	sql.append("and intbtype like '%' || '아파트' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '30평~60평' || '%' ");	
              break;
              case	"CAC" :	//빌라+전체+30평~60평
					  	sql.append("and intbtype like '%' || '빌라' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '30평~60평' || '%' ");	
              break;
              case	"DAC" :	//주택+전체+30평~60평
					  	sql.append("and intbtype like '%' || '주택' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '30평~60평' || '%' ");	
              break;

              //공간-평수 선택
              case	"BAD" :	//아파트+전체+60평이상
					  	sql.append("and intbtype like '%' || '아파트' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '60평이상' || '%' ");		
              break;
              case	"CAD" :	//빌라+전체+60평이상
					  	sql.append("and intbtype like '%' || '빌라' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '60평이상' || '%' ");	
              break;
              case	"DAD" :	//주택+전체+60평이상
					  	sql.append("and intbtype like '%' || '주택' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '60평이상' || '%' ");	
              break;

              //공간-모던-30평이하 선택
              case	"BBB" :	//아파트+모던+30평이하
					  	sql.append("and intbtype like '%' || '아파트' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '모던' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '30평이하' || '%' ");		 
              break;
              case	"CBB" :	//빌라+모던+30평이하
					  	sql.append("and intbtype like '%' || '빌라' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '모던' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '30평이하' || '%' ");		 
              break;
              case	"DBB" :	//주택+모던+30평이하
					  	sql.append("and intbtype like '%' || '주택' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '모던' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '30평이하' || '%' ");	
              break;
              
              //공간-클래식-30평이하 선택
              case	"BCB" :	//아파트+클래식+30평이하
					  	sql.append("and intbtype like '%' || '아파트' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '클래식' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '30평이하' || '%' ");		 
              break;
              case	"CCB" :	//빌라+클래식+30평이하
					  	sql.append("and intbtype like '%' || '빌라' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '클래식' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '30평이하' || '%' ");		
              break;
              case	"DCB" :	//주택+클래식+30평이하
					  	sql.append("and intbtype like '%' || '주택' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '클래식' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '30평이하' || '%' ");		
              break;
              
              //공간-빈티지-30평이하선택
              case	"BDB" :	//아파트+빈티지+30평이하
					  	sql.append("and intbtype like '%' || '아파트' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '빈티지' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '30평이하' || '%' ");		
              break;
              case	"CDB" :	//빌라+빈티지+30평이하
					  	sql.append("and intbtype like '%' || '빌라' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '빈티지' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '30평이하' || '%' ");	
              break;
              case	"DDB" :	//주택+빈티지+30평이하
					  	sql.append("and intbtype like '%' || '주택' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '빈티지' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '30평이하' || '%' ");		
              break;
              
              //공간-인더스트리얼-30평이하선택
              case	"BEB" :	//아파트+인더스트리얼+30평이하
					  	sql.append("and intbtype like '%' || '아파트' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '인더스트리얼' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '30평이하' || '%' ");		
              break;
              case	"CEB" :	//빌라+인더스트리얼+30평이하
					  	sql.append("and intbtype like '%' || '빌라' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '인더스트리얼' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '30평이하' || '%' ");	
              break;
              case	"DEB" :	//주택+인더스트리얼+30평이하
					  	sql.append("and intbtype like '%' || '주택' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '인더스트리얼' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '30평이하' || '%' ");		
              break;
              
              //공간-미니멀리즘-30평이하선택
              case	"BFB" :	//아파트+미니멀리즘+30평이하
					  	sql.append("and intbtype like '%' || '아파트' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '미니멀리즘' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '30평이하' || '%' ");		  
              break;
              case	"CFB" :	//빌라+미니멀리즘+30평이하
					  	sql.append("and intbtype like '%' || '빌라' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '미니멀리즘' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '30평이하' || '%' ");	
              break;
              case	"DFB" :	//주택+미니멀리즘+30평이하
					  	sql.append("and intbtype like '%' || '주택' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '미니멀리즘' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '30평이하' || '%' ");	
              break;

              //공간-모던-30평~60평
              case	"BBC" :	//아파트+모던+30평~60평
					  	sql.append("and intbtype like '%' || '아파트' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '모던' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '30평~60평' || '%' ");	
              break;
              case	"CBC" :	//빌라+모던+30평~60평
					  	sql.append("and intbtype like '%' || '빌라' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '모던' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '30평~60평' || '%' ");	
              break;
              case	"DBC" :	//주택+모던+30평~60평
					  	sql.append("and intbtype like '%' || '주택' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '모던' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '30평~60평' || '%' ");		
              break;

              //공간-클래식-30평~60평
              case	"BCC" :	//아파트+클래식+30평~60평
					  	sql.append("and intbtype like '%' || '아파트' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '클래식' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '30평~60평' || '%' ");	
              break;
              case	"CCC" :	//빌라+클래식+30평~60평
					  	sql.append("and intbtype like '%' || '빌라' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '클래식' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '30평~60평' || '%' ");	
              break;
              case	"DCC" :	//주택+클래식+30평~60평
					  	sql.append("and intbtype like '%' || '주택' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '클래식' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '30평~60평' || '%' ");		
              break;
              
              //공간-빈티지-30평~60평
              case	"BDC" :	//아파트+빈티지+30평~60평
					  	sql.append("and intbtype like '%' || '아파트' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '빈티지' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '30평~60평' || '%' ");	
              break;
              case	"CDC" :	//빌라+빈티지+30평~60평
					  	sql.append("and intbtype like '%' || '빌라' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '빈티지' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '30평~60평' || '%' ");
              break;
              case	"DDC" :	//주택+빈티지+30평~60평
					  	sql.append("and intbtype like '%' || '주택' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '빈티지' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '30평~60평' || '%' ");		
              break;
              
              //공간-인더스트리얼-30평~60평
              case	"BEC" :	//아파트+인더스트리얼+30평~60평
					  	sql.append("and intbtype like '%' || '아파트' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '인더스트리얼' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '30평~60평' || '%' ");	
              break;
              case	"CEC" :	//빌라+인더스트리얼+30평~60평
					  	sql.append("and intbtype like '%' || '빌라' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '인더스트리얼' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '30평~60평' || '%' ");	
              break;
              case	"DEC" :	//주택+인더스트리얼+30평~60평
					  	sql.append("and intbtype like '%' || '주택' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '인더스트리얼' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '30평~60평' || '%' ");		
              break;
              
              //공간-미니멀리즘-30평~60평
              case	"BFC" :	//아파트+미니멀리즘+30평~60평
					  	sql.append("and intbtype like '%' || '아파트' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '미니멀리즘' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '30평~60평' || '%' ");		
              break;
              case	"CFC" :	//빌라+미니멀리즘+30평~60평
					  	sql.append("and intbtype like '%' || '빌라' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '미니멀리즘' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '30평~60평' || '%' ");	
              break;
              case	"DFC" :	//주택+미니멀리즘+30평~60평
					  	sql.append("and intbtype like '%' || '아파트' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '주택' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '30평~60평' || '%' ");	
              break;
              
              //공간-모던-60평이상
              case	"BBD" :	//아파트+모던+60평이상
					  	sql.append("and intbtype like '%' || '아파트' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '모던' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '60평이상' || '%' ");		 
              break;
              case	"CBD" :	//빌라+모던+60평이상
					  	sql.append("and intbtype like '%' || '빌라' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '모던' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '60평이상' || '%' ");	
              break;
              case	"DBD" :	//주택+모던+60평이상
					  	sql.append("and intbtype like '%' || '주택' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '모던' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '60평이상' || '%' ");	
              break;
              
              //공간-클래식-60평이상
              case	"BCD" :	//아파트+클래식+60평이상
					  	sql.append("and intbtype like '%' || '아파트' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '클래식' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '60평이상' || '%' ");	
              break;
              case	"CCD" :	//빌라+클래식+60평이상
					  	sql.append("and intbtype like '%' || '빌라' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '클래식' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '60평이상' || '%' ");		 
              break;
              case	"DCD" :	//주택+클래식+60평이상
					  	sql.append("and intbtype like '%' || '주택' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '클래식' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '60평이상' || '%' ");		
              break;
              
              //공간-빈티지-60평이상
              case	"BDD" :	//아파트+빈티지+60평이상
					  	sql.append("and intbtype like '%' || '아파트' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '빈티지' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '60평이상' || '%' ");	
              break;
              case	"CDD" :	//빌라+빈티지+60평이상
					  	sql.append("and intbtype like '%' || '빌라' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '빈티지' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '60평이상' || '%' ");
              break;
              case	"DDD" :	//주택+빈티지+60평이상
					  	sql.append("and intbtype like '%' || '주택' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '빈티지' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '60평이상' || '%' ");	
              break;
              
              //공간-인더스트리얼-60평이상
              case	"BED" :	//아파트+인더스트리얼+60평이상
					  	sql.append("and intbtype like '%' || '아파트' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '인더스트리얼' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '60평이상' || '%' ");	
              break;
              case	"CED" :	//빌라+인더스트리얼+60평이상
					  	sql.append("and intbtype like '%' || '빌라' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '인더스트리얼' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '60평이상' || '%' ");	
              break;
              case	"DED" :	//주택+인더스트리얼+60평이상
					  	sql.append("and intbtype like '%' || '주택' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '인더스트리얼' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '60평이상' || '%' ");	
              break;
              
              //공간-미니멀리즘-60평이상
              case	"BFD" :	//아파트+미니멀리즘+60평이상
					  	sql.append("and intbtype like '%' || '아파트' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '미니멀리즘' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '60평이상' || '%' ");		 
              break;
              case	"CFD" :	//빌라+미니멀리즘+60평이상
					  	sql.append("and intbtype like '%' || '빌라' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '미니멀리즘' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '60평이상' || '%' ");		  
              break;
              case	"DFD" :	//주택+미니멀리즘+60평이상
					  	sql.append("and intbtype like '%' || '주택' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '미니멀리즘' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '60평이상' || '%' ");		
              break;
          	
              
            default : // 전체+전체+전체
             	  	
					  	break;
					  }  
	  sql.append("    ) t2 ");
	  list = jt.query(sql.toString(), new BeanPropertyRowMapper<IntDTO>(IntDTO.class));
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
		sql.append("select count(intbnum) toalcnt from BOARDINTERIOR ");
	  
		cnt =	jt.queryForObject(sql.toString(), Integer.class);

		return cnt;
	}
	
	@Override
	public int reply(IntDTO intDTO) {
		// TODO Auto-generated method stub
		return 0;
	}
	
	//2)검색어 있는경우2
	@Override
	public int searchTotalRec2(String addsearch) {
		
	int totalRec = 0;
		System.out.println(addsearch);
		
		StringBuffer sql = new StringBuffer();	
		sql.append("select count(intbnum) totalRec ");
	  sql.append("from ( select row_number() over (order by intbgroup desc, intbstep asc) as num, t1.* ");
	  sql.append("         from BOARDINTERIOR t1 ");
		sql.append("        where intbnum > 0 "); 
		
					  switch(addsearch) {
					  case	"BAA" :// 아파트+전체+전체
					  	sql.append("and intbtype 	like '%' || '아파트' || '%' ");
					  	break;
					  case	"CAA" :	//빌라+전체+전체
					  	sql.append("and intbtype  	like '%' || '빌라' || '%' ");	  
					  	break;
					  case	"DAA" :	//주택+전체+전체
					  	sql.append("and intbtype   like '%' || '주택' || '%' ");	  
              break;
              //스타일만 선택
					  case	"ABA" :	//전체+모던+전체
					  	sql.append("and intbstyle like '%' || '모던' || '%' ");		  
					  	break;
					  case	"ACA" :	//전체+클래식+전체
					  	sql.append("and intbstyle like '%' || '클래식' || '%' ");		  
					  	break;
					  case	"ADA" :	//전체+빈티지+전체
					  	sql.append("and intbstyle like '%' || '빈티지' || '%' ");		  
					  	break;
					  case	"AEA" :	//전체+인더스트리얼+전체
					  	sql.append("and intbstyle like '%' || '인더스트리얼' || '%' ");		  
					  	break;
					  case	"AFA" :	//전체+미니멀리즘+전체
					  	sql.append("and intbstyle like '%' || '미니멀리즘' || '%' ");		  
              break;
              //평수만 선택
					  case	"AAB" :	//전체+전체+30평이하
					  	sql.append("and intblandmeter like '%' || '30평이하' || '%' ");		  
              break;
					  case	"AAC" :	//전체+30평~60평+전체
					  	sql.append("and intblandmeter like '%' || '30평~60평' || '%' ");		  
              break;
					  case	"AAD" :	//전체+60평이상+전체
					  	sql.append("and intblandmeter like '%' || '60평이상' || '%' ");		  
              break;
            
              //공간-스타일 선택
					  case	"BBA" :	//아파트+모던+전체
					  	sql.append("and intbtype like '%' || '아파트' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '모던' || '%' ");		  
              break;              
              case	"CBA" :	//빌라+모던+전체
					  	sql.append("and intbtype like '%' || '빌라' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '모던' || '%' ");		  
              break;
              case	"DBA" :	//주택+모던+전체
					  	sql.append("and intbtype like '%' || '주택' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '모던' || '%' ");		  
              break;
              
              //공간-스타일 선택
              case	"BCA" :	//아파트+클래식+전체
					  	sql.append("and intbtype like '%' || '아파트' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '클래식' || '%' ");		  
              break;
              case	"CCA" :	//빌라+클래식+전체
					  	sql.append("and intbtype like '%' || '빌라' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '클래식' || '%' ");		  
              break;
              case	"DCA" :	//주택+클래식+전체
					  	sql.append("and intbtype like '%' || '주택' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '클래식' || '%' ");		  
              break;
              
              //공간-스타일 선택
              case	"BDA" :	//아파트+빈티지+전체
					  	sql.append("and intbtype like '%' || '아파트' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '빈티지' || '%' ");		  
              break;
              case	"CDA" :	//빌라+빈티지+전체
					  	sql.append("and intbtype like '%' || '빌라' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '빈티지' || '%' ");		  
              break;
              case	"DDA" :	//주택+빈티지+전체
					  	sql.append("and intbtype like '%' || '주택' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '빈티지' || '%' ");		  
              break;
              
              //공간-스타일 선택
              case	"BEA" :	//아파트+인더스트리얼+전체
					  	sql.append("and intbtype like '%' || '아파트' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '인더스트리얼' || '%' ");		  
              break;
              case	"CEA" :	//빌라+인더스트리얼+전체
					  	sql.append("and intbtype like '%' || '빌라' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '인더스트리얼' || '%' ");		  
              break;
              case	"DEA" :	//주택+인더스트리얼+전체
					  	sql.append("and intbtype like '%' || '주택' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '인더스트리얼' || '%' ");		  
              break;
              
              //공간-스타일 선택
              case	"BFA" :	//아파트+미니멀리즘+전체
					  	sql.append("and intbtype like '%' || '아파트' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '미니멀리즘' || '%' ");		  
              break;
              case	"CFA" :	//빌라+미니멀리즘+전체
					  	sql.append("and intbtype like '%' || '빌라' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '미니멀리즘' || '%' ");		  
              break;
              case	"DFA" :	//주택+미니멀리즘+전체
					  	sql.append("and intbtype like '%' || '주택' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '미니멀리즘' || '%' ");		  
              break;
              
              //스타일-평수 선택
              case	"ABB" :	//전체+모던+30평이하
					  	sql.append("and intbstyle like '%' || '모던' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '30평이하' || '%' ");		  
              break;
              case	"ACB" :	//전체+클래식+30평이하
					  	sql.append("and intbstyle like '%' || '클래식' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '30평이하' || '%' ");		  
              break;
              case	"ADB" :	//전체+빈티지+30평이하
					  	sql.append("and intbstyle like '%' || '빈티지' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '30평이하' || '%' ");		  
              break;
              case	"AEB" :	//전체+인더스트리얼+30평이하
					  	sql.append("and intbstyle like '%' || '인더스트리얼' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '30평이하' || '%' ");		  
              break;
              case	"AFB" :	//전체+미니멀리즘+30평이하
					  	sql.append("and intbstyle like '%' || '미니멀리즘' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '30평이하' || '%' ");		  
              break;
              
              //스타일-평수 선택
              case	"ABC" :	//전체+모던+30~60평
					  	sql.append("and intbstyle like '%' || '모던' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '30평~60평' || '%' ");		  
              break;
              case	"ACC" :	//전체+클래식+30평60평
					  	sql.append("and intbstyle like '%' || '클래식' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '30평~60평' || '%' ");		  
              break;
              case	"ADC" :	//전체+빈티지+30평60평
					  	sql.append("and intbstyle like '%' || '빈티지' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '30평~60평' || '%' ");		  
              break;
              case	"AEC" :	//전체+인더스트리얼+30평60평
					  	sql.append("and intbstyle like '%' || '인더스트리얼' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '30평~60평' || '%' ");		  
              break;
              case	"AFC" :	//전체+미니멀리즘+30평60평
					  	sql.append("and intbstyle like '%' || '미니멀리즘' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '30평~60평' || '%' ");		  
              break;
              
              //스타일-평수 선택
              case	"ABD" :	//전체+모던+60평이상
					  	sql.append("and intbstyle like '%' || '모던' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '60평이상' || '%' ");		  
              break;
              case	"ACD" :	//전체+클래식+60평이상
					  	sql.append("and intbstyle like '%' || '클래식' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '60평이상' || '%' ");		  
              break;
              case	"ADD" :	//전체+빈티지+60평이상
					  	sql.append("and intbstyle like '%' || '빈티지' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '60평이상' || '%' ");		  
              break;
              case	"AED" :	//전체+인더스트리얼+60평이상
					  	sql.append("and intbstyle like '%' || '인더스트리얼' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '60평이상' || '%' ");		  
              break;
              case	"AFD" :	//전체+미니멀리즘+60평이상
					  	sql.append("and intbstyle like '%' || '미니멀리즘' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '60평이상' || '%' ");		  
              break;
              
              //공간-평수 선택
              case	"BAB" :	//아파트+전체+30평 이하
					  	sql.append("and intbtype like '%' || '모던' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '30평이하' || '%' ");		  
              break;
              case	"CAB" :	//빌라+전체+30평 이하
					  	sql.append("and intbtype like '%' || '클래식' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '30평이하' || '%' ");		  
              break;
              case	"DAB" :	//주택+전체+30평 이하
					  	sql.append("and intbtype like '%' || '빈티지' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '30평이하' || '%' ");		  
              break;

              //공간-평수 선택
              case	"BAC" :	//아파트+전체+30평~60평
					  	sql.append("and intbtype like '%' || '아파트' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '30평~60평' || '%' ");		  
              break;
              case	"CAC" :	//빌라+전체+30평~60평
					  	sql.append("and intbtype like '%' || '빌라' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '30평~60평' || '%' ");		  
              break;
              case	"DAC" :	//주택+전체+30평~60평
					  	sql.append("and intbtype like '%' || '주택' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '30평~60평' || '%' ");		  
              break;

              //공간-평수 선택
              case	"BAD" :	//아파트+전체+60평이상
					  	sql.append("and intbtype like '%' || '아파트' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '60평이상' || '%' ");		  
              break;
              case	"CAD" :	//빌라+전체+60평이상
					  	sql.append("and intbtype like '%' || '빌라' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '60평이상' || '%' ");		  
              break;
              case	"DAD" :	//주택+전체+60평이상
					  	sql.append("and intbtype like '%' || '주택' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '60평이상' || '%' ");		  
              break;

              //공간-모던-30평이하 선택
              case	"BBB" :	//아파트+모던+30평이하
					  	sql.append("and intbtype like '%' || '아파트' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '모던' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '30평이하' || '%' ");		  
              break;
              case	"CBB" :	//빌라+모던+30평이하
					  	sql.append("and intbtype like '%' || '빌라' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '모던' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '30평이하' || '%' ");		  
              break;
              case	"DBB" :	//주택+모던+30평이하
					  	sql.append("and intbtype like '%' || '주택' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '모던' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '30평이하' || '%' ");		  
              break;
              
              //공간-클래식-30평이하 선택
              case	"BCB" :	//아파트+클래식+30평이하
					  	sql.append("and intbtype like '%' || '아파트' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '클래식' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '30평이하' || '%' ");		  
              break;
              case	"CCB" :	//빌라+클래식+30평이하
					  	sql.append("and intbtype like '%' || '빌라' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '클래식' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '30평이하' || '%' ");		  
              break;
              case	"DCB" :	//주택+클래식+30평이하
					  	sql.append("and intbtype like '%' || '주택' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '클래식' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '30평이하' || '%' ");		  
              break;
              
              //공간-빈티지-30평이하선택
              case	"BDB" :	//아파트+빈티지+30평이하
					  	sql.append("and intbtype like '%' || '아파트' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '빈티지' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '30평이하' || '%' ");		  
              break;
              case	"CDB" :	//빌라+빈티지+30평이하
					  	sql.append("and intbtype like '%' || '빌라' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '빈티지' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '30평이하' || '%' ");		  
              break;
              case	"DDB" :	//주택+빈티지+30평이하
					  	sql.append("and intbtype like '%' || '주택' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '빈티지' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '30평이하' || '%' ");		  
              break;
              
              //공간-인더스트리얼-30평이하선택
              case	"BEB" :	//아파트+인더스트리얼+30평이하
					  	sql.append("and intbtype like '%' || '아파트' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '인더스트리얼' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '30평이하' || '%' ");		  
              break;
              case	"CEB" :	//빌라+인더스트리얼+30평이하
					  	sql.append("and intbtype like '%' || '빌라' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '인더스트리얼' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '30평이하' || '%' ");		  
              break;
              case	"DEB" :	//주택+인더스트리얼+30평이하
					  	sql.append("and intbtype like '%' || '주택' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '인더스트리얼' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '30평이하' || '%' ");		  
              break;
              
              //공간-미니멀리즘-30평이하선택
              case	"BFB" :	//아파트+미니멀리즘+30평이하
					  	sql.append("and intbtype like '%' || '아파트' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '미니멀리즘' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '30평이하' || '%' ");		  
              break;
              case	"CFB" :	//빌라+미니멀리즘+30평이하
					  	sql.append("and intbtype like '%' || '빌라' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '미니멀리즘' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '30평이하' || '%' ");		  
              break;
              case	"DFB" :	//주택+미니멀리즘+30평이하
					  	sql.append("and intbtype like '%' || '주택' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '미니멀리즘' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '30평이하' || '%' ");		  
              break;

              //공간-모던-30평~60평
              case	"BBC" :	//아파트+모던+30평~60평
					  	sql.append("and intbtype like '%' || '아파트' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '모던' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '30평~60평' || '%' ");		  
              break;
              case	"CBC" :	//빌라+모던+30평~60평
					  	sql.append("and intbtype like '%' || '빌라' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '모던' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '30평~60평' || '%' ");		  
              break;
              case	"DBC" :	//주택+모던+30평~60평
					  	sql.append("and intbtype like '%' || '주택' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '모던' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '30평~60평' || '%' ");		  
              break;

              //공간-클래식-30평~60평
              case	"BCC" :	//아파트+클래식+30평~60평
					  	sql.append("and intbtype like '%' || '아파트' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '클래식' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '30평~60평' || '%' ");		  
              break;
              case	"CCC" :	//빌라+클래식+30평~60평
					  	sql.append("and intbtype like '%' || '빌라' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '클래식' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '30평~60평' || '%' ");		  
              break;
              case	"DCC" :	//주택+클래식+30평~60평
					  	sql.append("and intbtype like '%' || '주택' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '클래식' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '30평~60평' || '%' ");		  
              break;
              
              //공간-빈티지-30평~60평
              case	"BDC" :	//아파트+빈티지+30평~60평
					  	sql.append("and intbtype like '%' || '아파트' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '빈티지' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '30평~60평' || '%' ");		  
              break;
              case	"CDC" :	//빌라+빈티지+30평~60평
					  	sql.append("and intbtype like '%' || '빌라' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '빈티지' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '30평~60평' || '%' ");		  
              break;
              case	"DDC" :	//주택+빈티지+30평~60평
					  	sql.append("and intbtype like '%' || '주택' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '빈티지' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '30평~60평' || '%' ");		  
              break;
              
              //공간-인더스트리얼-30평~60평
              case	"BEC" :	//아파트+인더스트리얼+30평~60평
					  	sql.append("and intbtype like '%' || '아파트' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '인더스트리얼' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '30평~60평' || '%' ");		  
              break;
              case	"CEC" :	//빌라+인더스트리얼+30평~60평
					  	sql.append("and intbtype like '%' || '빌라' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '인더스트리얼' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '30평~60평' || '%' ");		  
              break;
              case	"DEC" :	//주택+인더스트리얼+30평~60평
					  	sql.append("and intbtype like '%' || '주택' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '인더스트리얼' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '30평~60평' || '%' ");		  
              break;
              
              //공간-미니멀리즘-30평~60평
              case	"BFC" :	//아파트+미니멀리즘+30평~60평
					  	sql.append("and intbtype like '%' || '아파트' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '미니멀리즘' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '30평~60평' || '%' ");		  
              break;
              case	"CFC" :	//빌라+미니멀리즘+30평~60평
					  	sql.append("and intbtype like '%' || '빌라' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '미니멀리즘' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '30평~60평' || '%' ");		  
              break;
              case	"DFC" :	//주택+미니멀리즘+30평~60평
					  	sql.append("and intbtype like '%' || '아파트' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '주택' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '30평~60평' || '%' ");		  
              break;
              
              //공간-모던-60평이상
              case	"BBD" :	//아파트+모던+60평이상
					  	sql.append("and intbtype like '%' || '아파트' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '모던' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '60평이상' || '%' ");		  
              break;
              case	"CBD" :	//빌라+모던+60평이상
					  	sql.append("and intbtype like '%' || '빌라' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '모던' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '60평이상' || '%' ");		  
              break;
              case	"DBD" :	//주택+모던+60평이상
					  	sql.append("and intbtype like '%' || '주택' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '모던' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '60평이상' || '%' ");		  
              break;
              
              //공간-클래식-60평이상
              case	"BCD" :	//아파트+클래식+60평이상
					  	sql.append("and intbtype like '%' || '아파트' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '클래식' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '60평이상' || '%' ");		  
              break;
              case	"CCD" :	//빌라+클래식+60평이상
					  	sql.append("and intbtype like '%' || '빌라' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '클래식' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '60평이상' || '%' ");		  
              break;
              case	"DCD" :	//주택+클래식+60평이상
					  	sql.append("and intbtype like '%' || '주택' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '클래식' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '60평이상' || '%' ");		  
              break;
              
              //공간-빈티지-60평이상
              case	"BDD" :	//아파트+빈티지+60평이상
					  	sql.append("and intbtype like '%' || '아파트' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '빈티지' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '60평이상' || '%' ");		  
              break;
              case	"CDD" :	//빌라+빈티지+60평이상
					  	sql.append("and intbtype like '%' || '빌라' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '빈티지' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '60평이상' || '%' ");		  
              break;
              case	"DDD" :	//주택+빈티지+60평이상
					  	sql.append("and intbtype like '%' || '주택' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '빈티지' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '60평이상' || '%' ");		  
              break;
              
              //공간-인더스트리얼-60평이상
              case	"BED" :	//아파트+인더스트리얼+60평이상
					  	sql.append("and intbtype like '%' || '아파트' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '인더스트리얼' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '60평이상' || '%' ");		  
              break;
              case	"CED" :	//빌라+인더스트리얼+60평이상
					  	sql.append("and intbtype like '%' || '빌라' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '인더스트리얼' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '60평이상' || '%' ");		  
              break;
              case	"DED" :	//주택+인더스트리얼+60평이상
					  	sql.append("and intbtype like '%' || '주택' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '인더스트리얼' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '60평이상' || '%' ");		  
              break;
              
              //공간-미니멀리즘-60평이상
              case	"BFD" :	//아파트+미니멀리즘+60평이상
					  	sql.append("and intbtype like '%' || '아파트' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '미니멀리즘' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '60평이상' || '%' ");		  
              break;
              case	"CFD" :	//빌라+미니멀리즘+60평이상
					  	sql.append("and intbtype like '%' || '빌라' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '미니멀리즘' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '60평이상' || '%' ");		  
              break;
              case	"DFD" :	//주택+미니멀리즘+60평이상
					  	sql.append("and intbtype like '%' || '주택' || '%' ");		  
					  	sql.append("and intbstyle like '%' || '미니멀리즘' || '%' ");		  
					  	sql.append("and intblandmeter like '%' || '60평이상' || '%' ");		  
              break;
  
            default : // 전체+전체+전체
             	  	
					  	break;
					  }  
	  sql.append("    ) t2 ");
	  
		return totalRec;
	}
	@Override
	public int searchTotalRec(String searchType, String keyword) {
		
		return 0;
	}

}

