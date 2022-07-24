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


<form method='post' action = "registerClass.jsp">
<h2>Please enter class id</h2>
</br>

<input type = 'search' name= 'class_id' />
<input type = 'submit'/>
</form>





<%

String db = "student_portal";
String user = "root"; // assumes database name is the same as username
String targetClass = request.getParameter("class_id");
String name = session.getAttribute("login").toString();
String id = session.getAttribute("id").toString();
try { 
java.sql.Connection con; 
Class.forName("com.mysql.cj.jdbc.Driver"); 
con = DriverManager.getConnection("jdbc:mysql://localhost:3306/"+db, "root", "970630"); 
Statement stmt=con.createStatement();
//count the register table
int regisCounter=0;

//search
if(targetClass!= null && !targetClass.isBlank())
{
	String searchSql= "SELECT classes.class_id, enrollment,capacity, course_abbreviation from student_portal.classes join student_portal.is using(class_id) where class_id = '"+targetClass+"';";
	
	ResultSet rs = stmt.executeQuery(searchSql);
	
	out.println("searching"+ targetClass);
	//ResultSet rs = stmt.executeQuery(searchSql);
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
				/* enrollment++;
				String enAdd="update student_portal.classes set enrollment = '"+Integer.toString(enrollment)+"' where class_id= '"+targetClass+"';";
				
				stmt = con.createStatement();
				stmt.executeUpdate(enAdd); 
				*/
				stmt = con.createStatement();
				stmt.executeUpdate(addSql); 
				out.println("</br></br>"+"you added a class please check it");
				}else
				{
					out.println("</br>"+rsCheck.getString(1));
					out.println("</br></br>"+"Sorry that class is not availd");
				}
				
			}else
			{
				out.println("</br></br>"+"Sorry that class is not availd");
			}
		
		
		
		}
		else
		{
			out.println("</br></br>"+ "sorry class is full");
		}
	}
			
			
			
			
			
			
			
			
			
}
else
{
out.println("</br></br>"+"No such classes");	

}






con.close(); 
} catch(SQLException e) { 
out.println("SQLException caught: " +e.getMessage()); } 














%>











</body>
</html>