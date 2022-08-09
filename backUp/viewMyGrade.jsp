<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %> 
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="classesPackage.ClassInfo" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<h1><%=session.getAttribute("login") %></h1>
<h2>id: <%=session.getAttribute("id") %>
<table border="1">
    <tr>
        <th>class id</th>
        <th>course_abbreviation</th>
        <th>course_name</th>
        <th>grade</th>
        
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
String sqlGrade = "select class_id, course_abbreviation, course_name, grade from student_portal.is join grade using(class_id) join catalogue_courses using(course_abbreviation)where user_id='"+id+"'";
ResultSet rs = stmt.executeQuery(sqlGrade);
while(rs.next())
{
	%>
	<tr>
	
	<th><%=rs.getString(1) %> </th>
	<th><%=rs.getString(2) %> </th>
	<th><%=rs.getString(3) %> </th>
	<th><%=rs.getString(4) %> </th>
	
	
	
	</tr>
	
	
	
	<%
	
}






con.close(); 
} catch(SQLException e) { 
out.println("SQLException caught: " +e.getMessage()); } 













%>

</table>

<form action='studentHome.jsp' style='margin-top: 100px'>

<input style = 'color:blue;width:100px' value=' back ' type='submit' onclick = "window.location.href='studentHome.jsp"/> 
</form>
</body>
</html>