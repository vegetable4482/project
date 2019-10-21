package com.kh.myapp.bbs.dto;

import java.sql.Timestamp;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class FrbbsDTO {

	private int freernum;					//댓글번호
	private int freebnum;					//최초 원글
	
	private String freerid;				//댓글작성자 아이디
	private String freername;	//댓글작성자 별칭
	@JsonFormat(pattern = "yyyy-mm-dd h:mm a", timezone = "Asia/Seoul")	
	private Timestamp freercdate;	//댓글작성일시
	@JsonFormat(pattern = "yyyy-mm-dd h:mm a", timezone = "Asia/Seoul")	
	private Timestamp freerudate; //댓글수정일시
	
	private String freercontent;	//댓글내용
	private int freergood;				//선호
	private int freerbad;					//비선호
	private int freergroup;				//댓글그룹
	private int freerstep;				//댓글단계
	private int freerindent;			//댓글들여쓰기
	
	private Integer freerrnum;		//부모댓글번호
	private String freerrname;//부모댓글 별칭
	private String freerrid;			//부모댓글 아이디
	
}
