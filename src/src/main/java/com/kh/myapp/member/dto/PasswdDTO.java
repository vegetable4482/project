package com.kh.myapp.member.dto;

import javax.persistence.Entity;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import lombok.Data;

@Entity
@Data
public class PasswdDTO {
	
	@NotNull
	@Pattern(regexp="^\\w+@\\w+\\.\\w+(\\.\\w+)?$",message="ex)aaa@bbb.com")
	private String id;				//아이디		
	

	@NotNull
	/* @Size(min=6,max=10, message="비밀번호는 6~10자리로 입력바랍니다.") */
	private String fromPW;		//현재비밀번호
	

	@NotNull
	/* @Size(min=6,max=10, message="비밀번호는 6~10자리로 입력바랍니다.") */
	private String toPW;			//변경할 비밀번호
}
