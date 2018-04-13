<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Deleting Auction...</title>
</head>
<body>
<%
String auction = request.getParameter("auctionNumber");
try{
	//Get the database connection
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	
	Statement q1 = con.createStatement();
	ResultSet result = q1.executeQuery("SELECT * from AUCTION where auctionNum=\'"+auction+"\'");
	if(!result.next()){
		con.close();
		System.out.println("Auction not found");
		response.sendRedirect("adminHome.jsp");
	}

	String deleteAuc = "DELETE FROM AUCTION where auctionNum=\'"+auction+"\'";
	
	Statement s1 =con.createStatement();
	System.out.println("Attempting deletion:"+deleteAuc);
	s1.executeUpdate(deleteAuc);
	//close the connection.
	con.close();
	response.sendRedirect("adminHome.jsp");
	
}catch(Exception e){
e.printStackTrace();
}
%>
</body>
</html>