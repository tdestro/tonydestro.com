<%@ Page Language="VB" ContentType="text/html" ResponseEncoding="UTF-8" Debug="True" %>
<%@ Import Namespace="System.Web.Mail" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Security.Principal" %>
<%@ Import Namespace="System.Security.Permissions" %>
<!--#include file="_incl/baseURL.aspx"-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>SolFX // What is Drivewear?</title>
        <meta name="description" content="Inquiry thank you page" />
        <meta name="keywords" content="" />
        <meta name="robots" content="NOINDEX, NOFOLLOW" />
		<!--#include file="_incl/css-js.aspx"-->
        <asp:literal id="litFB" runat="server"></asp:literal>
        <asp:literal id="litRSS" runat="server"></asp:literal>
        <!-- litFB and litRSS Literals require baseURL.aspx -->
	</head>
	<body class="WhatisDrivewear">
	<!--#include file="_incl/GlobalHeader.aspx"-->
	<div id="wrapper">
	<div id="ajaxContainer">
       <div id="content" class="WhatIsDw">
       		<div id="drivewearNav">
				<ul>
        			<li><a href="Drivewear.aspx" title="Drivewear" class="first">Drivewear</a></li>
					<li><a href="DrivewearWhatis.aspx" title="What is Drivewear" class="active">What is Drivewear?</a></li>
					<li><a href="DrivewearTestimonials.aspx" title="Drivewear Testimonials" class="last">Testimonials</a></li>
				</ul>
                <div id="navArrows">
                	<a id="dwnPrev" href="Drivewear.aspx" title="Drivewear">Previous page</a>
                	<a id="dwnNext" href="DrivewearTestimonials.aspx" title="Drivewear Testimonials">Next Page</a>
                </div>
        	</div>
            <div id="aboutDrivewear">
            	<div id="WeatherIcons">
                    <a href="#" id="overcast">Overcast - High Contrast Green/Yellow Color</a>
                    <a href="#" id="sunny">Sunny - Behind the Windshield Daylight/Driving Conditions</a>
                    <a href="#" id="bright">Bright - Bright Light / Outside Conditions</a>
                </div>
                <div class="header">
                <h1>What is Drivewear</h1>
                <p>Drivewear is sunwear that is dynamic, not static.  In virtually every daylight driving situation, Drivewear<sup>&reg;</sup> Transitions<sup>&reg;</sup> <strong>SOL</strong>FX<sup>TM</sup> lenses provide optimal visual comfort and performance.</p>
				<ul>
                	<li><strong>In low light</strong>, such as overcast conditions, the lenses are a green/yellow color to provide high contrast, minimize glare and maximize useful light information reaching the eye.</li>
                    <li><strong>Behind the windshield of a car</strong>, the lenses change to a copper color, which reduces glare and excess visual light and provides good traffic signal recognition. </li>
                    <li><strong>In outdoor, bright-light conditions</strong>, they become a dark reddish-brown color to provide maximum comfort in bright light conditions by filtering excess light.</li>
                </ul>                
                <p>Like all Transitions products, Drivewear lenses<br/>
                 block 100 percent of UVA/UVB rays, <br/>
                 and help protect from <br/>
                 vision-impairing glare.</p>
    			</div>
            </div>
            <div id="Applications">
           		<div id="technologyPnl">
                	<h2>Technology</h2>
                    <p><strong>Leading technology.</strong> Our tech-savvy fans appreciate the advanced technology we’ve used to provide drivers with state-of-the-art lenses.  Drivewear lenses uniquely combine cutting-edge photochromics and polarization to enhance contrast, traffic signal recognition and depth perception.</p>
                    <a href="http://www.Drivewearlens.com">Learn More at Drivewearlens.com</a>
                </div>
                <div id="performancePnl">
                	<h2>Performance</h2>
                     <p><strong>Versatility is key.</strong>  Just as driving conditions change rapidly, Drivewear lenses do too. As the sun comes out, or the rain pours down, Drivewear shifts seamlessly to provide unrivaled performance. </p>
                     <a href="http://www.Drivewearlens.com">Learn More at Drivewearlens.com</a>
                </div>
                <div id="stylePnl">
                	<h2>Style</h2>
                     <p><strong>You'll always look good.</strong>  No more hurried switches or sunglasses being pushed to the top of your head as the weather changes.  Drivewear keeps you looking smooth and collected as you cruise.</p>
                     <a href="http://www.Drivewearlens.com">Learn More at Drivewearlens.com</a>
                </div>
            </div>
			<div id="WhereToBox">
            	<h2>Where to get them</h2>
                <p>Purchase Drivewear<sup>&reg;</sup> Transitions<sup>&reg;</sup> <strong>SOL</strong>FX<sup>TM</sup> - find an eyecare professional near you.</p>
                <a href="http://www.drivewearlens.com/find_ecp.php" title="Find ECP" target="_blank">I want these lenses</a>
            </div>
            <div id="HowTheyWork">
            	<h2>How They Work</h2>
            	<p>Drivewear<sup>&reg;</sup> Transitions<sup>&reg;</sup> <strong>SOL</strong>FX<sup>TM</sup> lenses uniquely combine two of the most advanced technologies found in the eyeglass industry today: NuPolar<sup>&reg;</sup> polarization and Transitions photochromic technology.  The NuPolar<sup>&reg;</sup> technology helps eliminate blinding glare, such as sunlight reflected off the road or car hood.  The photochromic technology allows the lenses to automatically adjust color, providing visual comfort and reduced glare while behind the wheel.</p>
            </div>
        </div>
	</div>
	<!--#include file="_incl/GlobalCategoryNavigation.aspx"-->
	<div id="pre-footer"></div>
	<!--#include file="_incl/GlobalFooter.aspx"-->