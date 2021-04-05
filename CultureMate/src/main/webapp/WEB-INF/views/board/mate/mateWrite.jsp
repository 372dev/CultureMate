<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>

<c:set var="path" value="${pageContext.request.contextPath}" />
<style>
     #mateSection {
	     min-height: 800px;
	     width: 1280px;
	     margin: 0 auto;
	}
    #mateWrite-container{ 
        text-align: center;
		margin: 0 auto;
		width: 1000px;
		height: 800px;
   
    }
    #mate-Title{
        text-align: left;
    }
    #mateWrite-frm{
        text-align: center;    
        border: 1px;
        border-radius: 10px;
        margin: auto;      
    }
  
    #mateWrite-tbl{ 
    	border-collapse: separate;
    	border-spacing: 0 5px;
	    text-align: center;          
        margin: 0 auto;
    }
    #mateWrite-tr1>td {
    
    }
    #mateButton{
     height:35px;
  	border: none;
	border-radius: 5px;
	background: yellowgreen;
	color: white;
  }	 
   
</style>
<section id="mateSection">
       
		    <div id="mateWrite-container">
		        <div id="mate-Title">
			        <h1>같이 가요</h1>
			        <h4>&nbsp; - 같이 갈 메이트 괌</h4>
		    	</div>
		    <hr>
		    <form action="${path}/mate/write" id="mateWrite-frm" method="post" enctype="multipart/form-data">
		     <table id="mateWrite-tbl">
		        <tr id="mateWrite-tr1">
		        	 <td>
				        <select name="mateShow" id="mateShow" style="border-radius:5px;height:28px;">
				            <option value="뮤지컬">뮤지컬</option>
				            <option value="연극">연극</option>
				            <option value="클래식">클래식</option>
				        </select>
			        </td>
			        <td>
						<select name="mateOpen" id="mateOpen" style="border-radius:5px;height:28px;">
							<option value="모집중">모집중</option>
							<option value="모집완료">모집완료</option>
						</select>
					</td>
		            <td><input style="border-radius:5px;height:28px;border:1px solid; width:200px;" type="text" name="mateTitle" id="mateTitle" placeholder="제목을 입력해주세요."></td>		            
		            <td> <input style="border-radius:5px;height:28px;border:1px solid; width:80px;" type="text" name="userNick" value="${loginMember.userNick }" readonly> </td>
		          
		        </tr>	     
		       <tr>
		          <td colspan="4">API</td> 
		        </tr>
		    <tr>
		    <td>
		   <select name="mateAge" id="mateAge" style="border-radius:5px;height:28px;">
		            <option value="">연령대</option>
		            <option value="10대">10대</option>
		            <option value="20대">20대</option>
		            <option value="30대">30대</option>
		            <option value="40대">40대</option>
		            <option value="50대 이상">50대 이상</option>
		    </select>
		    </td>
		    <td colspan="2">
		    	<select name="martGender" id="mateGender" style="border-radius:5px;height:28px;">
						<option value="">성별</option>
						<option value="여성">여성</option>
						<option value="남성">남성</option>
						<option value="아무나 환영">아무나 환영</option>
					</select>
			</td>
			<td>		
					<select name="mateNum" id="mateNum" style="border-radius:5px;height:28px;">
			        <option value="">인원수</option>
			        <option value="1명">1명</option>
			        <option value="5명 이하">5명 이하</option>
			        <option value="10명 이하">10명 이하</option>
			        <option value="15명 이하">15명 이하</option>
				</select>
			</td>
			</tr>
		<!--  	<tr>
				<td>모집성별</td>
				<td>
					<select name="martGender" id="mateGender" style="border-radius:5px;height:28px;">
						<option value="여성">여성</option>
						<option value="남성">남성</option>
						<option value="아무나 환영">아무나 환영</option>
					</select>
				</td>
			</tr>
			<tr>
			    <td>인원수</td>
			    <td>
			    <select name="mateNum" id="mateNum" style="border-radius:5px;height:28px;">
			        <option value="1명">1명</option>
			        <option value="5명 이하">5명 이하</option>
			        <option value="10명 이하">10명 이하</option>
			        <option value="15명 이하">15명 이하</option>
				</select>
				</td>
			</tr> -->
		    <tr>
			     <td colspan="4">
			       <textarea style="border-radius:5px" name="mateContent" id="mateContent" cols="80" rows="10"></textarea>
			    </td>
			</tr>			
		 </table>
		 <br>
		  	<button id="mateButton" type="button" onclick="writeMate()">등록하기</button> &nbsp;
    	    <button id="mateButton" type="button" onclick="location.replace('${path}/mate/list')">목록으로</button>		
	  </form>
	 </div>	
	  <br>
</section>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>