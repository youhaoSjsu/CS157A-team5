<%@ page import="java.sql.*" %>  


<!DOCTYPE html>
<html>

<head>

	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="modifyProfile.css" type="text/css" >
	<title>Welcome : <%=session.getAttribute("login")%></title>
	
	
	<script>
	function validateProfileChange() {
		var u = document.form1.username;
		var p = document.form1.password;
		var f = document.form1.fName;
		var l = document.form1.lName;
		var e = document.form1.email;
		var phone = document.form1.phone;

		if (u.value == null || u.value == "" || p.value == null || p.value == "" || f.value == null || f.value == "" || 
				l.value == null || l.value == "" || e.value == null || e.value == "" || phone.value == null || phone.value == ""){
			if (u.value == null || u.value == "") {
				u.style.background = '#f08080';
				u.focus();
			} else {
				u.style.background = '#282828';
			}
			
			if (p.value == null || p.value == "") {
				p.style.background = '#f08080';
				p.focus();
			} else {
				p.style.background = '#282828';
			}
			if (f.value == null || f.value == "") {
				f.style.background = '#f08080';
				f.focus();
			} else {
				f.style.background = '#282828';
			}
			if (l.value == null || l.value == "") {
				l.style.background = '#f08080';
				l.focus();
			} else {
				l.style.background = '#282828';
			}
			if (e.value == null || e.value == "") {
				e.style.background = '#f08080';
				e.focus();
			} else {
				e.style.background = '#282828';
			}
			if (phone.value == null || phone.value == "") {
				phone.style.background = '#f08080';
				phone.focus();
			} else {
				phone.style.background = '#282828';
			}
			return false;
		}
		return true;

	}

	</script>
</head>

<body>
	<div class="myspan">
		<button class ="backButton" onclick="history.go(-1)">&#8249;</button>
	
	    <div class="profile-home">			
				<div class="profile-home-title">
				    Welcome, <%=session.getAttribute("login")%>
				</div>
				<br>		
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
			Statement stmt=con.createStatement();
			
			if (request.getParameter("submit_profile_change") != null){
				String u = request.getParameter("username");
				String p = request.getParameter("password");
				String f = request.getParameter("fName");
				String l = request.getParameter("lName");
				String e = request.getParameter("email");
				String phone = request.getParameter("phone");
				
				String selectUsernameSql = "SELECT username FROM student_portal.users WHERE username='" + u + "'";
				String selectEmailSql = "SELECT email FROM student_portal.users WHERE email='" + e + "'";
				String selectPhoneSql = "SELECT phone FROM student_portal.users WHERE phone='" + phone + "'";

				Statement statement = con.createStatement();
				ResultSet rs = statement.executeQuery(selectUsernameSql);
				if (!rs.next()){ // means no one has that username
					 rs = statement.executeQuery(selectEmailSql);
					 if (!rs.next()){ // means no one has that email
						 rs = statement.executeQuery(selectPhoneSql);
						 if (!rs.next()){ // means no one has that phone
								String currentUser = session.getAttribute("login").toString();						 
								String sqlUpdateGradeStatement = "UPDATE `student_portal`.`users` SET username = '" + u + "', password='"+p+
								"', first_name='"+f+"', last_name='"+l+"', email='" + e +"', phone='" +phone +"' WHERE username = '"
								+ currentUser+ "';";
								statement.executeUpdate(sqlUpdateGradeStatement);
					            session.setAttribute("login", u); 
						 } else{
							 out.println("Phone is taken. Choose a different phone.");
						 }
					} else{
						out.println("Email is taken. Choose a different email.");
					}
				} else{
					out.println("Username is taken. Choose a different username.");
				}
	    	} 
			con.close(); 
		} catch(SQLException e) { 
			out.println("SQLException caught: " +e.getMessage());
		} 
		
		%>
		<div class="profile-home">
				<%
				if(session.getAttribute("login") == null || session.getAttribute("login")==" ") //check condition unauthorize user not direct access welcome.jsp page
				{
					response.sendRedirect("index.jsp"); 
				}
				%>	
				<h2> Change Profile </h2>
				
				
				<form name="form1" class="form2" method="post" onsubmit="return validateProfileChange();">
					Username: <input type="search" name="username" /> 
					<br> <br>
					Password: <input type="search" name="password" /> 
					<br> <br>
					First Name: <input type="search" name="fName" /> 
					<br> <br>
					Last Name: <input type="search" name="lName" /> 
					<br><br>
					Email: <input type="search" name="email" /> 
					<br> <br>
					Phone: <input type="search" name="phone" /> 
					<br> <br>
					
					<br>
					<input type="submit" class="submit_profile_change" name="submit_profile_change" value="Submit Change" />
				</form>
		
				
			<br>
			<a href="logout.jsp">Logout</a>	
		</div>
		
		
	
</body>

</html>