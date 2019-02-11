<%@ Import Namespace="System.Web.VirtualPathUtility" %>
<script runat="server" language="vb">
	Sub Page_Load()
		Dim pathstring As String = Context.Request.FilePath.ToString()
		dim domain as string = Request.ServerVariables("SERVER_NAME")
		dim Port as string = Request.ServerVariables("SERVER_PORT")
		If  Port = "80" then
			Port = ""
		elseif Port = "443" then
			Port = ""
		else
			Port = ":" + Port
		end If
		
		Dim baseUrl As String = "http://" & domain & Port & VirtualPathUtility.GetDirectory(pathstring).ToString()
		litFB.Text = "<link rel='image_src' href='" & baseUrl & "images/thumbFacebook.jpg' />"
		litRSS.Text = "<link rel='alternate' type='application/rss+xml' title='Transitions SolFX News Feed' href='" & baseUrl & "rss.xml' />"
	End Sub
</script>