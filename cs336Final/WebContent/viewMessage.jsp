<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>View Message</title>
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
int eid = Integer.parseInt(request.getParameter("messageNumber"));

try {
		
	//Get the database connection
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	Statement stat = con.createStatement();
	ResultSet result = stat.executeQuery("SELECT * from EMAIL where eid=\'"+ eid + "\'");
	if(result.next()){
		
		out.println("<h4>Sender: " + result.getString("sender") +"</h4>");
		out.println("<h4>Recipient: " + result.getString("recipient") +"</h4>");
		out.println("<h4>Contents:</h4>");
		out.println(result.getString("contents"));
		
		out.println("<h4>Reply");
		//out.println("Params are: " + request.getParameter("targetEaddr") + ", " + request.getParameter("senderEaddr"));
		out.println("<form method=post action=newMessageAttempt.jsp>");
		out.println("<table>");
		out.println("<tr>");
		out.println("<td>");
		out.println("<input type=\"hidden\" name=\"targetEaddr\" value=\""+ result.getString("sender") +"\">");
		out.println("<input type=\"hidden\" name=\"senderEaddr\" value=\""+ result.getString("recipient") +"\">");
		out.println("<textarea name=\"content\" rows=\"10\" cols=\"40\"></textarea>");
		out.println("</td>");
		out.println("</tr>");
		out.println("<tr>");
		out.println("<td>");
		out.println("<input type=\"submit\" value=\"Send Reply\">");
		out.println("</td>");
		out.println("</tr>");
		out.println("</table>");
		out.println("</form>");
	}
	else{
		//Unable to find item
		System.out.println("Unable to find item");
		//response.sendRedirect("login.jsp");
	}
	con.close();
	} catch (Exception e) {
		e.printStackTrace();
	}
%>
	
</body>
</html>