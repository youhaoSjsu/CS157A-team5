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
			var rId = document.form2.rId;


			if (username.value == null || username.value == "" || password.value == null || password.value == "" || fname.value==null || fname.value == "" || 
					lname.value==null || lname.value == "" || email.value==null || email.value == "" || phone.value == null || phone.value == "" 
					|| rId.value == null || rId.value == "" )  {
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
				
				if (rId.value == null || rId.value == "") {
					rId.style.background = '#f08080'; 
					rId.focus();
				}else {
					rId.style.background = '#282828';
				} 
				return false;
			}
			return true;
		}
		
		
		
		function validate2() {
/*  			document.writeln(-1);
 			var saa = document.form3.userIDtoDelete.value;
 			document.writeln(saa);
 			document.writeln(document.form3.userIDtoDelete.value);

			var u = document.getElementsById("userIDtoDelete")[0];
 			document.writeln(u); */
 			var userId = document.form3.userIDtoDelete;
/* 			document.writeln(userId);
 */
			if (userId.value == null || userId.value == ""){
				if (userId.value == null || userId.value == "")  {
					userId.style.background = '#f08080';
					userId.focus();
				}else {
					userId.style.background = '#282828';
				}
				 
				return false;
			}   
			return true;
		}
		
		
		function validateAddClass() {
			var cId = document.form4.cAbIDtoAdd;
 			var enr = document.form4.enrollmentToAdd;
			var cap = document.form4.capacityToAdd;
			var cred = document.form4.creditsToAdd;
			var mode = document.form4.modeToAdd;
			var loc = document.form4.locationToAdd;
			var time = document.form4.timeToAdd;

			if (cId.value == null || cId.value == "" || enr.value==null || enr.value == "" || 
					cap.value==null || cap.value == "" || cred.value==null || cred.value == "" || mode.value==null || mode.value == "" 
					|| loc.value == null || loc.value == "" || time.value == null || time.value == "" )  {
				if (cId.value == null || cId.value == "") {
					cId.style.background = '#f08080';
					cId.focus();
				} else {
					cId.style.background = '#282828';
				}
				
				
				if (enr.value == null || enr.value == "") {
					enr.style.background = '#f08080'; 
					enr.focus();
				}else {
					enr.style.background = '#282828';
				} 
				
				if (cap.value == null || cap.value == "") {
					cap.style.background = '#f08080'; 
					cap.focus();
				}else  {
					cap.style.background = '#282828';
				} 
				
				if (cred.value == null || cred.value == "") {
					cred.style.background = '#f08080'; 
					cred.focus();
				}else  {
					cred.style.background = '#282828';
				} 
				
				if (mode.value == null || mode.value == "") {
					mode.style.background = '#f08080'; 
					mode.focus();
				}else {
					phone.style.background = '#282828';
				} 
				
				if (loc.value == null || loc.value == "") {
					loc.style.background = '#f08080'; 
					loc.focus();
				}else {
					loc.style.background = '#282828';
				} 
				
				if (time.value == null || time.value == "") {
					time.style.background = '#f08080'; 
					time.focus();
				}else {
					time.style.background = '#282828';
				} 
				return false;
			}
			return true;
		}
		
		function validateModifyClass() {
			var cId = document.form5.classIDtoLookupWhenModifying;
 			var enr = document.form5.enrollmentToModify;
			var cap = document.form5.capacityToModify;
			var cred = document.form5.creditsToModify;
			var mode = document.form5.modeToModify;
			var loc = document.form5.locationToModify;
			var time = document.form5.timeToModify;

			if (cId.value == null || cId.value == "" || enr.value==null || enr.value == "" || 
					cap.value==null || cap.value == "" || cred.value==null || cred.value == "" || mode.value==null || mode.value == "" 
					|| loc.value == null || loc.value == "" || time.value == null || time.value == "" )  {
				if (cId.value == null || cId.value == "") {
					cId.style.background = '#f08080';
					cId.focus();
				} else {
					cId.style.background = '#282828';
				}
				
				
				if (enr.value == null || enr.value == "") {
					enr.style.background = '#f08080'; 
					enr.focus();
				}else {
					enr.style.background = '#282828';
				} 
				
				if (cap.value == null || cap.value == "") {
					cap.style.background = '#f08080'; 
					cap.focus();
				}else  {
					cap.style.background = '#282828';
				} 
				
				if (cred.value == null || cred.value == "") {
					cred.style.background = '#f08080'; 
					cred.focus();
				}else  {
					cred.style.background = '#282828';
				} 
				
				if (mode.value == null || mode.value == "") {
					mode.style.background = '#f08080'; 
					mode.focus();
				}else {
					phone.style.background = '#282828';
				} 
				
				if (loc.value == null || loc.value == "") {
					loc.style.background = '#f08080'; 
					loc.focus();
				}else {
					loc.style.background = '#282828';
				} 
				
				if (time.value == null || time.value == "") {
					time.style.background = '#f08080'; 
					time.focus();
				}else {
					time.style.background = '#282828';
				} 
				return false;
			}
			return true;
		}
		
		function validateDeleteClass() {
			var cId = document.form6.classIDtoDelete;
			
			if (cId.value == null || cId.value == "") {
				if (cId.value == null || cId.value == "") {
					cId.style.background = '#f08080';
					cId.focus();
				} else {
					cId.style.background = '#282828';
				}
				return false;
			}
			return true;

		}

		
	</script>
</head>

<body>

<div class="myspan">
<%
try {	
	Class.forName("com.mysql.cj.jdbc.Driver"); //load driver
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/student_portal?autoReconnect=true&useSSL=false", "root", "970630");


	if (request.getParameter("add_user") != null){ 
		String username = request.getParameter("username");
		String email = request.getParameter("email");
		String phone = request.getParameter("number");
		String roleId = request.getParameter("rId");
	
		String selectUsernameSql = "SELECT username FROM users WHERE username='" + username + "'";
		String selectEmailSql = "SELECT email FROM users WHERE email='" + email + "'";
		String selectPhoneSql = "SELECT phone FROM users WHERE phone='" + phone + "'";
		String selectRoleIdSql = "SELECT role_id FROM roles WHERE role_id='" + roleId + "'";

		Statement statement = con.createStatement();
		ResultSet rs = statement.executeQuery(selectUsernameSql);
		
		if (!rs.next()){ //no existing user with the same userName	
			 rs = statement.executeQuery(selectEmailSql);
			 if (!rs.next()){ //no existing user with the same email	
				 rs = statement.executeQuery(selectPhoneSql);
				 if (!rs.next()){ //no existing user with the same phone
					 	rs = statement.executeQuery(selectRoleIdSql);
					 	if (rs.next()) { //role id is valid
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
														
							sqlAddStudentStatment = "INSERT INTO `student_portal`.`has` (`user_id`, `role_id`) VALUES('"+newId+"','"+roleId+"');";
							statement.executeUpdate(sqlAddStudentStatment);
							rs.close();
							statement.close();
					 	}else{
					 		out.println("Role is invalid. Choose a different role id.");
					 	}
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

		String selectUsernameSql = "SELECT * FROM student_portal.users WHERE user_id='" + userId + "';";

		Statement statement = con.createStatement();
		ResultSet rs = statement.executeQuery(selectUsernameSql);
		
		if (rs.next()){ // if the user id exists
			String checkIfAdminSql = "SELECT * FROM student_portal.has JOIN student_portal.roles ON student_portal.has.user_id='" + userId + "' AND has.role_id=roles.role_id AND roles.role_name='admin'";
			rs = statement.executeQuery(checkIfAdminSql);
			if (!rs.next()){ // if the user id does not belong to an admin
				statement.executeUpdate("DELETE FROM `student_portal`.`has` WHERE (`user_id` = '" + userId + "');");
				statement.executeUpdate("DELETE FROM `student_portal`.`comment` WHERE (`user_id` = '" + userId + "');");
				statement.executeUpdate("DELETE FROM `student_portal`.`save` WHERE (`user_id` = '" + userId + "');");
				statement.executeUpdate("DELETE FROM `student_portal`.`grade` WHERE (`user_id` = '" + userId + "');");
				statement.executeUpdate("DELETE FROM `student_portal`.`register` WHERE (`user_id` = '" + userId + "');");
				statement.executeUpdate("DELETE FROM `student_portal`.`users` WHERE (`user_id` = '" + userId + "');");
			} else {  // if the user id does not belongs to an admin
				out.println("Cannot delete user. User id belongs to an admin.");
			}
		} else { // if the user id doesn't exist
			out.println("No user with the selected user id exists.");
		}

		/* rs.close();
		statement.close(); */
		//con.close(); //close connection
	}
	
	
	
	if (request.getParameter("add_class") != null){ 
		String cId = request.getParameter("cAbIDtoAdd");
		String enr = request.getParameter("enrollmentToAdd");
		String cap = request.getParameter("capacityToAdd");
		String cred = request.getParameter("creditsToAdd");
		String mode = request.getParameter("modeToAdd");
		String loc = request.getParameter("locationToAdd");
		String time = request.getParameter("timeToAdd");
		
		String selectClassSql = "SELECT * FROM student_portal.is WHERE course_abbreviation='" + cId + "';";
		Statement statement = con.createStatement();
		ResultSet rs = statement.executeQuery(selectClassSql);
		if (rs.next()){// means a class with this abbreviation is mapped to a course (meaning valid)	
			rs = statement.executeQuery("SELECT count(*) FROM student_portal.classes;");
			rs.next();
			int newClassId = rs.getInt(1) + 1;
			
			String sqlAddClassStatement = "INSERT INTO `student_portal`.`classes` (`class_id`, `enrollment`, `capacity`, `credits`, `mode_of_instruction`, `location`, `time`) " + 
			" VALUES('"+newClassId+"','"+enr+"','"+cap+"','"+cred+"','"+mode+"','"+loc+"','"+time+"');";
			statement.executeUpdate(sqlAddClassStatement);
				
			String sqlAddToIsStatement = "INSERT INTO `student_portal`.`is` (`class_id`, `course_abbreviation`) VALUES('"+newClassId+"','"+cId+"');";
			statement.executeUpdate(sqlAddToIsStatement);
		}else{
			out.println("Cannot create a class for a course that does not exist.");
		}
	}
	
	
	
	
	
	
	if (request.getParameter("modify_class") != null){ 
		String cId = request.getParameter("classIDtoLookupWhenModifying");
		String enr = request.getParameter("enrollmentToModify");
		String cap = request.getParameter("capacityToModify");
		String cred = request.getParameter("creditsToModify");
		String mode = request.getParameter("modeToModify");
		String loc = request.getParameter("locationToModify");
		String time = request.getParameter("timeToModify");
		
		String selectClassSql = "SELECT * FROM student_portal.classes WHERE class_id='" + cId + "';";
		Statement statement = con.createStatement();
		ResultSet rs = statement.executeQuery(selectClassSql);
		if (rs.next()){// means a class with that id exists	
			statement.executeUpdate("UPDATE student_portal.classes SET enrollment='"+enr+"', capacity='"+cap+"', credits='"+cred+
			"', mode_of_instruction='"+mode+"', location='"+loc+"', time='"+time+"' WHERE class_id='"+cId+"';");
		}else{
			out.println("Could not find class with given class_id.");
		}
	}
	
	if (request.getParameter("delete_class") != null){ 
		String cId = request.getParameter("classIDtoDelete");

		String selectUsernameSql = "SELECT * FROM student_portal.classes WHERE class_id='" + cId + "';";

		Statement statement = con.createStatement();
		ResultSet rs = statement.executeQuery(selectUsernameSql);
		
		if (rs.next()){ // if the class exists
			statement.executeUpdate("DELETE FROM `student_portal`.`is` WHERE (`class_id` = '" + cId + "');");
			statement.executeUpdate("DELETE FROM `student_portal`.`comment` WHERE (`class_id` = '" + cId + "');");
			statement.executeUpdate("DELETE FROM `student_portal`.`save` WHERE (`class_id` = '" + cId + "');");
			statement.executeUpdate("DELETE FROM `student_portal`.`grade` WHERE (`class_id` = '" + cId + "');");
			statement.executeUpdate("DELETE FROM `student_portal`.`register` WHERE (`class_id` = '" + cId + "');");
			statement.executeUpdate("DELETE FROM `student_portal`.`teach` WHERE (`class_id` = '" + cId + "');");
			statement.executeUpdate("DELETE FROM `student_portal`.`classes` WHERE (`class_id` = '" + cId + "');");
		} else { // if the user id doesn't exist
			out.println("No class with the selected class id exists.");
		}

		rs.close();
		statement.close();

	}
	
}
catch(Exception e)
{
	out.println(e);
}
%>

</div>
    <div class="admin-home">
    	<button class ="profileButton" onclick="window.location.href='modifyProfile.jsp'">Profile</button>
    
		<%
		if(session.getAttribute("login") == null || session.getAttribute("login")==" ") //check condition unauthorize user not direct access welcome.jsp page
		{
			response.sendRedirect("index.jsp"); 
		}
		%>
	
	
	
		<div class="admin-home-title">
			Welcome, Admin <%=session.getAttribute("login")%>
		</div>

		<!-- <form name="form1" method="POST" action="index.jsp"> -->

		<div class ="add-user-form">
			<h1> Add User </h1>
			<form name ="form2" class="form2" method = "post" onsubmit="return validate();">
				username:  
				<input type="search" name = "username"/>	
				<br><br>				
				password:
				<input type="search" name = "psd"/>
				<br><br>							
				first name:  
				<input type="search" name = "f_name"/>
				<br><br>							
				last name: 
				<input type="search" name = "l_name"/>
				<br><br>					
				email:
				<input type="search" name = "email"/>
				<br><br>							
				phone: 
				<input type="search" name = "number"/>
				<br><br>
				role id: 
				<input type="search" name = "rId"/>
				<br><br>
				<input type="submit" class="add_user" name="add_user" value="Add User"/>
			</form>
			
		</div>
		
		
		<div class ="delete-user-form">
			<h1> Delete User </h1>
			<form name ="form3" class="form3" method = "post" onsubmit="return validate2();">
				user id:  
				<input type="search" name = "userIDtoDelete" id ="userIDtoDelete"/>	
				<br><br>
							
				<input type="submit" class="delete_user" name="delete_user" value="Delete User"/>
			</form>
		</div> <br>
		
		
		
		<div class ="add-class-form">
			<h1> Add Class </h1>
			<form name ="form4" class="form4" method = "post" onsubmit="return validateAddClass();">
				Course Abbreviation:  
				<input type="search" name = "cAbIDtoAdd"/>	
				<br><br>
				Enrollment:  
				<input type="search" name = "enrollmentToAdd"/>	
				<br><br>		
				Capacity:  
				<input type="search" name = "capacityToAdd"/>	
				<br><br>		
				Credits:  
				<input type="search" name = "creditsToAdd"/>	
				<br><br>		
				Mode of Instruction:  
				<input type="search" name = "modeToAdd"/>	
				<br><br>		
				Location:  
				<input type="search" name = "locationToAdd"/>	
				<br><br>		
				Time:  
				<input type="search" name = "timeToAdd"/>	
				<br><br>		
				<input type="submit" class="add_class" name="add_class" value="Add Class"/>
			</form>
		</div><br>
		
		<div class ="modify-class-form">
			<h1> Modify Class </h1>
			<form name ="form5" class="form5" method = "post" onsubmit="return validateModifyClass();">
				Class id:  
				<input type="search" name = "classIDtoLookupWhenModifying"/>	
				<br><br>
				New Enrollment:  
				<input type="search" name = "enrollmentToModify"/>	
				<br><br>		
				New Capacity:  
				<input type="search" name = "capacityToModify"/>	
				<br><br>		
				New Credits:  
				<input type="search" name = "creditsToModify"/>	
				<br><br>		
				New Mode of Instruction:  
				<input type="search" name = "modeToModify"/>	
				<br><br>		
				New Location:  
				<input type="search" name = "locationToModify"/>	
				<br><br>		
				New Time:  
				<input type="search" name = "timeToModify"/>	
				<br><br>		
				<input type="submit" class="modify_class" name="modify_class" value="Modify Class"/>
			</form>
		</div><br>
		
		<div class ="delete-class-form">
			<h1> Delete Class </h1>
			<form name ="form6" class="form6" method = "post" onsubmit="return validateDeleteClass();">
				Class id:  
				<input type="search" name = "classIDtoDelete"/>	
				<br><br>
							
				<input type="submit" class="delete_class" name="delete_class" value="Delete Class"/>
			</form>
		</div><br>
		
		
		
		<a href="logout.jsp">Logout</a>
    </div>

</body>

</html>
