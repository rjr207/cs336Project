<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Messages</title>
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
//retrieve page number
if(session.getAttribute("messPageNum") == null){
	session.setAttribute("messPageNum", "1");
	//out.println("Page is: "+ session.getAttribute("messPageNum"));
}else{
	String currPage = request.getParameter("navBtn");
	
	int intPage = Integer.parseInt((String)session.getAttribute("messPageNum"));
	//Prev
	if("Previous Page".equals(currPage)){
		if(intPage > 1){
			intPage--;
			session.setAttribute("messPageNum",(""+intPage));
		}
	//next
	}else if("Next Page".equals(currPage)){
		intPage++;
		session.setAttribute("messPageNum",(""+intPage));
	//neither
	}else{
		session.setAttribute("messPageNum", "1");
	}
	

}

//retrieve number of auction results to display
//no preexisting session 
if(session.getAttribute("messResNum") == null){
	String currNum = request.getParameter("messResNum");
	//unitialized session variable, set to default
	if(currNum == null){
		session.setAttribute("messResNum", "10");
	//form is filled out
	}else{
		session.setAttribute("messResNum", currNum);
	}
}else{
	String currNum = request.getParameter("messResNum");
	//unitialized session variable, set to default
	if(currNum == null){
	//form is filled out
	}else{
		session.setAttribute("messResNum", currNum);
	}
}
//out.println("Session value = " + session.getAttribute("messResNum"));
//out.println("Form value was = " + request.getParameter("messResNum"));
%>
	<h1>View Messages</h1>
	<form method = "post" action="messages.jsp">
		<select name="messResNum" onchange="this.form.submit()">
			<option value="0">Select Number of Results</option>
			<option value="10">Show 10 Results</option>
			<option value="20">Show 20 Results</option>
			<option value="50">Show 50 Results</option>
			<option value="100">Show 100 Results</option>
		</select>
	</form>
	<%
		out.println("Page is: "+ session.getAttribute("messPageNum"));
		int numRows = Integer.parseInt((String)session.getAttribute("messResNum"));
		int pagNum = Integer.parseInt((String)session.getAttribute("messPageNum"))-1;//page number, minus 1
		int needToPass = numRows*pagNum;
		int currRow = 1;
		int prevRows = 0;

		try {
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			Statement stat0 = con.createStatement();
			Statement stat = con.createStatement();
			Statement stat1 = con.createStatement();
			//System.out.println("Attempting query:"+"SELECT * from ENDUSER where username=\'"+ usr +"\' AND password=\'"+pword+"\'");
			//NOTE: for now, only looks for auctions, not active auctions
			ResultSet eaddr;
			
			if(session.getAttribute("usrlvl").equals("user")){
				eaddr = stat0.executeQuery("SELECT eaddress from ENDUSER where username=\'"+ session.getAttribute("username") +"\'");
			}else{
				eaddr = stat0.executeQuery("SELECT eaddress from CUSTOMERREPRESENTATIVE where username=\'"+ session.getAttribute("username") +"\'");
			}
			eaddr.next();
			String theEaddr = eaddr.getString(1);
			
			ResultSet result = stat.executeQuery("SELECT * from EMAIL where sender=\'"+ eaddr.getString(1) +"\' OR recipient=\'"+eaddr.getString(1)+"\' ORDER BY eid DESC");
			
			//get a random rep's email
			ResultSet randomRep = stat1.executeQuery("SELECT * from CUSTOMERREPRESENTATIVE ORDER BY RAND() LIMIT 1");
			randomRep.next();
			String repEaddr = randomRep.getString("eaddress");
			
			//There are ongoing auctions
			if(result.next()){
				out.println("<table>");
				out.println("<tr>");
				out.println("<td>|</td>");
				out.println("<td>Sender</td>");
				out.println("<td>|</td>");
				out.println("<td>Recipient</td>");
				out.println("<td>|</td>");
				out.println("<td>Subject</td>");
				out.println("<td>|</td>");
				out.println("<td>Time Sent</td>");
				out.println("<td>|</td>");
				out.println("<td></td>");
				out.println("<td>|</td>");
				out.println("</tr>");
				do{
					if(prevRows < needToPass){
						prevRows++;
					}else{
						//decrement each cycle
						if(currRow > numRows){
							break;
						}else{
							currRow++;
						}
										
						out.println("<tr>");
						out.println("<td>|</td>");
						out.print("<td>");
						out.print(result.getString("sender"));
						out.println("</td>");
						out.println("<td>|</td>");
						out.print("<td>");
						out.print(result.getString("recipient"));
						out.println("</td>");
						out.println("<td>|</td>");
						out.print("<td>");
						out.print(result.getString("subject"));
						out.println("</td>");
						out.println("<td>|</td>");
						out.print("<td>");
						out.print(result.getString("timeSent"));
						out.println("</td>");
						out.println("<td>|</td>");
						out.println("<td><form method = \"post\" action=\"viewMessage.jsp\">");
						out.println("<input type=\"hidden\" name=\"messageNumber\" value="+ result.getString("eid") +">");
						out.println("<input type=\"submit\" value=\"View Message\" />");
						out.println("</form></td>");
						out.println("<td>|</td>");
						out.println("</tr>");
					}
				}while(result.next());
				out.println("<form action=\'messages.jsp\' method=\"post\">");
				out.println("</table>");
				out.println("<table>");
				out.println("<tr>");
				out.println("<td><input type=\"submit\" name=\"navBtn\" value=\"Previous Page\"></td>");
				out.println("<td><input type=\"submit\" name=\"navBtn\" value=\"Next Page\"></td>");
				out.println("</tr>");
				out.println("</table>");
				out.println("</form>");



			//There are no ongoing auctions
			}else{
				out.println("No messages currently!");
			}
			//field to create new message (if user)
			if(session.getAttribute("usrlvl").equals("user")){
				out.println("<h2>Message a Representative</h2>");
				out.println("<form method=\"post\" action=\"newMessage.jsp\">");
				out.println("<table>");
				out.println("<tr>");
				out.println("<input type=\"hidden\" name=\"targetEaddr\" value=\""+ repEaddr +"\">");
				out.println("<input type=\"hidden\" name=\"senderEaddr\" value=\""+ theEaddr +"\">");
				out.println("<td>");
				out.println("<input type=\"submit\" value=\"Compose a Message\">");
				out.println("</td>");
				out.println("</tr>");
				out.println("</table>");
				out.println("</form>");
			}
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	%>

</body>
</html>