using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using System.Collections.Generic;
using System.Globalization;
using System.IO;

public partial class ECPsimpler : Page {

	public string Keyzip = "";
	public string Keyradius = "";
	public string Keycity = "";
	public string KeystateID = "";
	public string Keycountry = "US";
	public string Keyscope = "All";
	public string Errs = "none";
	public string defaultError = "<span class='red'>*</span>"; 
	
	protected void Page_Load(object sender, EventArgs e)
	{
		error1Literal.Text = "<div>";
		error2Literal.Text = "<div>";
	}
	
	public void DriveButtonClick(Object sender, ImageClickEventArgs e){
		if(txtZip.Text=="ZIP CODE"){
		 	txtZip.Text = "";
		 }
		 if(txtZip.Text==""){
		 	error1Literal.Text = "<div class='red'>";
			Errs = defaultError;
		 }
		 if(txtDistance.Text==""){
		 	error2Literal.Text = "<div class='red'>";
			Errs = defaultError;
		 } 
		 
		Keyzip = txtZip.Text;
		Keyradius = txtDistance.Text;
		
		if(Errs == "none"){
			string outURL = "Results.aspx";//"http://en-us.transitions.com/findECP.htm";
		 	Response.Redirect(outURL+"?zip="+Keyzip+"&radius="+Keyradius+"&city="+Keycity+"&stateID="+KeystateID+"&searchScope="+Keyscope+"&country="+Keycountry);
		}
		else{
		 	txtZip.Text = "ZIP CODE";
		}
	}

}