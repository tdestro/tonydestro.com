<%@ Page Language="C#" ContentType="text/html" Src="./BeInTheKnow.cs" ResponseEncoding="UTF-8" Debug="False" Inherits="inquiryEvent" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>SolFX // Be In The Know</title>
		<meta name="description" content="Be In the Know with SolFX. Sign-up to find out all the happenings, events and breaking news" />
		<meta name="keywords" content="contact us, contact, solfx, sunglasses, inquire" />
		<!--#include file="_incl/css-js.aspx"-->
	</head>
	<body class="BeInTheKnow">
	<!--#include file="_incl/GlobalHeader.aspx"-->
	<div id="wrapper">
	<div id="ajaxContainer">
		<div id="content" class="protection">
			<h2>Be In the know</h2>
			<form id="know" runat="server" onsubmit="javascript:return WebForm_OnSubmit(this);">
				<fieldset>
					<legend></legend>
					<div id="formBox">
						<span id="errors"></span>
						<ul>
							<li>
								<label id="lblName" for="txtName">Name*</label>
								<asp:TextBox ID="txtName" TextMode="SingleLine" runat="server" CssClass="text"></asp:TextBox>
							</li>
							<li >
								<label id="lblEmail" for="txtEmail">Email*</label>
								<asp:TextBox ID="txtEmail" TextMode="SingleLine" runat="server" CssClass="text"></asp:TextBox>
							</li>
							<li>
								<label id="lblCompany" for="txtCompany">Company*</label>
								<asp:TextBox ID="txtCompany" TextMode="SingleLine" runat="server" CssClass="text"></asp:TextBox>
							</li>
							<li class="half">
								<label id="lblStreet" for="txtStreet">Street*</label>
								<asp:TextBox ID="txtStreet" TextMode="SingleLine" runat="server" CssClass="text"></asp:TextBox>
							</li>
							<li id="SA" class="half">
								<label id="lblState" for="txtState">State*</label>
								<asp:TextBox ID="txtState" TextMode="SingleLine" runat="server" CssClass="text"></asp:TextBox>
							</li>
							<li>
								<label id="lblCity" for="txtCity">City*</label>
								<asp:TextBox ID="txtCity" TextMode="SingleLine" runat="server" CssClass="text"></asp:TextBox>
							</li>
							<li>
								<label id="lblZip" for="txtZip">Zip Code*</label>
								<asp:TextBox ID="txtZip" TextMode="SingleLine" runat="server" CssClass="text"></asp:TextBox>
							</li>
							<li>
								<label id="lblComments" for="txtComments">Comments / Questions</label>
								<asp:TextBox ID="txtComments" TextMode="MultiLine" Rows="10" Columns="40" runat="server" CssClass="text"></asp:TextBox>
							</li>
							<li><asp:ImageButton ID="SubmitForm" runat="server" ImageUrl="images/form_submit.jpg" OnClick="Save_Comment"></asp:ImageButton></li>
						</ul>
					</div>
					<div id="sideBox">
						<h3>select which best applies to you:</h3>
						<asp:RadioButtonList runat="server" ID="interest">
							<asp:ListItem Selected="true" Value="wearing">I am interested in wearing Transitions SOLFX sunwear</asp:ListItem>
							<asp:ListItem Value="selling">I am interested in selling Transitions SOLFX sunwear</asp:ListItem>
							<asp:ListItem Value="media">I am with the media</asp:ListItem>
						</asp:RadioButtonList>
					</div>
				</fieldset>
			</form>
		</div>
	</div>
	<!--#include file="_incl/GlobalCategoryNavigation.aspx"-->
	<div id="pre-footer"></div>
	<!--#include file="_incl/GlobalFooter.aspx"-->