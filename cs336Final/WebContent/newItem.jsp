<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Create Item Listing</title>
</head>
<body>
<h1>Sell Some Socks!</h1><br>
<form method="post" action="newListingAttempt.jsp">
	<table>
	<tr>
		<td>Auction Title</td>
		<td><input type="text" name="itemName"></td>
	</tr>
	<tr>
		<td>Sock Style</td>
		<td>
		<select name="itemType">
			<option value="knee">Knee</option>
			<option value="crew">Crew</option>
			<option value="ankle">Ankle</option>
		</select>
		</td>
	</tr>
	<tr>
		<td>Color</td>
		<td><input type="text" name="itemColor"></td>
	</tr>
	<tr>
		<td>Size</td>
		<td>
			<select name="itemSize">
			<option value="small">Small</option>
			<option value="medium">Medium</option>
			<option value="large">Large</option>
		</select>
		</td>
	</tr>
	<tr>
		<td>Starting Price</td>
		<td><input type="text" name="startingPrice"></td>
	</tr>
	<tr>
		<td>Reserve Price</td>
		<td><input type="text" name="reservePrice"></td>
	</tr>
	<tr>
		<td>Duration</td>
		<td><input type="text" name="duration"></td>
	</tr>
	<tr>
		<td><input type="submit" value="submit" /></td>
	</tr>
	</table>
</form>
</body>
</html>