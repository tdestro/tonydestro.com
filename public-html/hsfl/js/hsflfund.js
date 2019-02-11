$(document).ready(function(){
	//External links open in a new window
	$('a[rel="external"]').attr('target', '_blank');
	
	//accordions
	$('.accordion').Accordion({
		headerSelector : 'dt',
		panelSelector : 'dd',
		activeClass : 'accActive',
		alwaysOpen: false,
		showSpeed: 400,
		hideSpeed: 800
	});
	
});