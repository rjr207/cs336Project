<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>User Profile</title>
</head>
<body>
<%
try {
	
	//Not yet sure how to get username so using static variable
	String username = "dave";
	
	//Get the database connection
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	ResultSet userResult = con.createStatement().executeQuery("SELECT * from ENDUSER where username=\'"+ username + "\'");
	ResultSet previousBids = con.createStatement().executeQuery("SELECT * from BID, AUCTION WHERE BID.auctionNum = AUCTION.auctionNum AND BID.placedByUsername=\'"+ username + "\'");
	//NOT SURE HOW TO DO THIS ONE ResultSet soldItems = stat.executeQuery("SELECT * from ")
	ResultSet alerts = con.createStatement().executeQuery("SELECT * from ALERTS where username=\'"+ username + "\'");
	if(userResult.next()){
		%><p><%out.println(userResult.getString("username")); %>'s Account Page</p><%
	}
	else
		System.out.println("Unable to find user with given username");
	
	out.println("<br><p>Previous Bids</p>");
	while(previousBids.next()){
		out.println( "<p>Item: " + previousBids.getString("itemName") + "&nbsp;&nbsp;Amount : $" + previousBids.getDouble("bidAmount") + "</p>" );
	}
	
	//TODO: Remove after debugging
	session.setAttribute("username", "dave");
	System.out.println(session.getAttribute("username"));
	
	if(session.getAttribute("username").equals(username)){
		%><br>If you would like to change your password, enter your new password: 
		<form method=post action=changePassAttempt.jsp> 
			<input name="newPass" type="password">
			<input type="submit" value="Submit">
		</form>
	<%}
	
%>
</body>
</html>

<%
con.close();
} catch (Exception e) {
	e.printStackTrace();
}
%>