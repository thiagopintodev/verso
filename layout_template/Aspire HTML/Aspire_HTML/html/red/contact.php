<!-- CONTACT FORM SCRIPT! DON'T MESS WITH THIS STUFF HERE, SCROLL DOWN FOR WHERE TO ENTER YOUR EMAIL -->
<?php
		/****SET THE MAX CHARS FOR EACH MESSAGE***************/
			
			//it is recommended not to set the max too high, to prevent extremely long messages
			// from stalling your server
			
			$EMAIL_MAX = 2500;
			$SMS_MAX = 120;
		
		/*****************************************************/

		//function for stripping whitespace and some chars
		function cleanUp($str_to_clean, $newlines, $spaces){
		
			//build list of whitespace chars to be removed
			$bad_chars = array('\r', '\t', ';');
		
			//if newlines are false, add that to the list of bad chars
			if(!$newlines){array_push($bad_chars, '\n');}
			
			//if spaces are false, strip them too
			if(!$spaces){array_push($bad_chars, ' ');}
			
			$str_to_clean_a = str_replace($bad_chars, '', $str_to_clean);
			$str_to_clean_b = strip_tags($str_to_clean_a);
			return $str_to_clean_b;
		}
		
		//function to check for valid email address pattern
		function checkEmail($email) {
			if(!eregi("^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,3})$", $email)) {return false;}
			return true;
		}
		//function to check for valid url pattern
		function checkURL($url) {
			if(!eregi("^http:\/\/", $url)) {return false;}
			return true;
		}
?>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xml:lang="en-us" xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Aspire</title>

<link rel="icon" type="image/x-icon" href="../assets/img/global/favicon.gif" />

<!-- Stylesheet -->
<link href="../assets/css/core.css" media="screen" rel="stylesheet" type="text/css" />
<link href="../assets/colors/red/red.css" media="screen" rel="stylesheet" type="text/css" />

<!-- JavaScript -->
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script> 

<!-- Load theme JavaScript -->
<script type="text/javascript" src="../assets/js/load.js"></script> 

				
<!--[if IE 6]>
<script type="text/javascript" src="../assets/js/DD_belatedPNG_0.0.8a-min.js"></script> 
<script>
  DD_belatedPNG.fix('img, .social li a, #intro');
</script>
<![endif]-->


<!-- BEGIN CONTACT FORM SCRIPT! SCROLL DOWN TO ENTER YOUR OWN EMAIL ADDRESS - OR CREATE YOUR OWN CUSTOM VERSION HERE: http://supersimple.org/contact -->
<script type="text/javascript">
v_fields = new Array('sender_name','sender_email','sender_subject','sender_message');alert_on = true;thanks_on = true; thanks_message = "Thank you. Your message has been sent.";	
	function validateForm(){
		
		//alert(v_fields);
		
		//init errors
		var err = "";
		
		//start checking fields
		for(i=0;i<v_fields.length;i++){
			
			//store the field value
			var _thisfield = eval("document.contact."+v_fields[i]+".value");
			
			//check the field value
			if(v_fields[i] == "sender_name"){
				if(!isAlpha(_thisfield)){ err += "Please enter a valid name\n";}
			}else if(v_fields[i] == "sender_subject"){
				if(!isAlpha(_thisfield)){ err += "Please enter a valid subject\n";}
			}else if(v_fields[i] == "sender_email"){
				if(!isEmail(_thisfield)){ err += "Please enter a valid email address\n";}
			}else if(v_fields[i] == "sender_url"){
				if(!isURL(_thisfield)){ err += "Please enter a valid URL\n";}
			}else if(v_fields[i] == "sender_phone"){
				if(!isPhone(_thisfield)){ err += "Please enter a valid phone number\n";}
			}else if(v_fields[i] == "sender_message"){
				if(!isText(_thisfield)){ err += "Please enter a valid message\n";}
			}
			
		}//end for
		
		if(err != ""){ 
			if(alert_on){
				alert("The following errors have occurred\n"+err);
			}else{
				showErrors(err);
			}
			
			return false;
		
		}
		
		return true;
	}
	
	//function to show errors in HTML
	function showErrors(str){
		var err = str.replace(/\n/g,"<br />");
		document.getElementById("form_errors").innerHTML = err;
		document.getElementById("form_errors").style.display = "block";
	
	}
	
	//function to show thank you message in HTML
	function showThanks(str){
		var tym = str.replace(/\n/g,"<br />");
		document.getElementById("form_thanks").innerHTML = tym;
		document.getElementById("form_thanks").style.display = "block";
	
	}
	
	function isEmail(str){
	if(str == "") return false;
	var regex = /^[^\s()<>@,;:\/]+@\w[\w\.-]+\.[a-z]{2,}$/i
	return regex.test(str);
	}
	
	function isText(str){
		if(str == "") return false;
		return true;
	}
	
	function isURL(str){
		var regex = /[a-zA-Z0-9\.\/:]+/
		return regex.test(str);
	}
	
	// returns true if the number is formatted in the following ways:
	// (000)000-0000, (000) 000-0000, 000-000-0000, 000.000.0000, 000 000 0000, 0000000000
	function isPhone(str){
		var regex = /^\(?[2-9]\d{2}[\)\.-]?\s?\d{3}[\s\.-]?\d{4}$/
		return regex.test(str);
	}
	
	// returns true if the string contains A-Z, a-z or 0-9 or . or # only
	function isAddress(str){
		var regex = /[^a-zA-Z0-9\#\.]/g
		if (regex.test(str)) return true;
		return false;
	}
	
	// returns true if the string is 5 digits
	function isZip(str){
		var regex = /\d{5,}/;
		if(regex.test(str)) return true;
		return false;
	}
	
	// returns true if the string contains A-Z or a-z only
	function isAlpha(str){
		var regex = /[a-zA-Z]/g
		if (regex.test(str)) return true;
		return false;
	}
	
	// returns true if the string contains A-Z or a-z or 0-9 only
	function isAlphaNumeric(str){
		var regex = /[^a-zA-Z0-9]/g
		if (regex.test(str)) return false;
		return true;
	}

</script>

	<?php
	if(isset($_POST["submitForm"])){

		$_name = cleanUp($_POST["sender_name"], false, true);

		$_email = cleanUp($_POST["sender_email"], false, false);

		$_subject = cleanUp($_POST["sender_subject"], false, true);

		$_message = cleanUp($_POST["sender_message"], true, true);

		
		$_body = "You have been sent this message from your contact form\n\n";
		
		if($_name){
			$_body .= "NAME: $_name\n\n";
		}
		
		if($_email){
			$_body .= "EMAIL: $_email\n\n";
		}
		
		if($_url){
			$_body .= "URL: $_url\n\n";
		}
		
		if($_phone){
			$_body .= "PHONE: $_phone\n\n";
		}
		
		if($_message){
		
			//check length of body, reduce to max chars
			if(strlen($_message) > $EMAIL_MAX){$_message= substr($_message, 0, $EMAIL_MAX);}else{$_message = $_message;}
			if(strlen($_message) > $SMS_MAX){$_message2 = substr($_message, 0, $SMS_MAX);}else{$_message2 = $_message;}
		}
		
		

		//store the recipient(s)
		$_to = array();

		//now get the recipient(s)
		// !!!!!!!!!!!!!!!!!!!!!!!
		// !!!!!!!!!!!!!!!!!!!!!!!
		// YOUR EMAIL ADDRESS GOES HERE
		$_to[] = "YourEmail@Address.here";
		
		//define the subject
		if(!$_subject){$_subject = "E-Mail from your contact form";}

		
		if(!$_name){$_name = "CONTACT FORM";}
		if(!$_email){$_email = $_name;}
		
		//set the headers
		$_header = "From: $_name < $_email >" . "\r\n" .
    "Reply-To: ".$_email."\r\n" .
    "Super-Simple-Mailer: supersimple.org";
		
		//we can send up to 2 emails (EMAIL and/or SMS)
		if(count($_to) > 2){ $_to = array_slice($_to,0,2);}
		
		for($i=0;$i<count($_to);$i++){
			
			//get the correct message, based on where it is delivering to
			if(strstr($_to[$i],"teleflip.com")){$_text = $_body.$_message2;}else{$_text = $_body.$_message;}
			
			//send the email(s)
			mail($_to[$i], $_subject, $_text, $_header);
			
		}
		
		echo "<script type=\"text/javascript\">window.onload = function(){showThanks(thanks_message);}</script>";
	}
	?>



</head>
<body class="sub">

	<!-- Container -->
	<div id="container">
		<!-- Header -->
		<div id="header">
			<div class="logo">
				<a href="index.html"><img src="../assets/img/global/logo.png" alt="image" /></a>
			</div>
			
			<ul class="sf-menu">
			<li class="current">
			    <a href="index.html">home</a>
			</li>
			<li>
			    <a href="about.html">about</a>
			</li>
			<li>
			    <a href="services.html">services</a>
			    <ul>
			    	<li>
			    		<a href="fullwidth.html">Full Width Template</a>
			    	</li>
			    	<li>
			    		<a href="#">Web Design</a>
			    		<ul>
			    			<li><a href="#">Examples</a></li>
			    		</ul>
			    	</li>
			    	<li>
			    		<a href="#">Web Dev</a>
			    		<ul>
			    			<li><a href="#">PHP</a></li>
			    			<li><a href="#">XHTML</a></li>
			    		</ul>
			    	</li>
			    	<li>
			    		<a href="#">Video</a>
			    		<ul>
			    			<li><a href="#">Premiere</a></li>
			    			<li><a href="#">After Effects</a></li>
			    		</ul>
			    	</li>
			    </ul>
			</li>
			<li>
			    <a href="portfolio.html">portfolio</a>
			</li>	
			<li>
			    <a href="blog.html">blog</a>
			</li>	
			<li>
			    <a href="contact.html">contact</a>
			</li>	
		</ul>
		
		<div class="sub_header">
				<p><img src="../assets/img/global/sub_icon_3.png" alt="image" />Complete with a configurable contact form - let's get started!</p>
		</div>
		
		</div>
		<!-- </Header -->
		
		
		<!-- Page -->
		<div id="page">
				
				<ul id="entries" class="single">
					
					<!-- Entry #1 -->
					<li>
						<img src="../assets/img/contact/map.jpg" class="border" alt="Map"/>
						
						<div class="entry single">
							<!-- Contact -->
							<div id="contact">
							
								<h2>Fill out this simple form below to send us a message:</h2>
								
								<form name="contact" action="<?=$_SERVER['PHP_SELF']?>" method="post" onsubmit="return validateForm();">
									<fieldset>
										<input type="text" name="sender_name" value="Your Name" />
										<input type="text" name="sender_email" value="Your Email (Kept Private)" />
										<input type="text" name="sender_subject" value="Your Website" />
										<textarea name="sender_message" cols="65" rows="10">Your Comments</textarea>
										<input type="submit" class="button" name="submitForm" value="Send Email" />
									</fieldset>
								</form>
								
								<p id="form_errors"></p>
								<p id="form_thanks"></p>

							</div>
							<!-- </Contact -->
							
						</div>
						
					</li>	
					<!-- </Entry #1 -->										
				</ul>				
		</div>
		<!-- </Page -->
		
		<!-- Sidebar -->
		<div id="sidebar">
			
			<!-- Affiliates -->
			<div class="box">
				<h2>Affiliates</h2>
				<ul class="ads">
					<li><a href="#"><img src="../assets/img/sidebar/ads/themeforest.jpg" alt="Theme Forest"/></a></li>
					<li><a href="#"><img src="../assets/img/sidebar/ads/graphic_river.jpg" alt="Graphic River"/></a></li>
					<li><a href="#"><img src="../assets/img/sidebar/ads/flash_den.jpg" alt="Flash Den"/></a></li>
					<li><a href="#"><img src="../assets/img/sidebar/ads/audio_jungle.jpg" alt="Audio Jungle"/></a></li>
				</ul>
			</div>
			<!-- </Affiliates -->
			
			<!-- Style Switcher -->
			<div class="box">
				<h2>7 Custom Styles!</h2>
				<form name="styles">
						<select name="menu">
							<option value="http://makedesignnotwar.com/themes/aspire/html/black/index.html">Black</option>
							<option value="http://makedesignnotwar.com/themes/aspire/html/blue/index.html">Blue</option>
							<option value="http://makedesignnotwar.com/themes/aspire/html/red/index.html">Red</option>
							<option value="http://makedesignnotwar.com/themes/aspire/html/green/index.html">Green</option>
							<option value="http://makedesignnotwar.com/themes/aspire/html/orange/index.html">Orange</option>
							<option value="http://makedesignnotwar.com/themes/aspire/html/pink/index.html">Pink</option>
							<option value="http://makedesignnotwar.com/themes/aspire/html/white/index.html">White</option>
						</select>
						<INPUT TYPE="button" VALUE="Go" class="go" onClick="location=document.styles.menu.options[document.styles.menu.selectedIndex].value;" value="Go!" />
				</form>
			</div>
			<!-- </Style Switcher -->

			<!-- Sponsor -->
			<div class="box">
				<h2>Sponsor</h2>
				<a href="#"><img src="../assets/img/sidebar/ads/arsenal.jpg" alt="Audio Jungle"/></a>
			</div>
			<!-- </Sponsor -->
						
			<!-- Categories -->
			<div class="box">
				<h2>Categories</h2>
				<ul class="cat">
					<li><a href="#">Articles</a></li>
					<li><a href="#">Tips</a></li>
					<li><a href="#">Freebies</a></li>
					<li><a href="#">Videos</a></li>
					<li><a href="#">Creative</a></li>
				</ul>
			</div>
			<!-- </Categories -->
			
			<!-- Author -->
			<div class="box noborder">
			   <h2>About the Author</h2>
			    
			    <div class="author">
			    	<p><img src="../assets/img/sidebar/author.jpg" alt="image"/>
			    	The designer and developer of this theme is Brandon R Jones, with code support from <a href="http://philohermans.com/">Philo Hermans</a>. Images are from Brandon R Jones, <a href="http://felix-ajenjo.com/interactive-art-director/index.htm">Felix Ajenjo</a>, and <a href="http://www.behance.net/flareationalist">Jacob Bian</a>. You can check out more of Brandon's work at <a href="http://makedesignnotwar.com">Make Design, Not War</a></p>
			    </div>
			</div>
			<!-- </Author -->
				
		</div>
		<!-- </Sidebar -->

	</div>
	<!-- </Container -->
	

	
	<!-- Footer -->
	<div id="footer">
		<div class="inner">
			<ul class="ads">
				<li><a href="#"><img src="../assets/img/global/footer/media_temple.jpg" alt="image"/></a></li>
				<li><a href="#"><img src="../assets/img/global/footer/atlantica.jpg" alt="image"/></a></li>
				<li><a href="#"><img src="../assets/img/global/footer/concept.jpg" alt="image"/></a></li>
			</ul>
			
			<div class="copyright">
				<p>&copy; 2010 - All site content &copy; by Your Company.</p>
			</div>
			
			<ul class="quick_links">
				<li><a href="#">Home</a></li>
				<li><a href="#">Privacy Policy</a></li>
				<li><a href="#">More Links</a></li>
				<li><a href="#">Support</a></li>
				<li><a href="#">Contact Us</a></li>
			</ul>
			<div class="clear"></div>
		</div>
	</div>
	<!-- </Footer -->
	
</body>
</html>