<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Auction Info</title>
</head>
<body>
<table>
<%
try {
	
	//Not yet sure how to get auction num so using static variable
	int auctionNum = 1;
	
	//Get the database connection
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	Statement stat = con.createStatement();
	ResultSet result = stat.executeQuery("SELECT * from AUCTION where auctionNum=\'"+ auctionNum + "\'");
	if(result.next()){
		%>
		<tr><td>Item Name: <%out.println(result.getString("itemName"));%></td></tr>
		<tr><td>Starting Price: $<%out.println(result.getDouble("startingPrice"));%></td></tr>
		<tr><td>Reserve Price: $<%out.println(result.getDouble("reservePrice"));%></td></tr>
		<tr><td>Sock Type: <%out.println(result.getString("itemType"));%></td></tr>
		<tr><td>Color: <%out.println(result.getString("itemColor"));%></td></tr>
		<tr><td>Size: <%out.println(result.getString("itemSize"));%></td></tr>
		<tr><td>Auction End Date: <%out.println(result.getString("duration"));%></td></tr>
		<tr><td>Seller: <%out.println(result.getString("posterUsername"));%></td></tr>
		<%
	}
	else{
		//Unable to find item
		System.out.println("Unable to find item");
		//response.sendRedirect("login.jsp");
	}
%>
</table>

<br><p>Interested in this item? Place a bid!</p>
<form method=post action=createBid.jsp>
<table>
	<tr><td>Bid Amount: <input type="number" name="bidAmount"></td></tr>
	<tr><td>AudoBid Max : <input type="number" name="autoBidMax"></td></tr>
	<tr><td>Quantity: <input type="number" name="quantity"></td></tr>
	<tr><td>Payment Method: <select>
		<option value="Credit">Credit/Debit</option>
		<option value="PayPal">PayPal</option>
		<option value="BitCoin">BitCoin</option>
	</select></td></tr>
	<tr><td><input type="submit" value="Submit"></td></tr>
</table>
</form>

<%result = stat.executeQuery("SELECT * from BID where auctionNum=\'"+ auctionNum + "\'"); %>

<p>Bid History</p>
<table>
<%while(result.next()){
	out.println("<tr>Amount: $" + result.getString("bidAmount") + " Bidder: " + result.getString("placedByUsername") + "</tr>");
}%>
</table>

</body>
</html>

<%
con.close();
} catch (Exception e) {
	e.printStackTrace();
}
%>