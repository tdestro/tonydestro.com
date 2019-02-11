using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Security.Cryptography;

public class inquiryEvent : Page {
	// Create the required webcontrols with the same name as in the default.aspx file

	public TextBox txtName;
	public TextBox txtEmail;
	public TextBox txtCompany;
	public TextBox txtStreet;
	public TextBox txtState;
	public TextBox txtCity;
	public TextBox txtZip;
	public TextBox txtComments;
	public RadioButtonList interest;
	public string error;

	public void Save_Comment(object sender, EventArgs e) {
		// Everything is all right, so let us save the data into the XML file			
		SaveXMLData();

		txtName.Text="";
		txtEmail.Text="";
		txtCompany.Text="";
		txtStreet.Text="";
		txtState.Text="";
		txtCity.Text="";
		txtZip.Text="";
		txtComments.Text="";
	}
	private void SaveXMLData() {
		// Load the xml file
		XmlDocument xmldoc 	= new XmlDocument();
		xmldoc.Load( Server.MapPath("BeInTheKnow.xml") );

		//Create a new guest element and add it to the root node
		XmlElement parentNode 	= xmldoc.CreateElement("person");
		xmldoc.DocumentElement.PrependChild(parentNode);

		// Create the required nodes
		XmlElement dateNode = xmldoc.CreateElement("date");
		XmlElement nameNode = xmldoc.CreateElement("name");
		XmlElement emailNode = xmldoc.CreateElement("email");
		XmlElement companyNode = xmldoc.CreateElement("company");
		XmlElement streetNode = xmldoc.CreateElement("street");
		XmlElement stateNode = xmldoc.CreateElement("state");
		XmlElement zipNode = xmldoc.CreateElement("zip");
		XmlElement commentNode	= xmldoc.CreateElement("comment");
		XmlElement interestNode = xmldoc.CreateElement("interest");

		// retrieve the text 
		XmlText dateText = xmldoc.CreateTextNode(DateTime.Now.ToString());
		XmlText nameText = xmldoc.CreateTextNode(txtName.Text);
		XmlText emailText = xmldoc.CreateTextNode(txtEmail.Text);
		XmlText companyText = xmldoc.CreateTextNode(txtCompany.Text);
		XmlText streetText	= xmldoc.CreateTextNode(txtStreet.Text);
		XmlText stateText = xmldoc.CreateTextNode(txtState.Text);
		XmlText zipText = xmldoc.CreateTextNode(txtZip.Text);
		XmlText commentText	= xmldoc.CreateTextNode(txtComments.Text);
		XmlText interestText = xmldoc.CreateTextNode(interest.SelectedItem.Value);

		// append the nodes to the parentNode without the value
		parentNode.AppendChild(dateNode);
		parentNode.AppendChild(nameNode);
		parentNode.AppendChild(emailNode);
		parentNode.AppendChild(companyNode);
		parentNode.AppendChild(streetNode);
		parentNode.AppendChild(stateNode);
		parentNode.AppendChild(zipNode);
		parentNode.AppendChild(commentNode);
		parentNode.AppendChild(interestNode);

		// save the value of the fields into the nodes
		dateNode.AppendChild(dateText);
		nameNode.AppendChild(nameText);
		emailNode.AppendChild(emailText);
		companyNode.AppendChild(companyText);
		streetNode.AppendChild(streetText);
		stateNode.AppendChild(stateText);
		zipNode.AppendChild(zipText);
		commentNode.AppendChild(commentText);
		interestNode.AppendChild(interestText);

		// Save to the XML file
		xmldoc.Save( Server.MapPath("BeInTheKnow.xml") );
		
		// Display the user the signed guestbook
		Response.Redirect("ThankYou.aspx");
	}
}