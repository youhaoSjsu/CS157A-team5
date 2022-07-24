<%-- <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

</body>
</html> --%>


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
    
    
    
    
			<%
			if(session.getAttribute("login") == null || session.getAttribute("login") == " ") {//check is user accessed this page without logging in(eg. changing url)
			
				response.sendRedirect("index.jsp"); 
			}
			%>
			
			
			
			
			
			
			<div class="student-home-title">
			    Welcome, STUDENT <%=session.getAttribute("login")%>
			</div>
			
			<a href="logout.jsp">Logout</a>
    </div>

</body>

</html>
