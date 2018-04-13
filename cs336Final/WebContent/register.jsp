<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Create an Account</title>
</head>
<body>


	<form method=post onsubmit="newAcct(this.form)" action="RegistrationAttempt.jsp">
		<h3>Input Information</h3>
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
	<h3>Return to Login</h3>
	<input type="button" value="Return" onClick="window.location='login.jsp';">
	
</body>
</html>