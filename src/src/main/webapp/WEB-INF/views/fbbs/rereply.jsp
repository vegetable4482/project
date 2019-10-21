<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
 <script src="${pageContext.request.contextPath }/webjars/jquery/3.4.1/dist/jquery.js" ></script> 
<script>
	var freebnum = "${fbbsDTO.freebnum}"; //원글
	var page = 1; 				 			 //요청페이지
	
	var l_id = "${sessionScope.user.id}"; //로긴아이디
	var l_name = "${sessionScope.user.name}"; //로긴닉네임
	var l_url = "${pageContext.request.contextPath }/rbbs"; //공통 URL요청
	
	
	
	$(function(){
		//댓글목록 보이기
		replyList(page);
		
		//댓글 작성
		$("#replyBtn2").on("click",function(){
			let $freerid = l_id;
			let $name = l_name;
			let $freercontent = $("#freercontent").val();			
			let $url = l_url;
			
			//로그인체크
			if($freerid ==''){
				if(confirm('로그인 후 댓글작성이 가능합니다\n로그인 하시겠습니까?')){
					document.location.href='${pageContext.request.contextPath }/login/login';
				}
				return;
			}
			
			//AJAX 비동기 처리기술
			$.ajax({
				type : "POST",    	 //http 전송 방식
				url  : $url,				 //요청 url
				headers : {					 //전송 데이터 유형
					"Content-Type" : "application/json"
				},
				dataType : "text",   //요청시 응답데이터 타입
				data : JSON.stringify({ //전송 데이터(자바스크립트객체 -> 문자열변환)
					freebnum : freebnum,
					freerid : $freerid,
					freername : $name,
					freercontent : $freercontent
				}),
				//응답 성공시 처리사항
				success:function(result){		
					console.log(result);
					$("#freercontent").val('');
					replyList(page);
				},
				//응답 실패시 처리사항
				error:function(xhr, status, err){			
					console.log("code:"+xhr.status);
					console.log("message:"+xhr.responseText );
					console.log("status:"+status);
					console.log("err:"+err);
				}			
			});
		});
		
		//등록취소
		$("#replyCancleBtn").on("click",function(){
			$("#freercontent").val('');
			$("#freercontent").focus();
		})
		
		//요청페이지에 대한 댓글목록 가져오기
		function replyList(reqPage){
			
			let $url = l_url+"/"+page+"/"+freebnum; 
			let str = "";
			
			$.ajax({
				type : "GET",    	 //http 전송 방식
				url  : $url,				 //요청 url
				dataType : "JSON",   //요청시 응답데이터 타입
				//응답 성공시 처리사항
				success:function(result){		
					$.each(result.item,function(idx, rec){
						
						if(rec.rfreername == null) rec.rfreername = '';
						//들여쓰기
						if(rec.rindent == 0){
							str += '<div data-freernum='+rec.freernum+'>';
							str += '<div class="row mt-2 p-0">';
							str += '  <div class="col-1">';
							str += '    <img src="${pageContext.request.contextPath }/resources/img/reply_icon.jpg"';
							str += '         class="rounded-cicle" style="width:45px"'; 
							str += '         alt="" />';
							str += '  </div>';
							str += '  <div class="col-11">';
							str += '    <h6>'+rec.freername+'('+rec.freerid+')' +'<small class="ml-2"><i>'+rec.freercdate+'</i></small></h6>';
							str += '    <p><span class="mr-1 text-primary"></span><span>'+rec.freercontent+'</span></p>';
							str += '  </div>';
							str += '</div>';	
							str += '<div class="row m-0 p-0">';
							str += '  <div class="col-1"></div>';
							str += '  <div class="col-8">';
							/* str += '    <a class="badge badge-light" data-toggle="tooltip" data-placement="top"';
							str += '              data-html="true" title="호감">';
							str += '      <i class="goodBtn far fa-thumbs-up mr-1">('+rec.rgood+')</i></a>';
							str += '    <a class="badge badge-light" data-toggle="tooltip" data-placement="top"';
							str += '              data-html="true" title="비호감">'; */
							/* str += '      <i class="badBtn far fa-thumbs-down mr-1">('+rec.rbad+')</i></a>'; */
						/* 	str += '    <a class="rereplyBtn badge badge-pill badge-success"><i>댓글</i></a>'; */
							str += ' <hr>';
							str += '  </div>';															
						}else{
							str += '<div data-freernum="'+rec.freernum+'" data-freerrnum="'+rec.freerrnum+'">';
							str += '<div class="row mt-4 p-0">';
									
							str += '  <div class="col-1">';
							str += '    <img src="${pageContext.request.contextPath }/resources/img/reply_icon.jpg"';
							str += '         class="rounded-cicle" style="width:45px"'; 
							str += '         alt="" />';
							str += '  </div>';
							str += '  <div class="col-10">';
							str += '    <h6>'+rec.freername+'('+rec.freerid+')' +'<small class="ml-2"><i>'+rec.freercdate+'</i></small></h6>';
							str += '    <p><span class="mr-1 text-primary">'+rec.rfreername+'</span><span>'+rec.freercontent+'<span></p>';
							str += '  </div>';
							str += '</div>';	
							str += '<div class="row m-0 p-0">';
							str += '  <div class="col-2"></div>';
							str += '  <div class="col-7">';
							/* str += '    <a class="badge badge-light" data-toggle="tooltip" data-placement="top"';
							str += '              data-html="true" title="호감">';
							str += '      <i class="goodBtn far fa-thumbs-up mr-1">('+rec.rgood+')</i></a>';
							str += '    <a class="badge badge-light" data-toggle="tooltip" data-placement="top"';
							str += '              data-html="true" title="비호감">'; */
							/* str += '      <i class="badBtn far fa-thumbs-down mr-1">('+rec.rbad+')</i></a>'; */
							/* str += '    <a class="rereplyBtn badge badge-pill badge-success"><i>댓글</i></a>'; */
							str += '  </div>';		
						}
						
						//댓글작성자 아이디와 로긴 아이디가 동일한경우만 보이도록함.					
						if(l_id == rec.freerid){
							str += '  <div class="col-3 text-right">';
							str += '    <a class="reModifyBtn badge badge-pill badge-light">수정 </a>';
							str += '  <span>|</span>'
							str += '    <a class="replyDelBtn badge badge-pill badge-light">삭제</a>';
							str += '  </div>';	
						}
						str += '</div>';	
						str += '</div>';	
					});
					
					//댓글목록 삽입
					$("#replyList").html(str);
					
					//페이지 삽입
					showPageList(result.pc);
					
					//댓글목록 이벤트처리
					doActionEvent();

				},
				//응답 실패시 처리사항
				error:function(xhr, status, err){			
					console.log("code:"+xhr.status);
					console.log("message:"+xhr.responseText );
					console.log("status:"+status);
					console.log("err:"+err);
				}	
						
			});//End of $.ajax
			
			//페이지번호 클릭시 이벤트 처리
			//id값이 paging인 하위요소 li a 에 클릭이벤트가 발생하면
			$("#paging").on("click","li a", function(e){
				//현재 이벤트의 기본동작을 중단.
				e.preventDefault(); 
				
				//현재 이벤트가 상위 및 현재 레벨에 걸린 다른 이벤트가 동작 않도록 중단
				e.stopImmediatePropagation();
				
				page = $(this).attr("href");
				replyList(page);
			});
							
		}//End of replyList()	
		
		function showPageList(pc){
			console.log("showPageList:"+pc);
			let str = "";
			
			str += '<nav aria-label="">';
			str += '  <ul class="pagination pagination-sm">';
			
			//이전페이지여부
			if(pc.prev){
				//처음
				str += '    <li class="page-item">';
				str += '      <a class="page-link" href="1" tabindex="-1" aria-disabled="true" style=" border:none;"></a>';
				str += '    </li>';				
				//이전페이지
				str += '    <li class="page-item">';
				str += '      <a class="page-link" href="'+(pc.startPage-1)+'" tabindex="-1" aria-disabled="true" style=" border:none;"></a>';
				str += '    </li>';					
			}else{
				//처음
				str += '    <li class="page-item disabled">';
				str += '      <a class="page-link" href="1" tabindex="-1" aria-disabled="true" style=" border:none;" ></a>';
				str += '    </li>';
				//이전페이지
				str += '    <li class="page-item disabled">';
				str += '      <a class="page-link"  style=" border:none;" href="'+(pc.startPage-1)+'" tabindex="-1" aria-disabled="true" style=" border:none;"></a>';
				str += '    </li>';				
			}
			
			//페이지1~10
			for(let i=pc.startPage, end=pc.endPage; i<=end; i++){
				// 현재페이지와 요청페이지가 다르면
				if(pc.rc.reqPage != i){				
					str += '    <li class="page-item"><a  style="color:black; border:none;" class="page-link" href="'+i+'">'+i+'</a></li>';					
				}else{
				// 현재페이지와 요청페이지가 같으면
					str += '    <li class="page-item active" aria-current="page"  >';
					str += '      <a class="page-link" href="'+i+'"  style="background-color:#FF8800; border:none;" >'+i+'<span class="sr-only">(current)</span></a>';
					str += '    </li>';					
				}
			}
			
			//다음페이지여부
			if(pc.next){
				//다음페이지
				str += '    <li class="page-item">';
				str += '      <a class="page-link" href="'+(pc.endPage+1)+'" tabindex="-1" aria-disabled="true" style=" border:none;"></a>';
				str += '    </li>';				
				//끝
				str += '    <li class="page-item">';
				str += '      <a class="page-link" href="'+(pc.finalEndPage)+'" tabindex="-1" aria-disabled="true" style=" border:none;"></a>';
				str += '    </li>';					
			}else{
				//다음페이지
				str += '    <li class="page-item disabled">';
				str += '      <a class="page-link" href="'+(pc.endPage+1)+'" tabindex="-1" aria-disabled="true" style=" border:none;"></a>';
				str += '    </li>';
				//끝
				str += '    <li class="page-item disabled">';
				str += '      <a class="page-link" href="'+(pc.finalEndPage)+'" tabindex="-1" aria-disabled="true" style=" border:none;"></a>';
				str += '    </li>';				
			}
						
			str += '  </ul>';
			str += '</nav>';			

			//페이징 삽입
			$("#paging").html(str);
		}

		function doActionEvent(){
			//대댓글 작성
			$(".rereplyBtn").on("click",function(){
				console.log("댓글작성!");
						
				if(!isLogin()){
					document.location.href="${pageContext.request.contextPath }/login/login";
					return;
				}
					
				//댓글
				let $divEle = $(this).closest("div[data-freernum]");
				
				//댓글번호
				let $data_freernum  = $divEle.attr("data-freernum");

				//대댓글번호
				let $data_freerrnum = $divEle.next().attr("data-freerrnum");

				//대댓글 작성 or 대댓글 수정
				let $data_form = $divEle.next().attr("data-form");
						
 				//대댓글 양식이 없을경우만 추가
				if($data_freernum != $data_freerrnum){
					//열린 댓글,수정양식제거
					$("div[data-form]").remove();			
					$divEle.after(rereply_str);

				//현재글의 대댓글은 있으나 댓글 작성 중이 아닐경우	
				}else if($data_freernum == $data_freerrnum && $data_form ==null){
					//열린 댓글,수정양식제거
					$("div[data-form]").remove();
					$divEle.after(rereply_str);
				//현재글의 대댓글이 있고 댓글 작성 중일 경우
				}else if($data_freernum == $data_freerrnum && $data_form == 'write' ){
					
 					let $textarea = $divEle.next().find('textarea');
					let $tmp = $textarea.val();

					$divEle.next().replaceWith(rereply_str);
					$divEle.find('textarea').val($tmp); 
					
				//현재글의 대댓글이 있고 댓글 수정 중일 경우	
				}else if($data_freernum == $data_freerrnum && $data_form == 'modify' ){
					
 					let $textarea = $divEle.next().find('textarea');
					let $tmp = $textarea.val();
					
					$divEle.next().replaceWith(rereply_str);

				} 
				
				$divEle.next().attr('data-freerrnum',$divEle.attr('data-freernum'));
			
				//대댓글 양식 닫기
				$(".rrclose").on("click",function(e){
					console.log('대댓글닫기');
					e.stopImmediatePropagation();
					$divEle.next().remove();
				});
								
				//대댓글 작성
				$(".rrreply").on("click",function(){
					console.log('대댓글등록!');
					
					let $divEle = $(this).closest("div[data-freerrnum]").prev();
					let $freerrnum = $divEle.attr("data-freernum");
					let $freerid = l_id;
					let $freername = l_name;
					let $freercontent = $("#freercontent2").val().trim();			
					let $url = l_url+'/reply';
					
					if($freercontent.length == 0){
						$("#freercontent2").focus();
						return;
					} 
					
					console.log($divEle);
					console.log($freerrnum);											
					console.log($freerid);											
					console.log($freername);											
					console.log($freercontent);											
					//AJAX 비동기 처리기술
					$.ajax({
						type : "POST",    	 //http 전송 방식
						url  : $url,				 //요청 url
						headers : {					 //전송 데이터 유형
							"Content-Type" : "application/json"
						},
						dataType : "text",   //요청시 응답데이터 타입
						data : JSON.stringify({ //전송 데이터(자바스크립트객체 -> 문자열변환)
							freernum : $freerrnum,						//부모댓글번호
							freerid  : $freerid,							//대댓글 작성아디
							freername : $freername,		//대댓글 작성자 별칭
							freercontent : $freercontent,			//대댓글 내용
							freerrnum : $freerrnum            //부모댓글번호
						}),
						//응답 성공시 처리사항
						success:function(result){		
							console.log(result);
							replyList(page);
						},
						//응답 실패시 처리사항
						error:function(xhr, status, err){			
							console.log("code:"+xhr.status);
							console.log("message:"+xhr.responseText );
							console.log("status:"+status);
							console.log("err:"+err);
						}			
					});					
				});
			});
			
			//댓글 수정
			$(".reModifyBtn").on("click",function(){
				console.log("댓글수정!");
				
				//댓글
				let $divEle = $(this).closest("div[data-freernum]");				
				//댓글번호
				let $data_freernum  = $divEle.attr("data-freernum");
				//대댓글번호
				let $data_freerrnum = $divEle.next().attr("data-freerrnum");
				//대댓글 작성 or 대댓글 수정
				let $data_form = $divEle.next().attr("data-form");				
								
				
				//대댓글 수정 양식이 없을경우만 추가
				if($data_freernum != $data_freerrnum){
					//열린 댓글,수정양식제거
					$("div[data-form]").remove();
					
					let $tmp = $divEle.find("p span:nth-child(2)").text();
					$divEle.after(replyModify_str);
					//대글내용을 수정양식에 복사
					$divEle.next().find("textarea").val($tmp);


				//현재글의 대댓글은 있으나 댓글수정 중이 아닐경우
				}else if($data_freernum == $data_freerrnum && $data_form == null){
					//열린 댓글,수정양식제거
					$("div[data-form]").remove();
					
					$tmp = $divEle.find("p span:nth-child(2)").text();
					$divEle.after(replyModify_str);
					//대글내용을 수정양식에 복사
					$divEle.next().find("textarea").val($tmp);					

				//현재글의 대댓글이 있고 댓글작성 양식이 있을경우	
				}else if($data_freernum == $data_freerrnum && $data_form == "write"){
					let $tmp = $divEle.find("p span:nth-child(2)").text();
					$divEle.next().replaceWith(replyModify_str);
					$divEle.next().find("textarea").val($tmp);
			
				//현재글의 대댓글이 있고 댓글수정 양식이 있을경우
				}else if($data_freernum == $data_freerrnum && $data_form == "modify"){
					let $textarea = $divEle.next().find("textarea");
					let $tmp = $textarea.val();
					if($tmp.trim().length == 0){
						$tmp = $divEle.find("p span:nth-child(2)").text();
					}
					
					$divEle.next().replaceWith(replyModify_str);
					$divEle.next().find("textarea").val($tmp);

				}
				
				$divEle.next().attr("data-freerrnum",$divEle.attr("data-freernum"));
							
				//대댓글 수정 양식 닫기
				$(".rrclose").on("click",function(e){
					console.log("대댓글수정닫기!");
					e.stopImmediatePropagation();
					$divEle.next().remove();
				});
				
				//대댓글 수정 등록
				$(".rrmodify").on("click",function(){
					console.log("대댓글 수정 등록!");
					
					let $divEle = $(this).closest("div[data-freerrnum]").prev();
					let $freerrnum = $divEle.attr("data-freernum");
					let $freercontent = $("#freercontent3").val().trim();			
					let $url = l_url;					
					
					//AJAX 비동기 처리기술
					$.ajax({
						type : "PUT",    	 //http 전송 방식
						url  : $url,				 //요청 url
						headers : {					 //전송 데이터 유형
							"Content-Type" : "application/json"
						},
						dataType : "text",   //요청시 응답데이터 타입
						data : JSON.stringify({ //전송 데이터(자바스크립트객체 -> 문자열변환)
							freernum : $freerrnum,						//부모댓글번호
							freercontent : $freercontent,			//대댓글 내용
						}),
						//응답 성공시 처리사항
						success:function(result){		
							console.log(result);
							replyList(page);
						},
						//응답 실패시 처리사항
						error:function(xhr, status, err){			
							console.log("code:"+xhr.status);
							console.log("message:"+xhr.responseText );
							console.log("status:"+status);
							console.log("err:"+err);
						}			
					});						
					
				});				
				
			});
			
			//댓글 삭제
			$(".replyDelBtn").on("click", function(){
				
				let $freernum = $(this).closest("div[data-freernum]").attr("data-freernum");				
				let $url = l_url + '/' + $freernum;
				
				if(!confirm("삭제하시겠습니까?")) return false;				
				
				//AJAX 비동기 처리기술
				$.ajax({
					type : "DELETE",    	//http 전송 방식
					url  : $url,				  //요청 url
					dataType : "text",    //요청시 응답데이터 타입
					//응답 성공시 처리사항
					success:function(result){		
						console.log(result);
	
						replyList(page);
					},
					//응답 실패시 처리사항
					error:function(xhr, status, err){			
						console.log("code:"+xhr.status);
						console.log("message:"+xhr.responseText );
						console.log("status:"+status);
						console.log("err:"+err);
					}			
				});					
			}); //End of 댓글 삭제
			
			//호감
			$(".goodBtn").on("click",function(){
				//console.log("호감!");
				let $freernum = $(this).closest("div[data-freernum]").attr("data-freernum");
				let $url = l_url +'/'+ $freernum + '/good';
				//AJAX 비동기 처리기술
				$.ajax({
					type : "PUT",    	 //http 전송 방식
					url  : $url,				 //요청 url
					dataType : "text",   //요청시 응답데이터 타입
					//응답 성공시 처리사항
					success:function(result){		
						console.log(result);
	
						replyList(page);
					},
					//응답 실패시 처리사항
					error:function(xhr, status, err){			
						console.log("code:"+xhr.status);
						console.log("message:"+xhr.responseText );
						console.log("status:"+status);
						console.log("err:"+err);
					}			
				});						
			});//End of 호감
			
			//비호감
			$(".badBtn").on("click",function(){
				console.log("비호감!"+page);
				
				let $freernum = $(this).closest("div[data-freernum]").attr("data-freernum");
				let $url = l_url +'/'+ $freernum + '/bad';
				//AJAX 비동기 처리기술
				$.ajax({
					type : "PUT",    	 //http 전송 방식
					url  : $url,				 //요청 url
					dataType : "text",   //요청시 응답데이터 타입
					//응답 성공시 처리사항
					success:function(result){		
						console.log(result);
	
						replyList(page);
					},
					//응답 실패시 처리사항
					error:function(xhr, status, err){			
						console.log("code:"+xhr.status);
						console.log("message:"+xhr.responseText );
						console.log("status:"+status);
						console.log("err:"+err);
					}			
				});					
			});// End of 비호감		
		}// End of doActionEvent()
		
		
		//로긴 유뮤체크
		function isLogin() {
			let status = false;
			
			//로그인 상태면 true를 반환한다.
			if ( l_id.length > 0 && l_name.length > 0){
				status = true;
			}
			return status;
		}
		
		
	});// End of $(function(){}
	
	
</script>
	<!-- 댓글작성 -->
<div>
	<div class="row">
   	<textarea class="form-control" id="freercontent" name="freercontent" rows="3"
   						placeholder="[댓글작성 100자 이하]"></textarea>
	</div>
  <div class="row justify-content-end my-1">
		<div class="col-sm-1 px-0 m-1">
     	<button class="btn btn-sm btn-outline-secondary btn-block" id="replyCancleBtn">취소</button>
    </div>
		<div class="col-sm-1 px-0 m-1">
     	<button class="btn btn-sm btn-outline-secondary btn-block border-white" id="replyBtn2" style="background:#FF8800;"><span style="color:white">등록</span></button>
    </div>
  </div>
	
	<!-- 댓글목록 -->
	<div class="row">
		<div id="replyList" class="col m-0 p-0 my-5">
	
			<!-- 들여쓰기 0 -->
			<div class="row m-2 p-0">
<!-- 				<div class="col-1"> -->
					<img src="${pageContext.request.contextPath }/resources/img/Fish-icon.png"
							 class="rounded-cicle" style="width:45px" 
							 alt="" />
<!-- 				</div> -->
				<div class="col-11">
					<h6>별칭(아이디) <small class="ml-2"><i>댓글생성일</i></small></h6>
					<p><span class="mr-1 text-primary">부모댓글별칭</span>댓글내용</p>
				</div>
			</div>	
			<div class="row m-0 p-0">
<!-- 				<div class="col-1"></div> -->

				<div class="col-3 text-right">
					<a class="badge badge-pill badge-warning">수정</a>
					<a class="badge badge-pill badge-danger">삭제</a>
				</div>	
			</div>	
			
			<!-- 대댓글작성 -->
			<div class="row mt-2">
				<div class="col-1"></div>
				<div class="col">
			   	<textarea class="form-control" id="freercontent" name="freercontent" rows="2"
			   						placeholder="[댓글작성 100자 이하]"></textarea>						
				</div>
			</div>
		  <div class="row justify-content-end my-1 mr-0">
					<a class="badge badge-pill badge-light mr-1">취소</a>
					<a class="badge badge-pill badge-info mr-3">댓글</a>
		  </div>

			<!-- 대댓글수정 -->
			<div class="row mt-2">
				<div class="col-1"></div>
				<div class="col">
			   	<textarea class="form-control" id="freercontent" name="freercontent" rows="2"
			   						placeholder="[댓글수정 100자 이하]"></textarea>						
				</div>
			</div>
		  <div class="row justify-content-end my-1 mr-0">
					<a class="badge badge-pill badge-light mr-1">취소</a>
					<a class="badge badge-pill badge-light mr-3">수정</a>
		  </div>
		  
			<!-- 들여쓰기 > 0 -->
			<div class="row m-2 p-0">
<!-- 			<div class="col-1"></div> -->
				<div class="col-1">
					<img src="${pageContext.request.contextPath }/resources/img/Fish-icon.png"
							 class="rounded-cicle" style="width:45px" 
							 alt="" />
				</div>
				<div class="col-10">
					<h6>별칭(아이디) <small class="ml-2"><i>댓글생성일</i></small></h6>
					<p><span class="mr-1 text-primary">부모댓글별칭</span>댓글내용</p>
				</div>
			</div>	
			<div class="row m-0 p-0">
				<div class="col-2"></div>
				<div class="col-7">
					<a class="badge badge-light" data-toggle="tooltip" data-placement="top"
										data-html="true" title="호감">
						<i class="far fa-thumbs-up mr-1">(1)</i></a>
					<a class="badge badge-light" data-toggle="tooltip" data-placement="top"
										data-html="true" title="비호감">
						<i class="far fa-thumbs-down mr-1">(2)</i></a>
					<a class="badge badge-pill badge-success"><i>댓글</i></a>
				</div>		
				<div class="col-3 text-right">
					<a class="badge badge-pill badge-light">수정</a>
					<a class="badge badge-pill badge-light">삭제</a>
				</div>	
			</div>
		
		</div>
	</div>	

	<!-- 페이징 -->
	<div id="paging" class="row justify-content-center my-3">
		<nav aria-label="">
		  <ul class="pagination pagination-sm">
		    <li class="page-item disabled">
		      <a class="page-link" href="#" tabindex="-1" aria-disabled="true">Previous</a>
		    </li>
		    <li class="page-item"><a class="page-link" href="#">1</a></li>
		    <li class="page-item active" aria-current="page">
		      <a class="page-link" href="#">2 <span class="sr-only">(current)</span></a>
		    </li>
		    <li class="page-item"><a class="page-link" href="#">3</a></li>
		    <li class="page-item">
		      <a class="page-link" href="#">Next</a>
		    </li>
		  </ul>
		</nav>
	</div>	
	</div>



