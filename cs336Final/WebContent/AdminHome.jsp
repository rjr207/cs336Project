a <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
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
<h1>Welcome Administrator</h1>
<br>
<h2>Account Functions</h2>
	<form method=post onsubmit="newAcct(this.form)" action="RegistrationAttempt.jsp">
	<input type="hidden" name="userlvl" value="2">
	<h3>Create New Customer Representative</h3>
	<table>
		<tr>
			<td>Username</td>
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
	<form method=post onsubmit="deleteAcct(this.form)" action="DeleteAttempt.jsp">
	<h3>Delete Account</h3>
	<table>
		<tr>
			<td>Username</td>
			<td><input type="text" name="username"></td>
		</tr>
		<tr>
			<td><input type="submit" value="submit"></td>
		</tr>
	</table>
	</form>
<br><br>
<h2>Auction Functions</h2><br>
	<h3>Sales Reports</h3>
	<form action="salesGen.jsp">
		<select name="Report Type">
			<option value="a">Total Earnings</option>
			<option value="b">Earnings Per Item</option>
			<option value="c">Earnings Per Item Type</option>
			<option value="d">Earnings Per End-User</option>
			<option value="e">Best-selling Item</option>
			<option value="f">Best-selling User</option>
		</select>
	</form>
</body>
</html>