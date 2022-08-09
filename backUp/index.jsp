<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %> 


<%-- need redirect here? --%>

<%
String db = "student_portal";
String user = "root"; // assumes database name is the same as username
try
{
	Class.forName("com.mysql.jdbc.Driver"); //load driver
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/"+db, "root", "970630");
	
	  if(request.getParameter("btn_login") != null){ //check login button click event not null
	        String username = request.getParameter("username");
	        String password = request.getParameter("password");
	        String selectSql =
	        "SELECT role_name FROM users JOIN has ON users.user_id=has.user_id JOIN roles ON has.role_id=roles.role_id WHERE username='" + username + "' AND password='" + password + "'";
	        Statement statement = con.createStatement();
	        ResultSet rs = statement.executeQuery(selectSql);
	        
	        //get id
	       /*  ResultSet rs_id = statement.executeQuery("SELECT user_id FROM student_portal.users where username = '"+username+"';");
	        if(rs_id.next())
	        {
	        	int user_id = rs_id.getInt("user_id");
	        	session.setAttribute("login_id", user_id);
	        }
	        rs_id.close();
	         */
	        
	        if (rs.next()) {
	            session.setAttribute("login", username); //session name is login and store fetchable database email address
	            
	            
	            
	            String userType = rs.getString("role_name");
	            if (userType.equals("student")) {
	                response.sendRedirect("studentHome.jsp");
	            } else if (userType.equals("instructor")) {
	                response.sendRedirect("instructorHome.jsp");
	            }else if (userType.equals("admin")) {
	                response.sendRedirect("adminHome.jsp");
	            } else {
	                out.println("Error.");
	            }
	        }
	        rs.close();
	        statement.close();
	        
	        con.close(); //close connection    
	    } 
	    
	
	
}
catch(Exception e)
{
	out.println(e);
}
%>

<!DOCTYPE html>
<html>

<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">

	<link rel="stylesheet" href="style.css" type="text/css" >
	
	<script>
		
		function validate()
		{
			var username = document.login.username;
			var password = document.login.password;
			if (username.value == null || username.value == "" || password.value == null || password.value == "")  {
				if (username.value == null || username.value == "") {
	 				username.style.background = '#f08080';
					username.focus();
				} else if (username == document.activeElement) {
					 username.style.background = '#282828';
				}
				if (password.value == null || password.value == "") //check password textbox not blank
				{
	 				password.style.background = '#f08080'; 
					password.focus();
				}else if (password == document.activeElement) {
					 password.style.background = '#282828';
				} 
				return false;
			}
		}
			
	</script>
	
</head>

<body>
	<form class="login-form-container" method="POST" name="login" onsubmit="return validate();">
		<div class="login-page">
			<div class="form">
				<div class="login">
					<div class="login-header">
						<h3>Login</h3>
					</div>
				</div>
				<form class="login-form">
					<input type="text" name="username" placeholder="Username" />
					<input type="password" name="password" placeholder="Password" />
					<input type="submit" class="btn_login" name="btn_login" value="Sign in"/>
				</form>
			</div>
		</div>
	</form>
</body>

</html>