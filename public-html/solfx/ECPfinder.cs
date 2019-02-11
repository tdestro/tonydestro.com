using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.SessionState;
using System.Web.UI.HtmlControls;
using System.Xml;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Web.Caching;
using System.Net;

public partial class ECPfinder : Page {
	
	protected void Page_Load(object sender, EventArgs e)
	{
		error2Literal.Text = "<div>";
		string zip = ""+Request.QueryString["zip"];
		string radius = ""+Request.QueryString["radius"];
		string city = ""+Request.QueryString["city"];
		string stateID = ""+Request.QueryString["stateID"];
		string searchScope = ""+Request.QueryString["searchScope"];
		string country = ""+Request.QueryString["country"];
		string allowPaging = ""+Request.QueryString["AllowPaging"];
		
		/**/
		//Step 1: Determine Base URL for external link
		string baseURL = "http://en-us.transitions.com/Transitions_MCMS/Templates/2008/findECP.aspx?NRMODE=Published&NRNODEGUID={F08C0296-5C50-4994-84B5-525A6464C4B0}&NRORIGINALURL=%2ffindECP.htm";
		
		//Step 3: Assemble entire query String
		string ALTzip = "%3fzip%3d"+zip;
		string ALTradius = "%26radius%3d"+radius;
		string cityfix = city.Replace(" ", "%2520");
		city = city.Replace(" ", "%20");
		string ALTcity = "%26city%3d"+cityfix;
		string ALTstateID = "%26stateID%3d"+stateID;
		string ALTsearchScope = "%26searchScope%3d"+searchScope;
		string ALTcountry = "%26country%3d"+country;
		
		string extURL = baseURL + ALTzip + ALTradius + ALTcity + ALTstateID + ALTsearchScope +ALTcountry+"&NRCACHEHINT=Guest&zip="+zip+"&radius="+radius+"&searchScope="+searchScope+"&country="+country+"&stateID="+stateID+"&city="+city+""+"&AllowPaging=false";
		
		
		//ShowString.Text = GetString("http://en-us.transitions.com/findECP.htm?zip=15219&radius=10&city=&stateID=&searchScope=&country=US");
		string ecpURL = "http://en-us.transitions.com/findECP.htm?zip="+zip+"&radius="+radius+"&city="+city+"&stateID="+stateID+"=&searchScope="+searchScope+"&country="+country+"&AllowPaging=false";
		string fullsite = GetString(extURL);
		
		if(radius != "" && country != "")
		{
			if(zip == "")
			{
				if(city == "" && stateID == ""){
				}
				else{
					fullsite = GetContentOnly(fullsite);
				}
			}
			else{
				fullsite = GetContentOnly(fullsite);
			}
		}	 
		
		if(fullsite==" " || (zip+radius+city+stateID)=="") {
			ShowString.Text = "<div id='noresults'><h4>No search results returned.</h4> Please make sure that you enter a valid zip code or city and state combination as well as a large enough radius.</div>";
		}
		else {
			ShowString.Text = fullsite;
		}
	}
	
	public string GetContentOnly(string full)
	{
		string final = "";
		string search4 = "<div id=\"centerColumn\">";
		int theIndex = full.IndexOf(search4);
		
		if(theIndex!=-1)
		{
			final = full.Substring(theIndex);
			string search2 = "<table";
			int index2 = final.IndexOf(search2);	
			
			if(final.IndexOf("ctl00_CenterColumnContent_findECP1_GridViewIndependentResults")!=-1){	
				if(final.IndexOf("ctl00_CenterColumnContent_findECP1_GridViewRetailResults")!=-1)
				{
					if(index2!=-1)
					{
						final = final.Substring(index2);								
						string search3 = "</table>";
						int index3 = final.LastIndexOf(search3)+8;
						final = final.Substring(0,index3);
					}
					else {final = " ";}
				}
				else {final = " ";}
			}
			else {final = " ";}
			
		}
		else {final = " ";}
		
		return final;
	}
	
	public string GetString(string url)
	{
        using (WebClient client = new WebClient())
        {
			//client.OpenWrite(url,ShowAll());
			//client.OnOpenWriteCompleted(OpenWriteCompletedEventArgs e);
            string response = client.DownloadString(url);
            return response;
        }
    }
	
	public string ShowAll()
	{
		string e;
		//InvokeOnClick(buttonIndependentShowAll,e);
		/*GridViewIndependentResults.AllowPaging = false;
		GridViewRetailResults.AllowPaging = false;*/
		//GridViewResults.AllowPaging = false;
		return "happy";
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