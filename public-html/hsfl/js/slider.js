/*
 * 	sunKING.Sliding.Gallery - Sliding with jQuery
 *  http://www.sunkingdigital.com
 *
 * Dual licensed under the MIT (MIT-LICENSE.txt)
 * and GPL (GPL-LICENSE.txt) licenses.
 *
 * Built on top of the jQuery library with the interface plugin for animation
 * http://jquery.com
 *
 * Inspired by CAKE PHP dot ORG and some shitty carousel plugin found elsewhere
 *
 */
var slidingGallery={
	init:function(){
		$("body").addClass("awesome"); 
			/* adding this class allows our styles to not overwrite your styles. Make your carousel skin classes looky like this...  body.awesome .className {} */
		slidingGallery.Features.init();
		
	},
	Features:{
		init:function(){
			smartContent.init($(".panels"));
		}
	}
}
var smartContent={
	container:null,
	panels:Array(),
	init:function(container){
		smartContent.container=$(container);
		$('.panel',smartContent.container).each(
			function(i){
				var newPanel={};
				newPanel.element=this;
				newPanel.id=this.id;
				newPanel.index=i;
				smartContent.panels[i]=newPanel;
			}
		)
		smartContent.createToggles();
		smartContent.showPanel(smartContent.panels[0]);
	},
	createToggles:function(){
		var smartContentParent=$(".slidingGalleryContainer")[0];
		
		var toggleBtnBarLeft=document.createElement("div");
		toggleBtnBarLeft.className="toggleButtonsLeft";
		smartContentParent.appendChild(toggleBtnBarLeft);
		
		var toggleBtnBarRight=document.createElement("div");
		toggleBtnBarRight.className="toggleButtonsRight";
		smartContentParent.appendChild(toggleBtnBarRight);

		next=document.createElement("a");
		next.className="next";
		next.href="#";
		$(next).click(function() {smartContent.showNextPanel(); return false;})

		previous=document.createElement("a");
		previous.className="previous";
		previous.href="#";
		$(previous).click(function() {smartContent.showPreviousPanel(); return false;})

		toggleBtnBarRight.appendChild(next);
		toggleBtnBarLeft.appendChild(previous);

	},
	showPanel:function(panel){
		var l = ($(".panel")[0].clientWidth)*panel.index;
		smartContent.container.animate({left:"-"+l+"px"},300,"easeboth");
		smartContent.activePanelIndex=panel.index;
	},
	
	showNextPanel:function(){
		var traceEnd = ($(".slidingGalleryContainer")[0].clientWidth)/($(".panel")[0].clientWidth);
		if (smartContent.activePanelIndex<(smartContent.panels.length-[traceEnd])){
			nextIndex=smartContent.activePanelIndex+1;
		}
		else{
			nextIndex=0;
		}
		smartContent.showPanel(smartContent.panels[nextIndex]);
	},
	
	showPreviousPanel:function(panel){
		var traceStart = ($(".slidingGalleryContainer")[0].clientWidth)/($(".panel")[0].clientWidth);
		//alert ([traceStart]);
		if (smartContent.activePanelIndex>(0)){
			nextIndex=smartContent.activePanelIndex-1;
		}else{
			nextIndex=smartContent.panels.length-3;
		}
		smartContent.showPanel(smartContent.panels[nextIndex]);
	}	
}
// okay, make 'er happen
$(document).ready(function(){
	slidingGallery.init()}
	);
