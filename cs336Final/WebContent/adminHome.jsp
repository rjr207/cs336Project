<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Administrator Home</title>
</head>
<body>
<table>
		<tr>
			<td><input type="button" value="Home" onClick="window.location='adminHome.jsp';"></td>
			<td><input type="button" value="Messages" onClick="window.location='messages.jsp';"></td>
			<td><input type="button" value="Account" onClick="window.location='accountInfo.jsp';"></td>
			<td><input type="button" value="Log Out" onClick="window.location='login.jsp';"></td>
		
		</tr>
	</table>
<h1>Welcome Administrator</h1>
<br>
<h2>Account Functions</h2>
	<form method=post onsubmit="newAcct(this.form)" action="registrationAttempt.jsp">
	<input type="hidden" name="userlvl" value="2">
	<h3>Create New Customer Representative</h3><br>
	<table>
		<tr>
			<td>User-name</td>
			<td><input type="text" name="username"></td>
		</tr>
		<tr>
			<td>Password</td>
			<td><input type="text" name="password"></td>
		</tr>
		<tr>
			<td>Address</td>
			<td><input type="text" name="address"></td>
		</tr>
		<tr>
			<td>Email</td>
			<td><input type="text" name="eaddress"></td>
		</tr>
		<tr>
			<td><input type="submit" value="submit"></td>
		</tr>
	</table>
	</form>
<br>
	<form method=post onsubmit="deleteAcct(this.form)" action="usrDeleteAttempt.jsp">
	<h3>Delete Account</h3><br>
	<table>
		<tr>
			<td>User-name</td>
			<td><input type="text" name="username"></td>
		</tr>
		<tr>
			<td><input type="submit" value="submit"></td>
		</tr>
	</table>
	</form>
<br>
<h2>Auction Functions</h2><br>
	<h3>Sales Reports</h3><br>
	<table>
		<tr>
			<td><input type="button" value="Total Earnings" onClick="window.location='genTotalSales.jsp';"></td>
			<td><input type="button" value="Earnings Per Item" onClick="window.location='genItemSales.jsp';"></td>
			<td><input type="button" value="Earnings Per End-User" onClick="window.location='genUserSales.jsp';"></td>
			<td><input type="button" value="Best-Selling Item" onClick="window.location='genBestItem.jsp';"></td>
			<td><input type="button" value="Best-Selling Item Type" onClick="window.location='genBestType.jsp';"></td>
			<td><input type="button" value="Best-Selling User" onClick="window.location='genBestUser.jsp';"></td>
			<td><input type="button" value="Best Buyer" onClick="window.location='genBestBuyer.jsp';"></td>
		</tr>
	</table><br>
	<h3>Bid Removal</h3><br>
	
	<form method=post onsubmit="deleteAuc(this.form)" action="aucDeleteAttempt.jsp">
	<h3>Delete Auction</h3><br>
	<table>
		<tr>
			<td>Auction Number</td>
			<td><input type="text" name="auctionNumber"></td>
		</tr>
		<tr>
			<td><input type="submit" value="submit"></td>
		</tr>
	</table>
	</form><br>
	
	<h3>Browse Auctions</h3>
	

</body>
</html>