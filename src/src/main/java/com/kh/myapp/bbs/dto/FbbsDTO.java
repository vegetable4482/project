package com.kh.myapp.bbs.dto;

import java.sql.Date;

import javax.persistence.Entity;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import lombok.Data;

@Entity
@Data
public class FbbsDTO {

	private int freebnum;
	
	@NotNull
	@Size(min=4,max=30,message="제목은 4~30자 까지 입력 가능합니다!")
	private String 		freebtitle;				//자유게시판제목
	@NotNull
	private String 		freebid;					//자유게시판작성자ID
	@NotNull
	private String 		freebname;				//자유게시판작성자(별칭)
	private Date		freebcdate;				//자유게시판생성일
	private Date 		freebudate;				//자유게시판수정일
	private int 		freebhit;					//자유게시판조회수
	
	@NotNull
	@Size(min=4,max=100,message="내용은 4~100자 까지 입력 가능합니다!")
	private	String 		freebcontent;			//자유게시판본문내용
	private int 		freebgroup;				//자유게시판답글그룹
	private int 		freebstep;				//자유게시판답글의 단계
	private int 		freebindent;			//자유게시판답글의 들여쓰기
}
 