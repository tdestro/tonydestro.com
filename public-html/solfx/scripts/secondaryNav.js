var hash = '';
var trigger = '';
var progress, Ntitle, inContent, ext, gIndex, pstatus,sel,column1High,column2High;
var Pchange = 0;
var panels = new Array();
var currP = 0;
var desired = "";
//---------------------Redirect Script-----------------------//
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

//------------------Thickbox-Style Pop-up Script-----------------------//
function openLightBox(index) 
{
	ext = '<a href="#" class="closeBTN">&nbsp;</a><a href="http://www.drivewearlens.com/find_ecp.php" title="Where to Get Drivewear" class="whereToBTN" target="_blank">Where to get Drivewear</a><a href="#" class="prevBTN">&nbsp;</a><a href="#" class="nextBTN">&nbsp;</a>';
	$("#content").append('<a id="popUpOverlay" href="#" style="display:none"></a><div id="popUpContent" style="display:none"><div class="detail">'+ext+'<div class="dwcopy"></div></div></div>');
	$("#popUpOverlay, #popUpContent").fadeIn(ANIM.speed);
	//Event Listeners for New Buttons
	/*$(".whereToBTN").click(function(){
		navUi(this);
		var hash = $(this).attr('href');
		$.history.load('/'+hash.substr(0,hash.length-DOM.baseExtension.length));
		return false;
	});*/
	$("#popUpOverlay, .closeBTN").click(function(){ closeLightBox();return false; });
	$(".prevBTN").click(function(){ switchContent(gIndex-1);return false; });
	$(".nextBTN").click(function(){ switchContent(gIndex+1);return false; });
	//pull in content from ".content" under selected link and place into Light Box
	var inContent = $(".lightbox:eq("+index+") .content")[0].innerHTML;
	$("#popUpContent .detail .dwcopy").append(inContent);
	gIndex = index;
	$(document).pngFix();
}

function closeLightBox() 
{
	$("#popUpOverlay, #popUpContent").fadeOut(ANIM.speed);
	var me=setTimeout("removeDOM()",ANIM.speed);
}

function switchContent(num) 
{
	if(num<0) { num=$(".lightbox").length-1;}
	else if(num>($(".lightbox").length-1)) {num = 0;}
	gIndex = num;
	inContent = $(".lightbox:eq("+num+") .content")[0].innerHTML;
	$("#popUpContent .detail").fadeOut(ANIM.speed);
	var me=setTimeout("emptyAndFade('#popUpContent .detail',(inContent))",ANIM.speed);
}

function emptyAndFade(fieldselector,inContent)
{
	$(fieldselector+" .dwcopy")[0].innerHTML = inContent;
	$(fieldselector).fadeIn(ANIM.speed);
}

function removeDOM() 
{
	$("#popUpOverlay, #popUpContent").remove();	
}

function TempTestimonialsIEfix() 
{
	//IE6 has trouble handling the transparency filter after multiple fade outs apparently.. this forces a reload that allows IE6 to process the opacity filters appropriately
	if($("html")[0].className.match("msie6")){
		if(location.hash.match("DrivewearTestimonials")){
			var loc = location.pathname.substring(0,(location.pathname.lastIndexOf("/")+1))+"DrivewearTestimonials.aspx?Testimonials";
			window.location.assign(loc);
		}
	}
}

//------------What is Drivewear Applications Pop-up -----------------------//
function AppPopUp() 
{
	//Apply new Styles and content for Javascript version.
	pstatus = "clean";
	$("#content").addClass("jsStyle");
	$("#Applications").append("<a href='#' id='techPlusBtn' class='plusButn' title='technology'>&nbsp;</a><a href='#' id='perfPlusBtn' class='plusButn' title='performance'>&nbsp;</a><a href='#' id='stylePlusBtn' class='plusButn' title='style'>&nbsp;</a>");
	
	//Event Listeners for new buttons
	$("#techPlusBtn, #perfPlusBtn, #stylePlusBtn").click(function(){
		if(pstatus == "clean"){
			var content = $("#"+$(this).attr('title')+"Pnl")[0].innerHTML;
			//var class=$(this).attr('className');
			openAppPopUp($(this).attr('title'),content);
			pstatus = "dirty";
		}
		return false;
	});
}

function openAppPopUp(title,content) 
{
	$("#Applications").append("<div id='appPopUp' class='pop"+title+"'>"+content+"</div>");
	
	if($("html")[0].className.match("msie6") || $("html")[0].className.match("msie7")){
		$("#appPopUp").slideDown(ANIM.speed);//!! IE6 & 7 Both break on this... what if it did something else.
	}
	else{
		$("#appPopUp").fadeIn(ANIM.speed);//!! IE6 & 7 Both break on this...
	}
	
	$("#appPopUp").bind("mouseleave",function(){
		closeAppPopUp();
	});
}

function closeAppPopUp() 
{
	if($("html")[0].className.match("msie6") || $("html")[0].className.match("msie7")){
		$("#appPopUp").slideUp(ANIM.speed);
	}
	else{
		$("#appPopUp").fadeOut(ANIM.speed);	//!! IE6 & 7 Both break on this...
	}
	var IEsucksHARD=setTimeout("removeAppFromDOM()",ANIM.speed);
}

function removeAppFromDOM() 
{
	$("#appPopUp").empty();
	$("#appPopUp").remove();
	pstatus = "clean";
}


//------------Slider Script-----------------------//
function DefinePanelOrder() 
{
	panels.push("default");
	panels.push("sport");
	panels.push("special");
	panels.push("style");
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
	for(i=0;i<panels.length;i++){
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

function navActive(name) 
{
	$("#ulSecondaryNav li a").removeClass("active");
	for(i=0;i<$("#ulSecondaryNav li a").length;i++){
		if($("#ulSecondaryNav li a")[i].href.match(name)){
			$("#ulSecondaryNav li a")[i].className += " active";
		}
	}
}

// Set Up Event Listeners inside of function -----//

function SecondaryEvents() {
	//Flash Replacements
	$('#content.interactiveDemo').flash({
		src: 'Flash/Sunglasses_Shell.swf',
		width: 960,
		height: 485,
		wmode: 'transparent'
	}, {expressInstall: true});
	$('#shieldSideLink').flash({
		src: 'Flash/AkumaRolloversBlack.swf',
		width: 360,
		height: 50,
		wmode: 'transparent'
	}, {expressInstall: true});
	$('#content.dwProductDemo #demoArea').flash({
		src: 'Flash/carStandalone.swf',
		width: 960,
		height: 485,
		wmode: 'transparent',
		flashvars: { initScene: 'road', roadScene: 'car' }
	}, {expressInstall: true});
	$('#content.shieldProductDemo #demoArea').flash({
		src: 'Flash/akumaStandalone.swf',
		width: 960,
		height: 485,
		wmode: 'transparent',
		flashvars: { initScene: 'road', roadScene: 'bike' }
	}, {expressInstall: true});
	$('#content .shieldDemoLink').flash({
		src: 'Flash/ShieldLensButton.swf',
		width: 386,
		height: 203,
		wmode: 'transparent'
	}, {expressInstall: true});
	$('#exploreDW').flash({
		src: 'Flash/ExploreDrivewearButton.swf',
		width: 322,
		height: 141,
		wmode: 'transparent'
	}, {expressInstall: true});
	$('#shieldLink').flash({
		src: 'Flash/AkumaExploreDrivewearButton.swf',
		width: 322,
		height: 141,
		wmode: 'transparent'
	}, {expressInstall: true});
	$('#pnlDemoLnk').flash({
		src: 'Flash/demoBtn.swf',
		width: 378,
		height: 122,
		wmode: 'transparent'
	}, {expressInstall: true});
	$('#DWpnlDemo').flash({
		src: 'Flash/DrivewearSeeForYourselfButton_v01.swf',
		width: 284,
		height: 132,
		wmode: 'transparent'
	}, {expressInstall: true});
	$('#pnlGetWidget').flash({
		src: 'Flash/DrivewearWidgetButton_v01.swf',
		width: 284,
		height: 132,
		wmode: 'transparent'
	}, {expressInstall: true});
	
	//Event listners	
	$("#ulSecondaryNav li a").click(function(){
		if(!document.getElementById("ajaxContainer").getElementsByTagName("div")[0].className.match("home"))// //If the current page is not default (or a subpage of that) 
		{
			desired=$(this).attr('title')+"BG";
			navUi(this);
			hash = $(this).attr('href');
			document.getElementsByTagName('body')[0].className = "main";
			$.history.load('/'+hash.substr(0,hash.length-DOM.baseExtension.length));
			return false;
		}
		else {
			var cIndex = findCurrentIndex($("#content .panel")[0].className); 
			var nIndex = findCurrentIndex($(this).attr('href'));
			Slide2(cIndex,nIndex);
			return false;
		}
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
	$("#ulFooter li a, #ulTerms li a, #pnlInTheKnow a").click(function(){ 
			document.getElementById('lnkHome').focus();
			navUi(this);
			hash = $(this).attr('href');
			$.history.load('/'+hash.substr(0,hash.length-DOM.baseExtension.length));
			return false;
	});
	
	//-------------------What is Drivewear
	if(currentpage.match("DrivewearWhatis") || location.href.match("DrivewearWhatis")){
		$('#WeatherIcons').flash({
			src: 'Flash/weatherIcons.swf',
			width: 400,
			height: 190,
			wmode: 'transparent'
		}, {expressInstall: true});
		
		AppPopUp();
	}
	
	//-------------------Testimonials Page
	if(currentpage.match("DrivewearTestimonials") || location.href.match("DrivewearTestimonials")){
		$(".lightbox").click(function(){ 
			var vList = $(".lightbox");
			var index;
			for(i=0;i<vList.length;i++){ 
				if(vList[i] == this) { index = i;}
			}
			openLightBox(index); return false;
		});
		TempTestimonialsIEfix();
	}
	
} // Fire whenever a new page loads.

$(document).ready(function(){
	DefinePanelOrder();
	//Event listners
	SecondaryEvents();
});

//---------------- Validation Script--------------------//
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

function WebForm_OnSubmit() 
{
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