function checkname(text){
	if (text.length == 0 || text.length > 20) return false; 
	var reg = /^[a-zA-Z_]+( [a-zA-Z_]+)*$/;
	return reg.test(text);
}

function checkaddress(text){
	if (text.length == 0 || text.length > 100){
		return false;
	}
	return true;
}

function checkmail(text){
	var reg = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.com$/;
	return reg.test(text);
}

function checkmobile(text){
	if (text.length != 10){
		return false;
	}
	var reg = /^[1-9]+(\d{9})$/
	return reg.test(text);
}

function checkacc(text){
	if (text.length != 5){
		return false;
	}
	var reg = /^(\d{5})$/
	return reg.test(text);
}

function checkpass(text){
	if (text.length == 0 || text.length > 20) return false;
	var reg = /^\w*$/;
	return reg.test(text);
}
