<%@ page import="java.sql.*" %>  
<%-- <%@ include file="index.jsp"%>
 --%>
 <%@ page import="java.util.LinkedList" %>
 <%@ page import="classesPackage.ClassInfo" %>
 


<!DOCTYPE html>
<html>

<head>

	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">

 	
</head>

<body>
  <%
  String db = "student_portal";
  String user = "root"; // assumes database name is the same as username
  
  String name = session.getAttribute("login").toString();
  String id = session.getAttribute("id").toString();
  String targetId = session.getAttribute("cc").toString();
  String  content = request.getParameter("comment_content");
  try { 
  java.sql.Connection con; 
  Class.forName("com.mysql.cj.jdbc.Driver"); 
  con = DriverManager.getConnection("jdbc:mysql://localhost:3306/"+db, "root", "970630"); 
  Statement stmt=con.createStatement();
  String check ="Select count(*) from student_portal.comment where user_id='"+id+"' and class_id='"+targetId+"'";
  ResultSet rs = stmt.executeQuery(check);
  if(rs.next())
  {
	  if(rs.getInt(1)==0)
	  {

		  //add comment
		  String comtSql = "INSERT INTO `student_portal`.`comment` (`user_id`, `class_id`, `comment`) VALUES ('"+id+"', '"+targetId+"', '"+content+"');";
		  stmt.executeUpdate(comtSql);
	  }else
	  {
		  out.println("</br>"+"can not add comment, because you have commented that class before.");
	  }
  }
  
  
  //show
  stmt=con.createStatement();
  String sqlInfo = "Select comment.class_id, course_abbreviation,comment from student_portal.is join student_portal.comment using(class_id) join student_portal.register using(user_id) where user_id = '"+id+"'group by(course_abbreviation);";	  
	
  ResultSet rsInfo = stmt.executeQuery(sqlInfo);
  while(rsInfo.next())
  {
	  out.println("</br>"+"class:"+"</br>"+rsInfo.getString(1)+"&nbsp"+"&nbsp"+rsInfo.getString(2));
	  out.println("</br></br>"+"comment:"+"&nbsp"+"&nbsp"+rsInfo.getString(3) );
	  out.println("</br>"+"___________________________________________________________________________________________________________");
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
