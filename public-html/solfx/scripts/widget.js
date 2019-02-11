$(function(){
	$('#dwMyspace').click(function(){
		$('#pnlEmbedWidget').removeAttr('style');
		return false;
	});
	$('#lnkCloseCode').click(function(){
		$('#pnlEmbedWidget').attr('style', 'display: none;');
		return false;
	})
});