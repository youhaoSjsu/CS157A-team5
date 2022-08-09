<%@ page import="java.sql.*" %>  

<%-- <%@ include file="index.jsp"%>
 --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>



<!DOCTYPE html>
<html>
<style>

.resizedTextbox {width: 200px; height: 100px;}

</style>
<head>

	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">

	<title>please select a class></title>

 	
</head>
<body>

<form method='post' action = "commentClass.jsp">
<h2>Please enter class id</h2>
</br>

<input type = 'search' name= 'class_id' />
<input type = 'submit'/>
</form>





<%

String db = "student_portal";
String user = "root"; // assumes database name is the same as username
String targetClass = request.getParameter("class_id");
String name = session.getAttribute("login").toString();
String id = session.getAttribute("id").toString();
String targetId = request.getParameter("class_id");
try { 
java.sql.Connection con; 
Class.forName("com.mysql.cj.jdbc.Driver"); 
con = DriverManager.getConnection("jdbc:mysql://localhost:3306/"+db, "root", "970630"); 
Statement stmt=con.createStatement();
//count the register table
int regisCounter=0;
String info= "SELECT class_id,mode_of_instruction,location, time, course_name From student_portal.classes join student_portal.is using(class_id) join student_portal.catalogue_courses using(course_abbreviation)where class_id in (select class_id from student_portal.register where user_id = '"+id+"'); ";
//"SELECT mode_of_instruction,location, time, course_name From student_portal.classes join student_portal.is using(class_id) join student_portal.catalogue_courses using(course_abbreviation)where class_id in (select class_id from student_portal.register where user_id = '"+id+"'); ";
ResultSet rsInfo = stmt.executeQuery(info);
out.println("you have these classes now");
while(rsInfo.next())
{
	out.println("</br></br>"+"&nbsp"+rsInfo.getString(1) +"&nbsp"+"&nbsp"+ rsInfo.getString(2)+"&nbsp"+"&nbsp"+"&nbsp"+"&nbsp"+"&nbsp"+"&nbsp"+ rsInfo.getString(3)+"&nbsp"+"&nbsp"+"&nbsp"+"&nbsp"+"&nbsp"+"&nbsp"+rsInfo.getString(4) +"&nbsp"+"&nbsp"+"&nbsp"+"&nbsp"+rsInfo.getString(5));

}

//search
if(targetClass!= null && !targetClass.isBlank())
{
	out.println("searching"+ targetClass);
	String sqlSearch = "Select count(*) from student_portal.register where register.class_id = '"+targetId+"' and  user_id = '"+id+"';";
	stmt = con.createStatement();
	ResultSet rsSearch =stmt.executeQuery(sqlSearch);
	
	
	
	if(rsSearch.next())
	{
		if(rsSearch.getInt(1)!=0)
		{
			session.setAttribute("cc",targetClass);
			
		%>
		
			
			<form action = 'showComment.jsp'>
			<h2>write a comment</h2>
			<input class = "resizedTextbox" type = "text" name='comment_content'/>
			
			</br>
			
			<input style= 'submit' value='submit' type = 'submit'/>
			
			</form>
			
			
			
		<%
			
		}
		else{
			out.println("please double check, you are not in that class");
		}
		
	}
	
	
}

			
			
			
			
			
			
			
			
			








con.close(); 
} catch(SQLException e) { 
out.println("SQLException caught: " +e.getMessage()); } 













%>





<form action='studentHome.jsp' style='margin-top: 100px'>

<input style = 'color:blue;width:100px' value=' back ' type='submit' onclick = "window.location.href='studentHome.jsp"/> 
</form>






</body>
</html>