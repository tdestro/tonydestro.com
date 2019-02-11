$(document).ready(function(){
	/*$('#content.interactiveDemo').flash({
		src: 'Flash/Sunglasses_Shell.swf',
		width: 960,
		height: 485,
		wmode: 'transparent'
	}, {expressInstall: true});*/
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
	/*$('#WeatherIcons').flash({
		src: 'Flash/weatherIcons.swf',
		width: 400,
		height: 190,
		wmode: 'transparent'
	}, {expressInstall: true});*/
	$('#content.experienceVideo #pnlVideo').flash({
		src: 'Flash/player.swf',
		width: 640,
		height: 410,
		wmode: 'transparent',
		flashvars: { src: '../Video/sunglass031209_hsfl_hi-2.flv', slate: 'images/videoSlate.jpg' }
	}, {expressInstall: true});
});