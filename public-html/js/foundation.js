$(function()
 {
  // Prepare layout options.
  var options = {
   autoResize: true, // This will auto-update the layout when the browser window is resized.
   container: $('#main'), // Optional, used for some extra CSS styling
   offset: 0, // Optional, the distance between grid items
   itemWidth: 260 // Optional, the width of a grid item
  };
   $("#ted").hide();
   $(".standard_body").hide();
   


$("#about").click(function () {
            $(".standard_body").toggle("slow");
        });
		

$("#interupt").click(function () {
            $("#ted").toggle("slow");
        });


  // Get a reference to your grid items.
  var handler = $('#tiles li');

  // Call the layout function.
  handler.wookmark(options);
  handler.pShadow();
  
  $.get('images/logo_images.txt', function(data){
            var array = String(data).split('&');
            
		   window.logocount=0;
			 
	       window.myAnim = setInterval(function() {
		
            
			if(window.logocount > array.length) window.logocount = 0;
			$("#logoimage").attr('src', array[window.logocount]);
			window.logocount++;
			}
			
			, 42);

			
        });    
		
 	 
	
  $('a.gallery').colorbox({
   iframe:true, 
   scrolling:false, 
   title:function () {
    if($(this).attr('demo')){
     return (this.title) +" "+ "LIVE DEMO".link($(this).attr('demo'));
    }
    else {
	 return (this.title);
    }
   }
  });
 

});

