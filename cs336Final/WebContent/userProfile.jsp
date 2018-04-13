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
	ResultSet itemsWon = con.createStatement().executeQuery("SELECT * from AUCTION where soldTo=\'"+ username + "\'");
	ResultSet soldItems = con.createStatement().executeQuery("SELECT * from AUCTION where soldTo IS NOT NULL AND posterUsername=\'"+ username + "\'");
	if(userResult.next()){
		%><p><%out.println(userResult.getString("username")); %>'s Account Page</p><%
	}
	else
		System.out.println("Unable to find user with given username");
	
	out.println("<br><p>Previously Sold Items</p>");
	while(soldItems.next()){
		out.println("<p>Item: "+soldItems.getString("itemName") + " Type: "+soldItems.getString("itemType") +" Size: " +soldItems.getString("itemSize") + " Color: "+soldItems.getString("itemColor") +"</p>");
	}
	
	out.println("<br><p>Previous Bids</p>");
	while(previousBids.next()){
		out.println( "<p>Item: " + previousBids.getString("itemName") + "&nbsp;&nbsp;Amount : $" + previousBids.getDouble("bidAmount") + "</p>" );
	}
	
	out.println("<br><p>Items Won</p>");
	while(itemsWon.next()){
		out.println("<p>Item: " + itemsWon.getString("itemName") + "</p>");
	}
	
	
	//TODO: Remove after debugging
	session.setAttribute("username", "dave");
	System.out.println(session.getAttribute("username"));
	
	if(session.getAttribute("username").equals(username)){
		out.println("<br><p>Alerts<p>");
		while(alerts.next()){
			out.println("<p>Item: " + alerts.getString("itemWanted") + " Duration: " + alerts.getString("duration"));
		}
		%>
		<br>If you would like to change your password, enter your new password: 
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