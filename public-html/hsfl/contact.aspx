<%@ Page Language="VB" ContentType="text/html" ResponseEncoding="UTF-8" %>
<%@ Import Namespace="System.Web.Mail" %>
<script runat="server">
	Sub btnContact_Click(sender as object, e As ImageClickEventArgs)
		Dim objContactEmail as New MailMessage()
		objContactEmail.To = "mandy.haines@eurorscg.com, courtney.haines@eurorscg.com" 'comma separate email address
		objContactEmail.From = txtEmail.Text
		objContactEmail.Subject = "Healthy Sight For Life Fund - Contact" & ControlChars.NewLine 
		objContactEmail.Body += "Name: " & txtFirstName.Text & " " & txtLastName.Text & ControlChars.NewLine 
		objContactEmail.Body += "Email: " & txtEmail.Text & ControlChars.NewLine 
		objContactEmail.Body += "Address: " & txtAddress1.Text & txtAddress2.Text & ControlChars.NewLine 
		objContactEmail.Body += "City: " & txtCity.Text & ControlChars.NewLine 
		objContactEmail.Body += "State: " & txtState.Text & ControlChars.NewLine 
		objContactEmail.Body += "Zip or Postal Code: " & txtZip.Text & ControlChars.NewLine
		objContactEmail.Body += "Phone: " & txtPhone.Text & ControlChars.NewLine 
		objContactEmail.Body += "Comments: " & txtComments.Text
		
		try
			SmtpMail.Send(objContactEmail)
			pnlConfirm.Visible = "true"
			pnlFail.Visible = "false"
			frmContact.Visible = "false"
		catch exc as Exception
			pnlConfirm.Visible = "false"
			pnlFail.Visible = "true"
	  End Try
	End Sub
</script>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>Transitions Healthy Sight for Life Fund | Contact Us</title>
        <link rel="stylesheet" type="text/css" href="css/temp.css" />
		<link rel="stylesheet" type="text/css" href="css/hsfl.css" />
        <script type="text/javascript">
		var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
		document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));
		</script>
		<script type="text/javascript">
		try {
		var pageTracker = _gat._getTracker("UA-6684215-2");
		pageTracker._trackPageview();
		} catch(err) {}
		</script>
		<!--[if lt IE 7]>
			<link rel="stylesheet" type="text/css" href="css/ie.css" />
		<![endif]-->
	</head>
	<body id="contact">
		<div><a href="#content" class="nodisplay">skip to content</a></div>
		<div id="container">
			<ul id="ulCorpNav">
				<li><a href="index.aspx" id="lnkHome">Home</a></li>
				<li><a href="news.aspx" id="lnkNews">News</a></li>
				<li><a href="contact.aspx" id="lnkContact">Contact</a></li>
			</ul>
			<h1 id="hHSFL"><a href="index.aspx">Transitions Healthy Sight For Life Fund</a></h1>
			<ul id="ulMainNav">
				<li><a href="enhance-and-protect.aspx" id="lnkEnhance">Enhance &amp; Protect Your Sight</a></li>
				<li><a href="about-the-fund.aspx" id="lnkAbout">About the Fund</a></li>
				<li><a href="get-involved.aspx" id="lnkGetInvolved">Get Involved</a></li>
				<li><a href="professional-resources.aspx" id="lnkResources">Professional Resources</a></li>
				<li><a href="vision-scholarships.aspx" id="lnkScholarship">Vision Scholarships</a></li>
			</ul>
			<div id="content">
				<div id="pnlMainContent">
					<h2>Contact Us</h2>
					<form id="frmContact" runat="server">
						<ul id="ulContactUs">
							<li id="liFirstName">
								<label id="lblFirstName" for="txtFirstName">First Name*</label>
								<asp:TextBox ID="txtFirstName" runat="server" TextMode="SingleLine"></asp:TextBox>
							</li>
							<li id="liLastName">
								<label id="lblLastName" for="txtLastName">Last Name*</label>
								<asp:TextBox ID="txtLastName" runat="server" TextMode="SingleLine"></asp:TextBox>
							</li>
							<li id="liEmail">
								<label id="lblEmail" for="txtEmail">Email Address*</label>
								<asp:TextBox ID="txtEmail" runat="server" TextMode="SingleLine"></asp:TextBox>
							</li>
							<li id="liAddr1">
								<label id="lblAddr1" for="txtAddress1">Address Line 1*</label>
								<asp:TextBox ID="txtAddress1" runat="server" TextMode="SingleLine"></asp:TextBox>
							</li>
							<li id="liAddr2">
								<label id="lblAddr2" for="txtAddress2">Address Line 2*</label>
								<asp:TextBox ID="txtAddress2" runat="server" TextMode="SingleLine"></asp:TextBox>
							</li>
							<li id="liCity">
								<label id="lblCity" for="txtCity">City*</label>
								<asp:TextBox ID="txtCity" runat="server" TextMode="SingleLine"></asp:TextBox>
							</li>
							<li id="liState">
								<label id="lblState" for="txtState">State*</label>
								<asp:TextBox ID="txtState" runat="server" TextMode="SingleLine"></asp:TextBox>
							</li>
							<li id="liZip">
								<label id="lblZip" for="txtZip">Zip*</label>
								<asp:TextBox ID="txtZip" runat="server" TextMode="SingleLine"></asp:TextBox>
							</li>
							<li id="liPhone">
								<label id="lblPhone" for="txtPhone">Phone Number</label>
								<asp:TextBox ID="txtPhone" runat="server" TextMode="SingleLine"></asp:TextBox>
							</li>
							<li id="liComments">
								<label id="lblComments" for="txtComments">Comments</label>
								<asp:TextBox ID="txtComments" runat="server" TextMode="MultiLine" Rows="10" Columns="40"></asp:TextBox>
							</li>
							<li id="liSubmit">
								<asp:ImageButton ID="btnContact" runat="server" ImageUrl="images/blueSubmitBtn.jpg" OnClick="btnContact_Click"></asp:ImageButton>
							</li>
						</ul>
					</form>
					<asp:Panel ID="pnlConfirm" runat="server" Visible="false">Success!</asp:Panel>
					<asp:Panel ID="pnlFail" runat="server" Visible="false">Fail!</asp:Panel>
				</div>
				<div id="pnlSecondary">
					<div class="left">
						<h2>How We Support</h2>
						<p><a href="get-involved.aspx">See How to Get Involved.</a></p>
					</div>
					<div class="right">
						<h2>How We Educate</h2>
						<p><a href="professional-resources.aspx">View Our Resources.</a></p>
					</div>
				</div>
				<ul id="ulFooter">
					<li><a href="enhance-and-protect.aspx">Enhance &amp; Protect Your Sight</a></li>
					<li><a href="about-the-fund.aspx">About the Fund</a></li>
					<li><a href="get-involved.aspx">Get Involved</a></li>
					<li><a href="professional-resources.aspx">Professional Resources</a></li>
					<li><a href="news.aspx">Fund News</a></li>
					<li><a href="privacy.aspx">Privacy</a></li>
					<li><a href="terms-and-conditions.aspx">Terms and Conditions</a></li>
					<li class="last"><a href="contact.aspx">E-Mail Us</a></li>
				</ul>
				<p id="pCopyright">&copy; 2009 Transitions Optical, Inc.</p>
				<p id="pLegal">Transitions and the swirl are registered trademarks and Healthy sight in every light and customized eyeglass prescription are trademarks of Transitions Optical, Inc.</p>
			</div>
		</div>
	</body>
</html>