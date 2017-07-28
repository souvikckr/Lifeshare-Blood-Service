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
<link href="css/style.css" rel="stylesheet" type="text/css" />
<script src="js/login.js"></script>
</head>
<body>
	<%!String username, password, query;
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
				<li><a href="#" class="current">Home</a></li>
				<li><a href="#">About Us</a></li>
				<li><a href="#">Gallery</a></li>
				<li><a href="#">Blood Tips</a></li>
				<li><a href="#">Contact</a></li>
			</ul>
		</div>
		<!-- end of menu -->
	</div>
	<div id="content_wrapper">
		<div id="sidebar">
			<div class="sidebar_box">
				<h2>Announcements</h2>
				<div class="news_box">
					<a href="#">UNIVERSAL DONORS AND RECIPIENTS</a>
					<p class="post_info">
						Posted by <a href="#">Admin</a> on <span>April 30, 2048</span>
					</p>
				</div>
				<div class="news_box">
					<a href="#">BLOOD GROUPS</a>
					<p class="post_info">
						Posted by <a href="#">Admin</a> on <span>April 22, 2048</span>
					</p>
				</div>
				<div class="news_box">
					<a href="#">A HEALTHY DONOR</a>
					<p class="post_info">
						Posted by <a href="#">Admin</a> on <span>April 14, 2048</span>
					</p>
				</div>
			</div>
			<div class="sidebar_box_bottom"></div>
			<div class="sidebar_box">
				<h2>Newsletter</h2>
				<form action="#" method="get">
					<label>Please enter your email address to subscribe our
						newsletter.</label> <input type="text" value="" name="username" size="10"
						id="input_field" /> <input type="submit" name="login"
						value="Subscribe" alt="login" id="submit_btn" />
				</form>
				<div class="cleaner"></div>
			</div>
			<div class="sidebar_box_bottom"></div>
		</div>
		<!-- end of sidebar -->
		<div id="content">
			<div class="content_box">
				<h2>LOGIN</h2>
				<p>The day is celebrated to raise awareness globally about the
					need for regular and voluntary blood donation.</p>
				<div class="login">
					<form action="" onsubmit="return validate()">
						<table cellpadding="5px">
							<thead></thead>
							<tr>
								<td>USERNAME</td>
								<td><input type="text" id="username" name="username"
									style="height: 18px;" /></td>
							</tr>
							<tr>
								<td>PASSWORD</td>
								<td><input type="password" id="password" name="password"
									style="height: 18px;" /></td>
							</tr>
							<tr>
								<td></td>
								<td style="float: right;"><input type="submit" id="submit"
									name="submit" value="SUBMIT"
									style="height: 30px; background: #990000; color: #ffffff; width: 75px; border-radius: 10px;" /></td>
							</tr>
						</table>
					</form>
				</div>
				<div class="cleaner"></div>
			</div>
			<%
				if (request.getParameter("submit") != null) {
					username = request.getParameter("username");
					password = request.getParameter("password");
					query = "SELECT * FROM admin where adminid = '" + username + "' and password = '" + password + "'";
					resultSet = dao.getData(query);
					if (resultSet.next()) {
						session.setAttribute("admin", username);
			%>
			<script type="text/javascript">
				window.location.href = "admin.jsp";
			</script>
			<%
				} else {
			%>
			<script type="text/javascript">
				alert("Invalid Username and Password");
			</script>
			<%
				}
				}
			%>
			<div class="content_box_bottom"></div>
			<div class="content_box">
				<h2>Blood Donate Tips</h2>
				<div class="section_w250 float_l">
					<h3>ABOUT BLOOD DONATION</h3>
					<p>Donating blood is a life saving measure especially when you
						have a rare blood type. Blood donation is safe and simple. It
						takes only about 10 minutes to donate blood - less than the time
						of an average telephone call. We can save upto 3 to 4 precious
						lives by donating blood.</p>
				</div>
				<div class="section_w250 float_r">
					<h3>BLOOD BANK</h3>
					<p>A blood bank is a place designed especially for the storage
						of blood and blood products. Large coolers hold these products at
						a constant temperature and they are available at a moment's
						notice.</p>
				</div>
				<div class="cleaner"></div>
			</div>
			<div class="content_box_bottom"></div>
		</div>
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