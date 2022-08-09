
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

<table border='1'>
<tr>
<%-- <th><%=session.getAttribute("id") %></th> --%>
<th>id:</th>
<th>userName</th>
<th>passWord</th>
<th>phone</th>
<th>email</th>



</tr>


<%

String db = "student_portal";
String user = "root"; // assumes database name is the same as username

String name = session.getAttribute("login").toString();
String id;
if(session.getAttribute("id")==null)
{//means ad modify profile
	 id=request.getParameter("target_id");
}
else{
 id = session.getAttribute("id").toString();
}
String pw = request.getParameter("password");
out.println("</br>"+id);
String email = request.getParameter("email");
String phone = request.getParameter("phone");

try { 
java.sql.Connection con; 
Class.forName("com.mysql.cj.jdbc.Driver"); 
con = DriverManager.getConnection("jdbc:mysql://localhost:3306/"+db, "root", "970630"); 
//modify:
	Statement stmt=con.createStatement();
	String sqlM ="UPDATE `student_portal`.`users` SET `password` = '"+pw+"', `email` = '"+email+"', `phone` = '"+phone+"' WHERE (`user_id` = '"+id+"');";
	stmt.executeUpdate(sqlM);
	



stmt=con.createStatement();
String checkSql = "select username, password, phone, email from student_portal.users where user_id='"+id+"';";
ResultSet rs = stmt.executeQuery(checkSql);
if(rs.next())
{
	%>
	<tr>
	<th>new: </th>
	<th><%=rs.getString(1) %></th>
	<th><%=rs.getString(2) %></th>
	<th><%=rs.getString(3) %></th>
	<th><%=rs.getString(4) %></th>
	

	
	<%
}



con.close(); 
} catch(SQLException e) { 
out.println("SQLException caught: " +e.getMessage()); } 













%>


</table>

<form style='margin-top: 100px'>

<a href="javascript:history.go(-1)" >back</a>
</form>



</body>





</body>

</html>