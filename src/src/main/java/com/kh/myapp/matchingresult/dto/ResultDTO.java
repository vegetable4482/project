package com.kh.myapp.matchingresult.dto;

import lombok.Data;

@Data
public class ResultDTO {
	private int mformnum;					 //추천서 번호
	private int cmembernum;		  	 //매칭된 업체의 번호
	private String mcname;				 //매칭된 업체명
	private String mphonenum;			 //매칭된 업체 전화번호
	private String mbasicadd;			 //매칭된 업체 기본주소
	private String mrestadd;			 //매칭된 업체 나머지주소
	private int mpostnum;					 //매칭된 업체 우편번호
}
