var hash = '';
var trigger = '';
var progress, Ntitle, inContent, ext, gIndex, pstatus,sel,column1High,column2High;
var Pchange = 0;
var panels = new Array();
var currP = 0;

var desired = "";
//----------------------- ECP FINDER Javascript Version-----------------------------//
function ECPstyles() {
	$(".submit_input").remove();

	if($("body")[0].className.match("WheretoGetDrivewear"))
	{
		
		//Map and Print Buttons
		for(i=0;i<$("#resultsContent table td .orange").length+10;i++)
		{
			if($("#resultsContent table td .orange:eq("+i+")")[0])
			{
				if($("#resultsContent table td .orange:eq("+i+")")[0].innerHTML.match("Map")){
					$("#resultsContent table td .orange:eq("+i+")").addClass("MapIT").removeClass("orange");
				}
				if($("#resultsContent table td .orange:eq("+i+")")[0].innerHTML.match("Print")){
					$("#resultsContent table td .orange:eq("+i+")").addClass("PrintIT");
					//var hV = $("#resultsContent table td .orange:eq("+i+")")[0].href;
					//$("#resultsContent table td .orange:eq("+i+")")[0].href = "http://en-us.transitions.com"+hV.substring(hV.indexOf("/tools"));
				}
				if($("#resultsContent table td .orange:eq("+i+")")[0].innerHTML.match("Learn")){
					$("#resultsContent table td .orange:eq("+i+")")[0].innerHTML = "Learn More";
					$("#resultsContent table td .orange:eq("+i+")").addClass("learnMoreBtn");
				}
			}
		}
		
		//Bold Office Names
		for(i=0;i<$("#resultsContent tr tr td").length+10;i++)
		{
			$("#resultsContent tr tr td:eq("+i+") span:eq(0)").addClass("strong");
		}
		
		//Identify first and last td's in each tr entry
		for(i=0;i<$("#resultsContent tr tr td").length+10;i++)
		{
			if($("#resultsContent tr tr td:eq("+i+")")[0])
			{
				if($("#resultsContent tr tr td:eq("+i+")")[0].innerHTML.match('<ul class="ecpL">')){
					$("#resultsContent tr tr td:eq("+i+")").addClass("first");									   
				}
				if($("#resultsContent tr tr td:eq("+i+")")[0].innerHTML.match('miles</strong>')){
					$("#resultsContent tr tr td:eq("+i+")").addClass("last");									   
				}
			}
		}
		
		$("#resultsContent .first").remove();
		
		//Re-Style Table Headers
		for(i=0;i<$("#resultsContent tr td div").length;i++)
		{
			if(!$("#resultsContent tr td div")[i].innerHTML.match("<TABLE")){//IE6
				if(!$("#resultsContent tr td div")[i].innerHTML.match("<table")){
					$("#resultsContent tr td div:eq("+i+")").addClass("GRAY");
					$("#resultsContent tr td div:eq("+i+")").css({'background' : 'transparent url(images/resultHeader_small.gif) no-repeat','height' : '25px','text-transform' : 'uppercase','font-size' : '13px', 'width':'260px', 'padding':'10px 0 0 10px'});
				}
			}
		}
		
		//Remove Last Table Row
		for(i=0;i<$("#resultsContent td table tr").length;i++)
		{
			if($("#resultsContent td table tr:eq("+i+") td")[0].innerHTML.match("<table") || $("#resultsContent td table tr:eq("+i+") td")[0].innerHTML.match("<TABLE")){
				$("#resultsContent td table tr:eq("+i+")").remove();
			}
		}
		
		//Identify Main tables
		var tableCategory = 1;
		for(i=0;i<$("#resultsContent td").length;i++)
		{
			if($("#resultsContent td:eq("+i+")")[0]){
				if($("#resultsContent td:eq("+i+")")[0].innerHTML.match("<table") || $("#resultsContent td:eq("+i+")")[0].innerHTML.match("<TABLE")){
					$("#resultsContent td:eq("+i+")")[0].id="Category"+tableCategory;
					tableCategory++;
				}
			}
		}
		/*
		//Start Pagination  - This works but we want it removed for the time being...
		
		//Resize page
		$(".WheretoGetDrivewearResults #ajaxContainer").css({'height' : '900px'});
		
		var d,a,e;
		f=0;a=0;e=0;
		column1High = 0;
		column2High = 0;
		for(i=0;i<$("#resultsContent td table").length;i++){ 
			$("#resultsContent td table")[i].className="Col"+(i+1);
			a=0;e=0;//Reset and e values before running the new loop.
			for(d=0;d<$("#resultsContent td table:eq("+i+") tr").length;d++){
				if(a>1){a=0; e++;}
				$("#resultsContent td table:eq("+i+") tr:eq("+d+")").addClass("group"+e+" col"+(i+1));
				a++;
			}
			if(i==0)
			{ column1High = e;}
			if(i==1)
			{ column2High = e;}
		}
		
		if(column1High>e)
		{e=column1High;}
	
		sel = 0;
		$("#resultsContent").prepend("<div id='pagControls'><a href='#' id='Wprev'> </a><div id='pagNums'></div><a href='#' id='Wnext'> </a></div>");
		for(i=0;i<e;i++){
			$("#resultsContent #pagControls #pagNums").append("<a href='#' id='num"+i+">"+(i+1)+"</a>");	
		}
		
		$("#resultsContent #pagControls #pagNums a").click(function(){													
			ResultsPagSwitch(this.innerHTML-1,e);									   
			return false;								   
		});
		$("#pagControls #Wprev").click(function(){
			ResultsPagSwitch(sel-1,e);									   
			return false;								   
		});
		$("#pagControls #Wnext").click(function(){
			ResultsPagSwitch(sel+1,e);									   
			return false;								   
		});
		$("#resultsContent td table tr").addClass("hide");
		var group = "group"+sel;
		$("#resultsContent td table ."+group).removeClass("hide");
		*/
	}
}

function ResultsPagSwitch(num,total) 
{
	if($("body")[0].className.match("WheretoGetDrivewear"))
	{
		var cnumOne,cnumTwo,group;
		cnumOne = num;
		cnumTwo = num;
		if(num<0){ 
			cnumOne=column1High-1; 
			cnumTwo=column2High-1; 
			num=total-1;
		}
		if(num>=column1High){ cnumOne=0;}
		if(num>=column2High){ cnumTwo=0;}
		if(num>=total){ num=0;}
		
		sel = num;
		$("#resultsContent td table tr").addClass("hide");
		
		group = "group"+cnumOne;
		$("#resultsContent td .Col1 ."+group).removeClass("hide");
		group = "group"+cnumTwo;
		$("#resultsContent td .Col2 ."+group).removeClass("hide");
	}
}

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
		if(location.href.match("#/DrivewearTestimonials")){
			var loc = location.pathname.substring(0,(location.pathname.lastIndexOf("/")+1))+"DrivewearTestimonials.aspx?Testimonials";
			window.location.assign(loc);
		}
		else if(location.href.match("#/http://transitions.com/sunwear/DrivewearTestimonials")){
			var loc = location.pathname.substring(0,(location.pathname.lastIndexOf("/")+1))+"DrivewearTestimonials.aspx?Testimonials";
			window.location.assign(loc);
		}
		else if(location.href.match("#/http://sk-devserver:58/transitions/solfx/DrivewearTestimonials")){
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
		src: 'Flash/akuma/Panorama_Screen.swf?initScene=road&roadScene=car&menuOff=true',
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
	$('#WeatherIcons').flash({
		src: 'Flash/weatherIcons.swf',
		width: 400,
		height: 190,
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
	$(".lightbox").click(function(){ 
		var vList = $(".lightbox");
		var index;
		for(i=0;i<vList.length;i++){ 
			if(vList[i] == this) { index = i;}
		}
		openLightBox(index); return false;
	});
	AppPopUp();
	ECPstyles();
	TempTestimonialsIEfix();
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