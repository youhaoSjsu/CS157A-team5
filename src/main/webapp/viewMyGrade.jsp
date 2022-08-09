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
<link rel="stylesheet" href="viewMyGrade.css" type="text/css">

</head>
<body>
	<button class ="backButton" onclick="window.location.href='studentHome.jsp'">&#8249;</button>

	<h1><%=session.getAttribute("login")%>'s Grades</h1>
	<h2>
		<table border="1">
			<tr>
				<th>Class id</th>
				<th>Abbreviation</th>
				<th>Name</th>
				<th>Grade</th>
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
				String sqlGrade = "select class_id, course_abbreviation, course_name, grade from student_portal.is join grade using(class_id) join catalogue_courses using(course_abbreviation)where user_id='"
				+ id + "'";
				ResultSet rs = stmt.executeQuery(sqlGrade);
				while (rs.next()) {
				%>
				<tr>
					<td><%=rs.getString(1)%></td>
					<td><%=rs.getString(2)%></td>
					<td><%=rs.getString(3)%></td>
					<td><%=rs.getString(4)%></td>
				</tr>
				<%
				}

			con.close();
			} catch (SQLException e) {
			out.println("SQLException caught: " + e.getMessage());
			}
			%>

		</table>
</body>
</html>