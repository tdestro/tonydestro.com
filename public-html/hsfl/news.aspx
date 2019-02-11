﻿<%@ Page Language="VB" ContentType="text/html" ResponseEncoding="UTF-8" Debug="True"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>Transitions Healthy Sight for Life Fund | News</title>
		<link rel="stylesheet" type="text/css" href="css/hsfl.css" />
		<link rel="stylesheet" type="text/css" href="css/sliderSkin.css" />
        <link rel="stylesheet" type="text/css" href="css/temp.css" />
		<script type="text/javascript" src="js/jquery.js"></script>
		<script type="text/javascript" src="js/interface.js"></script>
		<script type="text/javascript" src="js/slider.js"></script>
        <script type="text/javascript">
		var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
		document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));
		</script>
		<script type="text/javascript">
		try {
		var pageTracker = _gat._getTracker("UA-6684215-2");
		pageTracker._trackPageview();	}
		catch(err) {}
		</script>
		<!--[if lt IE 7]>
			<link rel="stylesheet" type="text/css" href="css/ie.css" />
		<![endif]-->
		<script type="text/javascript">
			$(function(){
				$('a.pdf').attr('target', '_blank');
			});
		</script>
	</head>
	<body id="news">
		<div><a href="#content" class="nodisplay">skip to content</a></div>
		<div id="container">
			<ul id="ulCorpNav">
				<li><a href="index.aspx" id="lnkHome">Home</a></li>
				<li><a href="news.aspx" id="lnkNews">News</a></li>
				<li><a href="contact.aspx" id="lnkContact">Contact</a></li>
			</ul>
			<h1 id="hHSFL"><a href="index.aspx">Transitions Healthy Sight For Life Fund</a></h1>
			<ul id="ulMainNav">
				<li><a href="enhance-and-protect.aspx" id="lnkEnhance">Enhance &amp; Protect Your Sight</a></li>
				<li><a href="about-the-fund.aspx" id="lnkAbout">About the Fund</a></li>
				<li><a href="get-involved.aspx" id="lnkGetInvolved">Get Involved</a></li>
				<li><a href="professional-resources.aspx" id="lnkResources">Professional Resources</a></li>
				<li><a href="vision-scholarships.aspx" id="lnkScholarship">Vision Scholarships</a></li>
			</ul>
			<div id="content">
				<div id="pnlHeader">
					<h2>Transitions Healthy Sight for Life Fund News</h2>
					<p>Check back for more news from the Transitions Healthy Sight for Life Fund.</p>
				</div>
				<div id="pnlMainContent">
					<h3 id="NewsFeed">Transitions Latest News</h3>
                    <asp:Xml Runat="server" DocumentSource="rss.xml" TransformSource="rss.xsl" ID="NewsFeed1" />
					<div class="slidingGalleryContainer" id="buttonToggle">
					<div style="overflow: visible; display: block;" class="panels" id="pHolder">
                    <noscript>
                    <style type="text/css">
					#pnlMainContent div#buttonToggle.slidingGalleryContainer div.panels { left:0px; height:3700px; width:100%; background: #f9f9f9; }
                    </style>
                    </noscript>
                    <script type="text/javscript">
					document.getElementById("pHolder").style.left = "-1100px";
                    </script>
							<div id="pnlBCAB" class="panel">
								<h3>Butler County Association for the Blind</h3>
								<p>The Prevention of Blindness program provides screening for approximately 7,000 children a year at 83 sites, including preschool, kindergarten and first grade, and through programs geared toward Head Start participants and special-needs children of all ages.  </p>
								<p>The organization, located in western Pennsylvania, used the grant from the Transitions<sup>&reg;</sup> Healthy Sight for Life Fund to purchase new, updated equipment to help maintain accurate screenings.  Plans also included expansion of free screenings to additional schools and improvement of educational programs. </p>
								<a href="http://www.butlercountyfortheblind.org" rel="external">www.butlercountyfortheblind.org</a>
							</div>
							<div id="pnlCEC" class="panel">
								<h3>Camden Eye Center (CEC)</h3>
								<p>The SIGHT FIRST FOR KIDS program provides free and low-cost eye care to the economically disadvantaged residents of Camden City and surrounding areas of New Jersey.  Camden City now ranks as the poorest city in the nation, with 44 percent of the city&rsquo;s roughly 80,000 residents living in poverty.  Of the 30,400 children in Camden City, 50 percent are living at or below the poverty level.  Since 1961, approximately 236,000 patients have visited CEC&rsquo;s three main offices and Mobile Vision Clinic.  To this day, the CEC is the only free-standing, non-profit facility of its kind in the state of New Jersey.</p>
								<p>The donation from the Transitions<sup>&reg;</sup> Healthy Sight for Life Fund provided 6,227 children with comprehensive eye examinations, treatment services, prescription eye wear and screenings.</p>
								<a href="http://www.camdeneye.com" rel="external">www.camdeneye.com</a>
							</div>
							
							<div id="pnlCPS" class="panel">
								<h3>The Center for the Partially Sighted</h3>
								<p>Dedicated to helping people of all ages with impaired sight live, work and play independently, the Center for the Partially Sighted offers comprehensive low-vision services to 2,400 individuals each year.  It provides education about vision and vision loss to thousands more, including the general public, health care professionals and educators. </p>
								<p>With the donation through the Transitions&reg; Healthy Sight for Life Fund, a program helped students from a local school understand what it meant to be visually impaired.  Developed by a family resource specialist, the interactive program involved various stations that children and their parents and teachers visited.  Staff members demonstrated magnifiers and other devices, taught cane travel, simulated vision loss with special glasses and showed adaptive technology, like large-print books and talking items.</p>
								<a href="http://www.low-vision.org" rel="external">www.low-vision.org</a>
							</div>
							
							<div id="pnlCPSEI" class="panel">
								<h3>Coalition to Prevent Sports Eye Injuries</h3>
								<p>The Coalition to Prevent Sports Eye Injuries works to accomplish two goals: eliminate the use of &ldquo;street wear,&rdquo; or everyday eyeglasses in sports, and increase the wear of protective eyewear among those who do not need corrective eyewear.</p>
								<p>The grant contributes to the Coalition&rsquo;s grassroots efforts to raise awareness among student athletes, parents, coaches and sports leagues about the need for ASTM-approved protective eyewear. The campaign includes brochures and other public outreach materials.</p>
								<a href="http://www.sportseyeinjuries.com" rel="external">www.sportseyeinjuries.com</a>
							</div>
							
							<div id="pnlDCVR" class="panel">
								<h3>Spectrios Institute for Low Vision</h3>
								<p>Spectrios Institute for Low Vision travels throughout Illinois, offering low-vision clinics for children in grades K-12 with severe visual impairments.  Annually, 350 children are provided with a free low-vision exam and devices, including magnifiers, telescopes, prescription glasses and sunglasses. </p>
								<p>The grant supported the printing of educational handouts for distribution to children, their families and teachers and at school health fairs.  It also provided wraparound sunglasses to protect children&rsquo;s eyes from harmful ultraviolet rays and prevent dust and other objects from entering the eye.  Eighty percent of program participants were prescribed Transitions&reg; lenses for glare reduction and increased comfort in variable lighting conditions.  </p>
								<p>A survey of the children after they received their eyewear revealed that 38% improved the quality of their school work and 27% increased their participation in classroom activities. </p>
								<a href="http://www.spectrios.org/" rel="external">www.spectrios.org</a>
							</div>
							
							<div id="pnlEVF" class="panel">
								<h3>Essilor Vision Foundation</h3>
								<p>The Adopt-A-School program helps children receive vision correction by educating parents about the need for annual eye exams and working closely with school nurses and other non-profit organizations, such as Lions Clubs International and Prevent Blindness America.</p>
								<p>The donation from the Transitions<sup>&reg;</sup> Healthy Sight for Life Fund helps provide eye exams and eyeglasses to children in need. The program&rsquo;s goal is to provide 5,000 pairs of glasses.</p>
								<a href="http://www.essilorvisionfoundation.org" rel="external"></a>
							</div>
							
							<div id="pnlOrbis" class="panel">
								<h3>ORBIS Canada</h3>
								<p>Works to prevent blindness in developing countries by enhancing the skills of the local ophthalmic community so that they are better equipped to treat and prevent eye diseases prevalent in rural communities.</p>
								<p>The Transitions<sup>&reg;</sup> Healthy Sight for Life Fund grant supports the organization&rsquo;s initiatives to establish eye care centers in medically underserved areas of Bangladesh, China, Ethiopia, India and Vietnam.</p>
								<a href="http://www.orbiscanada.ca" rel="external">www.orbiscanada.ca</a>
							</div>
							
							<div id="pnlPBF" class="panel">
								<h3>Prevent Blindness Florida</h3>
								<p>The See the Difference Vision program strives to educate diabetics on the importance of regular eye exams and identify individuals with undiagnosed diabetic retinopathy.  The goals of the program are to provide screenings, dilated eye exams and treatment for individuals in financial need. </p>
								<p>The donation from the Transitions<sup>&reg;</sup> Healthy Sight for Life Fund supports events in the Tampa area, which provide attendees with on-site screening for diabetic retinopathy, conducted by local ophthalmologists.  To ensure healthy eye habits, all attendees receive educational information about the importance of regular eye exams.  After a positive detection for diabetic retinopathy is made, Prevent Blindness Florida determines eligibility for no-cost treatment. </p>
								<a href="http://www.preventblindnessflorida.org" rel="external">www.preventblindnessflorida.org</a>
							</div>
							
							<div id="pnlVHI" class="panel">
								<h3>Vision Health International (VHI)</h3>
								<p>VHI is a U.S.-based, non-profit, volunteer organization dedicated to the delivery of free vision-care services and sight-restoring surgery to the medically underserved populations in Latin America.  </p>
								<p>VHI&rsquo;s one-week field program, Restoring the Gift of Sight to Guatemala: 2008, was made possible exclusively through donations.  The donation from the Transitions<sup>&reg;</sup> Healthy Sight for Life Fund was used to acquire medical and surgical supplies and to defray other costs, such as shipping, transportation and volunteer expenses.  Over 1,000 patients, some coming on foot and many travelling considerable distances, made their way to the VHI clinic to be seen.  Following an eye examination by an ophthalmologist to determine the extent of vision loss, over 700 pairs of eyeglasses were dispensed and 119 surgeries were performed.  </p>
								<a href="http://www.visionhealth.org/about.html" rel="external">www.visionhealth.org/about.html</a>
							</div>
							
							<div id="pnlPBA" class="panel">
								<h3>Prevent Blindness America</h3>
								<p>Focused on promoting a continuum of vision care, Prevent Blindness America touches the lives of millions of people each year through public and professional education, advocacy, certified vision screenings, community and patient service programs and research.</p>
								<p>Drawing on support from the Transitions<sup>&reg;</sup> Healthy Sight for Life Fund, Prevent Blindness America has expanded its efforts to make the importance of UV protection for the eyes top-of-mind among consumers.  An online UV Learning Center, sponsored by Transitions, teaches about the dangers of UV exposure and the importance of UV-blocking eyewear.  The site features specific tips on protecting the eyes from the sun, UV safety news, plus a quiz for consumers to test their UV knowledge.  The site has contributed to more than 300,000 visitors to date.  </p>
								<a href="http://www.preventblindness.org" rel="external">www.preventblindness.org</a>
							</div>
							
							<div id="pnlCNIB" class="panel">
								<h3>CNIB</h3>
								<p>The partnership between the Transitions<sup>&reg;</sup> Healthy Sight for Life Fund and CNIB raises awareness about the need to protect the eyes from UV damage and expand vision-loss education and prevention programs.</p>
								<p>A collaboration among Transitions Optical, CNIB and Scholastic &ndash; a distributor of children&rsquo;s books &ndash; will reach over 10,000 Ontario teachers of grades four to six through distribution of teaching materials, classroom exercises and parent take-home information, which highlight the importance of eye health and UV protection.</p>
								<a href="http://www.cnib.ca" rel="external">www.cnib.ca</a>
							</div>
							
							<div id="pnlEDF" class="panel">
								<h3>Fondation des maladies de l&rsquo;oeil (The Eye Disease Foundation)</h3>
								<p>The &ldquo;Join and See&rdquo; campaign has reached 21,700 Quebec families with school-aged children with the support of the Transitions<sup>&reg;</sup> Healthy Sight for Life Fund.  Through the program, a tour &ndash; spanning 46 primary schools in 12 regions &ndash; serves as a forum to provide children with free vision screenings and remind parents of the importance of annual eye exams and sight-enhancing eyewear at school and at home.</p>
								<p>As a result of the screenings, some children were identified as needing a more thorough eye exam, and parents were notified to schedule an appointment with an optometrist or ophthalmologist.  More than 400 pairs of eyeglasses were distributed to lower-income families identified through the tour in 2008 &ndash; reinforcing the important role that vision wear can play in a child&rsquo;s performance at school.  </p>
								<a href="http://www.fondationdesmaladiesdeloeil.org" rel="external">www.fondationdesmaladiesdeloeil.org</a>
							</div>
						</div>
					</div>
				</div>
				<div id="pnlSecondary">
					<div class="left">
						<h2>How We Support</h2>
						<p><a href="get-involved.aspx">See How to Get Involved.</a></p>
					</div>
					<div class="right">
						<h2>How We Educate</h2>
						<p><a href="professional-resources.aspx">View Our Resources.</a></p>
					</div>
				</div>
				<ul id="ulFooter">
					<li><a href="enhance-and-protect.aspx">Enhance &amp; Protect Your Sight</a></li>
					<li><a href="about-the-fund.aspx">About the Fund</a></li>
					<li><a href="get-involved.aspx">Get Involved</a></li>
					<li><a href="professional-resources.aspx">Professional Resources</a></li>
					<li><a href="news.aspx">Fund News</a></li>
					<li><a href="privacy.aspx">Privacy</a></li>
					<li><a href="terms-and-conditions.aspx">Terms and Conditions</a></li>
					<li class="last"><a href="contact.aspx">E-Mail Us</a></li>
				</ul>
				<p id="pCopyright">&copy; 2009 Transitions Optical, Inc.</p>
				<p id="pLegal">Transitions and the swirl are registered trademarks and Healthy sight in every light and customized eyeglass prescription are trademarks of Transitions Optical, Inc.</p>
			</div>
		</div>
	</body>
</html>