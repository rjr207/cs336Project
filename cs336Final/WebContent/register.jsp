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

	<form method=post onsubmit="newAcct(this.form)" action="login.jsp">
		<h3>Login</h3>
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
	
	<script>
function newAcct(form){
	
	Exception e;
	try{
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			
			String usr = form.username.value;
			String pword = form.password.value;
			String addr = form.address.value;
			String eaddr = form.eaddress.value;
			
			//Make an insert statement for the emailaccount table:
			String insert1 = "INSERT INTO EMAILACCOUNT(eaddress)"
					+ "VALUES (?)";
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			PreparedStatement ps1 = con.prepareStatement(insert1);

			//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
			ps1.setString(1, eaddr);
			//Run the query against the DB
			ps1.executeUpdate();

			//Make an insert statement for the Sells table:
			String insert2 = "INSERT INTO ENDUSER(username, password, address, eaddress)"
					+ "VALUES (?, ?, ?, ?)";
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			PreparedStatement ps2 = con.prepareStatement(insert);

			//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
			ps2.setString(1, usr);
			ps2.setString(2, pword);
			ps2.setString(3, addr);
			ps2.setString(4, eaddr);
			//Run the query against the DB
			ps2.executeUpdate();

			//close the connection.
			con.close();
	}catch(e){
		e.printStackTrace();
	}

}
</script>
</body>
</html>