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
<link href="css/admin.css" rel="stylesheet" type="text/css" />
<script type="text/javascript"
	src="http://maps.googleapis.com/maps/api/js?key=AIzaSyCL20r7YLxeo_oYiEE2Miv0elMqqPxHYkA"></script>
<script src="js/admin.js"></script>
</head>
<body>
	<%!String bkname, address, phno, mobileno, lat, lng, email, query;
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
				<li><a href="bloodbank.jsp">Blood Bank</a></li>
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
				<table>
					<tr>
						<td><div id="gmap" style="width: 850px; height: 300px"></div></td>
					</tr>
				</table>
				<%
					if (request.getParameter("edit_id") == null) {
				%>
				<div class="bank_details">
					<form action="" onsubmit="return validatebankdetails()">
						<table style="margin-top: 30px;" cellspacing="10px;">
							<thead>
							</thead>
							<tr>
								<td>BLOOD BANK NAME</td>
								<td><input type="text" id="bankname" name="bankname"
									style="width: 200px; height: 20px;" /></td>
							</tr>
							<tr>
								<td>ADDRESS</td>
								<td><input type="text" id="address" name="address"
									style="width: 200px; height: 20px;" /></td>
							</tr>
							<tr>
								<td>PHONE NO</td>
								<td><input type="text" id="phoneno" name="phoneno"
									style="width: 200px; height: 20px;" /></td>
							</tr>
							<tr>
								<td>MOBILE NO</td>
								<td><input type="text" id="mobileno" name="mobileno"
									style="width: 200px; height: 20px;" /></td>
							</tr>
							<tr>
								<td>MAIL ID</td>
								<td><input type="text" id="mailid" name="mailid"
									style="width: 200px; height: 20px;" /></td>
							</tr>
							<tr>
								<td>LAT</td>
								<td><input type="text" id="lat" name="lat"
									style="width: 200px; height: 20px;" /></td>
							</tr>
							<tr>
								<td>LNG</td>
								<td><input type="text" id="lng" name="lng"
									style="width: 200px; height: 20px;" /></td>
							</tr>
							<tr>
								<td></td>
								<td style="float: right;"><input type="submit" id="submit"
									name="submit" value="SUBMIT"
									style="height: 30px; width: 100px; color: #ffffff; font-weight: bold; background: #990000;" /></td>
							</tr>
						</table>
					</form>
				</div>
				<%
					}
				%>
				<%
					if (request.getParameter("edit_id") != null) {
						int id = Integer.parseInt(request.getParameter("edit_id"));						
						query = "select * from bloodbanks where bloodbankid = "+id;						
						resultSet = dao.getData(query);
						if(resultSet.next())							
						{
							String name = resultSet.getString("name");
							String adrs = resultSet.getString("address");
							String emailid = resultSet.getString("phno");
							String mobile = resultSet.getString("mobileno");
							String phno = resultSet.getString("mailid");
							String lattitude = resultSet.getString("lat");
							String longtitude = resultSet.getString("lng");
				%>
				<div class="bank_details">
					<form action="" onsubmit="return validatebankdetails()">
						<table style="margin-top: 30px;" cellspacing="10px;">
							<thead>
							</thead>
							<tr>
								<td>BLOOD BANK NAME</td>
								<td><input type="text" id="bankname_up" name="bankname_up"
									style="width: 200px; height: 20px;" value="<%=name %>" /></td>
							</tr>
							<tr>
								<td>ADDRESS</td>
								<td><input type="text" id="address_up" name="address_up"
									style="width: 200px; height: 20px;" value="<%=adrs %>" /></td>
							</tr>
							<tr>
								<td>PHONE NO</td>
								<td><input type="text" id="phoneno_up" name="phoneno_up"
									style="width: 200px; height: 20px;" value="<%=emailid %>"/></td>
							</tr>
							<tr>
								<td>MOBILE NO</td>
								<td><input type="text" id="mobileno_up" name="mobileno_up"
									style="width: 200px; height: 20px;" value="<%=mobile %>"/></td>
							</tr>
							<tr>
								<td>MAIL ID</td>
								<td><input type="text" id="mailid_up" name="mailid_up"
									style="width: 200px; height: 20px;" value="<%=phno %>"/></td>
							</tr>
							<tr>
								<td>LAT</td>
								<td><input type="text" id="lat" name="lat"
									style="width: 200px; height: 20px;" value="<%=lattitude %>"/></td>
							</tr>
							<tr>
								<td>LNG</td>
								<td><input type="text" id="lng" name="lng"
									style="width: 200px; height: 20px;" value="<%=longtitude %>" /></td>
							</tr>
							<tr>
								<td><input type="hidden" id="editid" name="editid" value="<%=id%>"/> </td>
								<td style="float: right;"><input type="submit"
									id="submit_up" name="submit_up" value="UPDATE"
									style="height: 30px; width: 100px; color: #ffffff; font-weight: bold; background: #990000;" /></td>
							</tr>
						</table>
					</form>
				</div>
				<%
						}
					}
				%>
			</div>
		</div>
		<%
			if (request.getParameter("submit") != null) {
				bkname = request.getParameter("bankname");
				address = request.getParameter("address");
				email = request.getParameter("mailid");
				mobileno = request.getParameter("mobileno");
				phno = request.getParameter("phoneno");
				lat = request.getParameter("lat");
				lng = request.getParameter("lng");
				query = "INSERT INTO bloodbanks (name,address,phno,mobileno,mailid,lat,lng) VALUES ('" + bkname + "','"
						+ address + "','" + phno + "','" + mobileno + "','" + email + "','" + lat + "','" + lng + "')";
				int rows = dao.putData(query);
				if (rows > 0) {
		%>
		<script type="text/javascript">
			alert("BLOOD BANK DETAILS HAS BEEN \n ADDED SUCEFULLY");
		</script>
		<%
			} else {
		%>
		<script type="text/javascript">
			alert("BLOOD BANK DETAILS HAS NOT BEEN ADDED");
		</script>
		<%
			}
			}

			if (request.getParameter("submit_up") != null) {					
				String bkname_up = request.getParameter("bankname_up");
				String address_up = request.getParameter("address_up");
				String email_up = request.getParameter("mailid_up");
				String mobileno_up = request.getParameter("mobileno_up");
				String phno_up = request.getParameter("phoneno_up");
				String lat_up = request.getParameter("lat");
				String lng_up = request.getParameter("lng");
				int bnkid = Integer.parseInt(request.getParameter("editid"));
				query = "UPDATE bloodbanks SET NAME = '"+bkname_up+"',address='"+address_up+"',phno ='"+phno_up+"',mobileno='"+mobileno_up+"',mailid='"+email_up+"',lat='"+lat_up+"',lng='"+lng_up+"' where bloodbankid = "+bnkid;
				int rows = dao.putData(query);
				if (rows > 0) {
					%>
					<script type="text/javascript">
						alert("BLOOD BANK DETAILS HAS BEEN \n UPDATED SUCEFULLY");
					</script>
					<%
						} else {
					%>
					<script type="text/javascript">
						alert("BLOOD BANK DETAILS HAS NOT BEEN UPDATED");
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
