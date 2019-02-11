<%@ Page Language="VB" ContentType="text/html" ResponseEncoding="UTF-8" %>
<script runat="server">
			Sub Page_Load(ByVal Sender as Object, ByVal E as EventArgs)
				Dim fbUrl As String
				fbUrl = Request.ApplicationPath & "/images/thumbFacebook.jpg"
				lblFB.Text = "<link rel='image_src' href='http://" & fbUrl & "' />"
			End Sub
		</script>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>Untitled Document</title>
		<asp:literal id="litFB" runat="server"></asp:literal>
	</head>
	<body>
		<asp:label id="lblFB" runat="server"></asp:label>
	</body>
</html>

	
