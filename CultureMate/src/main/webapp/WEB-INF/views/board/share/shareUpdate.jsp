<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>

<c:set var="path" value="${pageContext.request.contextPath}" />
<style>
  #shareSection {
	     min-height: 800px;
	     width: 1280px;
	     margin: 0 auto;
	}
    #shareUpdate-container{ 
        text-align: center;
		margin: 0 auto;
		width: 1000px;
		height: 950px;
   
    }
    #shareTitle{
        text-align: left;
        font-family: 'Do Hyeon', sans-serif;
    }
     #share-Title > a{
   	color: black;
   	text-decoration:none; 
 	       
    }
    #share-Title > h2 {
    	text-decoration:line-through #b7ba41;
    	margin-left:100px;
    }
    #shareUpdate-frm{
        text-align: center;    
        border: 1px;
        border-radius: 10px;
        margin: auto;      
    }
  
    #shareUpdate-tbl{
    	border-collapse: collapse;
	    text-align: center;       
        margin: 0 auto;
    }
    #shareUpdate-tr{
    	border-bottom: 1px solid lightgray;
     	border-top: 1px solid lightgray;
    }
    #shareUpdate-tr>td{
    	padding: 5px;
    	width: 80px;
    }
    #shareUpdate-tr>td:nth-child(4){
    	width: 200px;
    }
    #shareUpdate-tr>td:nth-child(6){
    	width: 150px;
    }
    #shareUpdate-tr1>td{
    	padding: 5px;
    }
      #shareButton{
     	height:35px;
	  	border: none;
		border-radius: 5px;
		background: #9db81f;
		color: white;
  }	
   
</style>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap" rel="stylesheet">
<section id="shareSection">
       
		    <div id="shareUpdate-container">
		        <div id="shareTitle">
			      <a style="color: black;text-decoration:none;" href="${path}/share/list"><h1 style="font-size: 48pt;">티켓나눔</h1></a>
			        <h2 style="text-decoration:line-through #b7ba41;margin-left:100px;">- 공연 티켓 괌</h4>	
		    	</div>
		    <hr>
		    <form action="${path}/share/update" id="shareUpdate-frm" method="post" enctype="multipart/form-data">
			    <input type="hidden" name="shareId" value = "${share.shareId}">
				<input type="hidden" name="shareOriginalFileName" value = "${share.shareOriginalFileName}">
				<input type="hidden" name="shareRenamedFileName" value = "${share.shareRenamedFileName}">
			
	     	<table id="shareUpdate-tbl">
			 <tr id="shareUpdate-tr">
		            <td>${share.shareId}</td>		           
		            <td>
			        <select style="border-radius:5px;height:28px;" name="shareShow" id="shareShow">
			            <option value="뮤지컬"
			             <c:if test="${share.shareShow == '뮤지컬'}">selected</c:if>>뮤지컬</option>
			            <option value="연극"
			             <c:if test="${share.shareShow == '연극'}">selected</c:if>>연극</option>
			            <option value="클래식"
			             <c:if test="${share.shareShow == '클래식'}">selected</c:if>>클래식</option>
			        </select>
			    	</td>
			    	<td>
					   <select style="border-radius:5px;height:28px;" name="shareOpen" id="shareOpen">
					            <option value="나눔중"
					             <c:if test="${share.shareOpen == '나눔중'}">selected</c:if>>나눔중</option>
					            <option value="나눔완료"
					             <c:if test="${share.shareOpen == '나눔완료'}">selected</c:if>>나눔완료</option>
					    </select>
					</td>
		            <td><input style="border-radius:5px;height:28px;border:1px solid" type="text" name="shareTitle" value="${share.shareTitle }" ></td>		            
		            <td>
		        		<input style="border-radius:5px;height:28px;border:1px solid;width:80px;" type="text" name="userNick" id="userNick" value="${loginMember.userNick }" readonly>
		        	</td>          
		            <td><fmt:formatDate value="${share.shareCreateDate}" pattern="yy/MM/dd HH:mm:ss"/></td>	           
		            <td>${share.shareCount}</td>			            
		        </tr>
		<tr id="shareUpdate-tr1">
	        <td colspan="7">티켓 인증 올리기</td>			        
	    </tr>
   	     <tr id="shareUpdate-tr1">
	        <td colspan="7">
	        	<input style="height:28px;" type="file" name="reloadFile">
        	<c:if test="${ !empty share.shareOriginalFileName }">
				<br>현재 업로드한 파일 : 
				<a href="${ path }/resources/upload/board/${ share.shareRenamedFileName }" download="${ share.shareOriginalFileName }">
					${ share.shareOriginalFileName }
				</a>
		   </c:if>
        	</td>
	     </tr>
		  <tr id="shareUpdate-tr1">
		       <td colspan="7">
		       <textarea style="resize: none;border-radius:5px;" name="shareContent" id="shareContent" cols="80" rows="10">${share.shareContent}</textarea>
		       </td>
		</tr>
		</table>
		<br>
			<button id="shareButton" type="submit" value="수정학기">수정하기</button>&nbsp;
		    <button id="shareButton" type="button" onclick="location.replace('${path}/share/list')">목록으로</button>&nbsp;		
		    <button id="shareButton" type="button" onclick="history.back()">취소하기</button>
		</form>
	 </div>	
</section>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>