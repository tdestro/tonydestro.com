var hash = '';
var trigger = '';
var progress, Ntitle;
var Pchange = 0;
var panels = new Array();
var currP = 0;
var desired = ""

function DefinePanelOrder(value) 
{
	for (i=0;i<($("#content .panel").length+1);i++){
		if($("#content .panel")[i])
		{
			panels.push(findKey($("#content .panel")[i].className));
		}
	}
	Pchange = 1;
}

function DefinePanelOrder2() 
{
	panels.push("default");
	panels.push("sport");
	panels.push("special");
	panels.push("style");
}

function runTimer(hash) 
{
	var me=setTimeout("goHOME()",5000);
}

function goHOME() 
{
	//window.location.replace("default.aspx");
	if(document.getElementById('content').className.match("thankyou"))
	{
		var t = document.getElementById('goHome');
		navUi(t);var hash = $(t).attr('href');
		$.history.load('/'+hash.substr(0,hash.length-DOM.baseExtension.length));
	}
}

function findKey(word) 
{
	if(word.match("sport")) {word = "sport"}
	else if(word.match("special")) {	word = "specialty"	}
	else if(word.match("style")) {	word = "style"	}
	else if(word.match("default")) {	word = "default"	}
	else {	word = "default"	}
	return word;
}

function loop(num)
{
	var nud = panels.length-1;
	if(num>nud){
		num=0;
	}
	if(num<0){
		num=nud;	
	}return num;
}

function findCurrentIndex(value)
{
	var y;
	for(i=0;i<panels.length;i++)
	{
		if(value.match(panels[i])){
			y = i;
		}
	}
	return y;
} // Won't function without the panels array

function Slide2(cIndex,nIndex) 
{
	navActive(panels[nIndex]);
	if(cIndex!=nIndex){
		var dist,bg,name;
		switch (nIndex){
			case 0://alert("go to "+panels[0]); 
				dist = 0;
				bg = "generalBG";
				name = panels[nIndex];
				break;
			case 1:
				dist = -1016;
				bg = "sportBG";
				name = panels[nIndex];
				break;
			case 2:
				dist = -1977;
				bg = "specialtyBG";
				name = panels[nIndex];
				break;
			case 3:
				dist = -2937;
				bg = "styleBG";
				name = panels[nIndex];
				break;
		}
		$("#content.home").animate( { left:dist+"px" }, { queue:false, duration:ANIM.speed } );
		$("#arrowBtns").css("left",(-1*dist)+"px");
		//Change Background
		document.getElementsByTagName('body')[0].className = bg;
		//FadeBG(bg);
		document.title = DOM.basePageTitle+' // '+makeTitle(name);
		currP = nIndex;
		//Add Google Analytics
		analyticTracker(panels[nIndex]+DOM.baseExtension);
	}
}

function setTitle() 
{
	document.title = DOM.basePageTitle+' // '+Ntitle;
}

function makeTitle(key) 
{
	if(key=="style"){
		key = "Style";	
	}
	if(key=="sport"){
		key = "Sports";	
	}
	if(key=="specialty"){
		key = "Specialty";	
	}
	if(key=="default"){
		key = "Sunwear by Transitions Optical";	
	}
	return key;
}

/*
function FadeBG(bg) {
		$("#fullBg").fadeOut(ANIM*2);
		desired = bg;
		var t=setTimeout("switchBackground(desired)",ANIM*2);
		$("#fullBg").fadeIn(ANIM*2);
}

function switchBackground(bg) {
	//$("#fullBg").css("background",bg);
	document.getElementById("fullBg").className = bg;
}*/

function navActive(name) {
	$("#ulSecondaryNav li a").removeClass("active");
	for(i=0;i<$("#ulSecondaryNav li a").length;i++){
		if($("#ulSecondaryNav li a")[i].href.match(name)){
			$("#ulSecondaryNav li a")[i].className += " active";
		}
	}
}

$(document).ready(function(){
	//Define The Order of 'panels' for sliding on pageLoad	
	if(document.getElementById("ajaxContainer").getElementsByTagName("div")[0].className=="home"){//If the current page is default (or a subpage of that)
		DefinePanelOrder2();//DefinePanelOrder();
	}
	else{
		DefinePanelOrder2();
	}
	
	//Event listners
	$("#ulSecondaryNav li a").click(function(){
		if(document.getElementById("ajaxContainer").getElementsByTagName("div")[0].className!="home")//If the current page is default (or a subpage of that)
		{
			desired=$(this).attr('title')+"BG";
			navUi(this);
			hash = $(this).attr('href');
			document.getElementsByTagName('body')[0].className = "main";
			$.history.load('/'+hash.substr(0,hash.length-DOM.baseExtension.length));
			return false;
		}
		else { // Navigate to default
			var cIndex = findCurrentIndex($("#content .panel")[0].className); 
			var nIndex = findCurrentIndex($(this).attr('href'));
			Slide2(cIndex,nIndex);
			return false;
		}
	});
	
	$("#ulFooter li a, #ulTerms li a, #pnlInTheKnow a").click(function(){ 
			document.getElementById('lnkHome').focus();
			navUi(this);
			hash = $(this).attr('href');
			document.getElementsByTagName('body')[0].className = "main";
			$.history.load('/'+hash.substr(0,hash.length-DOM.baseExtension.length));
			return false;
	});
	
	$("#arrowBtns .rightBtn").click(function(){ 
			var cIndex = currP;
			var nIndex = loop(currP+1);
			Slide2(cIndex,nIndex);
			return false;
	});
	$("#arrowBtns .leftBtn").click(function(){ 	
			var cIndex = currP;
			var nIndex = loop(currP-1);
			Slide2(cIndex,nIndex);
			return false;
	});
});

// Validation Script
function validate_email(field)
{
	with (field)
	{
		apos=value.indexOf("@");
		dotpos=value.lastIndexOf(".");
		if (apos<1||dotpos-apos<2) 
	 	{
			return false;
		}
		else {
			return true;
		}
	}
}

function WebForm_OnSubmit() {
	var theForm = document.getElementById("know");
	document.getElementById("errors").innerHTML = "";
	
	if(theForm.txtName.value.length == 0)
	{
		document.getElementById("errors").innerHTML = "Please enter your name";
		return false;
	}
	else if(theForm.txtEmail.value.length == 0)
	{
		document.getElementById("errors").innerHTML = "Please enter your email";
		return false;
	}
	else if(validate_email(theForm.txtEmail) == false)
	{
        document.getElementById("errors").innerHTML = "Please enter a valid email address";
		return false;
	}
	else if(theForm.txtCompany.value.length == 0)
	{
		document.getElementById("errors").innerHTML = "Please enter your company name";
		return false;
	}
	else if(theForm.txtStreet.value.length == 0)
	{
		document.getElementById("errors").innerHTML = "Please enter your street address";
		return false;
	}
	else if(theForm.txtState.value.length == 0)
	{
		document.getElementById("errors").innerHTML = "Please enter your state name";
		return false;
	}
	else if(theForm.txtCity.value.length == 0)
	{
		document.getElementById("errors").innerHTML = "Please enter your city name";
		return false;
	}
	else if(theForm.txtZip.value.length == 0)
	{
		document.getElementById("errors").innerHTML = "Please enter your zip code";
		return false;
	}
	else
	{
		return true;
	}
}