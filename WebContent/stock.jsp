<%@page import="dbconnect.DAO_Implement"%>
<%@page import="dbconnect.DAO"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Education</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="css/stock.css" rel="stylesheet" type="text/css" />
<script src="js/stock.js"></script>
</head>
<body>
	<%!String query;
	DAO dao = new DAO_Implement();
	ResultSet resultSet;
	String apos, aneg, bpos, bneg, abpos, abneg, opos, oneg,cmd;
	boolean isNew = true;
	%>
	<div id="header_wrapper">
		<div id="header">
			<div id="site_title">
				<h1>
					<a href="#"></a>
				</h1>
			</div>
		</div>
		<!-- end of header -->
	</div>
	<!-- end of menu_wrapper -->
	<div id="menu_wrapper">
		<div id="menu">
			<ul>
				<li><a href="admin.jsp">Home</a></li>
				<li><a href="bloodbank.jsp">Blood Bank</a></li>
				<li><a href="stock.jsp"  class="current">Blood Stock</a></li>
				<li><a href="#">Blood Tips</a></li>
				<li><a href="#">Contact</a></li>
			</ul>
		</div>
		<!-- end of menu -->

	</div>
	<div id="content_wrapper">
		<div id="content">
			<div class="content_box">
				<select
					style="height: 30px; margin-left: 35%; margin-top: 20px; background: #BDC3C7; color: #990000; font-weight: bold;"
					onchange="selectbank()" id="bank" name="bank">
					<option value="">-- SELECT BLOODBANK --</option>
					<%
						int id = 0;
						if (request.getParameter("bankid") != null) {
							id = Integer.parseInt(request.getParameter("bankid"));;
						}
						query = "select * from bloodbanks";
						resultSet = dao.getData(query);
						while (resultSet.next()) {
							if (id == resultSet.getInt("bloodbankid")) {
					%>
					<option value="<%=resultSet.getInt("bloodbankid")%>"
						selected="selected"><%=resultSet.getString("name")%></option>
					<%
						} else {
					%>
					<option value="<%=resultSet.getInt("bloodbankid")%>"><%=resultSet.getString("name")%></option>
					<%
						}
						}
					%>
					</select>
					
					<%
						String query = "select * from stocks where bloodbankid="+id;
						ResultSet resultSet = dao.getData(query);
						if(resultSet.next()){
							apos =  resultSet.getInt("a_pos")+"";
							bpos =  resultSet.getInt("b_pos")+"";
							aneg =  resultSet.getInt("a_neg")+"";
							bneg =  resultSet.getInt("b_neg")+"";
							abpos =  resultSet.getInt("ab_pos")+"";
							abneg =  resultSet.getInt("ab_neg")+"";
							opos =  resultSet.getInt("o_pos")+"";
							oneg =  resultSet.getInt("o_neg")+"";
							isNew = false;
							cmd = "UPDATE";
						}
						else{
							apos =  "";
							bpos =   "";
							aneg =  "";
							bneg =  "";
							abpos =  "";
							abneg =  "";
							opos =  "";
							oneg =  "";
							isNew = true;
							cmd = "SAVE";
						}
					%>
						<div class="stock">
							<form onsubmit="return validate();">
								<table style="margin-left: 26%; margin-top: 30px;" cellspacing="10px" >
									<thead>
									</thead>
									<tr>
										<td style="color: #990000;font-size: 22px;font-weight: bold;">A+</td>
										<td><input type="text" id="apos" name="apos" value="<%= apos %>" style="height: 22px; width: 200px;"></input></td>
									</tr>
									<tr>
										<td style="color: #990000; font-size: 22px;font-weight: bold;">A-</td>
										<td><input type="text" id="aneg" name="aneg" value="<%= aneg %>" style="height: 22px; width: 200px;"></input></td>
									</tr>
									<tr>
										<td style="color: #990000; font-size: 22px;font-weight: bold;">B+</td>
										<td><input type="text" id="bpos" name="bpos" value="<%= bpos %>" style="height: 22px; width: 200px;"></input></td>
									</tr>
									<tr>
										<td style="color: #990000; font-size: 22px;font-weight: bold;">B-</td>
										<td><input type="text" id="bneg" name="bneg" value="<%= bneg %>" style="height: 22px; width: 200px;"></input></td>
									</tr>
									<tr>
										<td style="color: #990000; font-size: 22px;font-weight: bold;">AB+</td>
										<td><input type="text" id="abpos" name="abpos" value="<%= abpos %>" style="height: 22px; width: 200px;"></input></td>
									</tr>
									<tr>
										<td style="color: #990000; font-size: 22px;font-weight: bold;">AB-</td>
										<td><input type="text" id="abneg" name="abneg" value="<%= abneg %>" style="height: 22px; width: 200px;"></input></td>
									</tr>
									<tr>
										<td style="color: #990000; font-size: 22px;font-weight: bold;">O+</td>
										<td><input type="text" id="opos" name="opos" value="<%= opos %>" style="height: 22px; width: 200px;"></input></td>
									</tr>
									<tr>
										<td style="color: #990000; font-size: 22px;font-weight: bold;">O-</td>
										<td><input type="text" id="oneg" name="oneg" value="<%= oneg %>" style="height: 22px; width: 200px;">
										</input>
										<input type="hidden" id="id" name="id" value="<%= id %>"></input></td>
									</tr>
									<tr>
										<td></td>
										<td><input type="submit" id="submit" name="submit" value="<%= cmd%>" style="height: 30px; width: 100px; background: #990000;color: #ffffff"></input></td>
									</tr>
								</table>
							</form>
						</div>
			</div>
		</div>
		<%
			if (request.getParameter("submit") != null) {
				
				apos =  request.getParameter("apos");
				bpos =  request.getParameter("bpos");
				aneg =  request.getParameter("aneg");
				bneg =  request.getParameter("bneg");
				abpos =  request.getParameter("abpos");
				abneg =  request.getParameter("abneg");
				opos =  request.getParameter("opos");
				oneg =  request.getParameter("oneg");
				id = Integer.parseInt(request.getParameter("id"));
				if(isNew){
				query = "insert into stocks (a_pos,b_pos,a_neg,b_neg,ab_pos,ab_neg,o_pos,o_neg,bloodbankid) values(" + apos + ","
						+ bpos + "," + aneg + "," + bneg + "," + abpos + "," + abneg + "," + opos + "," + oneg + ","+id+")";
				
				}
				else{
					query = "update stocks set a_pos="+apos+",b_pos="+bpos+",a_neg="+aneg+",b_neg="+bneg+",ab_pos="+abpos
							+",ab_neg="+abneg+",o_pos="+opos+",o_neg="+oneg+" where bloodbankid="+id;
				}
				int rows = dao.putData(query);
				if (rows > 0) {
		%>
		<script type="text/javascript">
			alert("STOCK DETAILS HAS BEEN <%=cmd%>D SUCCESSFULLY");
			window.location.href="stock.jsp";
		</script>
		<%
			} else {
		%>
		<script type="text/javascript">
			alert("STOCK DETAILS HAS NOT BEEN <%=cmd%>D");
			window.location.href="stock.jsp";
		</script>
		<%
			}
			}
		%>
		<!-- end of content -->
		<div class="cleaner"></div>
	</div>
	<div id="footer_wrapper">
		<div id="footer">
			<ul class="footer_menu">
				<li><a href="#">Home</a></li>
				<li><a href="#">Templates</a></li>
				<li><a href="#">Flash Files</a></li>
				<li><a href="#">Gallery</a></li>
				<li><a href="#">Members</a></li>
				<li class="last_menu"><a href="#">Contact Us</a></li>
			</ul>
			Copyright &copy; 2048 <a href="#">Your Company Name</a> | Designed by
			<a target="_blank" rel="nofollow" href="http://www.templatemo.com">templatemo</a>
		</div>
	</div>
</body>
</html>
