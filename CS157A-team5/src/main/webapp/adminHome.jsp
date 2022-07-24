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

 	<link rel="stylesheet" href="admin.css" type="text/css" >
	<script>
		function validate() {
			var username = document.form2.username;
			var password = document.form2.psd;
			var fname = document.form2.f_name;
			var lname = document.form2.l_name;
			var email = document.form2.email;
			var phone = document.form2.number;

			if (username.value == null || username.value == "" || password.value == null || password.value == "" || fname.value==null || fname.value == "" || 
					lname.value==null || lname.value == "" || email.value==null || email.value == "" || phone.value==null || phone.value == "")  {
				if (username.value == null || username.value == "") {
	 				username.style.background = '#f08080';
					username.focus();
				} else {
					 username.style.background = '#282828';
				}
				
				if (password.value == null || password.value == "") {
	 				password.style.background = '#f08080'; 
					password.focus();
				}else  {
					 password.style.background = '#282828';
				} 
				
				if (fname.value == null || fname.value == "") {
					fname.style.background = '#f08080'; 
					fname.focus();
				}else {
					fname.style.background = '#282828';
				} 
				
				if (lname.value == null || lname.value == "") {
					lname.style.background = '#f08080'; 
					lname.focus();
				}else  {
					lname.style.background = '#282828';
				} 
				
				if (email.value == null || email.value == "") {
					email.style.background = '#f08080'; 
					email.focus();
				}else  {
					email.style.background = '#282828';
				} 
				
				if (phone.value == null || phone.value == "") {
					phone.style.background = '#f08080'; 
					phone.focus();
				}else {
					phone.style.background = '#282828';
				} 
				return false;
			}
		}
		
		
		
		function validate2() {
			var userId = document.form3.userIDtoDelete;

			if (userId.value == null || userId.value == "")  {
				userId.style.background = '#f08080';
				userId.focus();
				return false;
			}else {
				userId.style.background = '#282828';
			}
		}
	</script>
</head>

<body>

<div class="myspan">
<%
try {	
	Class.forName("com.mysql.jdbc.Driver"); //load driver
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/student_portal?autoReconnect=true&useSSL=false", "", "");


	if (request.getParameter("add_student") != null){ 
		String username = request.getParameter("username");
		String email = request.getParameter("email");
		String phone = request.getParameter("number");

		String selectUsernameSql = "SELECT username FROM users WHERE username='" + username + "'";
		String selectEmailSql = "SELECT email FROM users WHERE email='" + email + "'";
		String selectPhoneSql = "SELECT phone FROM users WHERE phone='" + phone + "'";

		Statement statement = con.createStatement();
		ResultSet rs = statement.executeQuery(selectUsernameSql);
		
		if (!rs.next()){ //no existing user with the same userName	
			 rs = statement.executeQuery(selectEmailSql);
			 if (!rs.next()){ //no existing user with the same email	
				 rs = statement.executeQuery(selectPhoneSql);
				 if (!rs.next()){ //no existing user with the same phone	
					 	String password = request.getParameter("psd");
						String fname = request.getParameter("f_name");
						String lname = request.getParameter("l_name");
						
						rs = statement.executeQuery("SELECT count(user_id) FROM student_portal.users;");
						rs.next();
						int newId = rs.getInt(1) + 1;
							
						String sqlAddStudentStatment = "INSERT INTO `student_portal`.`users` (`user_id`, `username`, `password`, `first_name`, `last_name`, `email`, `phone`)"
								+ " VALUES('"+newId+"','"+username+"'"	+",'"+password+"','"+fname+"','"+lname+"','"+email+"','"+phone+"');";
						//rs =
						statement.executeUpdate(sqlAddStudentStatment);
						int roleId = 1;//for students
						sqlAddStudentStatment = "INSERT INTO `student_portal`.`has` (`user_id`, `role_id`) VALUES('"+newId+"','"+roleId+"');";
						statement.executeUpdate(sqlAddStudentStatment);
						rs.close();
						statement.close();
						//con.close(); //close connection
				 }else {
					 out.println("Phone is invalid. Choose a different phone number.");
				 }	
			}else {
				out.println("Email is invalid. Choose a different email.");
			}	
		}else {
			out.println("Username is invalid. Choose a different username.");
		}	
		
	} 
	
	
	if (request.getParameter("delete_user") != null){ 
		String userId = request.getParameter("userIDtoDelete");

		String selectUsernameSql = "SELECT * FROM users WHERE user_id='" + userId + "'";

		Statement statement = con.createStatement();
		ResultSet rs = statement.executeQuery(selectUsernameSql);
		
		if (rs.next()){ // if the user id exists
			String checkIfAdminSql = "SELECT * FROM has JOIN roles ON has.user_id='" + userId + "' AND has.role_id=roles.role_id AND roles.role_name='admin'";
			rs = statement.executeQuery(checkIfAdminSql);
			if (!rs.next()){ // if the user id does not belong to an admin
				statement.executeUpdate("DELETE FROM `student_portal`.`has` WHERE (`user_id` = '" + userId + "');");
				statement.executeUpdate("DELETE FROM `student_portal`.`users` WHERE (`user_id` = '" + userId + "');");
			} else {  // if the user id does not belongs to an admin
				out.println("Cannot delete user. User id belongs to an admin.");
			}
		} else { // if the user id doesn't exist
			out.println("No user with the selected user id exists.");
		}

		rs.close();
		statement.close();
		//con.close(); //close connection
	}
	
}
catch(Exception e)
{
	out.println(e);
}
%>

</div>
    <div class="admin-home">
		<%
		if(session.getAttribute("login") == null || session.getAttribute("login")==" ") //check condition unauthorize user not direct access welcome.jsp page
		{
			response.sendRedirect("index.jsp"); 
		}
		%>
	
		<div class="admin-home-title">
			Welcome, ADMIN <%=session.getAttribute("login")%>
		</div>

		<!-- <form name="form1" method="POST" action="index.jsp"> -->

		<div class ="add-student-form">
			<h1> Add Student </h1>
			<form name ="form2" class="form2" method = "post" onsubmit="return validate();">
				username:  
				<input type="search" name = "username"/>	
				<br><br><br>
				
				password:
				<input type="search" name = "psd"/>
				<br><br><br>
								
				first name:  
				<input type="search" name = "f_name"/>
				<br><br><br>
								
				last name: 
				<input type="search" name = "l_name"/>
				<br><br><br>
					
				email:
				<input type="search" name = "email"/>
				<br><br><br>
								
				phone: 
				<input type="search" name = "number"/>
				<br><br><br>
					
				<input type="submit" class="add_student" name="add_student" value="Add Student"/>
			</form>
			
		</div>
		
		
		<div class ="delete-user-form">
			<h1> Delete User </h1>
			<form name ="form3" method = "post" onsubmit="return validate2();">
				user id:  
				<input type="search" name = "userIDtoDelete"/>	
				<br><br><br>
							
				<input type="submit" class="delete_user" name="delete_user" value="Delete User"/>
			</form>
			
		</div>
		
		<a href="logout.jsp">Logout</a>
    </div>

</body>

</html>
