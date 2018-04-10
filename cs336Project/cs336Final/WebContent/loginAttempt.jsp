<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Attempting Login</title>
</head>
<body>
<%
String usr = request.getParameter("username");
String pword = request.getParameter("password");

try {

	//Get the database connection
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	Statement stat = con.createStatement();
	ResultSet r1;
	//System.out.println("Attempting query:"+"SELECT * from ENDUSER where username=\'"+ usr +"\' AND password=\'"+pword+"\'");
	r1 = stat.executeQuery("SELECT * from ENDUSER where username=\'"+ usr +"\' AND password=\'"+pword+"\'");
	
	if(r1.next()){
		//close the connection.
		con.close();
		if(r1.getString("userlvl") == "1"){
			session.setAttribute("username", usr);
			session.setAttribute("password", pword);
			response.sendRedirect("userHome.jsp");}
		else if(r1.getString("userlvl") == "2"){
			session.setAttribute("username", usr);
			session.setAttribute("password", pword);
			response.sendRedirect("repHome.jsp");}//Don't know what the rep file name is, so change accordingly
		else if(r1.getString("userlvl") == "3"){
			session.setAttribute("username", usr);
			session.setAttribute("password", pword);
			response.sendRedirect("adminHome.jsp");}
		else{
			response.sendRedirect("loginFail.jsp");}
		}
	else{
		//close the connection.
		con.close();
		//System.out.println("Failed login");
		response.sendRedirect("loginFail.jsp");
	}
} catch (Exception e) {
	e.printStackTrace();
}

%>

</body>
</html>