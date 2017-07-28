/**
 * 
 */
function validate() {
	var apos = document.getElementById("apos").value;
	var aneg = document.getElementById("aneg").value;
	var bpos = document.getElementById("bpos").value;
	var bneg = document.getElementById("bneg").value;
	var abpos = document.getElementById("abpos").value;
	var abneg = document.getElementById("abneg").value;
	var opos = document.getElementById("opos").value;
	var oneg = document.getElementById("oneg").value;

	if (apos == "" || isNaN(apos)) {
		alert("Enter A positive Blood Quantity in Numbers");
		return false;
	}
	if (aneg == "" || isNaN(aneg)) {
		alert("Enter A Negative Blood Quantity in Numbers");
		return false;
	}
	if (bpos == "" || isNaN(bpos)) {
		alert("Enter B Positive Blood Quantity in Numbers");
		return false;
	}
	if (bneg == "" || isNaN(bneg)) {
		alert("Enter B Negative Blood Quantity in Numbers");
		return false;
	}
	if (abpos == "" || isNaN(abpos)) {
		alert("Enter AB Positive Blood Quantity in Numbers");
		return false;
	}
	if (abneg == "" || isNaN(abneg)) {
		alert("Enter AB Negative Blood Quantity in Numbers");
		return false;
	}
	if (opos == "" || isNaN(opos)) {
		alert("Enter O Positive Blood Quantity in Numbers");
		return false;
	}
	if (aneg == "" || isNaN(oneg)) {
		alert("Enter O Negative Blood Quantity in Numbers");
		return false;
	}
	return true;
}

function selectbank() {
	var id = document.getElementById("bank").value;

	if (id == "") {
		window.location.href = "stock.jsp";
	} else {
		window.location.href = "stock.jsp?bankid="
				+ document.getElementById("bank").value;
	}
}