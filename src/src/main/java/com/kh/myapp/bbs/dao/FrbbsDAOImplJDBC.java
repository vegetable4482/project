package com.kh.myapp.bbs.dao;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.myapp.bbs.dto.FbbsDTO;
import com.kh.myapp.bbs.dto.FrbbsDTO;


@Repository
public class FrbbsDAOImplJDBC implements FrbbsDAO {

	private static Logger logger
	= LoggerFactory.getLogger(FrbbsDAOImplJDBC.class);
	
	@Inject
	JdbcTemplate jt;
	
	
	//댓글 등록
	@Override
	public int write(FrbbsDTO frbbsDTO) {
	
		int cnt = 0;
		StringBuffer sql = new StringBuffer();
		sql.append("INSERT INTO rboardfree (freernum,freerbnum,freerid,freername,freercontent,freergroup,freerstep,freerindent) ");
		sql.append("values(rboardfree_seq.nextval,?,?,?,?,rboardfree_seq.currval,0,0) ");
	
		cnt = jt.update(sql.toString(), 
				frbbsDTO.getFreebnum(),frbbsDTO.getFreerid(),frbbsDTO.getFreername(),frbbsDTO.getFreercontent());		
return cnt;
	
	}
	
	//댓글 목록
		@Override
		public List<FrbbsDTO> list(String freerbnum) {

			List<FrbbsDTO> alist = new ArrayList<>();
			StringBuffer sql = new StringBuffer();
			sql.append("SELECT freernum,freerbnum,freerid,freername,freercdate,freerudate, ");
			sql.append("	     freercontent,freergood,freerbad,freergroup,freerstep,freerindent ");
			sql.append("  FROM (select * from rboardfree ");
			sql.append("         where freerbnum = ? ");		
			sql.append("        order by freergroup desc, freerstep asc ) ");		
			sql.append(" where rownum >=1 and rownum < 25 ");		
			
			
			//case3)
			alist = jt.query(sql.toString(), 
											 new BeanPropertyRowMapper<FrbbsDTO>(FrbbsDTO.class), 
											 freerbnum);		
			return alist;
		}

		@Override
		public List<FrbbsDTO> list(String freerbnum, int startRec, int endRec) {
			List<FrbbsDTO> alist = new ArrayList<>();
			StringBuffer sql = new StringBuffer();
			
			sql.append("select t2.*, ");
	    sql.append("(select freername from rboardfree where freernum = t2.freerrnum and t2.freerrnum > 0) freerrname, ");
	    sql.append("(select freerid  from rboardfree where freernum = t2.freerrnum and t2.freerrnum > 0) freerrid	");	
			sql.append("from (select row_number() over (order by freergroup desc, freerstep asc) as num,t1.* ");
			sql.append("		    from rboardfree t1 ");
			sql.append("			 where freerbnum=? ) t2 ");
			sql.append("where num between ? and ? ");
			
			alist = jt.query(sql.toString(), 
					 						 new BeanPropertyRowMapper<FrbbsDTO>(FrbbsDTO.class), 
					 						 freerbnum,startRec,endRec);		
			
			return alist;
		}
	
	
	
//댓글수정
	@Override
	public int modify(FrbbsDTO frbbsDTO) {
	
		int cnt = 0;
		StringBuffer sql = new StringBuffer();
		sql.append("update rboardfree set freerudate=sysdate, freercontent=? ");
		sql.append("where freernum=? ");
		
		cnt = jt.update(sql.toString(), frbbsDTO.getFreercontent(), frbbsDTO.getFreernum());
		
		return cnt;
	}
//댓글 삭제
	@Override
	public int delete(String freernum) {
		
		int cnt = 0;
		StringBuffer sql = new StringBuffer();
		sql.append("delete from rboardfree where freernum=?");

		cnt = jt.update(sql.toString(), freernum);
		return cnt;
	}
	//댓글 호감 비호감
	@Override
	public int goodOrBad(String freernum, String freegoodOrBad) {
	
        int cnt = 0;
		
		StringBuffer sql = new StringBuffer();		
		switch(freegoodOrBad) {
		case "freegood":
			sql.append("update rboardfree set freergood = freergood + 1 where freernum=?");
			break;
		case "freebad":
			sql.append("update rboardfree set freerbad = freerbad + 1 where freernum=?");			
			break;
		default:
			break;
		}
		
		cnt = jt.update(sql.toString(), freernum);
		return cnt;
	}
	//대댓글 등록
	@Override
	public int reply(FrbbsDTO frbbsDTO) {
	
		int cnt1=0 , cnt2=0;

		//댓글대상 정보 읽어오기
		FrbbsDTO originDTO = replyView(frbbsDTO.getFreernum());
		logger.info("originDTO="+originDTO.toString());
		//이전 답글 step 업데이트(원글그룹에 대한 세로정렬 재정의)
		cnt1 = updateStep(originDTO.getFreergroup(), originDTO.getFreerstep());
		
		StringBuffer sql = new StringBuffer();	
		sql.append("INSERT INTO rboardfree (freernum,freerbnum,freerid,freername,freercontent,freergroup,freerstep,freerindent,freerrnum) ");
		sql.append("values(rboardfree_seq.nextval,?,?,?,?,?,?,?,?) ");		
		
		cnt2 =	jt.update(sql.toString(), 
									originDTO.getFreebnum(),
									frbbsDTO.getFreerid(),
									frbbsDTO.getFreername(),
									frbbsDTO.getFreercontent(),
									originDTO.getFreergroup(),				//원글번호 = 원글 그룹
									originDTO.getFreerstep()+1,				//원글 그룹의 세로정렬(답글단계)
									originDTO.getFreerindent()+1,			//원글 그룹의 가로정렬(들여쓰기)
									frbbsDTO.getFreerrnum());					//부모댓글번호		
		return cnt2;
	}
	
	// 댓글대상 읽어오기
	private FrbbsDTO replyView(int freernum) {
		FrbbsDTO frbbsDTO = new FrbbsDTO();
		
		StringBuffer sql = new StringBuffer();
		sql.append("select freerbnum,freergroup, freerstep, freerindent from rboardfree where freernum = ?");
		
		frbbsDTO = jt.queryForObject(sql.toString(), new BeanPropertyRowMapper<FrbbsDTO>(FrbbsDTO.class), freernum);
		
		return frbbsDTO;
	}

	//댓글단계 업데이트
	private int updateStep(int freergroup, int freerstep) {
		int cnt = 0;
		
		StringBuffer sql = new StringBuffer();
		sql.append("update rboardfree set freerstep=freerstep+1 where freergroup=? and freerstep>?");
		
		cnt = jt.update(sql.toString(), freergroup,freerstep);
		
		return cnt;
	}	
	//대댓글 총계
	@Override
	public int replyTotalRec(String freerbnum) {
	
int totalRec = 0;
		
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT count(*) totalRec from rboardfree where freerbnum=?");

		totalRec = jt.queryForObject(sql.toString(), Integer.class, freerbnum);
		
		return totalRec;
	}



}
