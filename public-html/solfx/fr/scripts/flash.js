$(document).ready(function(){
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
});