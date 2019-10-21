package com.kh.myapp.company.dto;

import javax.persistence.Entity;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import lombok.Data;

@Entity
@Data
public class CPasswdDTO {
	
	@NotNull
	@Pattern(regexp="^\\w+@\\w+\\.\\w+(\\.\\w+)?$", message="ex)aaa@bbb.com")	
	private String cid;				//아이디
	
	@NotNull
	@Size(min=6, max=20, message="비밀번호는 6~20자리로 입력바랍니다.")	
	private String fromCPW;		//현재비밀번호
	
	@NotNull
	@Size(min=6, max=20, message="비밀번호는 6~20자리로 입력바랍니다.")	
	private String toCPW;			//변경할 비밀번호
}
