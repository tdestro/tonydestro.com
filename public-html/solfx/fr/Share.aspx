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
		<title>SolFX // Passez Le Mot</title>
        <meta name="description" content="Inquire with Transitions to find our where you can get SolFX sunwear, sunglasses" />
        <meta name="keywords" content="contact us, contact, solfx, sunglasses, inquire" />
		<!--#include file="_incl/css-js.aspx"-->
        <asp:literal id="litFB" runat="server"></asp:literal>
        <asp:literal id="litRSS" runat="server"></asp:literal>
        <!-- litFB and litRSS Literals require baseURL.aspx -->
	</head>
	<body class="Share">
	<!--#include file="_incl/GlobalHeader.aspx"-->
    <div id="wrapper">
	<div id="ajaxContainer">
		<div id="content" class="spreadTheWord">
			<h2>Passez Le Mot</h2>
			<ul>
				<li id="liFacebook"><a onClick="window.open('http://www.facebook.com/sharer.php?u='+encodeURIComponent(location.href)+'&amp;t='+encodeURIComponent(document.title));return false;" href="http://www.facebook.com/" rel="nofollow">Facebook</a></li>
				<!--<li id="liTechnorati"><a onClick="window.open('http://technorati.com/faves?add='+encodeURIComponent(location.href)+'&tag=');return false;" href="http://www.technorati.com/" rel="nofollow">Technorati</a></li>
				<li id="liDigg"><a onClick="window.open('http://digg.com/submit?phase=2&url='+encodeURIComponent(location.href)+'&bodytext=&tags=&title='+encodeURIComponent(document.title));return false;" href="http://digg.com/" rel="nofollow">Digg</a></li>
				<li id="liDelicious"><a onClick="window.open('http://del.icio.us/post?v=2&url='+encodeURIComponent(location.href)+'&notes=&tags=&title='+encodeURIComponent(document.title));return false;" href="http://del.icio.us/" rel="nofollow">Delicious</a></li>-->
			</ul>
		</div>
	</div>
    <!--#include file="_incl/GlobalCategoryNavigation.aspx"-->
	<!--#include file="_incl/GlobalFooter.aspx"-->