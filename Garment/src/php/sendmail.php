<?php

  
  
  
   $senderName = $_POST['senderName'];
   $senderEmail =  $_POST['senderEmail'];
   $subject = $_POST['emailSubject'];
   $emailMessage = $_POST['emailMessage'];
 
 
$subject=$subject;
$body=$emailMessage;




$YourEmailAddress =$senderEmail; 
$Yourname = $senderName;

$MailUsername = 'abid@octalsoftware.com';
$MailPassword = 'octal123';
$MailServer = 'relay.airtelbroadband.in';


$MailType = "HTML"; 

require("class.phpmailer.php"); 


if(strtolower($MailType) == 'html'){
$mailtypetosend = true;
} else {
$mailtypetosend = false;
}


$mail = new PHPMailer();
$mail->From = senderEmail;
$mail->FromName = $senderName.'('.$senderEmail.')';
$mail->Host = $MailServer;
$mail->Mailer = "SMTP";

$mail->SMTPAuth = true; 
$mail->Username = $MailUsername; 
$mail->Password = $MailPassword; 
$mail->AddAddress($YourEmailAddress, $Yourname);


$mail->WordWrap = 50; 
$mail->IsHTML($mailtypetosend);
//$mail->SetLanguage("en", "include/language/");



$mail->Subject = $subject; 
$mail->Body = $body;

if(!$mail->Send())
{
	echo "Message could not be sent. <p>";
	echo "Mailer Error: " . $mail->ErrorInfo;
	exit;
} else {
	$sent = 1;
}

?>