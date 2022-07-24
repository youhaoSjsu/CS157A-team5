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
/* 	ResultSet rs=stmt.executeQuery("SELECT user_id FROM student_portal.users where username = '"+name+"';");
*/	
 String sqlSt = "SELECT class_id FROM student_portal.register where user_id = '" +id+"';";
	ResultSet rs=stmt.executeQuery(sqlSt);
	
	Vector vCrn = new Vector();
while(rs.next()){
	
	String class_id = rs.getString(1);
	vCrn.add(class_id);		
	

}
//this statment take class info
out.println("</br>"+"&nbsp&nbsp mode:  &nbsp"+"&nbsp location: &nbsp"+"&nbsp&nbsp&nbsp&nbsp &nbsp&nbsp     time    &nbsp&nbsp"+"&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp   course_name    &nbsp"+"</br>");

Statement stContent = con.createStatement();
String sInfo = "SELECT mode_of_instruction,location, time, course_name From student_portal.classes join student_portal.is using(class_id) join student_portal.catalogue_courses using(course_abbreviation)where class_id in (select class_id from student_portal.register where user_id = '"+id+"'); ";
ResultSet rsInfo =  stContent.executeQuery(sInfo);
while(rsInfo.next())
{


out.println("</br>"+"&nbsp"+rsInfo.getString(1) +"&nbsp"+"&nbsp"+ rsInfo.getString(2)+"&nbsp"+"&nbsp"+"&nbsp"+"&nbsp"+"&nbsp"+"&nbsp"+ rsInfo.getString(3)+"&nbsp"+"&nbsp"+"&nbsp"+"&nbsp"+"&nbsp"+"&nbsp"+rsInfo.getString(4) );

}
//test id obtain method
/* for(int i = 0;i<vCrn.size();i++)
{
out.println("</br>"+vCrn.get(i)+"\n");

}
 */


con.close(); 
} catch(SQLException e) { 
out.println("SQLException caught: " +e.getMessage()); } 













%>




</body>
</html>