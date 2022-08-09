<%@ page import="java.sql.*" %>
<%@ page import="java.util.LinkedList" %>
<%-- <%@ include file="index.jsp"%>
 --%>


<!DOCTYPE html>
<html>

<head>

	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">

	<title>Welcome : <%=session.getAttribute("login")%></title>

 	<link rel="stylesheet" href="shopCart.css" type="text/css">
 	
</head>
<body>
	<button class ="backButton" onclick="window.location.href='studentHome.jsp'">&#8249;</button>
	<h1>
		<%=session.getAttribute("login")%>'s Saved Classes
	</h1>
	
	
	
	</br></br></br></br>
	<form>
	
	
	
	</form>
	

<h2>
<form action="shopCart.jsp">
<table border="1">
    <tr>
        <th>Class id</th>
        <th>Abbreviation</th>
        <th>Name</th>
        <th>Time</th>
        <th>Mode</th>
        <th>Location</th>
        <th>Select</th>
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
	
	
	if (classList == null || operation == null) {
		String sqlSave ="select class_id, course_abbreviation, course_name, classes.time, classes.mode_of_instruction, classes.location from classes join student_portal.is using(class_id) join catalogue_courses using(course_abbreviation) join save using(class_id) where save.user_id = '"+id+"'; ";
		ResultSet rs = stmt.executeQuery(sqlSave);
		while(rs.next()) {
			%>
			<tr>
			<td><%=rs.getString(1) %></td>
			<td><%=rs.getString(2) %></td>
			<td><%=rs.getString(3) %></td>
			<td><%=rs.getString(4) %></td>
			<td><%=rs.getString(5) %></td>
			<td><%=rs.getString(6) %></td>
			<td><input type="checkbox" name ="selectClass" value = "<%=rs.getString(1) %>"/></td>
			
			</tr>
			
			<%				
		}
		
		if(operation != null) {
			out.println("</br>"+ "you didn't select any classes");
		}	
	} else {
		if(operation.equals("Enroll")) {
			//register:
			for (int i = 0; i < classList.length; i++){
				String targetClass= classList[i];
				int regisCounter = 0;
				String searchSql= "SELECT classes.class_id, enrollment,capacity, course_abbreviation,time from student_portal.classes join student_portal.is using(class_id) where class_id = '"+targetClass+"';";
				ResultSet rs = stmt.executeQuery(searchSql);
				if (rs.next()) {
					int enrollment = Integer.parseInt(rs.getString(2));
					int capacity =  Integer.parseInt(rs.getString(3));
					String time = rs.getString(5);
					if (capacity > enrollment) {	//check if the student has registered that class before
						String checkDupl = "SELECT count(*) from student_portal.register join student_portal.is  using (class_id) where user_id='"+id+
						"' and course_abbreviation='"+rs.getString(4)+"';";
						
						stmt = con.createStatement();
						ResultSet rsCheck = stmt.executeQuery(checkDupl);
						if (rsCheck.next()) {
							out.println("</br>"+"checking"+rs.getString(4));
							//check time
							stmt = con.createStatement();
							String sInfo = "SELECT time From student_portal.classes join student_portal.is using(class_id) join student_portal.catalogue_courses using(course_abbreviation)where class_id in (select class_id from student_portal.register where user_id = '"
							+ id + "'); ";
							ResultSet rsInfo = stmt.executeQuery(sInfo);
							LinkedList<String> timeList = new LinkedList<String>();
							String []timeAry;
							while (rsInfo.next()) {
							/* out.println("</br>"+"check time"+time+" with "+rsInfo.getString(1)); */
								timeList.add(rsInfo.getString(1));
					
					
							}
							timeAry = new String[timeList.size()];
							for(int k = 0;k<timeList.size();k++)
							{
							timeAry[k] = timeList.get(k);
							}
							
							
							if(checkConflict(time, timeAry))
							{	
							
							if (rsCheck.getString(1).equals("0")) {
								//update the register_id
								//get register_id:
								String count = "Select count(*) from student_portal.register;";
								stmt = con.createStatement();
								ResultSet rsCount = stmt.executeQuery(count);
								if (rsCount.next()) {
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
								String sqlSave ="select class_id, course_abbreviation, course_name, classes.time, classes.mode_of_instruction, classes.location from classes join student_portal.is using(class_id) join catalogue_courses using(course_abbreviation) join save using(class_id) where save.user_id = '"+id+"'; ";
								ResultSet rsShow = stmt.executeQuery(sqlSave);
								
								while (rsShow.next()) {
									%>
									<tr>
									<td><%=rsShow.getString(1) %></td>
									<td><%=rsShow.getString(2) %></td>
									<td><%=rsShow.getString(3) %></td>
									<td><%=rsShow.getString(4) %></td>
									<td><%=rsShow.getString(5) %></td>
									<td><%=rsShow.getString(6) %></td>							
									<td><input type="checkbox" name ="selectClass" value = "<%=rs.getString(1) %>"/></td>
									
									</tr>							
									<%														
								}
							}
							else {
								out.println("</br>"+rsCheck.getString(1));
								out.println("</br></br>"+"Sorry that class is not availd");
							}
						}
							else
							{
								out.println("time confilct");
							}
					}else {
						out.println("</br></br>"+targetClass+"Sorry that class is not availd");
					}
				}
				else {
					out.println("</br></br>"+"class: "+targetClass+ "sorry class is full");
				}
			}//for end
		}	
		}else if(operation.equals("Remove")) {
			for (int i = 0; i < classList.length; i++) {
				String targetClass = classList[i];
				stmt = con.createStatement();
				String sqlDrop = "DELETE FROM `student_portal`.`save` WHERE (`user_id` = '"+id+"') and (`class_id` = '"+targetClass+"');";
				stmt.executeUpdate(sqlDrop);
			}
			out.println("</br>"+"success");
			//show:
				stmt = con.createStatement();
				String sqlSave ="select class_id, course_abbreviation, course_name, classes.time, classes.mode_of_instruction, classes.location from classes join student_portal.is using(class_id) join catalogue_courses using(course_abbreviation) join save using(class_id) where save.user_id = '"+id+"'; ";
				ResultSet rs = stmt.executeQuery(sqlSave);
				while(rs.next()) {
					%>
					<tr>
					<td><%=rs.getString(1) %></td>
					<td><%=rs.getString(2) %></td>
					<td><%=rs.getString(3) %></td>
					<td><%=rs.getString(4) %></td>
					<td><%=rs.getString(5) %></td>
					<td><%=rs.getString(6) %></td>			
					<td><input type="checkbox" name ="selectClass" value = "<%=rs.getString(1)%>"/></td>
					
					</tr>
					
					<%
				}
		}else {
			out.println("error, no operation");
		}
	}
	
	%>
	</table>
	
	<br>
	
	<input type='submit' value='Enroll' name='operation'/>
	&nbsp&nbsp
	&nbsp&nbsp
	&nbsp&nbsp
	<input style="color:#FF0000" type = 'submit' value='Remove' name='operation'/>
	
	</form>
	
	<% 
	
	con.close(); 
} catch(SQLException e) { 
	out.println("SQLException caught: " +e.getMessage());
} 

%>

<%!
static boolean checkConflict(String time, String []classesTime)
{
	boolean ok = true;
	
	for(int i = 0;i<classesTime.length;i++)
	{
		String []dayAry = new String []{"W","Th","Tu","Fr"};
		for(int j=0;j<dayAry.length;j++)
		{
			//"m" is special alpha
			if(classesTime[i].contains(dayAry[j])&&time.contains(dayAry[j]) || classesTime[i].charAt(0)=='M'&&time.charAt(0)=='M' )
			{
				//convert time
				//old classes
				Time []cAry = time24h(classesTime[i]);
				Time []tAry = time24h(time);
				if(tAry[0].compareTo(cAry[0])<0 &&tAry[1].compareTo(cAry[0])>0)	// before ctime
				{
				
						ok=false;
					
				}
				if(tAry[0].compareTo(cAry[0])>0 &&tAry[0].compareTo(cAry[1])<0)
				{
					ok = false;
				}
				if(tAry[0].compareTo(cAry[0])==0||tAry[1].compareTo(cAry[1])==0)
				{
					ok =false;
				}
			}
				
		}
		
		
		
		
	}
		
	return ok;
	
	
}
//convert string to the sql.time
//convert am&pm String time into time format of sql.time
//import java.sql.time 
//core algorithm designed by Youhao Chen at SJSU
static Time []time24h(String aStr)//parameter like；MW 1:00pm-2；00pm
{
	aStr = aStr.replace(" ", "");
	String [] arry = new String[2];
	String []result;
	String[]timeArray = new String[2];
	Time []resultTime = new Time[2];
	for(int i =0;i<aStr.length();i++)
	{
		//getthe first number position;
		if(Character.isDigit(aStr.charAt(i)))
		{
			String time=aStr.substring(i);
			arry = time.split("-",2);
			
			//out
			i+=100;
		}
	}
	//change it to the 24 mode
	// the format here is like 1:00pm
	
	String s1 ="";
	for (int i=0;i<arry.length;i++)
	{
		/* arry[i].trim(); */
		if(arry[i].contains("P"))
		{
			timeArray = arry[i].split(":",2);
			//1
			int h = Integer.parseInt(timeArray[0]);
			if(h!=12)
			{
			h +=12;
			}
			 s1 = Integer.toString(h)+":"+timeArray[1].substring(0,timeArray[1].length()-3);//cut last two char
			 
			
			
		}
		if(arry[i].contains("A"))
		{
			//01:00am
			 s1 = "0"+arry[i].substring(0,arry[i].length()-2); //cut last two char
			
			
		}
		//seconds
		s1=s1+":00";
		
		resultTime[i] = Time.valueOf(s1); 
	}
	
	
	
	return resultTime;
}



%>




</h2>
</body>
</html>