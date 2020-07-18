<html>
<body>

<?php

// define variables and set to empty values

$ad = new SQLite3('admin.db');
$db = new SQLite3('new.db');
$flag=0;
//echo $flag;
if ($_SERVER["REQUEST_METHOD"] == "POST") {
	$name = $pass = "";
	//echo "name= ",$name;
  $name = $_POST["name"];
  $pass = $_POST["pass"];
  
	//echo "name= ",$name;
  $check=$ad->query("SELECT * FROM admin");
  /*if($name=='admin' && $pass=='admin'){
		
  }*/
  while ($row=$check->fetchArray()){
		/*echo "<br>","name= ",$row['name'],"<br>";
		echo "<br>","pass= ",$row['pass'],"<br>";*/
		if ($name==$row['name'] && $pass==$row['pass']){
			$flag=1;
			break;
		}
  }
  //echo $flag;
  
}

?>

<h2>Lets Build Stuff!</h2>
<form name="myForm"  method="post" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]);?>">  
  Admin: <input type="text" name="name">
  <br><br>
  Password: <input type="password" name="pass">
  <br><br>
  <input type="submit" name="submit" value="Submit">
  
</form>

<br><br>
<a href = "new.php"> Another Registration </a>

<br> <br>

<?php
if($flag==1){
  		$display=$db->query("SELECT * FROM Records");
  		echo "<br>";
  		echo "<table border='1' id=results>
		<tr>
		<th> Name</th>
		<th> Address</th>
		<th> Email</th>
		<th> Mobile</th>
		<th> Bank A/C</th>
		</tr>";
  		while ($row=$display->fetchArray()){
  			echo "<tr>";
  			echo "<td>" . $row['name'] . "</td>";
			echo "<td>" . $row['address'] . "</td>";
			echo "<td>" . $row['email'] . "</td>";
			echo "<td>" . $row['mobile'] . "</td>";
			echo "<td>" . $row['bankac'] . "</td>";
			echo "</tr>";
  		}
}

?>

</body>
</html>
