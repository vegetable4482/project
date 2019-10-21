package com.kh.myapp.test;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import lombok.Data;

@Data
public class MemberDTO {
	
	@NotNull
	@Size(min=4,max=10,message="아이디는 4~10자리로 입력바랍니다.")
	private String id;
	
	@NotNull
	@Size(min=4,max=10,message="별칭은 4~10자리로 입력바랍니다.")
	private String nickname;
	
	@NotNull(message="나이는 필수 값입니다.")
	@Size(min=1,max=3)
	private String age;
	
	
	private String region;
	
	
	
	
}
