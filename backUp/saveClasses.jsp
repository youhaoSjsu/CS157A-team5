<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %> 
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="classesPackage.ClassInfo" %>

<%@ page import="java.util.LinkedList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>


<%

String db = "student_portal";
String user = "root"; // assumes database name is the same as username

String name = session.getAttribute("login").toString();
String id = session.getAttribute("id").toString();
String [] classList;


classList= request.getParameterValues("savedClass");
if(classList!=null)
{
if(classList.length>0)
{
	LinkedList<String> cList = new LinkedList();

out.println("you selected these classes:");



for(int i =0;i<classList.length;i++)
{
	out.println("</br>"+classList[i]);
	cList.add(classList[i]);
}



try { 
java.sql.Connection con; 
Class.forName("com.mysql.cj.jdbc.Driver"); 
con = DriverManager.getConnection("jdbc:mysql://localhost:3306/"+db, "root", "970630"); 

Statement stmt=con.createStatement();
String sqlSaved = "select class_id from student_portal.save where user_id='"+id+"' ";
ResultSet rs = stmt.executeQuery(sqlSaved);
// check duplicated saving
while(rs.next())
{
	for(int i =0;i<cList.size();i++)
	{
		if(rs.getString(1).equals(cList.get(i)))
		{
			cList.remove(i);
		}
	}
}


out.println("</br>"+"classes saved");


for(int i=0;i<cList.size();i++)
{
	stmt=con.createStatement();
	String sqlSave = "INSERT INTO `student_portal`.`save` (`user_id`, `class_id`) VALUES ('"+id+"', '"+cList.get(i)+"');";
	stmt.executeUpdate(sqlSave);
}



con.close(); 
} catch(SQLException e) { 
out.println("SQLException caught: " +e.getMessage()); } 
}else
{
	out.println("</br>"+"you selected nothing.");
}
}
else
{
	out.println("you selected nothing");
}
%>

<form action='studentHome.jsp' style='margin-top: 100px'>

<input style = 'color:blue;width:100px' value=' back ' type='submit' onclick = "window.location.href='studentHome.jsp"/> 
</form>

</body>
</html>