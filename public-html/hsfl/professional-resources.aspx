<%@ Page Language="VB" ContentType="text/html" ResponseEncoding="UTF-8" %>
<%@ Import Namespace="System.Web.Mail" %>
<script runat="server">
	Sub btnSubmit_Click(sender as object, e As ImageClickEventArgs)
		Dim objEmail as New MailMessage()
		objEmail.To = "mandy.haines@eurorscg.com, courtney.haines@eurorscg.com" 'comma separate email address
		objEmail.From = txtToEmail.Text
		objEmail.Subject = "Healthy Sight For Life Fund - Resources" & ControlChars.NewLine  
		objEmail.Body = "Name: " & txtToName.Text & ControlChars.NewLine 
		objEmail.Body += "Email: " & txtToEmail.Text & ControlChars.NewLine 
		try
			SmtpMail.Send(objEmail)
			pnlSuccess.Visible = true
			pnlFail.Visible = false
		catch exc as Exception
			pnlSuccess.Visible = false
			pnlFail.Visible = true
	  End Try
	End Sub
</script>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>Transitions Healthy Sight for Life Fund | Professional Resources</title>
        <link rel="stylesheet" type="text/css" href="css/temp.css" />
		<link rel="stylesheet" type="text/css" href="css/hsfl.css" />
		<script type="text/javascript" src="js/jquery.js"></script>
		<script type="text/javascript" src="js/flash.js"></script>
		<script type="text/javascript" src="js/hsflfund.js"></script>
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
        <!--[if IE]>
			<style type="text/css">
				#pnlMainContent #pnlPartners ul {
                    margin-left: 10px;
   				}
                #pnlRequest fieldset h2#hReqCEM {
                	position:relative;
                    left:-7px;
                }
                #pnlGrants {
                	margin-top:15px;
                }
                div#pnlGrants a img{
					position:relative;
					top: 0px;
				}
			</style>
		<![endif]-->
		<!--[if lt IE 7]>
			<link rel="stylesheet" type="text/css" href="css/ie.css" />
		<![endif]-->
	</head>
	<body id="professionalResources">
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
				<div id="pnlHeader">
					<h2 id="hProfessionalResources">Resources for Professionals</h2>
					<p>Eyecare industry, health and education professionals have the opportunity to tie into broader-reaching national and global efforts by using the Transitions<sup>&reg;</sup> Healthy Sight for Life Fund educational materials to assist in educating consumers on a local level.</p>
				</div>
				<div id="pnlMainContent">
					<div id="pnlResources">
						<h2 id="hEducationalMaterials">Educational Materials</h2>
						<p>By aligning your educational messages with the Transitions Healthy Sight for Life Fund, eyecare practices demonstrate their commitment to patients&rsquo; healthy sight, and their support of the many hard-working organizations that strive to provide education and eye health solutions.</p>
					</div>
					
					<div id="pnlPartners">
						<h3 id="hPartenersEducation">Partners in Education</h3>
						<p>Transitions Optical also offers a number of clinical papers to further professional education, and several public awareness posters, which can be used as patient or student education. These materials can be downloaded or ordered free of charge from the Transitions Web site.</p>
						<ul>
							<li><a href="http://en-us.transitions.com/professionals/partnerseducation/clinicalpapers.htm" class="papers" rel="external">Clinical Papers</a></li>
							<li><a href="http://en-us.transitions.com/professionals/vew/posterorder.htm" class="papers" rel="external">Posters</a></li>
						</ul>
					</div>
					<div id="pnlRequest">
						<fieldset>
							<legend><h2 id="hReqCEM">Request Consumer Education Materials</h2></legend>
							<form id="frmResources" runat="server">
								<ul>
									<li>
										<label id="lblToName" for="txtToName">Name*</label>
										<asp:TextBox ID="txtToName" TextMode="SingleLine" runat="server" CssClass="text"></asp:TextBox>
									</li>
									<li>
										<label id="lblToEmail" for="txtToEmail">E-mail*</label>
										<asp:TextBox ID="txtToEmail" TextMode="SingleLine" runat="server" CssClass="text"></asp:TextBox>
									</li>
									<li>
										<label id="lblConfirmEmail" for="txtConfirmEmail">Confirm E-mail*</label>
										<asp:TextBox ID="txtConfirmEmail" TextMode="SingleLine" runat="server" CssClass="text"></asp:TextBox>
									</li>
									<li>
										<asp:ImageButton ID="btnSubmit" runat="server" ImageUrl="images/bigSubmitBtn.jpg" OnClick="btnSubmit_Click"></asp:ImageButton>
										<!--<asp:Button ID="btnSubmitOld" runat="server" Text="Submit"></asp:Button>-->
									</li>
								</ul>
								<asp:Panel ID="pnlSuccess" runat="server" Visible="false">Success!</asp:Panel>
								<asp:Panel ID="pnlFail" runat="server" Visible="false">Fail!</asp:Panel>
							</form>
						</fieldset>
					</div>
					<div id="pnlGrants">
						<h3 id="hGrants">Grants</h3>
						<p>Proposals are currently being accepted for Annual Charity Grants and Local Community Grants. Annual grants are considered and awarded once a year. Local community grants are considered and awarded on a rolling basis.</p>
						<a href="get-involved.aspx"><img src="images/headlines/GrantRequestProposal.jpg" alt="Gran Request Proposal" border="0" /><!--Grant Request Proposal--></a>
					</div>
					<!--<div id="pnlHealthySightInstitute">
						<h3>Healthy Sight Institute</h3>
						<p>The Healthy Sight Institute is a resource center, supported by Transitions Optical, which enables professionals to access a comprehensive range of health and vision care information and materials. Drawing on the expertise of a geographically diverse and multidisciplinary Steering Committee of more than 25 health and eyecare professionals, the Web site provides clinical updates and publications, professional education courses, public education tools and a forum for collaboration among professionals, industry leaders, policy makers and the public for a wider understanding of eyecare choices.</p>
						<a href="http://www.healthysightinstitute.org" class="lnkHSI" rel="external">Visit Healthy Sight Institute Web Site</a>
					</div>-->
				</div>
				<div id="pnlSecondary">
					<div class="left">
						<h2 id="hsecondartyHWSpr">How We Support</h2>
						<p><a href="testimonials.aspx">Meet Our Charity Partners.</a></p>
					</div>
					<div class="right">
						<h2 id="hsecondartyHSI">Healthy Sight Institute</h2>
						<p>Dedicated to the Protection and Preservation of Healthy Sight Worldwide.</p>
						<a href="http://www.healthysightinstitute.org" class="lnkLearnMore" rel="external">Visit Healthy Sight Institute Web Site</a>
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