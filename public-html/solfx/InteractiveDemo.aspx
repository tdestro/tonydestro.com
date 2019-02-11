<%@ Page Language="VB" ContentType="text/html" ResponseEncoding="UTF-8" Debug="True" %>
<%@ Import Namespace="System.Web.Mail" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Security.Principal" %>
<%@ Import Namespace="System.Security.Permissions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>SolFX // Interactive Demo</title>
        <meta name="description" content="Try out SolFX sunglass lenses in our Interactive Demonstration by choosing an option that best represents who you are" />
        <meta name="keywords" content="SolFX, interactive demo, trial, representation, demonstration, sunglasses" />
		<!--#include file="_incl/css-js.aspx"-->
	</head>
	<body class="TryThemOut">
	<!--#include file="_incl/GlobalHeader.aspx"-->
	<div id="wrapper">
	<div id="ajaxContainer">
		<div id="content" class="interactiveDemo">
			<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,28,0" width="960" height="485" title="SolFX Demo">
				<param name="movie" value="Flash/Sunglasses_Shell.swf" />
				<param name="quality" value="high" />
				<param name="wmode" value="opaque" />
				<embed src="Flash/Sunglasses_Shell.swf" quality="high" wmode="opaque" pluginspage="http://www.adobe.com/shockwave/download/download.cgi?P1_Prod_Version=ShockwaveFlash" type="application/x-shockwave-flash" width="960" height="485"></embed>
			</object>
		</div>
	</div>
	<!--#include file="_incl/GlobalCategoryNavigation.aspx"-->
	<div id="pre-footer"></div>
	<!--#include file="_incl/GlobalFooter.aspx"-->