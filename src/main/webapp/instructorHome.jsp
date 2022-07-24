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
	
	
		<h1> Welcome, INSTRUCTOR<%=session.getAttribute("login")%> </h1>
	
		<a href="logout.jsp">Logout</a>
    
		
    </div>

</body>

</html>
