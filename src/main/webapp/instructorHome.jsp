<%@ page import="java.sql.*" %>  

<!DOCTYPE html>
<html>

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>Welcome : <%=session.getAttribute("login")%></title>

<link rel="stylesheet" href="instructor.css" type="text/css">
<script>
		function validateGradeForm() {
			var cid = document.form2.classId;
			var uid = document.form2.userId;
			var grade = document.form2.grade;
			if (cid.value == null || cid.value == "" || uid.value == null || uid.value == "" || grade.value == null || grade.value == "" ||
					!(grade.value == "A+" || grade.value == "A" || grade.value == "A-" ||
					grade.value == "B+" || grade.value == "B" || grade.value == "B-" ||
					grade.value == "C+" || grade.value == "C" || grade.value == "C-" || grade.value == "F"))  {
				if (cid.value == null || cid.value == "") {
					cid.style.background = '#f08080';
					cid.focus();
				} else {
					cid.style.background = '#282828';
				}
				
				if (uid.value == null || uid.value == "") {
					uid.style.background = '#f08080'; 
					uid.focus();
				}else  {
					uid.style.background = '#282828';
				} 
				
				if (grade.value == null || grade.value == "" || !(grade.value == "A+" || grade.value == "A" || grade.value == "A-" ||
						grade.value == "B+" || grade.value == "B" || grade.value == "B-" ||
						grade.value == "C+" || grade.value == "C" || grade.value == "C-" || grade.value == "F")) {
					grade.style.background = '#f08080'; 
					grade.focus();
				}else {
					grade.style.background = '#282828';
				} 
				
				return false;
			}
			return true;
		}
		
		function validateDropForm() {
			var cid = document.form3.IDForClassToDrop;
			var uid = document.form3.IDForStudentToDrop;
			if (cid.value == null || cid.value == "" || uid.value == null || uid.value == ""){
				if (cid.value == null || cid.value == "") {
					cid.style.background = '#f08080';
					cid.focus();
				} else {
					cid.style.background = '#282828';
				}
				
				if (uid.value == null || uid.value == "") {
					uid.style.background = '#f08080'; 
					uid.focus();
				}else  {
					uid.style.background = '#282828';
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
		String username = session.getAttribute("login").toString();

	try {	
		Class.forName("com.mysql.cj.jdbc.Driver"); //load driver
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/student_portal?autoReconnect=true&useSSL=false", "root", "970630");
		
		Statement statement = con.createStatement();
		String sqlSt = "SELECT user_id FROM student_portal.users where username = '" + username +"';";
		ResultSet rs = statement.executeQuery(sqlSt);
		if (rs.next()){
			String id = rs.getString(1);
			session.setAttribute("id", id);	
		}
		
		if (request.getParameter("submit_student_grade") != null){ 
			String classId = request.getParameter("classId");
			String userId = request.getParameter("userId");
			String grade = request.getParameter("grade");
			
			int id = Integer.parseInt(session.getAttribute("id").toString());

			String selectInstructorClassSql = "SELECT * FROM student_portal.teach WHERE class_id='" + classId + "' AND user_id='" + id + "';";
			rs = statement.executeQuery(selectInstructorClassSql);
			if (rs.next()){ //means the instructor logged in teaches that class
				String selectClassUserSql = "SELECT * FROM student_portal.register WHERE class_id='" + classId + "' AND user_id='" + userId + "';";
				rs = statement.executeQuery(selectClassUserSql);
				if (rs.next()){ //means the user is registered in that class
					String hasGradeSql = "SELECT * FROM student_portal.grade WHERE class_id='" + classId + "' AND user_id='" + userId + "';";
					rs = statement.executeQuery(hasGradeSql);
					if (rs.next()){ // if there's already a grade (update it)
						String sqlUpdateGradeStatement = "UPDATE `student_portal`.`grade` SET grade = '" + grade + "' WHERE user_id = '"
						+ userId + "' AND class_id = '" + classId + "';";
						statement.executeUpdate(sqlUpdateGradeStatement);
					} else{ // insert grade
						String sqlInsertGradeStatement = "INSERT INTO `student_portal`.`grade` (`user_id`, `class_id`, `grade`)"
								+ " VALUES('"+userId+"','"+classId+"'"	+",'"+grade+"');";
						statement.executeUpdate(sqlInsertGradeStatement);
					}
				} else{
					out.println("Student not found. Choose a different user id.");
				}
			} else {
				out.println("You do not teach a class with that class id. Try again.");
			}
			
		}
		
		if (request.getParameter("drop_student") != null){ 
			String classId = request.getParameter("IDForClassToDrop");
			String userId = request.getParameter("IDForStudentToDrop");

			int id = Integer.parseInt(session.getAttribute("id").toString());
			String selectInstructorClassSql = "SELECT * FROM student_portal.teach WHERE class_id='" + classId + "' AND user_id='" + id + "';";
			rs = statement.executeQuery(selectInstructorClassSql);
			if (rs.next()){ //means the instructor logged in teaches that class
				String selectClassUserSql = "SELECT * FROM student_portal.register WHERE class_id='" + classId + "' AND user_id='" + userId + "';";
				rs = statement.executeQuery(selectClassUserSql);
				if (rs.next()){ //means the user is registered in that class
					statement.executeUpdate("DELETE FROM `student_portal`.`grade` WHERE (`user_id` = '" + userId + "' AND class_id = '" + classId + "');");					
					statement.executeUpdate("DELETE FROM `student_portal`.`register` WHERE (`user_id` = '" + userId + "' AND class_id = '" + classId + "');");					
				} else{
					out.println("Student not found. Choose a different user id.");
				}
			} else {
				out.println("You do not teach a class with that class id. Try again.");
			}
		}
		
    }catch(Exception e) {
		out.println(e);
	}
	%>
	</div>

	<div class="instructor-home">
		<%
		if(session.getAttribute("login") == null || session.getAttribute("login")==" ") //check condition unauthorize user not direct access welcome.jsp page
		{
			response.sendRedirect("index.jsp"); 
		}
		%>

		<button class ="profileButton" onclick="window.location.href='modifyProfile.jsp'">Profile</button>

		<div class="instructor-home-title">
			Welcome, Instructor <%=session.getAttribute("login")%>
		</div>

		<!-- <form name="form1" method="POST" action="index.jsp"> -->

		<div class="change-student-grade-form">
			<h1>Submit Student Grade</h1>
			<form name="form2" class="form2" method="post" onsubmit="return validateGradeForm();">
				Class id: <input type="search" name="classId" /> 
				<br> <br>
				User id: <input type="search" name="userId" /> 
				<br> <br>
				Grade: <input type="search" name="grade" /> 
				<br><br><br>
				<input type="submit" class="submit_student_grade" name="submit_student_grade" value="Submit Grade" />
			</form>
		</div>
		
		<br><br>
		
		<div class="drop-student-form">
			<h1>Drop User</h1>
			<form name="form3" class="form3" method="post" onsubmit="return validateDropForm();">
				Class id: <input type="search" name="IDForClassToDrop" /> 
				<br><br>
				User id: <input type="search" name="IDForStudentToDrop" /> 
				<br><br><br>
				<input type="submit" class="drop_student" name="drop_student" value="Drop Student" />
			</form>

		</div>
		<br>
		<a href="logout.jsp">Logout</a>
	</div>



</body>

</html>
