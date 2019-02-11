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
	import gs.*;	
	
	public class Glaucoma extends Sprite{
		
		private var filter_bmp:Bitmap;
		private var filter_bmd:BitmapData;
		private var blur:BlurFilter;
		private var filtersArray:Array;
		private var dispMatrix:Matrix;
		private var container:PanoramaModule;
		private var img:Bitmap;
		private var ldr:Loader;		
		
		public function Glaucoma(_container:PanoramaModule){
			container = _container;		
			
			/////////////////////////////////////////////////////////////////////
			///////////////////////////  load in png  ///////////////////////////
			/////////////////////////////////////////////////////////////////////
			
			ldr = new Loader();
			configureListeners(ldr.contentLoaderInfo);

			var url:String = "images/disease_pngs/glaucoma.png";
			var urlReq:URLRequest = new URLRequest(url);
			ldr.load(urlReq);			
			container.loaderBg_mc.dispatchEvent(new ImpairmentEvent({evtType:ImpairmentEvent.LOAD_START, name:"glaucoma"}));

		}
		
		///// called by panorama module whenever the ok button is clicked ////
		public function init(){
			trace("glaucoma init called");
			img.alpha=0;
			container.addChild(img);			
			TweenLite.to(img, 1, {alpha:1});			
			
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
			container.loaderBg_mc.dispatchEvent(new ImpairmentEvent({evtType:ImpairmentEvent.LOADED, name:"glaucoma"}));
			img = e.currentTarget.content;
		}
		
		private function progressHandler(e:ProgressEvent){
			container.loaderBg_mc.dispatchEvent(new ImpairmentEvent({evtType:ImpairmentEvent.PROGRESS, name:"glaucoma", bytesLoaded:e.bytesLoaded, bytesTotal:e.bytesTotal}));
		}
		

		
		/////////////////////////////////////////////////////////////
		/////////////////////  disable effect  //////////////////////
		/////////////////////////////////////////////////////////////
		
		public function disable():void{
			//TweenFilterLite.to(filter_bmp, 1, {alpha:0, blurFilter:{blurX:0, blurY:0}, onComplete:finishDisabling});
			TweenLite.to(img, 1, {alpha:0, onComplete:finishDisabling});
		}
		
		private function finishDisabling(){
			//container.removeChild(filter_bmp);		
			container.removeChild(img);
			//filter_bmp.filters = null;
			//filter_bmp.mask= null;
			//filter_bmp = null;
			//blurMask_mc = null;			
		}
		
		
	}
	
	
}