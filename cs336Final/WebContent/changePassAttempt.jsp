<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Password Change</title>
</head>
<body>
<%
try {
	String newPass = request.getParameter("newPass");
	String username = session.getAttribute("username").toString();
	//Get the database connection
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	int result = 0;
	if(newPass != null)
		result = con.createStatement().executeUpdate("UPDATE ENDUSER SET password=\'"+newPass+"\' WHERE username=\'"+username+"\'");
	if(result == 1)
		out.println("<p>Password Updated Succesfully</p>");
	else
		out.println("<p>Failed ot Update Password</p>");
	
%>
</body>
</html>

<%
con.close();
} catch (Exception e) {
	e.printStackTrace();
}
%>