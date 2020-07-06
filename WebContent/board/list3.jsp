<%@page import="connector.Connector"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
String[] searchs = request.getParameterValues("search");
String searchStr = request.getParameter("searchStr");
Connection conn = Connector.getConnection();
String sql = "select num, title, content, credat, cretim, creusr from board where 1=1 ";
if(searchs!=null){
for(String search:searchs){
	sql += " and " + search + " like concat('%',?,'%')";
	}
}
PreparedStatement ps = conn.prepareStatement(sql);
String searchStr = request.getParameter("searchStr");
if(searchs!=null){
for(int i=0;i<searchs.length;i++){
	ps.setString((i+1),searchs[i]);
	}
}
ResultSet rs = ps.executeQuery();
%>
<form>
	<label for="title">제목</label><input type="checkbox" id="title" name="search" value="title">
	<label for="content">내용</label><input type="checkbox" id="content" name="search" value="content">
	<label for="creusr">유저</label><input type="checkbox" id="creusr" name="search" value="creusr">
	<input type="text" name="searchStr">
<button>검색</button>
</form>
<table border="1">
	<tr>
		<th>번호</th>
		<th>제목</th>
		<th>내용</th>
		<th>작성일</th>
		<th>작성자</th>
	</tr>
<%
while(rs.next()){
%>
	<tr>
		<td><%=rs.getInt("num") %></td>
		<td><%=rs.getString("title") %></td>
		<td><%=rs.getString("content") %></td>
		<td><%=rs.getString("credat") %></td>
		<td><%=rs.getString("creusr") %></td>
	</tr>
<%
}
%>
</table>
</body>
</html>
