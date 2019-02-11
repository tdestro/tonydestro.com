package com.healthysight{
	/*
	//////////////////////////////////////////////////////
	This module loads in a VideoPlayer object, as well as
	a ShareVideo object. It's loaded into the shell swf for
	the Healthy Sight website. Used to play videos and
	share them with others.
	
	-Chris Natale
	/////////////////////////////////////////////////////
	*/
	
	
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	import com.healthysight.VideoPlayer;
    import com.healthysight.DropDown;
	import com.healthysight.ShareVideoComponent;
	import com.pixelwelders.events.Broadcaster;
	import com.healthysight.Shell;
	
	public class VideoModulePano extends MovieClip{
		
		var vp:VideoPlayer; 
		var sv:ShareVideoComponent;
		//var drop:DropDown;
		var drop:ShareWidget;		
		var flashVars;
		var filePath:String;
		public var p:*;
		
		public function VideoModulePano(){

			filePath = setFilePath();
			addEventListener(Event.ADDED_TO_STAGE,go);
		}
		
		private function go(evt:Event):void
		{
			var videoPlayerURL;
			removeEventListener(Event.ADDED_TO_STAGE,go);
			//debugBox.text = videoPlayerURL = filePath + "video/"+String(this.root.loaderInfo.parameters.video);
			videoPlayerURL = filePath + "video/video1.flv";
			
			vp = new VideoPlayer(videoPlayerURL, this.stage);
			//vp.x=110;
			//vp.y=20;
			this.x=100;
			this.y=20;
			vp.x=20;
			vp.y=20;
			sv = new ShareVideoComponent();
			vp.close_btn.x+=25;
			vp.close_btn.y-=25;
			
			this.addChild(vp);
			
			vp.close_btn.buttonMode=true;
			vp.swapChildren(vp.video, vp.close_btn);
			vp.close_btn.addEventListener(MouseEvent.CLICK, onCloseClick);
			
			/*
			drop = new DropDown();
			drop.y = 450;
			drop.x = (stage.width/2) -47.5;
			this.addChild(drop);
			*/
			
			sv = new ShareVideoComponent();
			drop = new ShareWidget();
			drop.y = 465;
			drop.x = (this.width/4) -140;
			
			this.addChild(drop);			
			
		}		
		
		protected function setFilePath():String{
			var fp:String;
			if(this.stage){
				fp = "../";
			}
			else{
				fp = "";
			}
			return fp;
		}		
		
	
		private function onCloseClick(e:MouseEvent){
			removeEventListener(MouseEvent.CLICK, onCloseClick);
			removeVideo();
		}
		
		public function removeVideo(){
			this.visible=false;
			vp.ns.pause();
			this.removeChild(vp);
			stage.getChildByName("root1").removeVideo();
			//this.removeChild(sv);
			//this.removeChild(drop);
		}
	}
	
	
}