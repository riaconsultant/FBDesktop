<?php
  
   $senderName = $_POST['senderName'];
   $senderEmail =  $_POST['senderEmail'];
   $sendToEmail = "abid@octalsoftware.com";
   $subject = $_POST['emailSubject'];
   $emailMessage = $_POST['emailMessage'];
 

$subject=$subject;

$body='<table width="500" cellspading="2" cellpadding="2" align="center" style="font-family:arial;font-size:12px;">';

$body.='<tr><Td>Name :</td><Td>'.$senderName.'</td></tr>';

$body.='<tr><Td>Query :</td><Td>'.$emailMessage.'</td></tr>';


$body.='</table>';

$to='abid@octalsoftware.com';

$YourEmailAddress =$to; //Email address you want the mail to go to
$Yourname = 'hello'; //Who the email is sent from - this is a name not an email

$MailUsername = 'abid@octalsoftware.com'; //Email address you are using to send the email
$MailPassword = 'octal123'; //This is the password of the emali account used to send the emali
//$MailServer = 'relay.airtelbroadband.in'; //Assigned mail server
$MailServer = 'email04.secureserver.net';

$MailType = "HTML"; // Can use HTML or TEXT -case doesnt matter

require("class.phpmailer.php");  //Change this to the real path of the file - this assumes that the mail script 

#----------------------- DO NOT EDIT BELOW THIS LINE ------------------------------#

# These are the form Vars - do not edit
if(strtolower($MailType) == 'html'){
$mailtypetosend = true;
} else {
$mailtypetosend = false;
}

$mail = new PHPMailer();
$mail->From = $senderEmail;
$mail->FromName = $senderName;
$mail->Host = $MailServer;
$mail->Mailer = "smtp";


$mail->SMTPAuth = true; // turn on SMTP authentication
$mail->Username = $MailUsername; // SMTP username
$mail->Password = $MailPassword; // SMTP password
$mail->AddAddress($YourEmailAddress, $Yourname);
$mail->AddAttachment("../uploads/file.png");


$mail->WordWrap = 50; // set word wrap to 50 characters
$mail->IsHTML($mailtypetosend); // True for HTML, FALSE for plain text
//$mail->SetLanguage("en", "include/language/");

//Start the page action upon submittal

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