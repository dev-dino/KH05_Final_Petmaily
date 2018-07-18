<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>관리자 페이지 회원 상태 리스트</title>
<style>
table, th, td {
	border: 1px solid black;
	border-collapse: collapse;
	padding: 6px 15px;
	margin: 170px 10px 105px 440px;
	text-align: center;

}
</style>
</head>
<body>
	<jsp:include page="mainFrame.jsp"/>
	<table>
	<thead>
		<tr>
					<th>아이디</th>
					<th>이름</th>
					<th>이메일</th>
					<th>상태</th>
					<th>추방</th>
					
					
				</tr>
				</thead>
						<tbody id="memberTable">
						
			</tbody>
			
	
	</table>
		<div id="paging" >
	</div>
	
</body>
<script>

var obj = {};		
obj.type="get";
obj.dataType="json";
obj.error=function(e){console.log(e)};
var showPageNum = 1 

$(document).ready(function() {
	
	memberlistCall(showPageNum)

});


function memberlistCall(page){
	$.ajax({
		type : "get",
		url : "./getmemberList",
		data : {
			"showPageNum" : page
		},
		success : function(data) {
			console.log(data.currPage);
			memberlistPrint(data);
			showPageNum=data.currPage;  //보여지는 페이지 = 현재 페이지 (data.currPage)
		},
		error : function(e) {
			console.log(e);
		}
	});
}



function memberlistPrint(data) {
	
	var content = "";
		data.list.forEach(function(item,idx) {
		content += "<tr>"; 
		content += "<td>" + item.member_id + "</td>";
		content += "<td>" + item.member_name + "</td>";
		content += "<td>" + item.member_email+ "</td>";
		content += "<td>" + item.member_state +"</td>";
        if(item.member_state=='일반회원'){
		   content+="<td><input class='delmem' type='button' value='추방'  onclick='delmember(id)' id="+ item.member_id +"></td>";
        }	
        if(item.member_state=='불량회원'){
 		   content+="<td></td>";
        }	
			content += "</tr>"; 
		})
		$("#memberTable").empty();
		$("#memberTable").append(content); 
		
		$("#paging").zer0boxPaging({
            viewRange : 5,
            currPage : data.currPage,
            maxPage : data.range,
            clickAction : function(e){
            	 memberlistCall($(this).attr('page'));
            }
        });
		
	}		

/*회원 추방 버튼 onclick */
function delmember(id) {
	var del = confirm("추방시키겠습니까?");
	 if(del){	
	console.log("추방");
	console.log(id);
	obj.url = "./changeState";
	obj.data = {
		idx : id
	};
	obj.success = function(data) {
		console.log(data);
	
		if (data==1) {
		
            memberlistCall(showPageNum);
		}
	 else {
			alert("삭제 실패")
		}
	}
	ajaxCall(obj);

	 }
};
	


function ajaxCall(param){
	console.log(param);
	$.ajax(param);
}




</script>

</html>