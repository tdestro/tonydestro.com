using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

using System.Xml;
using System.Xml.XPath;
using System.Collections.Generic;
using System.Collections;

public partial class worldcarousel_aspx : UserControl
{
	
// AUTHOR: ANTHONY ORLANDO DESTRO
///////////////////////////////////////////////////////////////////////////////
// CLASS 
//
// G l o b e S o r t I t e m 
//
// Objects of this class represent one of the 32 blocks on the matrix and
// contains their respective information.
//
protected class globeSortItem : IEquatable<globeSortItem>
{
        public float ratio;
        public int virtualGlobe;
        public int zone;
        public globeSortItem(float ratio, int virtualGlobe, int zone)
        {
                this.ratio = ratio;
                this.virtualGlobe = virtualGlobe;
                this.zone = zone;
        }

        public bool Equals(globeSortItem other)
        {
                if (other == null) return false;
                return (this.ratio.Equals(other.ratio));
        }
}

///////////////////////////////////////////////////////////////////////////////
// FUNCTION  
//
// o u t p u t G l o b e X M L
//
// This function writes the xml to flash in the appropriate order; the closest
// city is id 0.

void outputGlobeXML(int virtualGlobe, int zone, XmlDocument xmlDoc, string domainPrefix)
{
        string serverPath = domainPrefix;
        XmlNodeList nodeList = xmlDoc.SelectNodes(("meals/meal/item[@virtualGlobe="+virtualGlobe+"]"));
		string mealPath;
		string btPath;

        int id = 0;

        // List ID 0 first until end.
        for (int i = zone; i < nodeList.Count; i++){
                XmlNode currentNode =  xmlDoc.SelectSingleNode(("meals/meal/item[@virtualGlobe="+virtualGlobe+" and @zone="+i+"]"));
              
			    // add an ID
			    XmlAttribute attr = xmlDoc.CreateAttribute("id");
                attr.Value = id.ToString();
                currentNode.Attributes.SetNamedItem(attr);
                id++;
				
				// modify meal path
				mealPath = serverPath+currentNode.ParentNode.Attributes.GetNamedItem("dir").Value+currentNode.Attributes.GetNamedItem("href").Value;
				XmlAttribute attr1 = xmlDoc.CreateAttribute("href");
                attr1.Value = mealPath;
				currentNode.Attributes.SetNamedItem(attr1);
				
				// modify button/animation path.
				btPath = serverPath+currentNode.Attributes.GetNamedItem("hrefbt").Value;
				XmlAttribute attr2 = xmlDoc.CreateAttribute("hrefbt");
                attr2.Value = btPath;
				currentNode.Attributes.SetNamedItem(attr2);
				
                Response.Write(currentNode.OuterXml.ToString());
        }
        // List IDs remaining.
        for (int i = 0; i < zone; i++){
                XmlNode currentNode =  xmlDoc.SelectSingleNode(("meals/meal/item[@virtualGlobe="+virtualGlobe+" and @zone="+i+"]"));
                XmlAttribute attr = xmlDoc.CreateAttribute("id");
                attr.Value = id.ToString();
                currentNode.Attributes.SetNamedItem(attr);
                id++;
				
				// modify meal path
				mealPath = serverPath+currentNode.ParentNode.Attributes.GetNamedItem("dir").Value+currentNode.Attributes.GetNamedItem("href").Value;
				XmlAttribute attr1 = xmlDoc.CreateAttribute("href");
                attr1.Value = mealPath;
				currentNode.Attributes.SetNamedItem(attr1);
				 
				// modify button/animation path.
				btPath = serverPath+currentNode.Attributes.GetNamedItem("hrefbt").Value;
				XmlAttribute attr2 = xmlDoc.CreateAttribute("hrefbt");
                attr2.Value = btPath;
				currentNode.Attributes.SetNamedItem(attr2);
				
				Response.Write(currentNode.OuterXml.ToString());
        }
}

///////////////////////////////////////////////////////////////////////////////
// FUNCTION  
//
// P a g e _ L o a d
//
// This function writes the xml to flash in the appropriate order; the closest
// city is id 0.

void Page_Load(object sender, EventArgs e)
{
 float utcOffset, i, currentRatio;
 int currentGlobeItem, currentGlobeZone;
 string hours, domainPrefix;
 
 
 XmlDocument xmlDoc;
 XmlNode MealForCurrentTime;
 IEnumerator ienum;
 XmlElement currentElement, closestToOne;
 
 List <globeSortItem> utcOffsets;

//

       utcOffset = float.Parse(Request.QueryString["utcOffset"]);
       utcOffset += 13; // offset so we can do math without having to worry about negatives.
       hours = Request.QueryString["hours"];
	   domainPrefix = Request.QueryString["domainPrefix"];
		
        Response.Clear();
        Response.ContentType = "text/xml";
        Response.Write("<heinz><items width=\"400\" height=\"226\">");
		
        xmlDoc = new XmlDocument();
        XmlTextReader reader = new XmlTextReader(Server.MapPath("menu.xml"));
        xmlDoc.Load(reader);
        MealForCurrentTime = xmlDoc.SelectSingleNode (("meals/meal[@LowerLimitHours <= "+hours+" and "+hours+" < @UpperLimitHours]"));

        // gap is stradling hour 24 hour and 1 AM. Find the one guy where the lower limit is greater then the upper limit and we have our guy.
        if (MealForCurrentTime == null) MealForCurrentTime =  xmlDoc.SelectSingleNode ("/meals/meal[@LowerLimitHours > @UpperLimitHours]");

        // Find the Closest City to the User so we can then identify which virtual globe to send to flash.
        ienum = MealForCurrentTime.GetEnumerator();
        utcOffsets = new List<globeSortItem>();

        while (ienum.MoveNext())
        {
                currentElement = ienum.Current as XmlElement;
                i = float.Parse(currentElement.GetAttribute("utcOffset"));
                i += 13; // offset so we don't have to worry about negatives or zero.
				
                if (i < utcOffset) currentRatio =  utcOffset/i; 
				else currentRatio =  i/utcOffset;
            
                currentGlobeItem = int.Parse(currentElement.GetAttribute("virtualGlobe"));
                currentGlobeZone = int.Parse(currentElement.GetAttribute("zone"));

                if(i != utcOffset)
                {
                        utcOffsets.Add(new globeSortItem(currentRatio,currentGlobeItem, currentGlobeZone));
                }
                else {
                        // we've found an exact UTC timezone match. Stop everything and use this one.
                        // grab globe number and generate entire xml
                        outputGlobeXML(currentGlobeItem, currentGlobeZone, xmlDoc, domainPrefix);
                        Response.Write("</items></heinz>");
                        return;
                }
        }
        // We did not find an exact match to our UTC number so lets find the next closest one.
        // Sort the array and get the number closest to one.

        // Sort
        utcOffsets.Sort(delegate(globeSortItem p1, globeSortItem p2) { return p1.ratio.CompareTo(p2.ratio); });

        // grab globe number and generate entire globe.
        outputGlobeXML(utcOffsets[0].virtualGlobe, utcOffsets[0].zone, xmlDoc, domainPrefix);
		
        Response.Write("</items></heinz>");
}
}