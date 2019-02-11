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
		<title>SolFX // Drivewear - Get the Widget</title>
		<meta name="description" content="Get the Widget." />
		<meta name="keywords" content="" />
		<meta name="robots" content="NOINDEX, NOFOLLOW" />
		<!--#include file="_incl/widget-css-js.aspx"-->
		<asp:Literal ID="litFB" runat="server"></asp:Literal>
		<asp:Literal ID="litRSS" runat="server"></asp:Literal>
		<!-- litFB and litRSS Literals require baseURL.aspx -->
	</head>
	<body class="DrivewearWidget">
	<!--#include file="_incl/GlobalHeader.aspx"-->
	<div id="wrapper">
		<div id="ajaxContainer">
			<div id="content" class="WidgeAd">
				<div id="drivewearNav">
					<ul>
						<li><a href="Drivewear.aspx" title="Drivewear" class="first">Drivewear</a></li>
						<li><a href="DrivewearWhatis.aspx" title="What is Drivewear">What is Drivewear?</a></li>
						<li><a href="DrivewearTestimonials.aspx" title="Drivewear Testimonials">Testimonials</a></li>
						<!--<li><a href="DrivewearWhereto.aspx" title="Where to Get Drivewear" class="last">Find an Eyecare Professional</a></li>-->
					</ul>
				</div>
				<h1>Drivewear Widget</h1>
				<p>If you are like us, then you think these lenses are pretty cool.  Know someone who drives?  They would probably like to know about Drivewear<sup>&reg;</sup> Transitions<sup>&reg;</sup> SOLFX<sup>TM</sup> lenses. </p>
				<p>Share the Drivewear experience – you might make the road a better place for all of us.</p>
				<!--
					* Social Bookmark Script
					* @ Version 2.1
					* @ Copyright (C) 2006-2008 by Alexander Hadj Hassine - All rights reserved
					* @ Website http://www.social-bookmark-script.de/
				-->
				<ul id="ulShareLinks">
					<li><a rel="nofollow" id="dwFacebook" href="http://www.facebook.com/" onClick="window.open('http://www.facebook.com/sharer.php?u='+encodeURIComponent(location.href)+'&amp;t='+encodeURIComponent(document.title));return false;" title="Bookmark to: Facebook">Add to Facebook</a></li>
					<li><a rel="nofollow" style="text-decoration:none;" href="http://www.google.com/" onClick="window.open('http://www.google.com/bookmarks/mark?op=add&amp;hl=en&amp;bkmk='+encodeURIComponent(location.href)+'&amp;annotation=&amp;labels=&amp;title='+encodeURIComponent(document.title));return false;" title="Bookmark to: Google" id="dwGoogle">Add to Google Homepage</a></li>
					<li><a href="#" id="dwMyspace">Add to Myspace or Personal Blog</a></li>
					<!--<li><a href="#" id="dwEmail">Email</a></li>-->
				</ul>
				<div id="pnlEmbedWidget" style="display: none;">
					<a href="#" id="lnkCloseCode">Close</a>
					<textarea cols="40" rows="10">&lt;object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://..../swflash.cab#version=9,0,0,0" width="300" height="250"&gt;
						&lt;param name="movie" value="http://drivewear.widge-ad.com/drivewearwidgieadSolfxWeb.swf" /&gt;
						&lt;param name=quality value=high /&gt;
						&lt;embed src="http://drivewear.widge-ad.com/drivewearwidgieadSolfxWeb.swf" quality=high pluginspage="http://..../index.cgi?P1_Prod_Version=ShockwaveFlash" type="application/x-shockwave-flash" width="300" height="250"&gt;
						&lt;/embed&gt;
						&lt;/object&gt;
					</textarea>
				</div>
			</div>
		</div>
		<!--#include file="_incl/GlobalCategoryNavigation.aspx"-->
		<div id="pre-footer"></div>
		<!--#include file="_incl/GlobalFooter.aspx"-->