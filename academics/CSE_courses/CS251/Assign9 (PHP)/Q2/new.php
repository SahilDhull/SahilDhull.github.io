<html>
<head>
<script src="form.js"></script>
<script>
function validateForm(){
    var Name = document.forms["myForm"]["name"].value;
    var Address = document.forms["myForm"]["address"].value;
    var Email = document.forms["myForm"]["email"].value;
    var Mobile = document.forms["myForm"]["mobile"].value;
    var Bankac = document.forms["myForm"]["bankac"].value;
    var Pass = document.forms["myForm"]["pass"].value;
    
    if(!checkname(Name)){
    	alert("Invalid Name");
    	return false;
    }
    
    if(!checkaddress(Address)){
    	alert("Invalid Address");
    	return false;
    }
    if(!checkmail(Email)){
    	alert("Invalid Email");
    	return false;
    }
    if(!checkmobile(Mobile)){
    	alert("Invalid Mobile");
    	return false;
    }
    if(!checkacc(Bankac)){
    	alert("Invalid Bank A/C");
    	return false;
    }
    if(!checkpass(Pass)){
    	alert("Invalid Password");
    	return false;
    }
    return true;
    
}
</script>
</head>
<body>

<?php

// define variables and set to empty values
$name = $address = $email = $mobile = $bankac = $pass = "";
$db = new SQLite3('new.db');

if ($_SERVER["REQUEST_METHOD"] == "POST") {
  $name = $_POST["name"];
  $address = $_POST["address"];
  $email = $_POST["email"];
  $mobile = $_POST["mobile"];
  $bankac = $_POST["bankac"];
  $pass = $_POST["pass"];
  $create = $db->query("CREATE TABLE IF NOT EXISTS Records (
  name varchar(255),
  address varchar(255),
  email varchar(255),
  mobile int,
  bankac int,
  pass varchar(255))");
  $qstr = "INSERT INTO Records (name,address,email,mobile,bankac,pass) VALUES ('$name', '$address', '$email', '$mobile', '$bankac', '$pass')";
}
?>

<h2>Lets Build Stuff!</h2>
<form name="myForm" action="test.php" onsubmit="return validateForm()" method="post" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]);?>">  
  Name: <input type="text" name="name">
  <br><br>
  Address: <input type="text" name="address">
  <br><br>
  E-mail: <input type="text" name="email">
  <br><br>
  Mobile Number: <input type="text" name="mobile">
  <br><br>
  Bank A/C number: <input type="text" name="bankac">
  <br><br>
  Bank Password: <input type="password" name="pass">
  <br><br>
  <input type="submit" name="submitname" value="Submit">
  
</form>
<br>

<a href = "all.php"> See all Registration </a>

</body>
</html>
