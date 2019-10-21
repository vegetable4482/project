package com.kh.myapp.intbbs.dto;

import java.sql.Date;

import javax.persistence.Entity;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Entity
@Data
public class IntDTO {

	private int intbnum;//주거게시판번호
	
	@NotNull
	@Size(min=4,max=30,message="제목은 4~30자 까지 입력 가능합니다!")
	private String 		intbtitle;				//주거게시판제목
	@NotNull
	private String 		intbid;					//주거게시판작성자ID
	@NotNull
	private String 		intbname;				//주거게시판작성자(별칭)
	private Date		intbcdate;				//주거게시판생성일
	private Date 		intbudate;				//주거게시판수정일
	private int 		intbhit;					//주거게시판조회수
	
	@NotNull
	@Size(min=4,max=100,message="내용은 4~100자 까지 입력 가능합니다!")
	private	String 		intbcontent;			//자유게시판본문내용
	private int 		intbgroup;				//자유게시판답글그룹
	private int 		intbstep;				//자유게시판답글의 단계
	private int 		intbindent;			//자유게시판답글의 들여쓰기
	@NotNull
	private String intbmodifystatus; //글수정상태정보
	private String intbtype;          //공사지 공간
	private String intbstyle;          //공사지 스타일
	private String intblandmeter;     //공사지 평수
	private String intbarea;          //공사지 지역
	//파일 이미지 첨부
	private MultipartFile file;
	private String originFn; //업로드 파일명
	private String randomFn; //내부관리되는 실제 파일명(랜덤)
}
 