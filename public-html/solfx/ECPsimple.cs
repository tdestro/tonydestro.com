using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using System.Collections.Generic;
using System.Globalization;
using System.IO;

public partial class ECPsimple : Page {

	protected void Page_Load(object sender, EventArgs e)
	{
		error2Literal.Text = "<div>";
	}

	public void ButtonClick(Object sender, ImageClickEventArgs e)
    {	
		string Keyzip = "";
		string Keyradius = "";
		string Keycity = "";
		string KeystateID = "";
		string Keycountry = "";
		string Keyscope = "";
		string solfxScope = "";
		string Errs = "none";
		string defaultError = "<span class='red'>*</span>"; 
		errorMainLiteral.Text = "";
		error1Literal.Text = "";
		error2Literal.Text = "<div>";
		error3Literal.Text = "";
		error4Literal.Text = "";
		 
		 //Start of Validation
		 if(txtZip.Text=="ZIP CODE"){
		 	txtZip.Text = "";
		 }
		 if(txtCity.Text=="CITY"){
		 	txtCity.Text = "";
		 }
		 if(txtState.Text=="STATE"){
		 	txtState.Text = "";
		 }
		 
		 if(txtZip.Text==""){
		 	if(txtState.Text=="" && txtCity.Text==""){
				error1Literal.Text = defaultError;
				Errs = defaultError;
			}
		 	else if(txtState.Text==""){
				error4Literal.Text = defaultError;
				Errs = defaultError;
			}
			else if(txtCity.Text==""){
				error3Literal.Text = defaultError;
				Errs = defaultError;
			}
		 }
		 
		 if(txtDistance.Text==""){
		 	error2Literal.Text = "<div class='red'>";
			Errs = defaultError;
		 }
		 
		Keyzip = txtZip.Text;
		Keyradius = txtDistance.Text;
		Keycountry = "US";
		
		if(Keyzip==""){
			Keycity = txtCity.Text;
			KeystateID = txtState.Text;
		}
		
		if(eTall.Checked){
			Keyscope = "All";
		}
		if(eTindie.Checked){
			Keyscope = "Independent";
		}
		if(eTretail.Checked){
			Keyscope = "All";
			solfxScope = "&solfxScope=Retail";
		}
		 
		if(Errs == "none"){
		 	string outURL = "Results.aspx";//"http://en-us.transitions.com/findECP.htm";
		 	Response.Redirect(outURL+"?zip="+Keyzip+"&radius="+Keyradius+"&city="+Keycity+"&stateID="+KeystateID+"&searchScope="+Keyscope+"&country="+Keycountry+solfxScope);
		}
		else{
		 	txtZip.Text = "ZIP CODE";
		 	txtCity.Text = "CITY";
		 	txtState.Text = "STATE";
			errorMainLiteral.Text = "<span class='red'>Please fill in all required fields.</span><br/>";
		}
	}
}