<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>New Message</title>
</head>
<body>
<table>
		<tr>
			<%
			if(session.getAttribute("usrlvl").equals("user")){
				out.println("<td><input type=\"button\" value=\"Home\" onClick=\"window.location=\'userHome.jsp\';\"></td>");
			}else{
				out.println("<td><input type=\"button\" value=\"Home\" onClick=\"window.location=\'repHome.jsp\';\"></td>");
			}
			%>
			<td><input type="button" value="Messages" onClick="window.location='messages.jsp';"></td>
			<td><input type="button" value="Account" onClick="window.location='accountInfo.jsp';"></td>
			<td><input type="button" value="Log Out" onClick="window.location='login.jsp';"></td>
		
		</tr>
	</table>
	
	<%
		
	out.println("<h2>Message a Representative</h2>");
	//out.println("Params are: " + request.getParameter("targetEaddr") + ", " + request.getParameter("senderEaddr"));
	out.println("<form method=post action=newMessageAttempt.jsp>");
	out.println("<table>");
	out.println("<tr>");
	out.println("<td>");
	out.println("<input type=\"hidden\" name=\"targetEaddr\" value=\""+ request.getParameter("targetEaddr") +"\">");
	out.println("<input type=\"hidden\" name=\"senderEaddr\" value=\""+ request.getParameter("senderEaddr") +"\">");
	out.println("<textarea name=\"content\" rows=\"10\" cols=\"40\"></textarea>");
	out.println("</td>");
	out.println("</tr>");
	out.println("<tr>");
	out.println("<td>");
	out.println("<input type=\"submit\" value=\"Send\">");
	out.println("</td>");
	out.println("</tr>");
	out.println("</table>");
	out.println("</form>");
		
%>
	
</body>
</html>