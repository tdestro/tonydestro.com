<%@ Page Language="VB" ContentType="text/html" ResponseEncoding="UTF-8" Debug="True" %>
<%@ Import Namespace="System.Web.Mail" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Security.Principal" %>
<%@ Import Namespace="System.Security.Permissions" %>
<script runat="server">
	Sub Page_Load(ByVal Sender as Object, ByVal E as EventArgs)
		Dim fbUrl As String
		fbUrl = Request.ServerVariables("SERVER_NAME") & "/images/thumbFacebook.jpg"
	End Sub
</script>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>SolFX // Share Transitions Sunwear with Your Favorite Networks</title>
        <meta name="description" content="Share Transitions Sunwear with Your Favorite Networks. Technorati, Facebook, MySpace, etc..." />
        <meta name="keywords" content="Sunwear, sunglasses, solfx, share, technorati, facebook" />
		<!--#include file="_incl/css-js.aspx"-->
	</head>
	<body>
	<!--#include file="_incl/GlobalHeader.aspx"-->
	<div id="wrapper">
	<div id="ajaxContainer">
		<div id="content" class="spreadTheWord">
			<h2>Spread the Word</h2>
			<ul>
				<li id="liFacebook"><a rel="nofollow" href="http://www.facebook.com/" onclick="window.open('http://www.facebook.com/sharer.php?u='+encodeURIComponent(location.href)+'&amp;t='+encodeURIComponent(document.title));return false;">Facebook</a></li>
				<li id="liTechnorati"><a rel="nofollow" href="http://www.technorati.com/" onclick="window.open('http://technorati.com/faves?add='+encodeURIComponent(location.href)+'&amp;tag=');return false;">Technorati</a></li>
				<li id="liDigg"><a rel="nofollow" href="http://digg.com/" onclick="window.open('http://digg.com/submit?phase=2&amp;url='+encodeURIComponent(location.href)+'&amp;bodytext=&amp;tags=&amp;title='+encodeURIComponent(document.title));return false;">Digg</a></li>
				<li id="liDelicious"><a rel="nofollow" href="http://del.icio.us/" onclick="window.open('http://del.icio.us/post?v=2&amp;url='+encodeURIComponent(location.href)+'&amp;notes=&amp;tags=&amp;title='+encodeURIComponent(document.title));return false;">Delicious</a></li>
			</ul>
		</div>
	</div>
	<!--#include file="_incl/GlobalCategoryNavigation.aspx"-->
	<!--#include file="_incl/GlobalFooter.aspx"-->