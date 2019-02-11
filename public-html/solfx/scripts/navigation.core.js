var hash = '';
var cTitle ="main";
var currentpage ="default";
function navUi(trigger) {
	$.each($('.'+DOM.navActiveClass), function(){
		$('.'+DOM.navActiveClass).removeClass(DOM.navActiveClass);
	});		
	$(trigger).addClass(DOM.navActiveClass);
}
function pageload(hash) {
	if(hash) {		
		$('#'+DOM.ajaxContainer).animate(ANIM.typeExit, ANIM.speed, function() {
				retreiveContent(hash);
			}
		);
	} else {}
}

function retreiveContent(hash) {
	$('#'+DOM.ajaxContainer).load(hash.substr(1)+DOM.baseExtension+' #'+DOM.contentContainer +'', function() {
			$('#'+DOM.ajaxContainer).animate(ANIM.typeEnter, ANIM.speed);
			//   Flash Replacements   //
			$('#content.experienceVideo #pnlVideo').flash({
				src: 'Flash/player.swf',
				width: 640,
				height: 410,
				wmode: 'transparent',
				flashvars: { src: '../Video/sunglass031209_hsfl_hi-2.flv', slate: 'images/videoSlate.jpg' }
			}, {expressInstall: true});
			//--possible fix for second arrows bug;
			currP = findCurrentIndex(hash);
			
			SecondaryEvents();
			
			$(DOM.navActivator).click(function(){
				navUi(this);
				var hash = $(this).attr('href');
				return  navHandler(hash);
			});
			
			//Change Body Class
			$(DOM.navActivator+", #ulSecondaryNav li a ").each(function(){
				var lnkhref = "default.aspx";
				if($(this).attr('href')){
					lnkhref = $(this).attr('href');
				}
				//if(hash.substr(1)+DOM.baseExtension == lnkhref)
				if(lnkhref.toLowerCase().match((hash.substr(1)+DOM.baseExtension).toLowerCase())) {
					if($(this).attr('title')){
						cTitle = $(this).attr('title').replace(/ /g,"").replace(/'/g,"");
					}
					Ntitle = makeTitle($(this).attr('title'));
					document.title = DOM.basePageTitle+' // '+Ntitle;
					var t=setTimeout("setTitle()",ANIM.speed);//Backup of the command directly above, only it's delayed by the amount of miliseconds in the standard animation
		
					if(cTitle.match("sport") || cTitle.match("default") || cTitle.match("style") || cTitle.match("special")){
						cTitle = findKey(cTitle);
						document.getElementsByTagName('body')[0].className = cTitle+"BG";
					}
					else {
						document.getElementsByTagName('body')[0].className = cTitle;
					}
				}
			});//End Page title change.
			
		});
	
	analyticTracker(hash+DOM.baseExtension);
}

function analyticTracker(analyticHash) {
	if(ANALYTICS.google == true) {
		pageTracker._trackPageview(analyticHash);
	}
	else if(ANALYTICS.omniture == true) {
	 	
	}
	else if (ANALYTICS.webtrends == true) {
		
	}
	else if (ANALYTICS.reinvigorate == true) {
		
	}
	else {};
 };
 
function navHandler(hash) {
	var terms = false;
	if(hash.indexOf("#")>0){
		hash = hash.substr(hash.indexOf("#"));				
	}
	//_______________ Force page re-loads when in Internet Explorer to prevent browser hang-ups
	if($("html")[0].className.match("msie")){
		if(currentpage == hash || location.href.match("DrivewearDemo") || location.href.match("shieldDemo")){
			terms = true;
		}
	}
	
	if(terms == true){ 
		return true
	}else{
		$.history.load('/'+hash.substr(0,hash.length-DOM.baseExtension.length));
		currentpage = hash;
		return false;
	}	
}

$(document).ready(function(){
	$.history.init(pageload);
	$(DOM.navActivator).click(function(){
		navUi(this);
		var hash = $(this).attr('href');
		return  navHandler(hash);
	});
});