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
	<link rel="stylesheet" href="studentHome.css" type="text/css" >
	<title>Welcome : <%=session.getAttribute("login")%></title>
	
	<style>
	.buttonInput{
		font-family: Helvetica, sans-serif;
	  /*text-transform: uppercase;*/
	  	outline: 0;
	  	background-image: linear-gradient(90deg,#FC0441,#F62DA8);
	  	width: 280px;
	  	height:50px;
	  	border: 0;
	  	padding: 15px;
	  	color: #FFFFFF;
	  	font-size: 20px;
	  	cursor: pointer;
	  	margin-top:20px;
	  	horizontal-align: center;
	}
	
	
	
	</style>

 	
</head>

<body>
	<%
		if(session.getAttribute("login") == null || session.getAttribute("login")==" ") //check condition unauthorize user not direct access welcome.jsp page
		{
			response.sendRedirect("index.jsp"); 
		}
		%>
    <div class="student-home">
			<button class ="profileButton" onclick="window.location.href='modifyProfile.jsp'">Profile</button>
			
			<div class="student-home-title">
			    Welcome, STUDENT <%=session.getAttribute("login")%>
			</div>
			<br>
			
    </div>
    
    
    

	
	<div>
	 <form action = "MyClasses.jsp" >
		<input class="buttonInput" type="submit" value = "View My Classes" name = "button" onclick="window.location.href = 'MyClasses.jsp'">
	</form>
	
	<form action = "registerClass.jsp">
		<input  class="buttonInput" type="submit" value = "Add a Class" name ="button_add" onclick = "window.location.href = 'RegisterClass.jsp'">
	</form>
		
	<form action = "dropClass.jsp">
		<input class="buttonInput" type= "submit" value = "Drop a Class" class= "buttonInput" onclick = "window.location.href='dropClass.jsp'"/> 
	</form>
	
	<form action= "commentClass.jsp">		
		<input class= "buttonInput" type = "submit" value = "Comment On Class" onclick = "window.location.href='commentClass.jsp'"/>	
	</form>
	
	
	<form action ="allClasses.jsp">
		<input class= "buttonInput" type = 'submit' value = "Look Up Classes" />
	</form>
	
	
	<form action="viewMyGrade.jsp">
		<input class= "buttonInput"  type= 'submit' value = "View My Grades">
	</form>
	
	<form action= "shopCart.jsp">
	
	<input class= "buttonInput" type='submit' value = "Saved Classes">
	</form>
	
	</div>
	
	<%
	String db = "student_portal";
	String user = "root"; // assumes database name is the same as username

	String name = session.getAttribute("login").toString();
	
	try { 
	java.sql.Connection con; 
	Class.forName("com.mysql.cj.jdbc.Driver"); 
	con = DriverManager.getConnection("jdbc:mysql://localhost:3306/"+db, "root", "970630"); 
	//out.println (db+ "database successfully opened."); 
	//get id
	Statement stmt=con.createStatement();
/* 	ResultSet rs=stmt.executeQuery("SELECT user_id FROM student_portal.users where username = '"+name+"';");
 */	
	 String sqlSt = "SELECT user_id FROM student_portal.users where username = '" +name+"';";
 	ResultSet rs=stmt.executeQuery(sqlSt);
	if(rs.next()){
		String id = rs.getString(1);
		session.setAttribute("id",id);
	
	
	}
	String id = session.getAttribute("id").toString();
	LinkedList<ClassInfo> classList=new LinkedList<ClassInfo>();
	stmt = con.createStatement();
	String classesInfo = "SELECT student_portal.register.class_id, student_portal.is.course_abbreviation, student_portal.catalogue_courses.course_name from student_portal.register join student_portal.is using(class_id) join catalogue_courses using(course_abbreviation) where register.user_id = '"+id+"';";
	ResultSet rsInfo  = stmt.executeQuery(classesInfo);
	
	while(rsInfo.next())
	{
		ClassInfo ci = new ClassInfo(rsInfo.getString(1),rsInfo.getString(2),rsInfo.getString(3));
		classList.add(ci);
		
	}
	session.setAttribute("classList",classList);
	
	

	con.close(); 
	} catch(SQLException e) { 
	out.println("SQLException caught: " +e.getMessage()); } 
	
	%>
	<br>
	<a href="logout.jsp">Logout</a>
	
	
</body>

</html>