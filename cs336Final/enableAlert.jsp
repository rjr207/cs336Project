<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.time.format.*,java.time.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Enable Alert</title>
</head>
<body>
<%
try {
	String username = (String)session.getAttribute("username");
	String auctionNum = (String)session.getAttribute("currentAuction");
	String itemName = request.getParameter("itemName");
	int time  = Integer.parseInt(request.getParameter("duration"));
	//Get the database connection
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	
	DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");  
	LocalDateTime dateEntry = LocalDateTime.now();
	//out.println("Old date: "+ dtf.format(dateEntry));
	dateEntry = dateEntry.plusDays(time);
	//out.println("New date: "+ dtf.format(dateEntry));
	String dateTime = dtf.format(dateEntry);
	 
	String i1 = "INSERT INTO ALERTS VALUES(\'"+ username +"\',\'"+ itemName +"\',\'"+ dateEntry +"\',\'"+ auctionNum +"\')";
	out.println("Attempting auction: " + i1);
	//Execute insert
	Statement s1 = con.createStatement();
	s1.executeUpdate(i1);
	
	con.close();
	response.sendRedirect("userHome.jsp");

%>
</body>
</html>

<%
con.close();
} catch (Exception e) {
	e.printStackTrace();
}
%>