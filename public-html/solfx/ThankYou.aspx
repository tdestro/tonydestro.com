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
		<title>SolFX // Thank you for your inquiry</title>
        <meta name="description" content="Inquiry thank you page" />
        <meta name="keywords" content="" />
        <meta name="robots" content="NOINDEX, NOFOLLOW" />
		<!--#include file="_incl/css-js.aspx"-->
        <asp:literal id="litFB" runat="server"></asp:literal>
        <asp:literal id="litRSS" runat="server"></asp:literal>
        <!-- litFB and litRSS Literals require baseURL.aspx -->
	</head>
	<body>
	<!--#include file="_incl/GlobalHeader.aspx"-->
	<div id="wrapper">
	<div id="ajaxContainer">
       <div id="content" class="thankyou">
            <h2>Be In the know</h2>
                <h3>Thank you for submitting your inquiry.</h3>
                <script type="text/javascript">
				//-- Set timer to send user from Thank You to Homepage
				runTimer(hash);
				</script>
                <a href="default.aspx" style="display:none;" title="Transitions SolFX" id="goHome">Transitions</a>
        </div>
	</div>
	<!--#include file="_incl/GlobalCategoryNavigation.aspx"-->
	<div id="pre-footer"></div>
	<!--#include file="_incl/GlobalFooter.aspx"-->