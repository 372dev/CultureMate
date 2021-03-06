<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%@page import="com.kh.cm.mate.model.vo.Mate"%>
<%@page import="com.kh.cm.mate.model.vo.MateReply"%>
<%
	Mate mate = (Mate)request.getAttribute("mate");	
%>
<link rel="stylesheet" href="${ path }/resources/css/mateViewAPI.css" />
<style>
     #mateSection {
	     min-height: 800px;
	     width: 1280px;
	     margin: 0 auto; 
	     
	}
    #mateView-container{ 
        text-align: center;
		margin: 0 auto;
		width: 1000px;
		height: 1030px;
   
    }
    #mate-Title{
        text-align: left;
        font-family: 'Do Hyeon', sans-serif;
    }
      #mate-Title > a{
    	color: black;
    	text-decoration:none; 
 	       
    }
    #mate-Title > h2 {
    	text-decoration:line-through #b7ba41;
    		margin-left:100px;
    }
    #mateView-frm{
        text-align: center;    
        margin: auto;      
    }
  
    #mateView-tbl{ 
    	border-collapse: collapse;
	    border-spacing: 0 7px;
	    text-align: center;       
        margin: 0 auto;
    }
    #mateView-tr{
     border-bottom: 1px solid lightgray;
     border-top: 1px solid lightgray;
    }
     #mateView-tr>td:nth-child(8){
     	width: 300px;
     }
     #mateView-tr>td:nth-child(10){
     	width: 200px;
     }
      #mateView-tr>td:nth-child(4){
    	width: 100px;
    }
      #mateView-tr>td:nth-child(3){
    	width: 130px;
    }
   
     #mateView-tr>td{
     	padding:5px;
     	width:80px;
     }
     #mateView-tr1>td{
     	padding: 5px;
     }
     
  #btn-insert {
	width: 70px;
	height: 70px;
	border: none;
	border-radius: 5px;
	background: #9db81f;
	color: white;
	position:relative;
	top:-28.5px;
}
  #mateButton{
   height:35px;
  	border: none;
	border-radius: 5px;
	background: #9db81f;
	color: white;
  }
  /*댓글테이블*/
table#tbl-comment {
	width:500px; 
	margin:0 auto; 
	border-collapse:collapse; 
	clear:both; 
} 

table#tbl-comment tr td {
	border-bottom:0.5px solid gray; 
	border-top:0.5px solid gray; 
	padding:5px; 
	text-align:left; 
	line-height:100%;
}

table#tbl-comment tr td:first-of-type {
	padding: 5px 5px 5px 20px;
}

table#tbl-comment tr td:last-of-type {
	text-align:left; 
	width: 100px;
}

table#tbl-comment sub.comment-writer {
	vertical-align: top;
	color:#6c757d; 
	font-size:9pt;
	top:8px;
}

table#tbl-comment sub.comment-date {
	vertical-align: top;
	color:lightgray;
	font-size:9pt;
	top:8px;
}
.level1 >td> sub {
	font-size: 7pt;
}
.level2 >td> sub {	
	font-size: 7pt;
}
.level2 >td> sub.comment-writer {
	margin-left:15px;
}

</style>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap" rel="stylesheet">
<script src="https://kit.fontawesome.com/0fe4d45686.js"
		crossorigin="anonymous"></script>
<section id="mateSection">
	  <div id="mateView-container">
		        <div id="mate-Title">
			        <a href="${path}/mate/list"><h1 style="font-size: 48pt;">같이가요</h1></a>
			        <h2>- 같이 갈 메이트 괌</h4>
		    	</div>
		    <hr>
		     <table id="mateView-tbl">
		        <tr id="mateView-tr">
		        	<td>${mate.mateId}</td>		        	
		        	<td>${mate.mateShow}</td>
		        	<td>${mate.mateOpen}</td>
		        	<td>${mate.mateGender}</td>		        	
		        	<td>${mate.mateAge}</td>		        	
		        	<td>${mate.mateNum}</td>		        	
		        	<td>${mate.mateLoc}</td>			        		        	
		            <td>${mate.mateTitle}</td>	
		           	<td>${mate.userNick }</td>	                     
		            <td><fmt:formatDate value="${mate.mateCreateDate}" pattern="yy/MM/dd HH:mm:ss"/></td>	           
		            <td>${mate.mateCount}</td>	           
		        </tr>		       
		        <tr><td colspan="11">
        		    <div id="ajaxResultDiv" class="ajaxResultDiv"></div>
		        </td></tr>
		    <tr id="mateView-tr1">
		     <td colspan="11">
		     <div style="border-radius:5px;height: 250px;width: 500px;background-color: GAINSBORO;margin:0 auto; display: flex; align-items: center;">
     <div style="background-color:white;white-space:pre;border-radius:5px;height:210px;width:460px;border:0.5px solid lightgray;margin: 0 auto;padding:0 auto; middle;text-align: left;">${mate.mateContent}</div>
			</div>
			 </td>
			</tr>
		 </table>
		 <br>
		 <%--글작성자/관리자인경우 수정삭제 가능 --%>
		  <c:if test="${ !empty loginMember && (loginMember.userNick == mate.userNick || loginMember.userRole == 'ROLE_ADMIN')}">  
				    <button id="mateButton" type="button" onclick="location.replace('${path}/mate/update?mateId=${mate.mateId}')">수정하기</button> &nbsp;
			</c:if>	    
				    <button id="mateButton" type="button" onclick="location.replace('${path}/mate/list')">목록으로</button> &nbsp;
			<c:if test="${ !empty loginMember && (loginMember.userNick == mate.userNick || loginMember.userRole == 'ROLE_ADMIN')}">  	    
				    <button id="mateButton" type="button" onclick="location.replace('${path}/mate/delete?mateId=${mate.mateId}')">삭제하기</button>
			</c:if>	
		  	
		 <div id="comment-container">
		 <br>
	    	<div class="comment-editor">
	    		<form action="${path }/mate/reply/write" method="post" onsubmit="return checkEmpty()">
	    			<input type="hidden" name="mateId" value="${mate.mateId}">
	    			<input type="hidden" name="writer" value='${loginMember != null ? loginMember.userNick : "" }'>
					<textarea style="border-radius:5px;height:70px;resize: none;" id="content" name="content" cols="55" rows="3"></textarea>
					<button type="submit" id="btn-insert" onclick="return checkLogin()">등록</button>	    			
	    		</form>
	    	</div>
	    </div>
		<table id="tbl-comment">
			<c:if test="${empty mateReplies}">
				<tr>
					<td style="text-align: center;">
						등록된 댓글이 없습니다.
					</td>
				</tr>
			</c:if>
			<c:if test="${!empty mateReplies }">
		    	<c:forEach var = "mateReply" items="${mateReplies}">
		    	 <c:if test="${mateReply.mateReplyId == mateReply.mateReplyGroup }">
			    	<tr class="level1">
			    		<td>
			    			<sub class="comment-writer" >${mateReply.userNick}</sub>
			    			<sub class="comment-date"><fmt:formatDate value="${mateReply.mateReplyCreateDate}" pattern="yy/MM/dd HH:mm:ss"/></sub> 
			    			<br>
			    			<span style="font-size:9pt;"><c:out value="${mateReply.mateReplyContent}"></c:out></span>
			    		</td>
			    		<td>
		    			<c:if test="${ !empty loginMember}">	    		   
		    		    	<input type="hidden" class="mateReplyId" name="mateReplyId" value="${mateReply.mateReplyId }">
		    		    	<input type="hidden" name="mateId" id="mateId" value="${mateReply.mateId }">
		    		    <c:if test="${ !empty loginMember && (loginMember.userNick == mateReply.userNick || loginMember.userRole == 'ROLE_ADMIN')}">	
	    			    	<a href="javascript:deleteMateReply(${mateReply.mateReplyId })" ><span style="font-size:7pt;color:gray;float:right;"><i class="fas fa-times"></i>삭제</span></a>
	 					</c:if>	 					 	
		    			<a href="javascript:" id="btn-reWrite"><span style="font-size:7pt;color:gray;float:right;margin-right:5px;"><i class="fas fa-pencil-alt"></i>답글</span></a>		    			
		    			
		    			<script type="text/javascript">
		    				$("#btn-reWrite").on("click", () => {
		    						var mateReplyId = $("#mateReplyId").val();
		    						
		    						const url = "${path}/mate/reply/reWrite?mateReplyId=" + $(".mateReplyId").val();
		    						const title = "RE";
		    						const status = "left=500px, top=100px, width=500px, height=300px";
		    						
		    						window.open(url, title, status);
		    						
		    						
		    					});
		    				
		    				function deleteMateReply(no){
		    					let mateReplyId = $(".mateReplyId").val();
		    					if(confirm("댓글을 삭제 하시겠습니까?")){
		    						location.replace('${path}/mate/reply/delete?mateId='+ <%=mate.getMateId()%>+ '&mateReplyId=' + no);
		    					}
		    				}
		    				
		    				</script>
		    		      </c:if>
			    		</td>
			    	</tr>
			    	</c:if>
			    	 <c:if test="${mateReply.mateReplyId != mateReply.mateReplyGroup }">			    				
			    	<tr class="level2">	    	
			    		<td>
			    			<sub class="comment-writer">RE:${mateReply.userNick}</sub>
			    			<sub class="comment-date"><fmt:formatDate value="${mateReply.mateReplyCreateDate}" pattern="yy/MM/dd HH:mm:ss"/></sub> 
			    			<br>
			    			<span style="margin-left:15px;font-size:9pt;">→<c:out value="${mateReply.mateReplyContent}"></c:out></span>
			    		</td>			    		
			    		<td>
		    		    <c:if test="${ !empty loginMember && (loginMember.userNick == mateReply.userNick || loginMember.userRole == 'ROLE_ADMIN')}">
		    		    	<input type="hidden" name="mateReplyId" id="mateReplyId" value="${mateReply.mateReplyId }">
		    		    	<input type="hidden" name="mateId" id="mateId" value="${mateReply.mateId }">
		    					<!--  	<button class="btn-update">수정</button> -->	
		    				<a href="javascript:deleteMateReReply(${mateReply.mateReplyId })" ><span style="font-size:7pt;color:gray;float:right;top:10px;"><i class="fas fa-times"></i>삭제</span></a>		    				
		    				<script type="text/javascript">
		    				function deleteMateReReply(no){
		    					let mateReplyId = $("#mateReplyId").val();
		    					if(confirm("댓글을 삭제 하시겠습니까?")){
		    						location.replace('${path}/mate/reply/delete?mateId='+ <%=mate.getMateId()%>+ '&mateReplyId=' + no);
		    					}
		    				}
		    		    	</script>
		    			</c:if>
			    		</td>
			    	</tr>			    	
			    	</c:if>			    	
		    	</c:forEach>
		    	</c:if>
		    </table>
		     <br>
		    
		    <div id="pageBar">
    	 <c:if test="${!empty mateReplies}">
			<!-- 맨 처음으로 -->
			<button type="button" class="btn btn-light btn-sm" onclick="location.href='${path}/mate/view?mateId=${mate.mateId }&page=1'"><i class="fas fa-angle-double-left"></i></button>
			
			<!-- 이전 페이지로 -->
			<button type="button" class="btn btn-light btn-sm" onclick="location.href='${path}/mate/view?mateId=${mate.mateId }&page=${pageInfo.prvePage}'"><i class="fas fa-angle-left"></i></button>

			<!--  10개 페이지 목록 -->
			<c:forEach begin="${pageInfo.startPage}" end="${pageInfo.endPage}" step="1" varStatus="status">
				<c:if test="${status.current == pageInfo.currentPage}">
					<button type="button" class="btn btn-light btn-sm" style="height:25px;font-size:7pt;font-weight:bold;" disabled><c:out value="${status.current}"/></button>
   				</c:if>
				<c:if test="${status.current != pageInfo.currentPage}">
					<button type="button" class="btn btn-light btn-sm" style="height:25px;font-size:7pt;font-weight:bold;" onclick="location.href='${path}/mate/view?mateId=${mate.mateId }&page=${status.current}'"><c:out value="${status.current}"/></button>
   				</c:if>
			</c:forEach>
			
			<!-- 다음 페이지로 -->
			<button type="button" class="btn btn-light btn-sm" onclick="location.href='${path}/mate/view?mateId=${mate.mateId }&page=${pageInfo.nextPage}'"><i class="fas fa-angle-right"></i></button>
			
			<!-- 맨 끝으로 -->
			<button type="button" class="btn btn-light btn-sm" onclick="location.href='${path}/mate/view?mateId=${share.shareId }&page=${pageInfo.maxPage}'"><i class="fas fa-angle-double-right"></i></button>	
		</c:if>	
		</div>
	 </div>
	 <script type="text/javascript">
	 function checkEmpty() {
			var content = $("#content").val();
			if( content == ""  || content == null || content == '&nbsp;' || content == '<p>&nbsp;</p>') {
				alert('입력값이 없습니다.');
				return false;
			}
		}
	 
	 function checkLogin() {
			if(${empty loginMember}) {
				alert("로그인 후 댓글등록이 가능합니다.");
				return false;
			}
		}
	
	<!-- Ajax script -->
	
	$(document).ready(function () {
		
		var mt20id = "${ mate.mt20id }";
		$.ajax({
			type : "GET",
			url : "/cm/show/mateAjax",
			data : {
				"mt20id" : mt20id,
			},
			error : function(error) {
				console.log("ajax-error");
			},
			success : function(result) {
				console.log("ajax-success");
				$("#ajaxResultDiv").empty();
				var toAdd = '';
				if(result == null || $.isEmptyObject(result)) {
					console.log("no result");
					toAdd += "<p>검색 조건에 맞는 게시물이 없습니다.</p>";
				} else {
					console.log(result);
					toAdd += '<div class= "divImgWrapper">';
					toAdd += '<img src="' + result[0].poster + '" alt="' + result[0].prfnm + '"';
					toAdd += 'onclick="location.href=\'' + '${ path }/show/restview?name=' + result[0].mt20id + '\';"';
					toAdd += 'class= "imgLeft">';
					toAdd += '</div>';
					toAdd += '<div class="tableWrapper"><table class="showTable">';
					toAdd += '<tr><th colspan="2" class="tableTitle">' + result[0].prfnm + '</th></tr>';
					toAdd += '<tr><td class="colOne">공연장</td><td class="colTwo">' + result[0].fcltynm + '</td></tr>';
					toAdd += '<tr><td class="colOne">공연기간</td><td>' + result[0].prfpdfrom + '~' + result[0].prfpdto + '</td></tr>';
					toAdd += '<tr><td class="colOne">런타임</td><td>' + result[0].prfruntime + '</td></tr>';
					toAdd += '<tr><td class="colOne">관람연령</td><td>' + result[0].prfage + '</td></tr>';
					toAdd += '<tr><td class="colOne">티켓가격</td><td>' + result[0].pcseguidance + '</td></tr>';
					toAdd += '<tr><td class="colOne">출연진</td><td>';
					if(result[0].prfcast == " " || "") {
						toAdd += "정보가 없습니다.";
					} else {
						toAdd += result[0].prfcast;
					}
					toAdd += '</td></tr></table></div>';
				}
				$("#ajaxResultDiv").append(toAdd);
			}
		});
	})
	
	</script>

</section>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>