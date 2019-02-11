var hash = '';
var cTitle ="main";
function navUi(trigger) {
	$.each($('.'+DOM.navActiveClass), function(){
		$('.'+DOM.navActiveClass).removeClass(DOM.navActiveClass);
	});		
	$(trigger).addClass(DOM.navActiveClass);
}
function pageload(hash) {
	if(hash) {		
		$('#'+DOM.ajaxContainer).animate(ANIM.typeExit, ANIM.speed, function() {
				retreiveContent(hash)
			}
		);
	} else {}
}

function retreiveContent(hash) {
	$('#'+DOM.ajaxContainer).load(hash.substr(1)+DOM.baseExtension+' #'+DOM.contentContainer +'', function() {
			$('#'+DOM.ajaxContainer).animate(ANIM.typeEnter, ANIM.speed);
			$('#content.interactiveDemo').flash({
				src: 'Flash/Sunglasses_Shell_French.swf',
				width: 960,
				height: 485,
				wmode: 'transparent'
			}, {expressInstall: true});
			$('#pnlDemoLnk').flash({
				src: 'Flash/HomepageButtonFrench_v02.swf',
				width: 378,
				height: 122,
				wmode: 'transparent'
			}, {expressInstall: true});
			$('#content.experienceVideo #pnlVideo').flash({
				src: 'Flash/player.swf',
				width: 640,
				height: 410,
				wmode: 'transparent',
				flashvars: { src: '../Video/SOLFX-French-FINAL_hi.flv', slate: 'images/videoSlate.jpg' }
			}, {expressInstall: true});
			//--possible fix for second arrows bug;
			currP = findCurrentIndex(hash);
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
	$(DOM.navActivator+", #ulSecondaryNav li a").each(function(){
		var lnkhref = $(this).attr('href');
		if(hash.substr(1)+DOM.baseExtension == lnkhref) {
			if($(this).attr('title')){
				cTitle = $(this).attr('title').replace(/ /,"");
			}
			Ntitle = makeTitle($(this).attr('title'));
			document.title = DOM.basePageTitle+' // '+Ntitle;
			var t=setTimeout("setTitle()",ANIM.speed);
			document.getElementsByTagName('body')[0].className = cTitle;
			//Fix navigation issues that come with starting on a non-index page
			if(cTitle.match("sport") || cTitle.match("default") || cTitle.match("style") || cTitle.match("special"))
			{
				cTitle = findKey(cTitle);
				document.getElementsByTagName('body')[0].className = cTitle+"BG";
			}
			//FadeBG(cTitle);
		}
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

$(document).ready(function(){
	$.history.init(pageload);
	$(DOM.navActivator).click(function(){
		navUi(this);
		var hash = $(this).attr('href');
		$.history.load('/'+hash.substr(0,hash.length-DOM.baseExtension.length));
		return false;
	});
});