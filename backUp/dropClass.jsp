
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


<form method='post' action = "dropClass.jsp">
<h2>Please enter class id</h2>
</br>

<input type = 'search' name= 'class_id' />
<input type = 'submit' value='drop'/>
</form>



<form action = "dropClass.jsp"><table border="1">
<tr>
<th>CRN</th>
<th>mode</th>
<th>location</th>
<th>time</th>
<th>course_name</th>
<th>abbreviation</th>


</tr>







<%

String db = "student_portal";
String user = "root"; // assumes database name is the same as username
String targetClass = request.getParameter("class_id");
String name = session.getAttribute("login").toString();
String id = session.getAttribute("id").toString();
String targetId;
String [] classList = request.getParameterValues("selected");

try { 
java.sql.Connection con; 
Class.forName("com.mysql.cj.jdbc.Driver"); 
con = DriverManager.getConnection("jdbc:mysql://localhost:3306/"+db, "root", "970630"); 
Statement stmt=con.createStatement();
//count the register table
int regisCounter=0;

if(classList==null)
{
String info= "SELECT class_id,mode_of_instruction,location, time, course_name,course_abbreviation From student_portal.classes join student_portal.is using(class_id) join student_portal.catalogue_courses using(course_abbreviation)where class_id in (select class_id from student_portal.register where user_id = '"+id+"'); ";
//"SELECT mode_of_instruction,location, time, course_name From student_portal.classes join student_portal.is using(class_id) join student_portal.catalogue_courses using(course_abbreviation)where class_id in (select class_id from student_portal.register where user_id = '"+id+"'); ";
ResultSet rsInfo = stmt.executeQuery(info);
out.println("select classes");
while(rsInfo.next())
{
/* 	out.println("</br></br>"+"&nbsp"+rsInfo.getString(1) +"&nbsp"+"&nbsp"+ rsInfo.getString(2)+"&nbsp"+"&nbsp"+"&nbsp"+"&nbsp"+"&nbsp"+"&nbsp"+ rsInfo.getString(3)+"&nbsp"+"&nbsp"+"&nbsp"+"&nbsp"+"&nbsp"+"&nbsp"+rsInfo.getString(4) );
 */
 %>
 <tr>
	<th><%=rsInfo.getString(1) %></th>
	<th><%=rsInfo.getString(2) %></th>
	<th><%=rsInfo.getString(3) %></th>
	<th><%=rsInfo.getString(4) %></th>
	<th><%=rsInfo.getString(5) %></th>
	<th><input type='checkBox'name ="selected" value = "<%=rsInfo.getString(1) %>"/></th>

	</tr>
 
 
 
 <%
 
}
}
//search
if(classList!=null)
{
	for(int i = 0;i<classList.length;i++)
	{
		targetClass = classList[i];
		targetId = classList[i];
		if(targetClass!= null && !targetClass.isBlank())
		{
			out.println("searching"+ targetClass);
			String sqlSearch = "Select count(*) from student_portal.register where register.class_id = '"+targetId+"' and  user_id = '"+id+"';";
			stmt = con.createStatement();
			ResultSet rsSearch =stmt.executeQuery(sqlSearch);
			if(rsSearch.next())
			{
				if(rsSearch.getInt(1)!=0)
				{//delete;
					out.println("</br>"+ "dropping that class");
					String deSql = "DELETE FROM `student_portal`.`register` WHERE (`user_id` = '"+id+"') and (`class_id` = '"+targetId+"');";
					stmt = con.createStatement();
					stmt.executeUpdate(deSql);
					//enrollment--
					stmt = con.createStatement();
					String sqlEn="select enrollment from student_portal.classes where class_id='"+targetId+"';";
					ResultSet rsEn = stmt.executeQuery(sqlEn);
					if(rsEn.next())
					{
					int em = rsEn.getInt(1);
					em--;
					//set back
					stmt = con.createStatement();
					String sqlSet="UPDATE `student_portal`.`classes` SET `enrollment` = '"+Integer.toString(em)+"' WHERE (`class_id` = '"+targetId+"');";
					stmt.executeUpdate(sqlSet);
						
					}
					
					
					
					
					
				}
				else{
					out.println("please double check, you are not in that class");
				}
				
			}
	}
	
}
	stmt= con.createStatement();
	String info= "SELECT class_id,mode_of_instruction,location, time, course_name,course_abbreviation From student_portal.classes join student_portal.is using(class_id) join student_portal.catalogue_courses using(course_abbreviation)where class_id in (select class_id from student_portal.register where user_id = '"+id+"'); ";
	//"SELECT mode_of_instruction,location, time, course_name From student_portal.classes join student_portal.is using(class_id) join student_portal.catalogue_courses using(course_abbreviation)where class_id in (select class_id from student_portal.register where user_id = '"+id+"'); ";
	ResultSet rsInfo = stmt.executeQuery(info);
	out.println("select classes");
	while(rsInfo.next())
	{
	/* 	out.println("</br></br>"+"&nbsp"+rsInfo.getString(1) +"&nbsp"+"&nbsp"+ rsInfo.getString(2)+"&nbsp"+"&nbsp"+"&nbsp"+"&nbsp"+"&nbsp"+"&nbsp"+ rsInfo.getString(3)+"&nbsp"+"&nbsp"+"&nbsp"+"&nbsp"+"&nbsp"+"&nbsp"+rsInfo.getString(4) );
	 */
	 %>
	 <tr>
		<th><%=rsInfo.getString(1) %></th>
		<th><%=rsInfo.getString(2) %></th>
		<th><%=rsInfo.getString(3) %></th>
		<th><%=rsInfo.getString(4) %></th>
		<th><%=rsInfo.getString(5) %></th>
		<th><input type='checkBox'name ="selected" value = "<%=rsInfo.getString(1) %>"/></th>

		</tr>
	 
	 
	 
	 <%
	 
	}
	
	
}


con.close(); 
} catch(SQLException e) { 
out.println("SQLException caught: " +e.getMessage()); } 


%>



</table>

<input style = 'color:#FF0000'type='submit' value = "drop selected classes" />

</from>

<form action='studentHome.jsp' style='margin-top: 100px'>

<input style = 'color:blue;width:100px' value=' back ' type='submit' onclick = "window.location.href='studentHome.jsp"/> 
</form>





</body>
