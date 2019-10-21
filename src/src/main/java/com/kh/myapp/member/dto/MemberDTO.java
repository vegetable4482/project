package com.kh.myapp.member.dto;

import java.sql.Timestamp;

import javax.persistence.Entity;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Entity
@Data
public class MemberDTO {
	
	@NotNull
	@Pattern(regexp="^\\w+@\\w+\\.\\w+(\\.\\w+)?$", message="ex)aaa@bbb.com")
	private String id;				//아이디(이메일)
	
	@NotNull
	@Size(min=6, max=20, message="비밀번호는 6~20자리로 입력바랍니다.")
	private String pw;				//비밀번호

	private String firstpw;				//비밀번호
	
	@NotNull
	private String name;				//이름
	
	@NotNull
	@Pattern(regexp="^\\d{3}-\\d{3,4}-\\d{4}$" , message="ex)010-1234-5678")
	private String phonenum;				//전화번호
	
	@NotNull
	private String postnum;				//우편번호
	
	@NotNull
	private String basicaddress;				//기본주소

	@NotNull
	private String restaddress;				//나머지주소

	@JsonFormat(pattern = "yyyy-mm-dd HH:mm:ss", timezone = "Asia/Seoul")
	private Timestamp membercdate;	//생성일 = 가입일
	@JsonFormat(pattern = "yyyy-mm-dd HH:mm:ss", timezone = "Asia/Seoul")	
	private Timestamp memberudate;	//수정일 
	
	private int membernum;	//회원순서번호
	private String policyagree;//회원약관동의
	
}
