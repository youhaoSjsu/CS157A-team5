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
<link rel="stylesheet" href="dropClass.css" type="text/css">

 	
</head>
<body>

<button class ="backButton" onclick="window.location.href='studentHome.jsp'">&#8249;</button>

<h2>Drop Class</h2> 

<form name ="form3" class="form3" method = "post" action = "dropClass.jsp">
	<br>
	<h3>Enter Class id:</h3> <br>
	<input type = "search" name = "class_id" />
	<input type = "submit" value ="Drop"/>
</form>



<form action = "dropClass.jsp">
<h2>
<table border="1">
<tr>
<th>CRN</th>
<th>Abbreviation</th>
<th>Name</th>
<th>Time</th>
<th>Mode</th>
<th>Select</th>
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

if(targetClass!=null)
{
	if(targetClass!= null && !targetClass.isBlank())
	{
		out.println("searching"+ targetClass);
		String sqlSearch = "Select count(*) from student_portal.register where register.class_id = '"+targetClass+"' and  user_id = '"+id+"';";
		stmt = con.createStatement();
		ResultSet rsSearch =stmt.executeQuery(sqlSearch);
		if(rsSearch.next())
		{
			if(rsSearch.getInt(1)!=0)
			{//delete;
				out.println("</br>"+ "dropping that class");
				String deSql = "DELETE FROM `student_portal`.`register` WHERE (`user_id` = '"+id+"') and (`class_id` = '"+targetClass+"');";
				stmt = con.createStatement();
				stmt.executeUpdate(deSql);
				//enrollment--
				stmt = con.createStatement();
				String sqlEn="select enrollment from student_portal.classes where class_id='"+targetClass+"';";
				ResultSet rsEn = stmt.executeQuery(sqlEn);
				if(rsEn.next())
				{
				int em = rsEn.getInt(1);
				em--;
				//set back
				stmt = con.createStatement();
				String sqlSet="UPDATE `student_portal`.`classes` SET `enrollment` = '"+Integer.toString(em)+"' WHERE (`class_id` = '"+targetClass+"');";
				stmt.executeUpdate(sqlSet);
					
				}
						
			}
			else{
				out.println("please double check, you are not in that class");
			}
			
		}
}
}

if(classList==null)
{
String info = "SELECT class_id, course_abbreviation, course_name, time, mode_of_instruction, location From student_portal.classes join student_portal.is using(class_id) join student_portal.catalogue_courses using(course_abbreviation)where class_id in (select class_id from student_portal.register where user_id = '"+id+"'); ";



//"SELECT mode_of_instruction,location, time, course_name From student_portal.classes join student_portal.is using(class_id) join student_portal.catalogue_courses using(course_abbreviation)where class_id in (select class_id from student_portal.register where user_id = '"+id+"'); ";
ResultSet rsInfo = stmt.executeQuery(info);
out.println("<br><br>Select Classes<br><br>");
while(rsInfo.next())
{
/* 	out.println("</br></br>"+"&nbsp"+rsInfo.getString(1) +"&nbsp"+"&nbsp"+ rsInfo.getString(2)+"&nbsp"+"&nbsp"+"&nbsp"+"&nbsp"+"&nbsp"+"&nbsp"+ rsInfo.getString(3)+"&nbsp"+"&nbsp"+"&nbsp"+"&nbsp"+"&nbsp"+"&nbsp"+rsInfo.getString(4) );
 */
 %>
 <tr>
	<td><%=rsInfo.getString(1) %></td>
	<td><%=rsInfo.getString(2) %></td>
	<td><%=rsInfo.getString(3) %></td>
	<td><%=rsInfo.getString(4) %></td>
	<td><%=rsInfo.getString(5) %></td>
	<td><input type='checkBox' name ="selected" value = "<%=rsInfo.getString(1) %>"/></td>

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
		<td><%=rsInfo.getString(1) %></td>
		<td><%=rsInfo.getString(2) %></td>
		<td><%=rsInfo.getString(3) %></td>
		<td><%=rsInfo.getString(4) %></td>
		<td><%=rsInfo.getString(5) %></td>
		<td><input type='checkBox' name ="selected" value = "<%=rsInfo.getString(1) %>"/></td>

		</tr>
	 
	 
	 
	 <%
	 
	}
	
	
}


con.close(); 
} catch(SQLException e) { 
out.println("SQLException caught: " +e.getMessage()); } 


%>
<%!
static boolean checkConflict(String time, String []classesTime)
{
	boolean ok = true;
	
	for(int i = 0;i<classesTime.length;i++)
	{
		String []dayAry = new String []{"M","W","Th","Tu","Fr"};
		for(int j=0;j<dayAry.length;j++)
		{
			if(classesTime[i].contains(dayAry[j])&&time.contains(dayAry[j]))
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



</table>
</h2>

<input style = 'color:#FF0000 background-image:0;'type='submit' value = "Drop" />

</form>




</body>
</html>