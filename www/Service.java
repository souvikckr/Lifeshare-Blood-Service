package com.bloodbankservices.www;

import java.sql.ResultSet;

import org.json.JSONObject;

import dbconnect.DAO;
import dbconnect.DAO_Implement;

public class Service {
		
	public String register(String data) {
		String response = "", username = "", password = "", mobileno = "", address = "", emailid = "", query = "",bloodgroup= "",status = "";
		ResultSet resultSet;
		JSONObject jsonObject = new JSONObject();
		DAO dao = new DAO_Implement();
		try {
			JSONObject dataobject = new JSONObject(data);
			username = dataobject.getString("username");
			password = dataobject.getString("password");
			mobileno = dataobject.getString("address");
			address = dataobject.getString("phonenum");
			emailid = dataobject.getString("emailid");
		    bloodgroup = dataobject.getString("bloodgroup");
			status = dataobject.getString("status");
	
			query = "select * from user where mailid = '" + emailid + "'";
			resultSet = dao.getData(query);
			if (resultSet.next()) {
				jsonObject.put("error", "0");
			} else {
				query = "insert into user (username,password,address,mobileno,bloodgroup,mailid,status) values('" + username + "','"
						+ password + "','" + address + "','" + mobileno + "','" + bloodgroup + "','"+emailid+"','"+status+"')";
				int rows = dao.putData(query);
				if (rows > 0) {
					jsonObject.put("error", 1);
				} else {
					jsonObject.put("error", 2);
				}
			}

		} catch (Exception exception) {
			exception.printStackTrace();
		}
		dao.closeConnection();
		response = jsonObject.toString();
		System.out.println(response);
		return response;
	}

	public String login(String data) {
		System.out.println("calling");
		String response = "", query = "";
		ResultSet resultSet;
		JSONObject jsonObject = new JSONObject();
		DAO dao = new DAO_Implement();
		try {
			JSONObject dataobject = new JSONObject(data);
			String email = dataobject.getString("email");
			String password = dataobject.getString("password");
			query = "select * from user where mailid = '" + email + "' and password = '" + password + "'";
			System.out.println(query);
			resultSet = dao.getData(query);
			if (resultSet.next()) {
				jsonObject.put("error", 0);
			} else {
				jsonObject.put("error", 1);
			}
		} catch (Exception exception) {

		}
		dao.closeConnection();
		System.out.println(response);
		response = jsonObject.toString();
		return response;
	}
}
