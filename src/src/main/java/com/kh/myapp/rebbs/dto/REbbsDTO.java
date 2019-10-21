package com.kh.myapp.rebbs.dto;



import java.sql.Date;

import javax.persistence.Entity;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;



@Entity
@Data
public class REbbsDTO {
	private int reviewbnum;    //게시글 번호
	
	@NotNull
	@Size(min=4,max=30,message="제목은 4~30자 까지 입력 가능합니다!")
	private String reviewbtitle; //제목
	@NotNull
	private String reviewbid; //작성자ID
	@NotNull
	private String reviewbname; //작성자(이름)
	
	private Date reviewbcdate; //게시글 생성일	
	
	private Date reviewbudate; //게시글 수정일
	
	private int reviewbhit; //게시글 조회수
	@NotNull
	@Size(min=4,max=400,message="내용은 4~400자 까지 입력 가능합니다!")
	private String reviewbcontent; //게시글내용
	
	private int reviewbscore; // 별점
	//파일 이미지 첨부
	private MultipartFile file;
	private String revieworiginFn; //업로드 파일명
	private String reviewrandomFn; //내부관리되는 실제 파일명(랜덤)


}
