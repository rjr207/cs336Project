<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Welcome!</title>
</head>
<body>
	<h1>Sell an Item</h1>
	<input type="button" value="Enter an Item" onClick="window.location='newItem.jsp';">
	<br><br>

	<%
		try {
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			
			String username = (String)session.getAttribute("username");
			String password = (String)session.getAttribute("password");
			out.println("Username is: " + username);
			out.println("Password is: " + password);
			//close the connection.
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	%>
	<br><br>
	<input type="button" value="Signout" onClick="window.location='login.jsp';">
</body>
</html>