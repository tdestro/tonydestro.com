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
		<title>SolFX // Shield - Power Sports Performance</title>
        <meta name="description" content="Inquiry thank you page" />
        <meta name="keywords" content="" />
        <meta name="robots" content="NOINDEX, NOFOLLOW" />
		<!--#include file="_incl/css-js.aspx"-->
        <asp:literal id="litFB" runat="server"></asp:literal>
        <asp:literal id="litRSS" runat="server"></asp:literal>
        <!-- litFB and litRSS Literals require baseURL.aspx -->
	</head>
	<body class="Shield">
	<!--#include file="_incl/GlobalHeader.aspx"-->
	<div id="wrapper">
	<div id="ajaxContainer">
       <div id="content" class="shieldMain">
       		<div id="drivewearNav">
				<ul>
        			<li><a href="shield.aspx" title="Shield" class="first">Shield Tech</a></li>
					<li><a href="shieldDemo.aspx" title="Shield Demo">Visor Demo</a></li>
				</ul>
        	</div>
            <div class="header">
                <h1>Power Sports Performance</h1>
                <p>When tackling hairpin turns, managing heavy traffic or just riding for pleasure, vision is absolutely critical.  Enhancing your visual performance can help you take your riding experience to the ultimate level.
                </p>
                <p>SHIELD Tech<sup>TM</sup> Transitions&reg; SOLFX<sup>TM</sup> visors help you do just that by helping to optimize vision in sun and shade, day and night.  Unlike traditional clear or tinted visors, which are static, these visors automatically adjust their level of darkness depending on changing outdoor light conditions. 
                </p>
                <p>You don't always know what you will experience around the next curve. No need to carry extra visors and no need to spend time struggling to change them – it's time to enjoy the freedom of the open road with visors that adjust for you and enhance your ride.
                </p>
                <div class="shieldDemoLink"><a href="InteractiveDemo.aspx" title="Shield Demo">S.H.I.E.L.D. Lens Product Demo</a><a href="Akuma.aspx" class="akumaLink" title="Akuma" style="display:none;">Visit Akuma</a></div>
            </div>
            <div id="shieldSideLink">
            	<a href="BeInTheKnow.aspx?comment=shield" title="Shield Website">S.H.I.E.L.D. Tech</a>
            </div>
            <div id="akWeather">
            	<div class="pnl" id="dark">
                <h2>Dark</h2>
                <p>Bright sun and glare can potentially obscure vision.  SHIELD Tech Transitions SOLFX visors seamlessly darken when you need it the most. </p>
                </div>
                <div class="pnl" id="mid">
                <h2>Mid</h2>
                <p>Light can change quickly and so do SHIELD Tech Transitions SOLFX visors, providing the right level of tint for the condition you're in now and down the road.</p>
                </div>
                <div class="pnl" id="clear">
                <h2>Clear</h2>
                <p>SHIELD Tech Transitions SOLFX visors are clear when traveling at night or in the low-light conditions you may experience while riding through wooded areas, forests and at dawn or dusk.</p>
                </div>
            </div>
        </div>
	</div>
	<!--#include file="_incl/GlobalCategoryNavigation.aspx"-->
	<div id="pre-footer"></div>
	<!--#include file="_incl/GlobalFooter.aspx"-->