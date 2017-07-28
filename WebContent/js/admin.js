/**
 * 
 */
var map;
function initialize() {
	var myLatlng = new google.maps.LatLng(12.31122, 76.65875);
	var myOptions = {
		zoom : 7,
		center : myLatlng,
		mapTypeId : google.maps.MapTypeId.ROADMAP
	}
	map = new google.maps.Map(document.getElementById("gmap"), myOptions);
	// marker refers to a global variable
	marker = new google.maps.Marker({
		position : myLatlng,
		map : map
	});

	google.maps.event.addListener(map, "click", function(event) {
		// get lat/lon of click
		var clickLat = event.latLng.lat();
		var clickLon = event.latLng.lng();

		// show in input box
		document.getElementById("lat").value = clickLat.toFixed(5);
		document.getElementById("lng").value = clickLon.toFixed(5);
				
		var marker = new google.maps.Marker({
			position : new google.maps.LatLng(clickLat, clickLon),
			map : map
		});
	});
}

window.onload = function() {
	initialize()
};

function validatebankdetails() {
	var bankname = document.getElementById("bankname").value
	var address = document.getElementById("address").value
	var phoneno = document.getElementById("phoneno").value
	var mobileno = document.getElementById("mobileno").value
	var mailid = document.getElementById("mailid").value
	var lat = document.getElementById("lat").value
	var lng = document.getElementById("lng").value

	if (bankname == "") {
			alert("Enter BankName");
			return false;
		}
	
	if (address == "") {
			alert("Enter address");
			return false;
		}
	if (phoneno == "") {
			alert("Enter phoneno");
			return false;
		}
	if (mobileno == "") {
			alert("Enter mobileno");
			return false;
		}
	if (mailid == "") {
			alert("Enter mailid");
			return false;
		}
	if (lat == "") {
			alert("Enter lattitude");
			return false;
		}
	if (lng == "") {
		alert("Enter longtitude");
		return false;
	}
	return true;
}

function selectbank()
{
	var bankid = document.getElementById("bank").value;
	var target = "stock.jsp";
	if(bankid != "")
		{
			target += "?bankid="+bankid;
		}	
	window.location.href = target;	
}