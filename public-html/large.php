<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	
	var height = $('.galleryImage').height();
	var width = $('.galleryImage').width();
	
    parent.$.fn.colorbox.resize({
       innerWidth: width,
        innerHeight: height,
		scrolling:  false
    });
});
</script>
<script type="text/javascript">

  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', 'UA-40195474-2']);
  _gaq.push(['_setDomainName', 'tonydestro.com']);
  _gaq.push(['_trackPageview']);

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();

</script>
</head>
<body style="margin:0px; padding:0px;">
<?php

list($width, $height, $type, $attr) = getimagesize($_GET["url"]);

echo '<img class="galleryImage" '.$attr.' src="'.htmlspecialchars($_GET["url"]).'" border=0>';

?>
</body>
</html>