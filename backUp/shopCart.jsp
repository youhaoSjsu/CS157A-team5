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

 	
</head>
<body>

<form action="shopCart.jsp">
<table border="1">
    <tr>
        <th>class id</th>
        <th>course_abbreviation</th>
        <th>course_name</th>
        <th>time</th>
        <th>mode</th>
        
    </tr>

<%

String db = "student_portal";
String user = "root"; // assumes database name is the same as username
/* String targetClass = request.getParameter("class_id"); */
String name = session.getAttribute("login").toString();
String id = session.getAttribute("id").toString();
String [] classList = request.getParameterValues("selectClass");
String operation = request.getParameter("operation");

try { 
java.sql.Connection con; 
Class.forName("com.mysql.cj.jdbc.Driver"); 
con = DriverManager.getConnection("jdbc:mysql://localhost:3306/"+db, "root", "970630"); 
Statement stmt=con.createStatement();


%>



<%


if(classList==null||operation==null)
{
	
	String sqlSave ="select class_id, course_abbreviation, course_name, classes.time, classes.mode_of_instruction from classes join student_portal.is using(class_id) join catalogue_courses using(course_abbreviation) join save using(class_id) where save.user_id = '"+id+"'; ";
	ResultSet rs = stmt.executeQuery(sqlSave);
	while(rs.next())
	{
		%>
		<tr>
		<th><%=rs.getString(1) %></th>
		<th><%=rs.getString(2) %></th>
		<th><%=rs.getString(3) %></th>
		<th><%=rs.getString(4) %></th>
		<th><%=rs.getString(5) %></th>
		<th><input type="checkbox" name ="selectClass" value = "<%=rs.getString(1) %>"/></th>
		
		</tr>
		
		<%
		
		
	}
	
	if(operation != null)
	{
		out.println("</br>"+ "you didn't select any classes");
	}
	
	
}
else
{
	if(operation.equals("checkOut"))
	{
		//register:
	for(int i = 0;i<classList.length;i++ ){
		String targetClass= classList[i];
		int regisCounter = 0;
	String searchSql= "SELECT classes.class_id, enrollment,capacity, course_abbreviation from student_portal.classes join student_portal.is using(class_id) where class_id = '"+targetClass+"';";
	ResultSet rs = stmt.executeQuery(searchSql);
		if(rs.next())
	{
		int enrollment = Integer.parseInt(rs.getString(2));
		int capacity =  Integer.parseInt(rs.getString(3));
		if(capacity > enrollment)
		{	//check if the student has registered that class before
			String checkDupl = "SELECT count(*) from student_portal.register join student_portal.is  using (class_id) where user_id='"+id+
			"' and course_abbreviation='"+rs.getString(4)+"';";
			
			stmt = con.createStatement();
			ResultSet rsCheck = stmt.executeQuery(checkDupl);
			if(rsCheck.next())
			{
				out.println("</br>"+"checking"+rs.getString(4));
				if(rsCheck.getString(1).equals("0"))
				{
				//update the register_id
				//get register_id:
				String count = "Select count(*) from student_portal.register;";
				stmt = con.createStatement();
				ResultSet rsCount = stmt.executeQuery(count);
				if(rsCount.next())
				{
					regisCounter = Integer.parseInt(rsCount.getString(1));
					regisCounter++;
				}
				
				// add a student to classes table
				String addSql = "INSERT INTO `student_portal`.`register` ( `user_id`, `class_id`) VALUES ( '"+id+"', '"+targetClass+"');";
				//modifiy the enrollment number after add;
				enrollment++;
				String enAdd="update student_portal.classes set enrollment = '"+Integer.toString(enrollment)+"' where class_id= '"+targetClass+"';";
				
				stmt = con.createStatement();
				stmt.executeUpdate(enAdd); 
				
				stmt = con.createStatement();
				stmt.executeUpdate(addSql); 
				out.println("</br></br>"+"success");
				//modify saving table
				stmt = con.createStatement();
				String sqlDrop = "DELETE FROM `student_portal`.`save` WHERE (`user_id` = '"+id+"') and (`class_id` = '"+targetClass+"');";
				stmt.executeUpdate(sqlDrop);
				//show new saving table
				String sqlSave ="select class_id, course_abbreviation, course_name, classes.time, classes.mode_of_instruction from classes join student_portal.is using(class_id) join catalogue_courses using(course_abbreviation) join save using(class_id) where save.user_id = '"+id+"'; ";
				ResultSet rsShow = stmt.executeQuery(sqlSave);
				while(rsShow.next())
				{
					%>
					<tr>
					<th><%=rsShow.getString(1) %></th>
					<th><%=rsShow.getString(2) %></th>
					<th><%=rsShow.getString(3) %></th>
					<th><%=rsShow.getString(4) %></th>
					<th><%=rsShow.getString(5) %></th>
					<th><input type="checkbox" name ="selectClass" value = "<%=rs.getString(1) %>"/></th>
					
					</tr>
					
					<%
					
					
				}
				
				
				}else
				{
					out.println("</br>"+rsCheck.getString(1));
					out.println("</br></br>"+"Sorry that class is not availd");
				}
				
			}else
			{
				out.println("</br></br>"+targetClass+"Sorry that class is not availd");
			}
		
		
		
		}
		else
		{
			out.println("</br></br>"+"class: "+targetClass+ "sorry class is full");
		}
	}//for end
	}
		
		
		
		
		
		
	}else if(operation.equals("drop"))
	{
		for(int i=0;i<classList.length;i++)
		{
			String targetClass = classList[i];
			stmt = con.createStatement();
			String sqlDrop = "DELETE FROM `student_portal`.`save` WHERE (`user_id` = '"+id+"') and (`class_id` = '"+targetClass+"');";
			stmt.executeUpdate(sqlDrop);
		}
		out.println("</br>"+"success");
		//show:
			stmt = con.createStatement();
			String sqlSave ="select class_id, course_abbreviation, course_name, classes.time, classes.mode_of_instruction from classes join student_portal.is using(class_id) join catalogue_courses using(course_abbreviation) join save using(class_id) where save.user_id = '"+id+"'; ";
			ResultSet rs = stmt.executeQuery(sqlSave);
			while(rs.next())
			{
				%>
				<tr>
				<th><%=rs.getString(1) %></th>
				<th><%=rs.getString(2) %></th>
				<th><%=rs.getString(3) %></th>
				<th><%=rs.getString(4) %></th>
				<th><%=rs.getString(5) %></th>
				<th><input type="checkbox" name ="selectClass" value = "<%=rs.getString(1) %>"/></th>
				
				</tr>
				
				<%
		
		
			}
		
		
		
		
	}else
	{
		out.println("error, no operation");
	}
	
	
	
	
}

%>
</table>

<input type='submit' value='checkOut' name='operation'/>
&nbsp&nbsp
&nbsp&nbsp
<input style="color:#FF0000" type = 'submit' value='drop' name='operation'/>

</form>


<%





con.close(); 
} catch(SQLException e) { 
out.println("SQLException caught: " +e.getMessage()); } 

%>




<form action='studentHome.jsp' style='margin-top: 100px'>

<input style = 'color:blue;width:100px' value=' back ' type='submit' onclick = "window.location.href='studentHome.jsp"/> 
</form>








</body>
</html>