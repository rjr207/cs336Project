<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Bid Deletion</title>
</head>
<body>
<%
String num = request.getParameter("bidNum");
out.println("Passed in: " + request.getParameter("bidNum"));
try{
	//Get the database connection
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	
	Statement q1 = con.createStatement();
	System.out.println("Attempting query:SELECT * from BID where bidNumber="+num);
	ResultSet result = q1.executeQuery("SELECT * from BID where bidNumber="+num);
	if(!result.next()){
		con.close();
		System.out.println("Bid not found");
		response.sendRedirect("repHome.jsp");
	}

	String deleteBid = "DELETE FROM BID where bidNumber="+num;
	
	Statement s1 =con.createStatement();
	System.out.println("Attempting deletion:"+deleteBid);
	s1.executeUpdate(deleteBid);
	//close the connection.
	con.close();
	response.sendRedirect("repHome.jsp");
	
}catch(Exception e){
e.printStackTrace();
}
%>
</body>
</html>