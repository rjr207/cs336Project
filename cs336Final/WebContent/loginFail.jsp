<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Welcome!</title>
</head>
<body>
	<h1>Login Unsuccessful!</h1>
<br>
	<h2>Try Again</h2>
<br>
<form method=post action=LoginAttempt.jsp>
	<h3>Login</h3>
	<table>
		<tr>
			<td>Username</td>
			<td><input type="text" name="username"></td>
		</tr>
		<tr>
			<td>Password</td>
			<td><input type="password" name="password"></td>
		</tr>
		<tr>
			<td><input type="submit" value="submit" /></td>
		</tr>
	</table>
</form>
<br>
<form method=post action=register.jsp>
	<h3>Register</h3>
	<input type="submit" value="Create new account" />
</form><br>
<form method=post action=resetPW.jsp>
	<h3>Register</h3>
	<input type="submit" value="Reset my Password" />
</form>
</body>
</html>