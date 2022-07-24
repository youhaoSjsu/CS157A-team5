<%@ page import="java.sql.*" %>  
<%-- <%@ include file="index.jsp"%>
 --%>


<!DOCTYPE html>
<html>

<head>

	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">

	<title>Welcome : <%=session.getAttribute("login")%></title>

 	<link rel="stylesheet" href="style.css" type="text/css" >
</head>

<body>
    <div class="student-home">
			
			<div class="student-home-title">
			    Welcome, STUDENT <%=session.getAttribute("login")%>, <%=session.getAttribute("login_id") %>
			</div>
			
			<a href="logout.jsp">Logout</a>
    </div>

	<div>
	<div>
	<form action = "MyClasses.jsp" >
		<input type="submit" value = "view my classes" name = "button" class= "btn_login" onclick="window.location.href = 'MyClasses.jsp'">
	</form>
	
	<form action = "registerClass.jsp">
	
	<input type="submit" value = "add a class" name ="button_add" class="btn_login" onclick = "window.location.href = 'RegisterClass.jsp'">
	</form>
		
	<form action = "dropClass.jsp">
	
	<input type= "submit" value = "drop a class" class= "btn_login" onclick = "window.location.href='dropClass.jsp'"/> 
	
	
	</form>
	
	
	
	</div>
	
	
	
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
	
	
	

	con.close(); 
	} catch(SQLException e) { 
	out.println("SQLException caught: " +e.getMessage()); } 
	
	%>
	
	
	
</body>

</html>
