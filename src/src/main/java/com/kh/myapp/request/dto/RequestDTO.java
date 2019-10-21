package com.kh.myapp.request.dto;

import java.sql.Timestamp;

import javax.persistence.Entity;

import lombok.Data;

@Entity
@Data
public class RequestDTO {
	
	//신청자 아이디
	private String custid;
	//신청자 이름
	private String custname;
	//신청자 전화번호
	private String custphonenum;
	//신청자 요구사항
	private String custrequest;
	//공사지 우편번호
	private String constpostnum;
	//공사지 기본주소
	private String constbasicaddress;
	//공사지 나머지주소
	private String constrestaddress;
	//공사지 공간
	private String consttype;
	//공사지 예정 날짜
	private String constdate;
	//신청서 생성일
	private Timestamp formcdate;
	//신청서 수정일
	private Timestamp formudate;
	//신청서 등록 순서
	private int formnum;
	//공사지 인테리어 스타일
	private String conststyle;
	//공사지 유형
	private String constspace;
	//동의
	private String csubmitstatus;
	//매칭상태
	private String mstatus;
	//기업 번호
	private int cmembernum;
	
}
