/**
 *  login javascript 
 */

function validate()
{
	var username = document.getElementById("username").value;
	var password = document.getElementById("password").value;
	if(username == "") {
		alert("Enter Username");
		return false;
	}
	
	if(password == "") {
		alert("Enter Password");
		return false;
	}
}