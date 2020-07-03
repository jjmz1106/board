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
String title = request.getParameter("title");
String content = request.getParameter("content");
String creusr = request.getParameter("creusr");

Connection conn = Connector.getConnection();
String sql = "select num, title, content, credat, cretim, creusr from board where 1=1 ";
if(title!=null && !"".equals(title)){
	sql += "and title like concat('%',?,'%')";
}
if(content!=null && !"".equals(content)){
	sql += "and content like concat('%',?,'%')";
}
if(creusr!=null && !"".equals(creusr)){
	sql +=" and creusr like concat('%',?,'%') ";
}
PreparedStatement ps = conn.prepareStatement(sql);
int cnt = 1;
if(title!=null && !"".equals(title)){
	ps.setString(cnt++,title);
}
if(content!=null && !"".equals(content)){
	ps.setString(cnt++,content);
}
if(content!=null && !"".equals(creusr)){
	ps.setString(cnt++,creusr);
}
ResultSet rs = ps.executeQuery();
%>

<form>
	제목 : <input type="text" name="title"><br>
	내용 : <input type="text" name="content"><br>
	작성자 : <input type="text" name="creusr"><br>
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