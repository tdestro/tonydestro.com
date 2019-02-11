<%@ Page Language="C#" ContentType="text/html" ResponseEncoding="UTF-8" Debug="True" CodeFile="ECPfinder.cs" Inherits="ECPfinder" %>
<%@ Import Namespace="System.Web.Mail" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Security.Principal" %>
<%@ Import Namespace="System.Security.Permissions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>SolFX // Drivewear - Find an Eyecare Professional</title>
        <meta name="description" content="Inquiry thank you page" />
        <meta name="keywords" content="" />
        <meta name="robots" content="NOINDEX, NOFOLLOW" />
		<!--#include file="_incl/css-js.aspx"-->
        <script type="text/javascript" src="http://en-us.transitions.com/Transitions_MCMS/js/2008/action/ous001_FindanEyeCareProfessional_1.js"></script>

	</head>
	<body class="WheretoGetDrivewearResults">
	<!--#include file="_incl/GlobalHeader.aspx"-->
	<div id="wrapper">
	<div id="ajaxContainer">
       <div id="content" class="WhereToDw">&nbsp;
       		<div id="drivewearNav">
				<ul>
        			<li><a href="Drivewear.aspx" title="Drivewear" class="first">Drivewear</a></li>
					<li><a href="DrivewearWhatis.aspx" title="What is Drivewear">What is Drivewear?</a></li>
					<li><a href="DrivewearTestimonials.aspx" title="Drivewear Testimonials">Testimonials</a></li>
					<li><a href="DrivewearWhereto.aspx" title="Where to Get Drivewear" class="last active">Find an Eyecare Professional</a></li>
				</ul>
                <div id="navArrows">
                	<a id="dwnPrev" href="DrivewearTestimonials.aspx" title="Drivewear Testimonials">Previous page</a>
                	<a id="dwnNext" href="Drivewear.aspx" title="Drivewear">Next Page</a>
                </div>
        	</div>
            <div class="header">
            <h1>Where to get Drivewear</h1>
            <p>Eyecare professionals within 5 miles of 15219 are listed below.</p>
            <ul>
                <li>Select the 'Learn More' button to view Hours of Operation, Languages Spoken, Accepted Insurance Plans and Specialty Areas.</li>  
                <li>Select "Map It" for directions to the selected eyecare professional.</li>
                <li>Select "Print it" to print eyecare professionals information with a checklist of topics for discussion.</li>
            </ul>
            </div>
            <div class="results">
                <div id="finder">
                    <div id="findThem">
                        <h2>Refine Your Search</h2>
                        <form id="ecpFinder" runat="server">
                          <fieldset>
                            <legend>Find ECP</legend>
                            <div class="mainBox">
                            	<asp:Literal ID="errorMainLiteral" runat="server"></asp:Literal>
                                <asp:Label ID="lbl_txtZip" runat="server" AssociatedControlID="txtZip">Zip Code</asp:Label>
                                <asp:TextBox ID="txtZip" TextMode="SingleLine" runat="server" Text="ZIP CODE" MaxLength="15"></asp:TextBox><asp:Literal ID="error1Literal" runat="server"></asp:Literal>
                                <strong class="or">OR</strong>
                                <asp:Label ID="lbl_txtCity" runat="server" AssociatedControlID="txtCity">City</asp:Label>
                                <asp:TextBox ID="txtCity" TextMode="SingleLine" runat="server" Text="CITY"></asp:TextBox><asp:Literal ID="error3Literal" runat="server"></asp:Literal>
                                
                                <asp:Label ID="lbl_txtState" runat="server" AssociatedControlID="txtState">State</asp:Label>
                                <asp:DropDownList ID="txtState" runat="server">
                                    <asp:ListItem Selected Value="">STATE</asp:ListItem>
                                    <asp:ListItem Value="2">AK</asp:ListItem>
                                    <asp:ListItem Value="1">AL</asp:ListItem>
                                    <asp:ListItem Value="5">AR</asp:ListItem>
                                    <asp:ListItem Value="3">AS</asp:ListItem>
                                    <asp:ListItem Value="4">AZ</asp:ListItem>
                                    <asp:ListItem Value="6">CA</asp:ListItem>
                                    <asp:ListItem Value="7">CO</asp:ListItem>
                                    <asp:ListItem Value="8">CT</asp:ListItem>
                                    <asp:ListItem Value="10">DC</asp:ListItem>
                                    <asp:ListItem Value="9">DE</asp:ListItem>
                                    <asp:ListItem Value="12">FL</asp:ListItem>
                                    <asp:ListItem Value="11">FM</asp:ListItem>
                                    <asp:ListItem Value="13">GA</asp:ListItem>
                                    <asp:ListItem Value="14">GU</asp:ListItem>
                                    <asp:ListItem Value="15">HI</asp:ListItem>
                                    <asp:ListItem Value="19">IA</asp:ListItem>
                                    <asp:ListItem Value="16">ID</asp:ListItem>
                                    <asp:ListItem Value="17">IL</asp:ListItem>
                                    <asp:ListItem Value="18">IN</asp:ListItem>
                                    <asp:ListItem Value="20">KS</asp:ListItem>
                                    <asp:ListItem Value="21">KY</asp:ListItem>
                                    <asp:ListItem Value="22">LA</asp:ListItem>
                                    <asp:ListItem Value="26">MA</asp:ListItem>
                                    <asp:ListItem Value="25">MD</asp:ListItem>
                                    <asp:ListItem Value="23">ME</asp:ListItem>
                                    <asp:ListItem Value="24">MH</asp:ListItem>
                                    <asp:ListItem Value="27">MI</asp:ListItem>
                                    <asp:ListItem Value="28">MN</asp:ListItem>
                                    <asp:ListItem Value="30">MO</asp:ListItem>
                                    <asp:ListItem Value="40">MP</asp:ListItem>
                                    <asp:ListItem Value="29">MS</asp:ListItem>
                                    <asp:ListItem Value="31">MT</asp:ListItem>
                                    <asp:ListItem Value="38">NC</asp:ListItem>
                                    <asp:ListItem Value="39">ND</asp:ListItem>
                                    <asp:ListItem Value="32">NE</asp:ListItem>
                                    <asp:ListItem Value="34">NH</asp:ListItem>
                                    <asp:ListItem Value="35">NJ</asp:ListItem>
                                    <asp:ListItem Value="36">NM</asp:ListItem>
                                    <asp:ListItem Value="33">NV</asp:ListItem>
                                    <asp:ListItem Value="37">NY</asp:ListItem>
                                    <asp:ListItem Value="41">OH</asp:ListItem>
                                    <asp:ListItem Value="42">OK</asp:ListItem>
                                    <asp:ListItem Value="43">OR</asp:ListItem>
                                    <asp:ListItem Value="45">PA</asp:ListItem>
                                    <asp:ListItem Value="46">PR</asp:ListItem>
                                    <asp:ListItem Value="44">PW</asp:ListItem>
                                    <asp:ListItem Value="47">RI</asp:ListItem>
                                    <asp:ListItem Value="48">SC</asp:ListItem>
                                    <asp:ListItem Value="49">SD</asp:ListItem>
                                    <asp:ListItem Value="50">TN</asp:ListItem>
                                    <asp:ListItem Value="51">TX</asp:ListItem>
                                    <asp:ListItem Value="52">UT</asp:ListItem>
                                    <asp:ListItem Value="55">VA</asp:ListItem>
                                    <asp:ListItem Value="54">VI</asp:ListItem>
                                    <asp:ListItem Value="53">VT</asp:ListItem>
                                    <asp:ListItem Value="56">WA</asp:ListItem>
                                    <asp:ListItem Value="58">WI</asp:ListItem>
                                    <asp:ListItem Value="57">WV</asp:ListItem>
                                    <asp:ListItem Value="59">WY</asp:ListItem>
                                </asp:DropDownList><asp:Literal ID="error4Literal" runat="server"></asp:Literal>
                            	<br/>
                            	<asp:Literal ID="error2Literal" runat="server"></asp:Literal>
                                <asp:Label ID="lbl_txtDistance" runat="server" AssociatedControlID="txtDistance">Distance</asp:Label>
                                <asp:DropDownList ID="txtDistance" runat="server">
                                    <asp:ListItem Selected Value="">DISTANCE</asp:ListItem>
                                    <asp:ListItem Value="2">2 miles</asp:ListItem>
                                    <asp:ListItem Value="5">5 miles</asp:ListItem>
                                    <asp:ListItem Value="10">10 miles</asp:ListItem>
                                    <asp:ListItem Value="25">25 miles</asp:ListItem>
                                    <asp:ListItem Value="50">50 miles</asp:ListItem>
                                </asp:DropDownList></div>
                            </div>
                            
                            <div id="filter">
                                <h3>Filter Your Results:</h3>
                                <div id="deTall"><asp:RadioButton ID="eTall" runat="server" Text="All Results" Checked="True" GroupName="ecpType" /></div>
                                <div id="deTindie"><asp:RadioButton ID="eTindie" runat="server" Text="Indepenent Eyecare Practices" GroupName="ecpType" /></div>
                                <div id="deTretail"><asp:RadioButton ID="eTretail" runat="server" Text="Retail Chains" GroupName="ecpType" /></div>
                            </div>
                            <asp:ImageButton ID="SearchButton" runat="server" ImageUrl="images/searchBtn.jpg" AlternateText="Search" OnClick="ButtonClick"></asp:ImageButton>
                          	<!--<a href="" title="Buy Now" class="buyNowBtn">Buy Now</a>-->
                          </fieldset>
                       </form>
                    </div>
                </div>
                <div id="resultsContent">
                	<asp:Literal ID="ShowString" runat="server"></asp:Literal>
                    <!--<div id="framesDirect"><h3>Frames Direct</h3>
                        <div class="container">
                            <div class="entry">
                                <strong>Frames Direct</strong>
                                <br/>(w) <a href="http://www.framesdirect.com">http://www.framesdirect.com</a>
                            </div>
                        </div>
                    </div>-->
                    
                </div>
            </div>
            
			
        </div>
	</div>
	<!--#include file="_incl/GlobalCategoryNavigation.aspx"-->
	<div id="pre-footer"></div>
	<!--#include file="_incl/GlobalFooter.aspx"-->