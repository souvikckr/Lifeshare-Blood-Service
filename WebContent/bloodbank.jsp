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
<link href="css/bloodbank.css" rel="stylesheet" type="text/css" />
</head>
<body>
	<%!String bankid, bkname, address, phno, mobileno, email, query;
	DAO dao = new DAO_Implement();
	ResultSet resultSet;%>
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
				<li><a href="admin.jsp" class="current">Home</a></li>
				<li><a href="admin.jsp">Blood Bank</a></li>
				<li><a href="stock.jsp">Blood Stock</a></li>
				<li><a href="#">Blood Tips</a></li>
				<li><a href="#">Contact</a></li>
			</ul>
		</div>
		<!-- end of menu -->
	</div>
	<div id="content_wrapper">
		<!-- end of sidebar -->

		<div id="content">
			<div class="content_box">
				<div class="bnk_details">
					<table cellspacing="10px">
						<thead>
							<tr>
								<td>BankName</td>
								<td>Address</td>
								<td>PhoneNum</td>
								<td>MobileNo</td>
								<td>EmailId</td>
							</tr>
						</thead>
						<%
							query = "select * from bloodbanks";
							resultSet = dao.getData(query);
							while (resultSet.next()) {
								bkname = resultSet.getString("name");
								address = resultSet.getString("address");
								phno = resultSet.getString("phno");
								mobileno = resultSet.getString("mobileno");
								email = resultSet.getString("mailid");
								bankid = resultSet.getString("bloodbankid");
						%>

						<tr>
							<td style="color: #5E33FF; font-size: 15px;"><%=resultSet.getString("name")%></td>
							<td style="color: #5E33FF; font-size: 15px;"><%=resultSet.getString("address")%></td>
							<td style="color: #5E33FF; font-size: 15px;"><%=resultSet.getString("phno")%></td>
							<td style="color: #5E33FF; font-size: 15px;"><%=resultSet.getString("mobileno")%></td>
							<td style="color: #5E33FF; font-size: 15px;"><%=resultSet.getString("mailid")%></td>
							<td><a href="admin.jsp?edit_id=<%=bankid%>">Edit</a></td>
							<td><a href="bloodbank.jsp?delete_id=<%=bankid%>">Delete</a></td>
							<td><input type="hidden" id="edit_id" name="edit_id"
								value="<%=bankid%>"></input></td>
						</tr>
						<%
							}
						%>
					</table>
				</div>
			</div>
		</div>
	</div>
	<%
		if (request.getParameter("delete_id") != null) {
			int delid = Integer.parseInt(request.getParameter("delete_id"));
			query = "delete FROM bloodbanks WHERE bloodbankid = " + delid;
			int rows = dao.putData(query);
			if (rows > 0) {
	%>
	<script type="text/javascript">	
		alert("Blood Bank Details has been Deleted");
		window.location.href = "bloodbank.jsp";
	</script>
	<%
		} else {
	%>
	<script type="text/javascript">
		alert("Blood Bank Details has not been Deleted");
		window.location.href = "bloodbank.jsp";
	</script>
	<%
		}
	}
	%>
	<!-- end of content -->
	<div class="cleaner"></div>
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
