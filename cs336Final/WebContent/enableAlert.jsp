<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Enable Alert</title>
</head>
<body>
<%
try {
	String auctionNum = request.getParameter("auctionNum");
	String username = (String)session.getAttribute("username");
	String itemName = request.getParameter("itemName");
	//Get the database connection
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	int result = 0;
	//if(auctionNum != null)
		result = con.createStatement().executeUpdate("INSERT INTO ALERTS VALUES (\'" + username + "\'), (\'" + itemName + "\'), (\'" + request.getParameter("datetime") + "\'), (" + auctionNum + ")" );
	if(result == 1)
		out.println("<p>Alert Created Succesfully</p>");
	else
		out.println("<p>Failed to Create Alert</p>");
	
%>
</body>
</html>

<%
con.close();
} catch (Exception e) {
	e.printStackTrace();
}
%>