<%@ Page Language="C#" ContentType="text/html" ResponseEncoding="UTF-8" Debug="True" CodeFile="ECPsimpler.cs" Inherits="ECPsimpler" %>
<%@ Import Namespace="System.Web.Mail" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Security.Principal" %>
<%@ Import Namespace="System.Security.Permissions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>SolFX // Drivewear</title>
        <meta name="description" content="Inquiry thank you page" />
        <meta name="keywords" content="" />
        <meta name="robots" content="NOINDEX, NOFOLLOW" />
		<!--#include file="_incl/css-js.aspx"-->
	</head>
	<body class="Drivewear">
	<!--#include file="_incl/GlobalHeader.aspx"-->
	<div id="wrapper">
	<div id="ajaxContainer">
       <div id="content" class="drivewear">
       		<div id="drivewearNav">
				<ul>
        			<li><a href="Drivewear.aspx" title="Drivewear" class="first active">Drivewear</a></li>
					<li><a href="DrivewearWhatis.aspx" title="What is Drivewear">What is Drivewear?</a></li>
					<li><a href="DrivewearTestimonials.aspx" title="Drivewear Testimonials">Testimonials</a></li>
				</ul>
                <div id="navArrows">
                	<a id="dwnPrev" href="DrivewearTestimonials.aspx" title="Drivewear Testimonials">Previous page</a>
                	<a id="dwnNext" href="DrivewearWhatis.aspx" title="What is Drivewear">Next Page</a>
                </div>
        	</div>
            <h1>King Road</h1>
            <p>Driving conditions can change in the blink of an eye – literally.  When you need them to, Drivewear<sup>&reg;</sup> Transitions<sup>&reg;</sup> <strong>SOL</strong>FX<sup>&trade;</sup> lenses will help to provide enhanced visual performance and a more enjoyable driving experience as you take on the open road.  These polarized lenses self adjust with changing light conditions, helping to enhance visual performance and the driving experience by automatically changing their degree of darkness and color.</p>
			<p>Driving is a part of life.  If you are a commuter, parent or driving enthusiast, you probably spend hours each day in the car.  In fact, we spend more than 10% of our waking hours behind the wheel.  While eyewear may not be able to take all of the stress out of driving, it can make that time comfortable and enjoyable.</p>
			<img src="images/youngLogo.png" id="imgYoung" alt="Younger Optics" />
           	<div class="panels">
                <div id="DWpnlDemo" class="DWpanel"><a href="DrivewearDemo.aspx" title="Drivewear Demo">See for yourself. Product Demo</a></div>
                <div id="DWpnlWhereto" class="DWpanel">
                    <h2>Where to Get Them</h2>
                    <p>Drivewear<sup>&reg;</sup> Transitions<sup>&reg;</sup> <strong>SOL</strong>FX<sup>&trade;</sup> lenses from Younger Optics, are available through your eyecare professional.</p>
                   <!-- <form id="ecpFinder" runat="server">
                      <fieldset>
                        <legend>Find ECP</legend>
                        <asp:Label ID="lbl_txtZip" runat="server" AssociatedControlID="txtZip">Zip Code</asp:Label>
						<asp:Literal ID="error1Literal" runat="server"></asp:Literal><asp:TextBox ID="txtZip" TextMode="SingleLine" runat="server" CssClass="text" Text="ZIP CODE" MaxLength="15"></asp:TextBox></div>
                        <asp:Label ID="lbl_txtDistance" runat="server" AssociatedControlID="txtDistance">Distance</asp:Label>
                        <asp:Literal ID="error2Literal" runat="server"></asp:Literal><asp:DropDownList ID="txtDistance" runat="server">
                        	<asp:ListItem Selected Value="">DISTANCE</asp:ListItem>
                        	<asp:ListItem Value="2">2 miles</asp:ListItem>
                            <asp:ListItem Value="5">5 miles</asp:ListItem>
                            <asp:ListItem Value="10">10 miles</asp:ListItem>
                            <asp:ListItem Value="25">25 miles</asp:ListItem>
                            <asp:ListItem Value="50">50 miles</asp:ListItem>
                        </asp:DropDownList></div>
                        <span class="hide">
                            <asp:Literal ID="error3Literal" runat="server"></asp:Literal>
                            <asp:Literal ID="error4Literal" runat="server"></asp:Literal>
                            <asp:Literal ID="txtCity" Text="" runat="server"></asp:Literal>
                            <asp:Literal ID="txtState" Text="" runat="server"></asp:Literal>
                        </span>
                        
                        <asp:ImageButton ID="SearchButton" runat="server" ImageUrl="images/searchBtn.jpg" AlternateText="Search" OnClick="DriveButtonClick"></asp:ImageButton>
                      </fieldset>
                    </form>-->
                    <a href="http://www.drivewearlens.com/find_ecp.php" id="SearchButton" target="_blank">Search</a>
                </div>
				<div id="pnlGetWidget"><a href="DrivewearWidget.aspx" id="lnkGetWidget">Get the Widget</a></div>
                <!--<a id="DWpnlWidget" href="DrivewearWidget.aspx" title="Drivewear Widget" class="DWpanel">Get The Drivewear Widget</a>-->
       		</div>
        </div>
	</div>
	<!--#include file="_incl/GlobalCategoryNavigation.aspx"-->
	<div id="pre-footer"></div>
	<!--#include file="_incl/GlobalFooter.aspx"-->