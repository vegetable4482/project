//package com.kh.myapp.request.dao;
//
//import java.util.ArrayList;
//import java.util.List;
//
//import javax.inject.Inject;
//
//import org.springframework.jdbc.core.BeanPropertyRowMapper;
//import org.springframework.jdbc.core.JdbcTemplate;
//import org.springframework.stereotype.Repository;
//
//import com.kh.myapp.request.dto.RequestDTO;
//
//@Repository
//public class RequestDAOImplJDBC{
//
//	@Inject
//	private JdbcTemplate jdbcTemplate;
//	
//	@Override
//	public int insert(RequestDTO requestDTO) {
//
//		int cnt = 0;
//		StringBuffer sql = new StringBuffer();
//		sql.append("insert into estimateform " );
//		sql.append(" (formnum,custid,custname,custphonenum,custrequest,constpostnum,constbasicaddress,constrestaddress,consttype,constdate,formcdate,formudate,conststyle,constspace ) ");
//		sql.append(" values(ESTIMATE_SEQ.nextval,?,?,?,?,?,?,?,?,?,sysdate,sysdate,?,? ) ");
//		
//		cnt = jdbcTemplate.update(sql.toString(),requestDTO.getCustid(),requestDTO.getCustname(),requestDTO.getCustphonenum(),requestDTO.getCustrequest(),
//				requestDTO.getConstpostnum(),requestDTO.getConstbasicaddress(),requestDTO.getConstrestaddress(),requestDTO.getConsttype(),requestDTO.getConstdate(),requestDTO.getConststyle(),requestDTO.getConstspace());
//				
//		return cnt;
//		
//	}
//	
//	//내견적 상세조회
//	@Override
//	public RequestDTO getRequest(String formnum) {
//		RequestDTO requestDTO = new RequestDTO();
//
//		StringBuffer sql = new StringBuffer();
//		sql.append("select custid,custname,custphonenum,custrequest,constpostnum,constbasicaddress,constrestaddress,consttype,constdate,conststyle,constspace ");
//		sql.append(" from estimateform ");
//		sql.append(" where formnum= ? ");
//		
//		requestDTO = jdbcTemplate.queryForObject(sql.toString(), new BeanPropertyRowMapper<RequestDTO>(RequestDTO.class), formnum);
//	
//		return requestDTO;
//	}
//
//	//견적 목록
//	@Override
//	public List<RequestDTO> list(String custid) {
//		
//		List<RequestDTO> list = new ArrayList<>();		
//		StringBuffer sql = new StringBuffer();
//		
//		sql.append("select formnum,custid,custname,custphonenum,custrequest,constbasicaddress,constrestaddress,consttype,constdate,conststyle,constspace ");
//		sql.append(" from estimateform "); 
//		sql.append(" where custid= ? ");
//		
//		list = jdbcTemplate.query(sql.toString(), new BeanPropertyRowMapper<RequestDTO>(RequestDTO.class),custid);
//		
//		return list;
//	}
//}