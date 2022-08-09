
<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %> 
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<h1><%=session.getAttribute("login") %></h1>
<h2>id: <%=session.getAttribute("id") %>
<form action = 'mp.jsp'>
<table border='1'>
<tr>
<th>form</th>
<th>userName</th>
<th>passWord</th>
<th>phone</th>
<th>email</th>



</tr>


<%

String db = "student_portal";
String user = "root"; // assumes database name is the same as username

String name = session.getAttribute("login").toString();
String id = session.getAttribute("id").toString();
try { 
java.sql.Connection con; 
Class.forName("com.mysql.cj.jdbc.Driver"); 
con = DriverManager.getConnection("jdbc:mysql://localhost:3306/"+db, "root", "970630"); 


Statement stmt=con.createStatement();
String checkSql = "select username, password, phone, email from student_portal.users where user_id='"+id+"';";
ResultSet rs = stmt.executeQuery(checkSql);
if(rs.next())
{
	%>
	<tr>
	<th>old: </th>
	<th><%=rs.getString(1) %></th>
	<th><%=rs.getString(2) %></th>
	<th><%=rs.getString(3) %></th>
	<th><%=rs.getString(4) %></th>
	
	
	</tr>
	<tr>
	<th>new: </th>
	<th><%=rs.getString(1) %></th>
	<th><input type="search" style="width:100px;" value = "<%=rs.getString(2) %>" name="password"/></th>
	<th><input type="search" style="width:100px;" value = "<%=rs.getString(3) %>" name="phone"/></th>
	<th><input type="search" style="width:100px;" value = "<%=rs.getString(4) %>" name="email"/></th>
	
	
	
	</tr>
	
	<%
}



con.close(); 
} catch(SQLException e) { 
out.println("SQLException caught: " +e.getMessage()); } 













%>


</table>
<input type = 'submit' value="submit"/>

</form>


<input style = 'color:blue;width:100px' value=' back ' type='submit' onclick="javascript:history.back(-1);"/> 




</body>





</body>

</html>