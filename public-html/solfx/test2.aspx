<%@ Page Language="VB" ContentType="text/html" ResponseEncoding="UTF-8" %>
<%@ Import Namespace="System.Web.VirtualPathUtility" %>
<script runat="server">
	Sub Page_Load()
		Dim pathstring As String = Context.Request.FilePath.ToString()
		dim Domain as string = Request.ServerVariables("SERVER_NAME")
		dim Port as string = Request.ServerVariables("SERVER_PORT")
		If  Port = "80" then
			Port = ""
		elseif Port = "443" then
			Port = ""
		else
			Port = ":" + Port
		end If
		
		Dim baseUrl As String = "http://" & Domain & Port & VirtualPathUtility.GetDirectory(pathstring).ToString()
		litFB.Text = "<link rel='image_src' href='" & baseUrl & "images/thumbFacebook.jpg' />"
		litRSS.Text = "<link rel='alternate' type='application/rss+xml' title='Transitions SolFX News Feed' href='" & baseUrl & "rss.xml' />"
	End Sub
</script>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>Untitled Document</title>
		<asp:literal id="litFB" runat="server"></asp:literal>
        <asp:literal id="litRSS" runat="server"></asp:literal>
	</head>
	<body>
	</body>
</html>