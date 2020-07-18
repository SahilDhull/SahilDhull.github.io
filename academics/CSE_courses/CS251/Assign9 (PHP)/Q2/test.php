<html>
<body>

<?php
require_once('new.php');
$flag=0;
$match=0;
$bal=1; 
if (isset($_POST['submitname'])){
	$emailcheck = $db->query("SELECT email FROM Records");
	while ($row1 = $emailcheck->fetchArray()) {
		if($email== $row1['email']){
			$flag=1;
			break;
		}
	}
	$check=$db->query("SELECT * FROM balances");
	if ($flag==0){
		while ($row=$check->fetchArray()){
			if($bankac==$row['bankac'] && $pass == $row['pass']){
				if($row['balance']<1000)
					$bal=0;
				$b=$row['balance']-1000;
				$a=$row['bankac'];
				$match=1;
				break;
			}
		}
		// $match=1 indicates records matched
		if ($match==0){
			echo "<br>","<br>","Invalid Account/Password";
		}
		else if ($bal==0){
			echo "<br>","<br>","Insufficient Balance";
		}
		else{
			$insres = $db->query($qstr);
			//update the balance
			$update=$db->query("UPDATE balances SET balance = '$b' WHERE bankac = $a");
			echo "<br>","<br>","Registration Successful";
		}
	}
	else{
		echo "<br>","<br>","Already registered";
	}
}
else{
	header("Location: new.php");
}
?>


</body>
</html>
