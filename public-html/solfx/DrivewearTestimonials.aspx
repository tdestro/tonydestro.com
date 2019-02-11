<%@ Page Language="VB" ContentType="text/html" ResponseEncoding="UTF-8" Debug="True" %>
<%@ Import Namespace="System.Web.Mail" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Security.Principal" %>
<%@ Import Namespace="System.Security.Permissions" %>
<!--#include file="_incl/baseURL.aspx"-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>SolFX // Drivewear Testimonials</title>
        <meta name="description" content="Inquiry thank you page" />
        <meta name="keywords" content="" />
        <meta name="robots" content="NOINDEX, NOFOLLOW" />
		<!--#include file="_incl/css-js.aspx"-->
        <asp:literal id="litFB" runat="server"></asp:literal>
        <asp:literal id="litRSS" runat="server"></asp:literal>
        <!-- litFB and litRSS Literals require baseURL.aspx -->
	</head>
	<body class="DrivewearTestimonials">
	<!--#include file="_incl/GlobalHeader.aspx"-->
	<div id="wrapper">
	<div id="ajaxContainer">
       <div id="content" class="Testimonials">
        	<div id="drivewearNav">
				<ul>
        			<li><a href="Drivewear.aspx" title="Drivewear" class="first">Drivewear</a></li>
					<li><a href="DrivewearWhatis.aspx" title="What is Drivewear">What is Drivewear?</a></li>
					<li><a href="DrivewearTestimonials.aspx" title="Drivewear Testimonials" class="active last">Testimonials</a></li>
				</ul>
                <div id="navArrows">
                	<a id="dwnPrev" href="DrivewearWhatis.aspx" title="What is Drivewear">Previous page</a>
                	<a id="dwnNext" href="Drivewear.aspx" title="Drivewear">Next Page</a>
                </div>
        	</div>
            <h1>Drivewear Testimonials</h1>
            <p>Enhanced vision, reduced eye fatigue, total comfort and convenience – just a few of the words spoken by our wearers.</p>
			<div id="testimonialBtns">
            	<a href="DrivewearTestimonialsDetail.aspx#calvinScaff" title="Read full testimonial of Calvin Scaff" class="lightbox"> 
                	<span class="picture"><img src="images/testimonials/test_CalvinScaff.jpg" alt="Calvin Scaff" /></span>
					<strong>Calvin Scaff</strong>
					<span>November 2008</span>
                    <span class="content">
                    	<img src="images/testimonials/DetailCalvinScaf.jpg" alt="Calvin Scaff" />
                    	<strong class="name">Calvin Scaff</strong>
						<span class="location">November 2008</span>
                    	<strong>"Reduces Glare, Increases Contrast"</strong>
                    	<br/><br/>
                        <span>I am a bus driver for Greater Cleveland Regional Transit Authority (RTA). I LOVE these glasses. I have had clear to dark Transitions lenses before, but they did not work at all when driving. My Drivewear glasses work GREAT!!! As a bus driver, I fight glare all the time and drive in all conditions: low light, bright light and fog. These glasses help me to be a more aware and safer driver. Safety is so important when you have a bus loaded with customers that are putting their lives in your hands. "Drivewear" says it all. Thank you.</span>
                    	<br/><br/><em>Calvin Scaff</em>                    
                   </span>
                  <span class="plus"></span> 
                </a>
            	<a href="DrivewearTestimonialsDetail.aspx#colleenHoaulfuss" title="Read full testimonial of Colleen Hoaulfuss" class="lightbox"> 
                	<span class="picture"><img src="images/testimonials/test_ColleenHoaulfuss.jpg" alt="Colleen Hoaulfuss" /></span>
					<strong>Colleen Hoaulfuss</strong>
					<span>October 2008</span>
                    <span class="content">
                    	<img src="images/testimonials/DetailColleenHoaulfuss.jpg" alt="Colleen Hoaulfuss" />
                    	<strong class="name">Colleen Hoaulfuss</strong>
						<span class="location">October 2008</span>
                    	<strong>"Sun Up to Sun Down"</strong>
                    	<br/><br/>
                        <span>Just completed a five day hike in the Grand Canyon. I wore my Drivewear lenses from sun up to sun down; they were wonderful. I would definitely recommend them to hikers. Even on overcast days they are light enough to wear comfortably.</span>
                    	<br/><br/><em>Colleen Hoaulfuss</em>                    
                   </span>
                  <span class="plus"></span> 
                </a>
                <a href="DrivewearTestimonialsDetail.aspx#paulKing" title="Read full testimonial of Paul King" class="lightbox"> 
                	<span class="picture"><img src="images/testimonials/test_PaulKing.jpg" alt="Paul King" /></span>
					<strong>Paul King</strong>
					<span>March 2009</span>
                    <span class="content">
                    	<img src="images/testimonials/DetailPaulKing.jpg" alt="John Doe" />
                    	<strong class="name">Paul King</strong>
						<span class="location">March 2009</span>
                    	<strong>"Our Patients Love It"</strong>
                    	<br/><br/>
                        <span>I like to talk about my love of Younger Optics’ Drivewear lens. Almost every month, 8% to 10% of our sales are Drivewear and our patients just love the lens. I bring my glasses with Drivewear lenses into the office every day. I just leave them on my dispensing table. Over half of our patients will ask about them just by seeing the lens sit there.</span>
                    	<br/><br/><em>Paul King</em>                    
                   </span>
                  <span class="plus"></span> 
                </a>
                <a href="DrivewearTestimonialsDetail.aspx#howardGoyer" title="Read full testimonial of Howard Goyer" class="lightbox"> 
                	<span class="picture"><img src="images/testimonials/test_HowardGoyer.jpg" alt="Howard Goyer" /></span>
					<strong>Howard Goyer</strong>
					<span>April 2008</span>
                    <span class="content">
                    	<img src="images/testimonials/DetailHowardGoyer.jpg" alt="Howard Goyer" />
                    	<strong class="name">Howard Goyer</strong>
						<span class="location">April 2008</span>
                    	<strong>"Under the Florida Sun"</strong>
                    	<br/><br/>
                        <span>My Drivewear lenses are fantastic. I live in Florida and have used photochromic lenses before, but most of the photochromic lenses don’t get dark enough in the heat of the Florida sun. That’s why I love my Drivewear lenses, they get dark even when it’s hot. For anyone who wants a photochromic lens, Drivewear is it.</span>
                    	<br/><br/><em>Howard Goyer</em>                    
                   </span>
                  <span class="plus"></span> 
                </a>
                <a href="DrivewearTestimonialsDetail.aspx#cyndiWideman" title="Read full testimonial of Cyndi Wideman" class="lightbox"> 
                	<span class="picture"><img src="images/testimonials/test_CyndiWideman.jpg" alt="Cyndi Wideman" /></span>
					<strong>Cyndi Wideman</strong>
					<span>March 2009</span>
                    <span class="content">
                    	<img src="images/testimonials/DetailCyndiWideman.jpg" alt="Cyndi Wideman" />
                    	<strong class="name">Cyndi Wideman</strong>
						<span class="location">March 2009</span>
                    	<strong>"I Am Amazed"</strong>
                    	<br/><br/>
                        <span>I need the best vision possible when riding my motorcycle and my optometrist suggested Drivewear. At first I was skeptical; now I am amazed! Clear vision on any kind of day! I had them made up in polycarbonate for extra safety.<br />I have always been a fan of brown lenses, so finding a polarized transitional lens in these colors makes them ideal! I love them so much I had pair made up for my significant other for his birthday!</span>
                    	<br/><br/><em>Cyndi Wideman</em>                    
                   </span>
                  <span class="plus"></span> 
                </a>
                <a href="DrivewearTestimonialsDetail.aspx#mikeMerrich" title="Read full testimonial of Mike Merrich" class="lightbox"> 
                	<span class="picture"><img src="images/testimonials/test_MikeMerrich.jpg" alt="Mike Merrich" /></span>
					<strong>Mike Merrich</strong>
					<span>April 2009</span>
                    <span class="content">
                    	<img src="images/testimonials/DetailMikeMerrich.jpg" alt="Mike Merrich" />
                    	<strong class="name">Mike Merrich</strong>
						<span class="location">April 2009</span>
                    	<strong>"Comfort After Cataract Surgery"</strong>
                    	<br/><br/>
                        <span>I recently had cataract surgery on both eyes. My vision has been poor most of my life so removing the cataracts allowed the physician to implant intraocular lenses. I am now 20/20 in one eye 20/40 in the other. However the (intraocular) lenses resulted in a higher sensitivity to light.<br />Drivewear lenses have allowed me to comfortably drive, play and work in all environments. They are a godsend. Thank you, Drivewear.</span>
                    	<br/><br/><em>Mike Merrich</em>                    
                   </span>
                  <span class="plus"></span> 
                </a>
                <a href="DrivewearTestimonialsDetail.aspx#joeBonchard" title="Read full testimonial of Joe Bonchard" class="lightbox"> 
                	<span class="picture"><img src="images/testimonials/test_JoeBonchard.jpg" alt="Joe Bonchard" /></span>
					<strong>Joe Bonchard</strong>
					<span>March 2009</span>
                    <span class="content">
                    	<img src="images/testimonials/JoeBonchardDetail.jpg" alt="Joe Bonchard" />
                    	<strong class="name">Joe Bonchard</strong>
						<span class="location">March 2009</span>
                    	<strong>"Well Traveled"</strong>
                    	<br/><br/>
                        <span>I have been wearing my Drivewear lenses for about a year. My first experience was on a cruise to the Caribbean, and the lenses were fabulous. Recently my wife and I were in Costa Rica and I found the performance to be incredible. Whether in bright sun, the rainforest or the cloud forest, the lenses were always the correct density. While at a volcanic hot springs, we overstayed into the nighttime and I didn’t have my clear eyeglasses with me. But, it didn’t matter as the glasses provided me with proper contrast and density. Truly one pair of sunglasses for me, and my first recommendation to all my customers.</span>
                    	<br/><br/><em>Joe Bonchard</em>                    
                   </span>
                  <span class="plus"></span> 
                </a>
                <a href="DrivewearTestimonialsDetail.aspx#natalieEddy" title="Read full testimonial of Natalie Eddy" class="lightbox"> 
                	<span class="picture"><img src="images/testimonials/test_NatalieEddy.jpg" alt="Natalie Eddy" /></span>
					<strong>Natalie Eddy</strong>
					<span>August 2008</span>
                    <span class="content">
                    	<img src="images/testimonials/DetailNatalieEddy.jpg" alt="Natalie Eddy" />
                    	<strong class="name">Natalie Eddy</strong>
						<span class="location">August 2008</span>
                    	<strong>"Comfortable Inside and Outside"</strong>
                    	<br/><br/>
                        <span>I wore my Drivewear lenses to the county fair. They were comfortable sitting under the bright sun during the Tiger show, but light enough to wear inside the habitat hall, too!!<br />They are so comfortable in the car, but I also love them at the beach! As an eyecare professional, I haven’t been this excited about a new product in years, and I tell my patients about them!</span>
                    	<br/><br/><em>Natalie Eddy</em>                    
                   </span>
                  <span class="plus"></span> 
                </a>
                <a href="DrivewearTestimonialsDetail.aspx#sterlingEpps" title="Read full testimonial of Sterling Epps" class="lightbox"> 
                	<span class="picture"><img src="images/testimonials/test_SterlingEpps.jpg" alt="Sterling Epps" /></span>
					<strong>Sterling Epps</strong>
					<span>February 2009</span>
                    <span class="content">
                    	<img src="images/testimonials/SterlingEpps.jpg" alt="Sterling Epps" />
                    	<strong class="name">Sterling Epps</strong>
						<span class="location">February 2009</span>
                    	<strong>"Recommend for Public Safety"</strong>
                    	<br/><br/>
                        <span>I have been a law enforcement office for over 40 years. I am a retired deputy chief of police. The problem with previous sunglasses is that you have to have them on outside and remove them inside. The Drivewear lens is such that it is as good inside as outside, in direct sunlight or shade, in a car or in a store. Your vision is not diminished by location of sunlight.<br />I recommend Drivewear to all public safety officers including lifeguards, boating safety personnel and firefighters. These are the best sunglasses I have ever owned. Thanks for a superior product at a reasonable price.</span>
                    	<br/><br/><em>Sterling Epps</em>                    
                   </span>
                  <span class="plus"></span> 
                </a>
                <a href="DrivewearTestimonialsDetail.aspx#nguyetDao" title="Read full testimonial of Nguyet Dao" class="lightbox"> 
                	<span class="picture"><img src="images/testimonials/test_NguyetDao.jpg" alt="Nguyet Dao" /></span>
					<strong>Nguyet Dao</strong>
					<span>December 2008</span>
                    <span class="content">
                    	<img src="images/testimonials/DetailNguyetDao.jpg" alt="Nguyet Dao" />
                    	<strong class="name">Nguyet Dao</strong>
						<span class="location">December 2008</span>
                    	<strong>"Breathtaking Sight"</strong>
                    	<br/><br/>
                        <span>My friends and I decided to drive up to Mt. Hamilton, about 45 minutes from San Jose (heading to the top of Mt. Hamilton to Lick Observatory). It’s the tallest mountain overlooking Silicon Valley.<br />It was sunny and the weather was beautiful. The sight was amazing and I was able to see very clearly with my Drivewear sunglasses. It was breathtaking.</span>
                    	<br/><br/><em>Nguyet Dao</em>                    
                   </span>
                  <span class="plus"></span> 
                </a>
                <a href="DrivewearTestimonialsDetail.aspx#jimSanchez" title="Read full testimonial of Jim Sanchez" class="lightbox"> 
                	<span class="picture"><img src="images/testimonials/test_JimSanchez.jpg" alt="Jim Sanchez" /></span>
					<strong>Jim Sanchez</strong>
					<span>November 2008</span>
                    <span class="content">
                    	<img src="images/testimonials/DetailJimSanchez.jpg" alt="Jim Sanchez" />
                    	<strong class="name">Jim Sanchez</strong>
						<span class="location">November 2008</span>
                    	<strong>"Work Behind Helmet"</strong>
                    	<br/><br/>
                        <span>I love my new lenses. I wear them to ride my motorcycle all the time. They have just the right amount of tint for full sun, and if I get caught out after sundown, they are still very usable for the ride home. They work great behind the visor on my helmet, which my other Transitions lenses did not.</span>
                    	<br/><br/><em>Jim Sanchez</em>                    
                   </span>
                  <span class="plus"></span> 
                </a>
                <a href="DrivewearTestimonialsDetail.aspx#jayArroyo" title="Read full testimonial of Jay Arroyo" class="lightbox"> 
                	<span class="picture"><img src="images/testimonials/test_JayArroyo.jpg" alt="Jay Arroyo" /></span>
					<strong>Jay Arroyo</strong>
					<span>March 2009</span>
                    <span class="content">
                    	<img src="images/testimonials/DetailJayArroyo.jpg" alt="Jay Arroyo" />
                    	<strong class="name">Jay Arroyo</strong>
						<span class="location">March 2009</span>
                    	<strong>"Goodbye Maui Jim, Hello Drivewear"</strong>
                    	<br/><br/>
                        <span>Goodbye Maui Jim Polarized sunglasses - I used to have two pairs in my car. Living in the Pacific NW, I would alternate wearing each pair depending on the weather - on overcast days - I would usually use the lighter brown lens tint and on bright sunny days - the darker blue tint. Now Drivewear is all I need.</span>
                    	<br/><br/><em>Jay Arroyo</em>                    
                   </span>
                  <span class="plus"></span> 
                </a>
            </div>
      </div>
	</div>
	<!--#include file="_incl/GlobalCategoryNavigation.aspx"-->
	<!--#include file="_incl/GlobalFooter.aspx"-->