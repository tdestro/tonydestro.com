package com.healthysight{
	
	import flash.events.ProgressEvent;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.events.NetStatusEvent;
	import flash.events.AsyncErrorEvent;
	import flash.media.Video;
	import flash.media.SoundTransform;
	import flash.utils.Timer;
	import flash.events.TimerEvent;	
	import flash.events.MouseEvent;
	import flash.display.MovieClip;	
	
	import gs.TweenLite;		
	
	public class VideoPlayer extends MovieClip{
		
		public var rootPath:*;		
		private var url:String;
		public var nc:NetConnection;
		public var ns:NetStream;
		private var firstTimeBuffered:Boolean;
		public var st:SoundTransform;   //used to mute thumbnail audio
		private var repeatTimer:Timer;
		public var pauseBtn_mc:MovieClip;
		public var playBtn_mc:MovieClip;
		public var closeBtn_mc:MovieClip;
		public var video:Video;			
		private var playheadTimer:Timer;
		public var videoLength:*;
		public var thumbnail:*;
		public var close_btn:MovieClip;
		
		public var isPaused:Boolean;
		
		public function VideoPlayer(u:String, rp:*/*, t:*/):void{
			
            closeBtn_mc = new CloseBtn();
			addChild(closeBtn_mc);
			closeBtn_mc.x = 740;
			closeBtn_mc.visible = false;
			
			//thumbnail = t;
			playheadTimer = new Timer(300, 0);
			playheadTimer.addEventListener(TimerEvent.TIMER, updateTime);
			playheadTimer.start();
			
			
			firstTimeBuffered=true;			
			url=u;
			rootPath = rp;
			videoLength=0;
			
			playAgain_mc.alpha=0;
			playAgain_mc.visible=false;			

 			pauseBtn_mc.visible=false;
			playBtn_mc.visible=true;
			
			closeBtn_mc.buttonMode = pauseBtn_mc.buttonMode = playBtn_mc.buttonMode = true;

			
			//enable event listeners			
			closeBtn_mc.addEventListener(MouseEvent.CLICK, onCloseBtnClick);
			pauseBtn_mc.addEventListener(MouseEvent.CLICK, onPauseClick);			
			playBtn_mc.addEventListener(MouseEvent.CLICK, onPlayClick);

			audioSlider_mc.hitArea_mc.addEventListener(MouseEvent.CLICK, onVolumeBarClick);
			audioSlider_mc.hitArea_mc.addEventListener(MouseEvent.MOUSE_DOWN, onVolumeBarDown);
			
			videoBar_mc.addEventListener(MouseEvent.MOUSE_DOWN, onPlaybackDown);
			//videoBar_mc.addEventListener(MouseEvent.CLICK, onPlaybackScrub);
			
			//setVideoInfo(rootPath.videoList.currentCenteredThumbnail.info);
			//setVideoInfo(thumbnail.info);
						
			video = new Video();
			this.addChild(video);
			
			//put video behind play again button and close button;
			this.swapChildren(video, playAgain_mc);
			//rootPath.addChild(this);
			load();
			
		}
		
		
		
		////////////////////////////////////////////////////////
		///////////////  Volume bar handlers  //////////////////
		////////////////////////////////////////////////////////
		
		
		private function onVolumeBarClick(e:MouseEvent):void{
			/*
			var cp:Number = Math.abs(audioSlider_mc.hitArea_mc.height - e.localY);
			trace("localY: " + cp);		
			//volume percentage
			var pct:Number = (cp / audioSlider_mc.hitArea_mc.height);
			
			//audioSlider_mc.volumeBar_mc.y = e.localY;
			//audioSlider_mc.volumeBar_mc.scaleY = pct;
			audioSlider_mc.volumeBarCircle_mc.y = e.localY;
			
			st.volume=pct;
			ns.soundTransform = st;
			*/
		}
		
		
		
		private function onVolumeBarDown(e:MouseEvent):void{
			audioSlider_mc.gotoAndStop(2);
			
			stage.addEventListener(MouseEvent.MOUSE_UP, onVolumeBarUp);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onVolumeBarMove);
			
			var cp:Number = Math.abs(audioSlider_mc.hitArea_mc.height - e.localY);
			trace("localY: " + cp);		
			//volume percentage
			var pct:Number = (cp / audioSlider_mc.hitArea_mc.height);
			
			//audioSlider_mc.volumeBar_mc.y = e.localY;
			//audioSlider_mc.volumeBar_mc.scaleY = pct;
			audioSlider_mc.volumeBarCircle_mc.y = e.localY;
			
			st.volume=pct;
			ns.soundTransform = st;			
			
		}

		
		private function onVolumeBarMove(e:MouseEvent):void{
			
			var cp:Number;
			var pct:Number;
			if(stage.mouseY < audioSlider_mc.y)   /* set volume bar to 100% */
			{
				pct = 1;
				
				//audioSlider_mc.volumeBar_mc.y = 0;
				//audioSlider_mc.volumeBar_mc.scaleY = 1;
				audioSlider_mc.volumeBarCircle_mc.y = 4;
				
				st.volume=pct;
				ns.soundTransform = st;							
	
			}
			else if(stage.mouseY > audioSlider_mc.y + audioSlider_mc.hitArea_mc.height)   /* set volume bar to 0% */
			{
				pct = 0;
			
				
				//audioSlider_mc.volumeBar_mc.y = audioSlider_mc.hitArea_mc.height;
				//audioSlider_mc.volumeBar_mc.scaleY = pct;
				audioSlider_mc.volumeBarCircle_mc.y = audioSlider_mc.hitArea_mc.height /*-4*/;
				
				st.volume=pct;
				ns.soundTransform = st;										
			}
			else{
			
				cp = Math.abs(audioSlider_mc.bg_mc.height - audioSlider_mc.mouseY);
				
				//trace("localY: " + cp);		
				//volume percentage
				pct = (cp / audioSlider_mc.bg_mc.height);
				
				//audioSlider_mc.volumeBar_mc.y = audioSlider_mc.mouseY;
				//audioSlider_mc.volumeBar_mc.scaleY = pct;
				audioSlider_mc.volumeBarCircle_mc.y = audioSlider_mc.mouseY;
				
				st.volume=pct;
				ns.soundTransform = st;										
			}
		
			
		}
		
		private function onVolumeBarUp(e:MouseEvent):void{
			audioSlider_mc.gotoAndStop(1);
			
			stage.removeEventListener(MouseEvent.MOUSE_UP, onVolumeBarUp);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, onVolumeBarMove);
			
		}
		
		
		
		////////////////////////////////////////////////////////
		/////////////  Playback Slider Handlers  ///////////////
		////////////////////////////////////////////////////////
		
		
		private function onPlaybackDown(e:MouseEvent):void{
			playheadTimer.stop();			
			ns.pause();			
			stage.addEventListener(MouseEvent.MOUSE_UP, onPlaybackUp);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onPlaybackScrub);
			
			
			//////////  jump to position user clicks on playbar  /////////
			var lx:Number = videoBar_mc.mouseX;
			var pPct:Number = lx / videoBar_mc.playBarBg_mc.width;   //percent of playback to jump to
			var lgPctPlayed:Number = Math.ceil(pPct*100);
			pPct = lgPctPlayed/100;
		
			if(pPct >= 1){  //scrub took us past 100 percent
				endOfMovie(false);
				pPct=1;
			}
			else if(pPct <= 0){  //scrub took us to less than zero percent
				try{
					playBtn_mc.removeEventListener(MouseEvent.CLICK, onPlayAgainClick);
				}
				catch(e:Error){}
				try{
					playBtn_mc.addEventListener(MouseEvent.CLICK, onPlayClick);				
				}catch(e:Error){}
				playAgain_mc.visible=false;
				playAgain_mc.alpha=0;

				pPct=0;
				videoBar_mc.playhead_mc.x = videoBar_mc.playBarBg_mc.x;
				videoBar_mc.playLine_mc.width = videoBar_mc.playBarBg_mc.width * pPct;
			}
			else{  //we're in an acceptable scrubbing range
				try{
					playBtn_mc.removeEventListener(MouseEvent.CLICK, onPlayAgainClick);
				}
				catch(e:Error){}
				try{
					playBtn_mc.addEventListener(MouseEvent.CLICK, onPlayClick);					
				}catch(e:Error){}
				playAgain_mc.visible=false;
				playAgain_mc.alpha=0;				
			
				videoBar_mc.playhead_mc.x = videoBar_mc.playBarBg_mc.x + videoBar_mc.playBarBg_mc.width * pPct;
				videoBar_mc.playLine_mc.width = videoBar_mc.playBarBg_mc.width * pPct;
			}
	
			var pos:Number = pPct * Number(this.videoLength);
			ns.seek(pos);			
			

		}
		
		
		
		private function onPlaybackUp(e:MouseEvent):void{

			if(!isPaused){
				playheadTimer.start();
				ns.resume();
			}
			stage.removeEventListener(MouseEvent.MOUSE_UP, onPlaybackUp);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, onPlaybackScrub);
			
		}
		
		
		
		private function onPlaybackScrub(e:MouseEvent):void{
			
			var lx:Number = videoBar_mc.mouseX;
			var pPct:Number = lx / videoBar_mc.playBarBg_mc.width;   //percent of playback to jump to
			var lgPctPlayed:Number = Math.ceil(pPct*100); //round the percent in an effort to prevent bug
			pPct = lgPctPlayed/100;

			if(pPct >= 1){  //scrub took us past 100 percent
				endOfMovie(false);
				pPct=1;
			}
			else if(pPct <= 0){  //scrub took us to less than zero percent
				try{
					playBtn_mc.removeEventListener(MouseEvent.CLICK, onPlayAgainClick);
				}
				catch(e:Error){}
				try{
					playBtn_mc.addEventListener(MouseEvent.CLICK, onPlayClick);				
				}catch(e:Error){}
				playAgain_mc.visible=false;
				playAgain_mc.alpha=0;

				pPct=0;
				videoBar_mc.playhead_mc.x = videoBar_mc.playBarBg_mc.x;
				videoBar_mc.playLine_mc.width = videoBar_mc.playBarBg_mc.width * pPct;
			}
			else{  //we're in an acceptable scrubbing range
				try{
					playBtn_mc.removeEventListener(MouseEvent.CLICK, onPlayAgainClick);
				}
				catch(e:Error){}
				try{
					playBtn_mc.addEventListener(MouseEvent.CLICK, onPlayClick);					
				}catch(e:Error){}
				playAgain_mc.visible=false;
				playAgain_mc.alpha=0;				
			
				videoBar_mc.playhead_mc.x = videoBar_mc.playBarBg_mc.x + videoBar_mc.playBarBg_mc.width * pPct;
				videoBar_mc.playLine_mc.width = videoBar_mc.playBarBg_mc.width * pPct;
			}
	
	
			var pos:Number = pPct * Number(this.videoLength);
			ns.seek(pos);			
			
		}
		
		
		
		
		
		/////////////////////////////////////////////////////////
		////////////  Sets playhead every second  ///////////////
		/////////////////////////////////////////////////////////
		
		
		private function updateTime(e:TimerEvent){
			//trace("updatetime called");
			//show time played
			var t:Number = ns.time;
			var m:uint = t/60;
			var ms:String;
			if(m<10){
				ms="0" + m;
			}
			else{
				ms=String(m);
			}
			var s:uint = t % 60;
			var ss:String;
			if(s<10){
				ss="0" + s;
			}
			else{
				ss=String(s);
			}
			
			//time.text = String(String(ms) + ":" + String(ss));
			
			
			//update playhead
			var pctPlayed:Number = t/Number(this.videoLength);
			var lgPctPlayed:Number = Math.ceil(pctPlayed*100);
			var pPos:Number = videoBar_mc.playBarBg_mc.width * (lgPctPlayed/100);
			videoBar_mc.playLine_mc.width = pPos;
			videoBar_mc.playhead_mc.x = pPos;
			
			
		}
		
		
		
		
		/////////////////////////////////////////////////////////
		//////////  Sets initial video information  /////////////
		/////////////////////////////////////////////////////////
		
		
		
		private function setVideoInfo(info:Object):void{
			//playbackOverlay_mc.title.text = info.title;
			//playbackOverlay_mc.instructor.text = rootPath.instructorLookup[info.instructor];
			//playbackOverlay_mc.time.text = "0:00";
			
		}
		
		
	
		
		/////////////////////////////////////////////////////////////////////
		/////////////////////   Other Mouse Events   ////////////////////////
		/////////////////////////////////////////////////////////////////////
		
		
		
		private function onCloseClick(e:MouseEvent):void{
			fadeOut(true);
		}
		
		
		private function onPauseClick(e:MouseEvent):void{
			trace("pause btn clicked");
			playBtn_mc.visible=true;
			playBtn_mc.mouseEnabled=true;
			playBtn_mc.mouseChildren=true;				
			pauseBtn_mc.visible=false;
			pauseBtn_mc.mouseEnabled=false;
			pauseBtn_mc.mouseChildren=false;						
			
			ns.pause();	
			isPaused=true;
		}
		
		private function onPlayClick(e:MouseEvent):void{
			try{
				playBtn_mc.removeEventListener(MouseEvent.CLICK, onPlayAgainClick);
			}
			catch(e:Error){}
			playBtn_mc.addEventListener(MouseEvent.CLICK, onPlayClick);
			playBtn_mc.visible=false;
			playBtn_mc.mouseEnabled=false;
			playBtn_mc.mouseChildren=false;				
			pauseBtn_mc.visible=true;
			pauseBtn_mc.mouseEnabled=true;
			pauseBtn_mc.mouseChildren=true;				
	
			playheadTimer.start();
			ns.resume();
			isPaused=false;
			
		}
		
			
		
		///////////////////////////////////////////////////////////
		//////////////////  Fade In/Out  //////////////////////////
		///////////////////////////////////////////////////////////
		
		
		public function fadeIn():void{
			TweenLite.to(this, .4, {alpha:1, onComplete:startPlayback});
		}
		
		
		public function fadeOut(... optionalParams):void{
			//check to see if there should be a delay before exiting to main menu
			if(optionalParams.length > 0){
				if(optionalParams[0]==true){
					TweenLite.to(this, .4, {delay:1.5, alpha:0, onComplete:cleanup});			
				}
				else{
					TweenLite.to(this, .4, {alpha:0, onComplete:cleanup});
				}
			}
			else{//default is no delay
				TweenLite.to(this, .4, {alpha:0, onComplete:cleanup});
			}
		}
		
		
		
		
		
		//////////////////////////////////////////////////////////////////
		//////  Called when video is buffered and everything is ready  ///
		//////////////////////////////////////////////////////////////////
		
		
		private function startPlayback():void{
			//trace("startplayback called");
			//st.volume=1;
			ns.soundTransform = st;		
			ns.seek(0);
			ns.resume();
			pauseBtn_mc.visible=true;
			playBtn_mc.visible=false;
			isPaused=false;
		}
		
		
		
//////////////////////////////////////////////////////////////////		
		
		
		////////////////////////////////////////////////////////////////////
		/////////////////////////   Loads in flv   /////////////////////////
		////////////////////////////////////////////////////////////////////
		
		
		
		public function load():void{
			nc = new NetConnection();
			nc.connect(null);	
			ns = new NetStream(nc);
			//ns.client = new Object(); //turns off onmetadata error
			ns.client = new CustomClient(this);
			
			st = new SoundTransform();
			st.volume=1;
			ns.soundTransform = st;
			ns.bufferTime=15;
			ns.addEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler);
			ns.play(url);   //starts loading video
			ns.pause();  //pauses immediately, so user has to start by pressing play button
			attachNS(ns);  //attach the video stream to the video displayObject
			ns.addEventListener(NetStatusEvent.NET_STATUS, statusHandler);
		}
		
		
/*
mystream.onMetaData=function(infoObject:Object) {
for (var propName:String in infoObject) {
clipduration=infoObject.duration



}									
*/


		private function statusHandler(event:NetStatusEvent):void
		{
			switch (event.info.code)
			{
				case "NetStream.Buffer.Empty":
						trace("buffer empty");
						playheadTimer.stop();
					
					break;
				
				case "NetStream.Buffer.Full":
					trace("buffer full")
					if(firstTimeBuffered){
						//attachNS(ns);
					}
					else{
						playheadTimer.start();		
					}
					
						
					firstTimeBuffered=false;	
					break;
				
				case "NetStream.Play.Start":
					trace("play start")
					playheadTimer.start();
					break;
				
				case "NetStream.Play.Stop":
					trace("NetStream.Play.Stop called");
					//this is being triggered when it shouldn't be. put an extra check in to keep it honest.
					if(Math.round(ns.time) >= Math.round(this.videoLength)){
						endOfMovie();
					}
					break;
					
				case "NetStream.Pause.Notify":
					trace("pause notify");
					playheadTimer.stop();
					break;
					
				case "NetStream.Unpause.Notify":
					trace("unpause notify");
					playheadTimer.start();
					break;
					
			}
		}
		
		
		function asyncErrorHandler(event:AsyncErrorEvent):void
		{
			trace("thumbnail video error: "+event.text);
			// ignore error
		}
		
		
		
		
		////////////////////////////////////////////////////////////////////
		////////////   Attaches Loaded Netstream to our video   ////////////
		////////////////////////////////////////////////////////////////////
		
		private function attachNS(netStream:NetStream):void{
			this.video.width = 739;
			this.video.height= 370;
			
			this.video.x = 0;
			this.video.y = 0;
			this.video.alpha=1;
			this.video.visible=true;
			this.video.attachNetStream(netStream);
			
			
			//////////improves performance at the cost of image quality
			this.video.smoothing = false;
			this.video.deblocking=1;
			
			/*
    		myVideo.savedWidth = myVideo.width;
    		myVideo.savedHeight = myVideo.height;
   			myVideo.savedSmoothing = myVideo.smoothing;
    		myVideo.savedDeblocking = myVideo.deblocking;
			*/
			
			//////////////////////////
			
			
			netStream.seek(0);
			netStream.pause();
			//fadeIn();
			startPlayback();
			
		}
		
		
	
		////////////////////////////////////////////////////////////////////
		/////////////////////////   Loop Video   ///////////////////////////
		////////////////////////////////////////////////////////////////////		
		
		
		
		private function loopClip(e:TimerEvent):void{
			
			//continuously loop video
			ns.seek(0);
			ns.resume();			
			
		}	
	
	
		////////////////////////////////////////////////////////////////////
		/////////  Triggered when playhead reaches end of timeline  ////////
		////////////////////////////////////////////////////////////////////
	
		private function endOfMovie(tweenIn:Boolean=true):void{
			trace("endOfMovie called");
			playBtn_mc.visible=true;
			playBtn_mc.mouseEnabled=true;
			playBtn_mc.mouseChildren=true;				
			pauseBtn_mc.visible=false;
			pauseBtn_mc.mouseEnabled=false;
			pauseBtn_mc.mouseChildren=false;				

			playBtn_mc.addEventListener(MouseEvent.CLICK, onPlayAgainClick);
			
			//tween in the replay button
			playAgain_mc.visible=true;
			playAgain_mc.addEventListener(MouseEvent.CLICK, onPlayAgainClick);
			playAgain_mc.buttonMode=true;
			if(tweenIn){
				TweenLite.to(playAgain_mc, .4, {alpha:1});
			}
			else{
				playAgain_mc.alpha=1;
			}
			isPaused=true;
			videoBar_mc.playhead_mc.x = videoBar_mc.playBarBg_mc.width;
			videoBar_mc.playLine_mc.width = videoBar_mc.playBarBg_mc.width;
			
			
		}
		
		
		////////////////////////////////////////////////////////////////////
		/////////////////////  Play the Movie Again  ///////////////////////
		////////////////////////////////////////////////////////////////////
		
		private function onPlayAgainClick(e:MouseEvent):void{
			try{
				playBtn_mc.removeEventListener(MouseEvent.CLICK, onPlayAgainClick);
			}
			catch(e:Error){}
			playBtn_mc.addEventListener(MouseEvent.CLICK, onPlayClick);			
			
			playAgain_mc.buttonMode=false;
			TweenLite.to(playAgain_mc, .4, {alpha:0});
			
			playBtn_mc.visible=false;
			playBtn_mc.mouseEnabled=false;
			playBtn_mc.mouseChildren=false;				
			pauseBtn_mc.visible=true;
			pauseBtn_mc.mouseEnabled=true;
			pauseBtn_mc.mouseChildren=true;							
			
			ns.seek(0);
			ns.resume();
			isPaused=false;
			playheadTimer.start();

						
			
		}
		
		private function onCloseBtnClick(e:MouseEvent):void{
			
			TweenLite.to(this, .5, {alpha:0, onComplete:cleanup});
			
		}
	
		//////////////////////////////////////////////////////////////////////////
		///////////////   Make Video Ready for Garbage Collector   ///////////////
		//////////////////////////////////////////////////////////////////////////
		
		
		
		public function cleanup():void{
			this.video=null;
			ns.pause();
			ns.removeEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler);
			ns.removeEventListener(NetStatusEvent.NET_STATUS, statusHandler);						
			pauseBtn_mc.removeEventListener(MouseEvent.CLICK, onPauseClick);			
			playBtn_mc.removeEventListener(MouseEvent.CLICK, onPlayClick);
			
			
			//remove audio slider controls
			audioSlider_mc.hitArea_mc.removeEventListener(MouseEvent.CLICK, onVolumeBarClick);	
			audioSlider_mc.hitArea_mc.removeEventListener(MouseEvent.MOUSE_DOWN, onVolumeBarDown);	
			
			
			//remove video slider controls
			videoBar_mc.removeEventListener(MouseEvent.MOUSE_DOWN, onPlaybackDown);
			videoBar_mc.removeEventListener(MouseEvent.CLICK, onPlaybackScrub);	
		
			
			if(stage.hasEventListener(MouseEvent.MOUSE_UP)){
				try{
					stage.removeEventListener(MouseEvent.MOUSE_UP, onPlaybackUp);
				}
				catch(e:Error){trace(e)}
			}
			if(stage.hasEventListener(MouseEvent.MOUSE_MOVE)){
				try{
					stage.removeEventListener(MouseEvent.MOUSE_MOVE, onPlaybackScrub);
				}
				catch(e:Error){trace(e)}
			}
			
			st=null;
			ns=null;
			nc=null;
			
			playheadTimer.stop();
			playheadTimer.removeEventListener(TimerEvent.TIMER, updateTime);
			playheadTimer= null;
			
			this.stage.removeChild(this);
			
		}		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
//////////////////////////////////////////////////////////////////////		
		
		
	}
		
	
}




	internal class CustomClient {
		public var par:*;
		
		public function CustomClient(p:*):void{
			par = p;
		}
		
    	public function onMetaData(info:Object):void {
       		trace("metadata: duration=" + info.duration + " width=" + info.width + " height=" + info.height + " framerate=" + info.framerate);
			par.videoLength = info.duration;
			
    	}
   		public function onCuePoint(info:Object):void {
        	trace("cuepoint: time=" + info.time + " name=" + info.name + " type=" + info.type);
    	}
	}