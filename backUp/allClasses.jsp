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
 <form action="saveClasses.jsp">
<table border="1">
    <tr>
        <th>class id</th>
        <th>course_abbreviation</th>
        <th>course_name</th>
        <th>time</th>
        <th>instructor</th>
        <th>save</th>
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
String sqlClasses = "Select student_portal.is.class_id, course_abbreviation, course_name, time, first_name from student_portal.classes join student_portal.is using(class_id) join catalogue_courses using(course_abbreviation) join student_portal.teach using(class_id) join student_portal.users using(user_id) order by course_abbreviation asc";
ResultSet rs = stmt.executeQuery(sqlClasses);
while(rs.next())
{
	%>
	<script> 
	function kk(){ 
	var handleEl = document.getElementById("kkHandler"); 
	var els = document.getElementsByName("kk"); 
	for(i=0;i<els.length;i++){ 
	els[i].checked = handleEl.checked; 
		} 
 
		} 
</script> 
	<tr>
	
	<th><%=rs.getString(1) %> </th>
	<th><%=rs.getString(2) %> </th>
	<th><%=rs.getString(3) %> </th>
	<th><%=rs.getString(4) %> </th>
	<th><%=rs.getString(5) %> </th>
	<th>
	<input type="checkbox" name ="savedClass" value = "<%=rs.getString(1) %>"/>
	</th>
	</tr>
	
	
	
	<%
	
}






con.close(); 
} catch(SQLException e) { 
out.println("SQLException caught: " +e.getMessage()); } 


%>


</table>
<input type = "submit" value ="submit"/>
</form>
<form action='studentHome.jsp' style='margin-top: 100px'>

<input style = 'color:blue;width:100px' value=' back ' type='submit' onclick = "window.location.href='studentHome.jsp"/> 
</form>

</body>
</html>