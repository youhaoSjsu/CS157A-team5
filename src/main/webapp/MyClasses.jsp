<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" href="myClasses.css" type="text/css">

</head>
<body>
	<button class ="backButton" onclick="window.location.href='studentHome.jsp'">&#8249;</button>
	<h1>
		<%=session.getAttribute("login")%>'s Class Schedule
	</h1>
	<h2>
		<br>
		

		<table border='1'>
			<tr>
				<th>Abbreviation</th>
				<th>Mode</th>
				<th>Location</th>
				<th>Time</th>
				<th>Name</th>
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
				/* 	ResultSet rs=stmt.executeQuery("SELECT user_id FROM student_portal.users where username = '"+name+"';");
				*/
				String sqlSt = "SELECT class_id FROM student_portal.register where user_id = '" + id + "';";
				ResultSet rs = stmt.executeQuery(sqlSt);

				Vector vCrn = new Vector();
				while (rs.next()) {
					String class_id = rs.getString(1);
					vCrn.add(class_id);

				}
				//this statment take class info

				Statement stContent = con.createStatement();
				String sInfo = "SELECT course_abbreviation,mode_of_instruction,location, time, course_name From student_portal.classes join student_portal.is using(class_id) join student_portal.catalogue_courses using(course_abbreviation)where class_id in (select class_id from student_portal.register where user_id = '"
				+ id + "'); ";
				ResultSet rsInfo = stContent.executeQuery(sInfo);
				while (rsInfo.next()) {
					%>
					<tr>
						<td><%=rsInfo.getString(1)%></td>
						<td><%=rsInfo.getString(2)%></td>
						<td><%=rsInfo.getString(3)%></td>
						<td><%=rsInfo.getString(4)%></td>
						<td><%=rsInfo.getString(5)%></td>
					</tr>
					<%
				}
			//test id obtain method
			/* for(int i = 0;i<vCrn.size();i++)
			{
			out.println("</br>"+vCrn.get(i)+"\n");

			}
			 */

			con.close();
			} catch (SQLException e) {
			out.println("SQLException caught: " + e.getMessage());
			}
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
			
<!-- 		<form action='studentHome.jsp' style='margin-top: 100px'>
			<input style='color: blue; width: 100px' value=' back ' type='submit' onclick="window.location.href='studentHome.jsp" />
		</form>
 -->
</body>
</html>