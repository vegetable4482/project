package com.kh.myapp.company.dto;

import java.sql.Timestamp;

import javax.persistence.Entity;

import lombok.Data;

@Entity
@Data
public class CompanyDTO {

	//업체 아이디
	private String cid;
	//업체 비밀번호
	private String cpw;
	//대표자 이름
	private String cname;
	//업체 우편주소
	private String cpostnum;
	//업체 기본주소
	private String cbasicaddress;
	//업체 상세주소
	private String crestaddress;
	//업체 전화번호
	private String cphonenum;
	//업체 사업자번호
	private String businessnum;
	//업체 시공 가능지역
	private String constarea;
	//업체 시공 대분류(공간)
	private String consttype;
	//업체 시공 소분류(공간 [거실,주방,현관,베란다/샷시,욕실,침실)
	private String constspace;
	//업체 시공 스타일(모던,클래식,빈티치,인더스트리얼,미니멀리즘)
	private String conststyle;
	//업체정보생성일
	private Timestamp cmembercdate;
	//업체정보수정일
	private Timestamp cmemberudate;
	//업체 회원약관동의
	private String cpolicyagree;
	//업체 가입순서 번호
	private int cmembernum;
	
	private char cidstatus;
}
