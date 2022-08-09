<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="classesPackage.ClassInfo"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" href="allClasses.css" type="text/css">
<script> 
	function kk(){ 
		var handleEl = document.getElementById("kkHandler"); 
		var els = document.getElementsByName("kk"); 
		for (i = 0; i < els.length; i++){ 
			els[i].checked = handleEl.checked; 
		}  
	} 
</script>
</head>
<body>
	<button class ="backButton" onclick="history.back(-1);">&#8249;</button>

	<h1><%=session.getAttribute("login")%>: Classes</h1>
	<h2>
		<form action="saveClasses.jsp">
			<table border="1">
				<tr>
					<th>Class id</th>
					<th>Abbreviation</th>
					<th>Name</th>
					<th>Time</th>
					<th>Instructor</th>
					<th>Save</th>
				</tr>



				<%
				String db = "student_portal";
				String user = "root"; // assumes database name is the same as username

				String name = session.getAttribute("login").toString();
				String id = session.getAttribute("id").toString();
				try {
					java.sql.Connection con;
					Class.forName("com.mysql.cj.jdbc.Driver");
					con = DriverManager.getConnection("jdbc:mysql://localhost:3306/" + db, "root", "970630");

					Statement stmt = con.createStatement();
					String sqlClasses = "Select student_portal.is.class_id, course_abbreviation, course_name, time, CONCAT(first_name, ' ', last_name) AS name from student_portal.classes join student_portal.is using(class_id) join catalogue_courses using(course_abbreviation) join student_portal.teach using(class_id) join student_portal.users using(user_id) order by course_abbreviation asc";
					ResultSet rs = stmt.executeQuery(sqlClasses);
					while (rs.next()) {
				%>
				
				<tr>
					<td><%=rs.getString(1)%></td>
					<td><%=rs.getString(2)%></td>
					<td><%=rs.getString(3)%></td>
					<td><%=rs.getString(4)%></td>
					<td><%=rs.getString(5)%></td>
					<td><input type="checkbox" name="savedClass" value="<%=rs.getString(1)%>" /></td>
				</tr>



				<%
				}

				con.close();
				} catch (SQLException e) {
					out.println("SQLException caught: " + e.getMessage());
				}
				%>


			</table>
			<input type="submit" value="submit" />
		</form>
</body>
</html>