a <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
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
String addr = request.getParameter("address");
String eaddr = request.getParameter("eaddress");
String access  = request.getParameter("userlvl");

try{
	//Get the database connection
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	
	Statement q1 = con.createStatement();
	//System.out.println("Attempting query:SELECT * from EMAILACCOUNT where eaddress=\'"+ eaddr +"\'");
	ResultSet result = q1.executeQuery("SELECT * from EMAILACCOUNT where eaddress=\'"+ eaddr +"\'");

	if(result.next()){
		con.close();
		//System.out.println("Used email");
		response.sendRedirect("register.jsp");
	}
	
	//Make an insert statement for the emailaccount table:
	String insert1 = "INSERT INTO EMAILACCOUNT(eaddress)" + " VALUES (\'" + eaddr + "\')";
	
	Statement s1 =con.createStatement();
	
	//System.out.println("Attempting query:"+insert1);
	s1.executeUpdate(insert1);
	
	Statement q2 = con.createStatement();
	//System.out.println("Attempting query:SELECT * from ENDUSER where username=\'"+ usr +"\'");
	result = q2.executeQuery("SELECT * from ENDUSER where username=\'"+ usr +"\'");

	if(result.next()){
		con.close();
		System.out.println("Used details");
		response.sendRedirect("register.jsp");
	}

	String insert2 = "INSERT INTO ENDUSER(username, password, address, eaddress, userlvl)" + " VALUES (\'"+usr+"\',\'"+pword+"\',\'"+addr+"\',\'"+eaddr+"\',\'"+access+"\')";
	
	Statement s2 =con.createStatement();

	System.out.println("Attempting query:"+insert2);
	s2.executeUpdate(insert2);

	//close the connection.
	con.close();
	response.sendRedirect("login.jsp");
	
}catch(Exception e){
e.printStackTrace();
}

%>
</body>
</html>