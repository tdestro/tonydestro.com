<%@ Page Language="VB" ContentType="text/html" ResponseEncoding="UTF-8" Debug="True" %>
<%@ Import Namespace="System.Web.Mail" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Security.Principal" %>
<%@ Import Namespace="System.Security.Permissions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>SolFX // Shield Demo</title>
        <meta name="description" content="Inquiry thank you page" />
        <meta name="keywords" content="" />
        <meta name="robots" content="NOINDEX, NOFOLLOW" />
		<!--#include file="_incl/css-js.aspx"-->
	</head>
	<body class="ShieldDemo">
	<!--#include file="_incl/GlobalHeader.aspx"-->
	<div id="wrapper">
	<div id="ajaxContainer">
       <div id="content" class="shieldProductDemo">
       		<div id="drivewearNav">
				<ul>
        			<li><a href="shield.aspx" title="Shield" class="first">Shield Tech</a></li>
					<li><a href="shieldDemo.aspx" title="Shield Demo">Visor Demo</a></li>
				</ul>
        	</div>
            <div id="demoArea">
                <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,28,0" width="960" height="485" title="Drivewear Demo">
                    <param name="movie" value="Flash/akumaStandalone.swf" />
                    <param name="quality" value="high" />
                    <param name="wmode" value="transparent" />
                    <embed src="Flash/akumaStandalone.swf" quality="high" wmode="transparent" pluginspage="http://www.adobe.com/shockwave/download/download.cgi?P1_Prod_Version=ShockwaveFlash" type="application/x-shockwave-flash" width="960" height="485"></embed>
                </object>
            </div>
        </div>
	</div>
	<!--#include file="_incl/GlobalCategoryNavigation.aspx"-->
	<div id="pre-footer"></div>
	<!--#include file="_incl/GlobalFooter.aspx"-->