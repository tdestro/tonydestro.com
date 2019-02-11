package com.healthysight.impairments{
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.filters.BlurFilter;	
	import flash.filters.BitmapFilterQuality;
	import flash.display.Sprite;	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import org.papervision3d.PaperBase;
	import com.healthysight.PanoramaModule;
	import com.healthysight.events.ImpairmentEvent;
	import com.healthysight.graphics.BlurMask;
	import gs.*;
		
	public class Presbyopia extends Sprite{
		
		private var filter_bmp:Bitmap;
		private var filter_bmd:BitmapData;
		private var blurMask_mc:BlurMask;
		private var blur:BlurFilter;
		private var blurFilter:BlurFilter;
		private var filtersArray:Array;
		private var dispMatrix:Matrix;
		private var container:PanoramaModule;
		
		public function Presbyopia(_container:PanoramaModule){
			//this impairment doesn't load any outside content, so we can dispatch loaded event immediately			
			container = _container;			
			
			container.loaderBg_mc.dispatchEvent(new ImpairmentEvent({evtType:ImpairmentEvent.LOADED, name:"presbyopia"}));
		}
		
		public function init(){
			trace("presbyopia effect initialized");
			////////////////////////////////////////////			
			////////////  add blur filter  /////////////
			////////////////////////////////////////////

			TweenFilterLite.to(container.panoramaScene.effectsLayer, 2, {blurFilter:{blurX:25, blurY:25, quality:2}});
		}
		
		
		/////////  copies portion of screen to bitmapdata  /////////////
		private function onEnterFrame(e:Event){
			
			var mx:int=container.mouseX -300;
			var my:int=container.mouseY -300;
			var dispMatrix:Matrix = new Matrix();
			dispMatrix.translate(-mx, -my);

			filter_bmp.x=blurMask_mc.x=mx;
			filter_bmp.y=blurMask_mc.y=my;		
			
			filter_bmp.visible=false;
			filter_bmd.draw(container, dispMatrix, null, null, new Rectangle(0, 0, 600, 600));
			filter_bmp.visible=true;
			
			filter_bmp.bitmapData = filter_bmd;
			
		}		
		
		
		/////////////////////////////////////////////////////////////
		/////////////////////  disable effect  //////////////////////
		/////////////////////////////////////////////////////////////
		
		public function disable():void{
			TweenFilterLite.to(container.panoramaScene.effectsLayer, 2, {blurFilter:{blurX:0, blurY:0, quality:2, onComplete:finishDisabling}});	
		}		
		
		
		private function finishDisabling(){
			blur=null;
			filtersArray=null;
			container.plane.filters = null;
		}
		
		
		
	}
	
	
}