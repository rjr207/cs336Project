<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>View Message</title>
</head>
<body>
<table>
		<tr>
			<%
			if(session.getAttribute("usrlvl").equals("user")){
				out.println("<td><input type=\"button\" value=\"Home\" onClick=\"window.location=\'userHome.jsp\';\"></td>");
			}else{
				out.println("<td><input type=\"button\" value=\"Home\" onClick=\"window.location=\'repHome.jsp\';\"></td>");
			}
			%>
			<td><input type="button" value="Messages" onClick="window.location='messages.jsp';"></td>
			<td><input type="button" value="Account" onClick="window.location='accountInfo.jsp';"></td>
			<td><input type="button" value="Log Out" onClick="window.location='login.jsp';"></td>
		
		</tr>
	</table>
	
	<%
int eid = Integer.parseInt(request.getParameter("eid"));

try {
		
	//Get the database connection
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	Statement stat = con.createStatement();
	ResultSet result = stat.executeQuery("SELECT * from EMAIL where eid=\'"+ eid + "\'");
	if(result.next()){
		
		out.println(result.getString("contents"));
		
	}
	else{
		//Unable to find item
		System.out.println("Unable to find item");
		//response.sendRedirect("login.jsp");
	}
	con.close();
	} catch (Exception e) {
		e.printStackTrace();
	}
%>
	
</body>
</html>