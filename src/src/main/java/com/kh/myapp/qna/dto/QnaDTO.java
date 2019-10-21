package com.kh.myapp.qna.dto;

import java.sql.Timestamp;

import javax.persistence.Entity;

import lombok.Data;

@Entity
@Data
public class QnaDTO {

	//1:1게시판번호
	private int qnabnum;
	//1:1게시판제목
	private String qnabtitle;
	//1:1게시판아이디
	private String qnabid;
	//1:1게시판작성자이름
	private String qnabname;
	//1:1게시판생성일
	private Timestamp qnabcdate;
	//1:1게시판수정일
	private Timestamp qnabudate;
	//1:1게시판조회수
	private int qnabhit;
	//1:1게시판내용글
	private String qnabcontent;
	//1:1게시판답글그룹
	private int qnabgroup;
	//1:1게시판답글스텝
	private int qnabstep;
	//1:1게시판답글인덴트
	private int qnabindent;
	//1:1게시판 답변상태
	private String qnaanswerstatus;

}
