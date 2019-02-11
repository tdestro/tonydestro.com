package com.healthysight.impairments{
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.filters.BlurFilter;	
	import flash.filters.BitmapFilterQuality;
	import flash.display.Sprite;	
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.display.Loader;
    import flash.net.URLRequest;		
	import org.papervision3d.PaperBase;
	import com.healthysight.PanoramaModule;	
	import com.healthysight.events.ImpairmentEvent;
	import com.healthysight.graphics.BlurMask;
	
	import gs.*;
	
	public class Retinopathy extends Sprite{
		
		private var filter_bmp:Bitmap;
		private var filter_bmd:BitmapData;
		private var blurMask_mc:BlurMask;
		private var blur:BlurFilter;
		private var filtersArray:Array;
		private var dispMatrix:Matrix;
		private var container:PanoramaModule;
		private var img:Bitmap;
		private var ldr:Loader;			
		
		public function Retinopathy(_container:PanoramaModule){
			container = _container;		
			
			
			/////////////////////////////////////////////////////////////////////
			///////////////////////////  load in png  ///////////////////////////
			/////////////////////////////////////////////////////////////////////
			
			ldr = new Loader();
			configureListeners(ldr.contentLoaderInfo);
			var url:String = "images/disease_pngs/diabeticRetinopathy.png";
			var urlReq:URLRequest = new URLRequest(url);
			ldr.load(urlReq);			
			
			
			container.loaderBg_mc.dispatchEvent(new ImpairmentEvent({evtType:ImpairmentEvent.LOAD_START, name:"retinopathy"}));
						
		}
		
		public function init(){
			
			filter_bmp = new Bitmap();
			filter_bmd = new BitmapData(600, 600, false);
			blurMask_mc = new BlurMask();
			filter_bmp.mask = blurMask_mc;
			container.addChild(filter_bmp);
				
			img.alpha=0;
			container.addChild(img);			
			TweenLite.to(img, 1, {alpha:1});				
	
			////////////////////////////////////////////			
			////////////  add blur filter  /////////////
			////////////////////////////////////////////
			TweenFilterLite.to(filter_bmp, 1, {blurFilter:{blurX:25, blurY:25, quality:2}});						
	
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			
		}
		
		
		
		/////////////////////////////////////////////////////////////////////
		/////////////////  configure png loader listeners  //////////////////
		/////////////////////////////////////////////////////////////////////
		
		private function configureListeners(dispatcher:IEventDispatcher):void {
            //dispatcher.addEventListener(Event.COMPLETE, completeHandler);
            //dispatcher.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
            dispatcher.addEventListener(Event.INIT, initHandler);
            //dispatcher.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
            //dispatcher.addEventListener(Event.OPEN, openHandler);
            dispatcher.addEventListener(ProgressEvent.PROGRESS, progressHandler);
            //dispatcher.addEventListener(Event.UNLOAD, unLoadHandler);
     	}	
		
		private function initHandler(e:Event){
			img = e.currentTarget.content;			
			container.loaderBg_mc.dispatchEvent(new ImpairmentEvent({evtType:ImpairmentEvent.LOADED, name:"retinopathy"}));			
			
		}
		
		private function progressHandler(e:ProgressEvent){
			container.loaderBg_mc.dispatchEvent(new ImpairmentEvent({evtType:ImpairmentEvent.PROGRESS, name:"retinopathy", bytesLoaded:e.bytesLoaded, bytesTotal:e.bytesTotal}));			
		}
		
		
		
		/////////  copies portion of screen to bitmapdata  /////////////
		private function onEnterFrame(e:Event){
			if(container.cameraRotationEnabled && !container.videoLock){						
				var mx:int=container.mouseX - 300;
				var my:int=container.mouseY - 300;
				var dispMatrix:Matrix = new Matrix();
				dispMatrix.translate(-mx, -my);
	
				filter_bmp.x=blurMask_mc.x=mx;
				filter_bmp.y=blurMask_mc.y=my;		
				
				filter_bmp.visible=false;
				filter_bmd.draw(container, dispMatrix, null, null, new Rectangle(0, 0, 600, 600));
				filter_bmp.visible=true;
				
				filter_bmp.bitmapData = filter_bmd;
			}
			
		}		
		
		
		/////////////////////////////////////////////////////////////
		/////////////////////  disable effect  //////////////////////
		/////////////////////////////////////////////////////////////
		
		public function disable():void{
			TweenFilterLite.to(filter_bmp, 1, {alpha:0, blurFilter:{blurX:0, blurY:0}, onComplete:finishDisabling});
			TweenLite.to(img, 1, {alpha:0});
		}

		private function finishDisabling(){
			this.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			container.removeChild(filter_bmp);		
			container.removeChild(img);			
			filter_bmp.filters=null;
			filter_bmp.mask = null;
			filter_bmp = null;
			blurMask_mc = null;			
		}
		
	}
	
	
}