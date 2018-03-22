<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Attempting Login</title>
</head>
<body>
<%
String usr = request.getParameter("username");
String pword = request.getParameter("password");
try {

	//Get the database connection
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	Statement stat = con.createStatement();
	//System.out.println("Attempting query:"+"SELECT * from ENDUSER where username=\'"+ usr +"\' AND password=\'"+pword+"\'");
	ResultSet result = stat.executeQuery("SELECT * from ENDUSER where username=\'"+ usr +"\' AND password=\'"+pword+"\'");

	if(result.next()){
		//close the connection.
		con.close();
		//System.out.println("Successful login");
		session.setAttribute("username", usr);
		session.setAttribute("password", pword);
		//response.sendRedirect("loggingIn.jsp");
	}else{
		//close the connection.
		con.close();
		//System.out.println("Failed login");
		response.sendRedirect("login.jsp");
	}
} catch (Exception e) {
	e.printStackTrace();
}

%>

<meta http-equiv="refresh" content="0; URL=loggingIn.jsp">
</body>
</html>