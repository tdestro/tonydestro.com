<%@ Page Language="VB" ContentType="text/html" ResponseEncoding="UTF-8" Debug="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
		<title>Transitions Healthy Sight for Life Fund | Get Involved</title>
		<link rel="stylesheet" type="text/css" href="css/getinvolved.css" />
		<link rel="stylesheet" type="text/css" href="css/temp.css" />
		<script type="text/javascript" src="js/jquery.js"></script>
		<script type="text/javascript" src="js/ui.tabs.js"></script>
		<script type="text/javascript">
			$(document).ready(function(){
				$('#ulGrantTabs').tabs();
			});
		</script>
		<script type="text/javascript" src="js/insertSpans.js"></script>
		<script type="text/javascript" src="js/flash.js"></script>
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
				#pnlGetInvolved {
					padding: 13px 25px;
				}
				#hGetInvolved {
					margin-top: -100px;
				}
				#ctl00 {
					padding: 0 10px;
				}
				#ctl00 .submit {
					margin-top: 0px;
				}
				#pnlAnnualGrants, #pnlLocalGrants {
					margin-top: 30px;
				}
			</style>
		<![endif]-->
		<!--[if lt IE 7]>
			<link rel="stylesheet" type="text/css" href="css/ie.css" />
		<![endif]-->
	</head>
	<body id="getInvolved">
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
				<div id="pnlGetInvolved">
					<h2 id="hGetInvolved">Get Involved</h2>
					<p class="lead">The simplest way to achieve and maintain healthy sight is to learn more about the steps you and your family can take to protect and optimize sight through proper vision care and vision wear. Talk to your eyecare professional and share this knowledge with someone else by forwarding this site.</p>
					<form runat="server" id="frmGetInvolved">
						<fieldset id="fsForward">
							<legend id="lgForward"><span>Forward this Site</span></legend>
							<h3 id="hForwardSite">Forward this Site</h3>
							<ul>
								<li>
									<label id="lblToName" for="txtToName">To Name*</label>
									
									<asp:TextBox ID="txtToName" TextMode="SingleLine" runat="server" CssClass="required text"></asp:TextBox>
								</li>
								<li>
									<label id="lblToEmail" for="txtToEmail">To E-mail*</label>
									
									<asp:TextBox ID="txtToEmail" TextMode="SingleLine" runat="server" CssClass="required email text"></asp:TextBox>
								</li>
								<li>
									<label id="lblConfirmEmail" for="txtConfirmEmail">Confirm To E-mail*</label>
									
									<asp:TextBox ID="txtConfirmEmail" TextMode="SingleLine" runat="server" CssClass="required email text"></asp:TextBox>
								</li>
								<li>
									<label id="lblFromName" for="txtFromName">From Name*</label CssClass="req">
									
									<asp:TextBox ID="txtFromName" TextMode="SingleLine" runat="server" CssClass="required text"></asp:TextBox>
								</li>
								<li>
									<label id="lblFromEmail" for="txtFromEmail">From E-mail*</label>
									
									<asp:TextBox ID="txtFromEmail" TextMode="SingleLine" runat="server" CssClass="required email text"></asp:TextBox>
								</li>
								<li class="submit">
									<asp:ImageButton ID="btnForward" runat="server" ImageUrl="images/smallSubmitBtn.jpg" validationgroup="forward" CausesValidation="true" OnClick="btnForward_Click"></asp:ImageButton>
								</li>
							</ul>
							<div class="pnlErrors">
								<asp:RequiredFieldValidator ID="reqToName" runat="server" validationgroup="forward" CssClass="req" ControlToValidate="txtToName">Please enter your friend's name.</asp:RequiredFieldValidator>
								<asp:RequiredFieldValidator ID="reqToEmail" runat="server" CssClass="req" validationgroup="forward" ControlToValidate="txtToEmail">Please enter a valid email address.</asp:RequiredFieldValidator>
								<asp:RegularExpressionValidator ID="regToEmail" runat="server" CssClass="req" validationgroup="forward" EnableClientScript="true" ControlToValidate="txtToEmail" ValidationExpression=".*@.*\..*">Please enter a valid email address.</asp:RegularExpressionValidator>
								<asp:RequiredFieldValidator ID="reqConfirmEmail" ControlToValidate="txtConfirmEmail" validationgroup="forward" CssClass="req" runat="server">Email addresses do not match.</asp:RequiredFieldValidator>
								<asp:CompareValidator ID="comConfirmEmail" ControlToValidate="txtConfirmEmail" CssClass="req" validationgroup="forward" ControlToCompare="txtToEmail" runat="server">Email addresses do not match.</asp:CompareValidator>
								<asp:RequiredFieldValidator ID="reqFromName" runat="server" CssClass="req" validationgroup="forward" ControlToValidate="txtFromName">Please enter your name.</asp:RequiredFieldValidator>
								<asp:RequiredFieldValidator ID="reqFromEmail" runat="server" validationgroup="forward" CssClass="req" ControlToValidate="txtFromEmail">Please enter a valid email address</asp:RequiredFieldValidator>
								<asp:RegularExpressionValidator ID="regFromEmail" runat="server" validationgroup="forward" CssClass="req" ControlToValidate="txtFromEmail" ValidationExpression=".*@.*\..*">Please enter a valid email address.</asp:RegularExpressionValidator>
							</div>
							<asp:Panel ID="pnlForwardConfirm" runat="server" Visible="false">Success!</asp:Panel>
							<asp:Panel ID="pnlForwardFail" runat="server" Visible="false">Fail!</asp:Panel>
						</fieldset>
						<div id="pnlDonate">
							<h3 id="hDonate">Donate</h3>
							<p>While the Transitions<sup>&reg;</sup> Healthy Sight for Life Fund is not currently accepting private donations, you can make a donation to one of the <a href="testimonials.aspx">charities we support</a>.</p>
							<a href="mailto:healthysightforlifefund@transitions.com" class="support" id="lnkEmailUs">E-mail Us</a>
							<h3 id="hDonateResources">Professional Resources</h3>
							<p>Optical industry, health and education professionals can access educational materials to use with patients and students.</p>
							<a href="professional-resources.aspx" class="support" id="lnkGetResources">Get Resources</a>
						</div>
						<div id="pnlAnnualGrants">
							<h2>Annual Charity Grants</h2>
							<p>Substantial yearly grants to qualified global or regional charitable organizations. Proposals are accepted for the following year on a rolling basis until June 30. Grant decisions will be made by Oct. 1. All applicants will be notified of their grant status at that time.</p>
						</div>
						<div id="pnlLocalGrants">
							<h2>Local Community Grants</h2>
							<p>Select one-time grants to benefit local community charities and volunteer efforts. Proposals are accepted and awarded on a rolling basis year-round.</p>
						</div>
						<div id="coRequestGrant">
                        	<p id="pProposalGuidelines">Please carefully read the Proposal Guidelines, Eligibility Requirements and Submission Instructions before submitting your proposals for consideration for either grant category.</p>
							<h2 id="hRequestGrant">Request a Grant</h2>
                            <p>The Transitions<sup>&reg;</sup> Healthy Sight for Life Fund is currently accepting Grant Request Proposals for its Annual Charity Grants and Local Community Grants.</p>
                            <p>Annual Charity Grants are substantial yearly grants to qualified global or regional charitable organizations. Proposals are accepted for the following year on a rolling basis until June 30. Grant decisions will be made by Oct. 1. All applicants will be notified of their grant status at that time.</p>
                            <p>Local Community Grants are select one-time grants to benefit local community charities and volunteer efforts. Proposals are accepted and awarded on a rolling basis year-round.</p>
                            <p id="pGuidelines">Please carefully read the Proposal Guidelines, Eligibility Requirements and Submission Instructions before submitting your proposals for consideration for either grant category.</p>
                        </div>
                        <ul id="ulGrantTabs">
							<li class="ui-tabs-selected"><a href="#pnlGrantGuidelines" id="lnkGrantGuidelines">Proposal Guidelines</a></li>
							<li><a href="#pnlGrantRequirements" id="lnkElegibilityRequirements">Elegibility Requirements</a></li>
							<li><a href="#pnlGrantInstructions" id="lnkGrantInstructions">Submission Instructions</a></li>
							<li><a href="#pnlGrantRequest" id="lnkGrantRequest">Request Form</a></li>
						</ul>
						<div id="pnlGrantGuidelines">
							<ol>
								<li>
									For consideration, all proposals must reflect the Transitions<sup>&reg;</sup> Healthy Sight for Life Fund Mission and support its Guiding Principles as stated below.
									<h3>Help Preserve Healthy Sight for a Lifetime</h3>
									Through the Transitions Healthy Sight for Life Fund, we support, on a global, regional and local basis, charitable organizations whose goal is to help create awareness of the need for eye exams, eye protection and the enhancement of visual quality, and who are striving to help eliminate preventable blindness. With the belief that knowledge empowers people, we provide education on the need for healthy sight and the steps people can take to  achieve it.
								</li>
								<li>All proposals must be earmarked for projects or programs with a defined scope and specific goals. Unspecified grant proposals will not be considered.</li>
								<li>Grants cannot be awarded for capital investments or to solely cover operating or other administrative costs.</li>
								<li>While Transitions Optical does support clinical research in eye health as part of the Transitions Partners in Education program, the Transitions Healthy Sight for Life Fund is not currently accepting proposals for research funding.</li>
								<li>While Transitions Optical does provide support to schools and educators through its Transitions Partners in Education program, the Transitions Healthy Sight for Life Fund is not currently accepting proposals for scholarship funding.</li>
							</ol>
						</div>
						<div id="pnlGrantRequirements" class="ui-tabs-hide">
							<h2>Annual Charity Grant</h2>
							<ul>
								<li>To be eligible for an Annual Charity Grant, you must be a registered non-profit or not-for-profit organization or association of international, national, or regional scope.</li>
								<li>Individuals are not eligible for Annual Charity Grants.</li>
							</ul>
							<h2>Local Community</h2>
							<ul>
								<li>Local Community Grants are open to eyecare professionals and optical laboratories as well as local non-profit, not-for-profit or volunteer groups and associations.</li>
								<li>Individuals are eligible for Local Community Grants.</li>
							</ul> 
						</div>
						<div id="pnlGrantInstructions" class="ui-tabs-hide">
							<h2>Submission Instructions</h2>
							<p>To submit your proposal for an Annual Charity Grant or a Local Community Grant, please fill out the electronic form below. It is important that your submission include all available contact information.</p>
							<p>Please use the space provided under proposal details to describe your specific project proposal. It is not necessary to describe your organization or cause. If you would like to include additional information about your organization or your project, you may attach one additional document to your proposal.</p>
							<p>Once you have submitted your proposal, you will receive an e-mail confirmation of receipt.</p>
							<p>Transitions Optical will respond to all proposals received - please do not call to check on the status.</p>
							<p>Please do not submit more than one proposal simultaneously. You are free to re-submit a proposal or submit a new one if we are unable to fund your original proposal.</p>
							<p>For Local Community Grants, please submit your proposal at a minimum of four weeks prior to the date funding is required. For Annual Charity Grants, please submit your proposal by the June 30 deadline.</p>
						</div>
						<div id="pnlGrantRequest" class="ui-tabs-hide">
							<fieldset>
								<legend><span>Transitions Healthy Sight for Life Fund Grant Request Form</span></legend>
								<ul>
									<li id="liGrantType">
										We are requesting a(n):
										 <!--Add Through Javascript: <span>Note: Applications are due by June 30. Grants will be awarded in October.</span> -->
										<asp:RadioButtonList runat="server" ID="radGrantType">
											<asp:ListItem Selected="true">Annual Charity Grant</asp:ListItem>
											<asp:ListItem>Local Community Grant</asp:ListItem>
										</asp:RadioButtonList>
										<!--Add Through Javascript: <span>Note: Applications are accepted on a rolling basis. All grant requests will be answered before the Date Funding would be required.</span> -->
									</li>
									<li>
										<label id="lblGrantFirstName" for="txtGrantFirstName">*First Name</label>
										<asp:TextBox ID="txtGrantFirstName" TextMode="SingleLine" runat="server" CssClass="text"></asp:TextBox>
									</li>
									<li class="alt">
										<label id="lblGrantLastName" for="txtGrantLastName">*Last Name</label>
										<asp:TextBox ID="txtGrantLastName" TextMode="SingleLine" runat="server" CssClass="text"></asp:TextBox>
									</li>
									<li>
										<label id="lblGrantTitle" for="txtGrantTitle">Title</label>
										<asp:TextBox ID="txtGrantTitle" TextMode="SingleLine" runat="server" CssClass="text"></asp:TextBox>
									</li>
									<li class="alt">
										<label id="lblGrantCompany" for="txtGrantCompany">*Company/Organization</label>
										<asp:TextBox ID="txtGrantCompany" TextMode="SingleLine" runat="server" CssClass="text"></asp:TextBox>
									</li>
									<li>
										<label id="lblGrantPhone" for="txtGrantPhone">*Phone</label>
										<asp:TextBox ID="txtGrantPhone" TextMode="SingleLine" runat="server" CssClass="text"></asp:TextBox>
									</li>
									<li class="alt">
										<label id="lblGrantEmail" for="txtGrantEmail">*Email</label>
										<asp:TextBox ID="txtGrantEmail" TextMode="SingleLine" runat="server" CssClass="text"></asp:TextBox>
									</li>
									<li>
										<label id="lblGrantWebsite" for="txtGrantWebsite">Website</label>
										<asp:TextBox ID="txtGrantWebsite" TextMode="SingleLine" runat="server" CssClass="text"></asp:TextBox>
									</li>
									<li class="alt">
										<label id="lblGrantAddress" for="txtGrantAddress">*Address</label>
										<asp:TextBox ID="txtGrantAddress" TextMode="SingleLine" runat="server" CssClass="text"></asp:TextBox>
									</li>
									<li>
										<label id="lblGrantCity" for="txtGrantCity">*City</label>
										<asp:TextBox ID="txtGrantCity" TextMode="SingleLine" runat="server" CssClass="text"></asp:TextBox>
									</li>
									<li class="alt">
										<label id="lblGrantState" for="txtGrantState">*State</label>
										<asp:TextBox ID="txtGrantState" TextMode="SingleLine" runat="server" CssClass="text"></asp:TextBox>
									</li>
									<li>
										<label id="lblGrantZip" for="txtGrantZip">*Zip or Postal Code</label>
										<asp:TextBox ID="txtGrantZip" TextMode="SingleLine" runat="server" CssClass="text"></asp:TextBox>
									</li>
									<li class="alt">
										<label id="lblGrantCountry" for="txtGrantCountry">*Country</label>
										<asp:TextBox ID="txtGrantCountry" TextMode="SingleLine" runat="server" CssClass="text"></asp:TextBox>
									</li>
									<li id="liNP">
										Organization Non-Profit Status:
										<asp:RadioButtonList runat="server" ID="radOrgStatus">
											<asp:ListItem>Non-Profit</asp:ListItem>
											<asp:ListItem>Individual Volunteer</asp:ListItem>
											<asp:ListItem>Association</asp:ListItem>
											<asp:ListItem>Academic</asp:ListItem>
										 </asp:RadioButtonList>
									</li>
									<li class="alt">
										<label id="lblGrantDescription" for="txtGrantDescription">*Description of Program or Project <span>(250 Words Maximum)</span></label>
										<asp:TextBox ID="txtGrantDescription" TextMode="MultiLine" Rows="10" Columns="40" runat="server" CssClass="text"></asp:TextBox>
									</li>
									<li>
										<label id="lblDateRequired" for="txtDateRequired">*Date Funding Would Be Required</label>
										<asp:TextBox ID="txtDateRequired" TextMode="SingleLine" runat="server" CssClass="text"></asp:TextBox>
									</li>
									<li class="alt">
										<label id="lblGrantRequired" for="txtGrantRequired">*Estimated Fund Required</label>
										<asp:TextBox ID="txtGrantRequired" TextMode="SingleLine" runat="server" CssClass="text"></asp:TextBox>
									</li>
									<li>
										<label id="lblAdditionalInfo" for="uplAdditionalInfo">Additional Information <span>(Submit attached in PDF or Word format)</span></label>
										
									</li>
									<li class="submit">
										<asp:ImageButton ID="btnGrant" runat="server" ImageUrl="images/bigSubmitBtn.jpg" validationgroup="request" CausesValidation="true" OnClick="btnGrant_Click"></asp:ImageButton>
									</li>
								</ul>
								<div class="pnlErrors">
									<asp:RequiredFieldValidator ID="reqGrantFirstName" CssClass="req" runat="server" validationgroup="request" ControlToValidate="txtGrantFirstName">Please enter your name.</asp:RequiredFieldValidator>
									<asp:RequiredFieldValidator ID="reqGrantLastName" CssClass="req" runat="server" validationgroup="request" ControlToValidate="txtGrantLastName">Please enter your name.</asp:RequiredFieldValidator>
									<asp:RequiredFieldValidator ID="reqGrantCompany" runat="server" CssClass="req" validationgroup="request" ControlToValidate="txtGrantCompany">Please enter your company or organization's name.</asp:RequiredFieldValidator>
									<asp:RequiredFieldValidator ID="reqGrantPhone" runat="server" CssClass="req" validationgroup="request" ControlToValidate="txtGrantPhone">Please enter your phone number.</asp:RequiredFieldValidator>
									<asp:RequiredFieldValidator ID="reqGrantEmail" runat="server" CssClass="req" validationgroup="request" ControlToValidate="txtGrantEmail">Please enter a valid email address.</asp:RequiredFieldValidator>
									<asp:RegularExpressionValidator ID="regGrantEmail" runat="server" CssClass="req" validationgroup="request" ControlToValidate="txtGrantEmail" ValidationExpression=".*@.*\..*">Please enter a valid email address.</asp:RegularExpressionValidator>
									<asp:RequiredFieldValidator ID="reqGrantAddress" runat="server" CssClass="req" validationgroup="request" ControlToValidate="txtGrantAddress">Please enter your address.</asp:RequiredFieldValidator>
									<asp:RequiredFieldValidator ID="reqGrantCity" runat="server" CssClass="req" validationgroup="request" ControlToValidate="txtGrantCity">Please enter your city.</asp:RequiredFieldValidator>
									<asp:RequiredFieldValidator ID="reqGrantState" runat="server" CssClass="req" validationgroup="request" ControlToValidate="txtGrantState">Please enter your state.</asp:RequiredFieldValidator>
									<asp:RequiredFieldValidator ID="reqGrantZip" runat="server" CssClass="req" validationgroup="request" ControlToValidate="txtGrantZip">Please enter your zip or postal code.</asp:RequiredFieldValidator>
									<asp:RequiredFieldValidator ID="reqGrantCountry" CssClass="req" runat="server" validationgroup="request" ControlToValidate="txtGrantCountry">Please enter your country.</asp:RequiredFieldValidator>
									<asp:RequiredFieldValidator ID="reqGrantDescription" CssClass="req" runat="server" validationgroup="request" ControlToValidate="txtGrantDescription">Please enter a description.</asp:RequiredFieldValidator>
									<asp:RequiredFieldValidator ID="reqDateRequired" CssClass="req" runat="server" validationgroup="request" ControlToValidate="txtDateRequired">Please enter a date.</asp:RequiredFieldValidator>
									<asp:RequiredFieldValidator ID="reqGrantRequired" CssClass="req" runat="server" validationgroup="request" ControlToValidate="txtGrantRequired">Please enter a dollar amount.</asp:RequiredFieldValidator>
								</div>
								<asp:Panel ID="pnlRequestConfirm" runat="server" Visible="false">Success!</asp:Panel>
								<asp:Panel ID="pnlRequestFail" runat="server" Visible="false">Fail!</asp:Panel>
							</fieldset>
						</div>
					</form>
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
	</body>
</html>