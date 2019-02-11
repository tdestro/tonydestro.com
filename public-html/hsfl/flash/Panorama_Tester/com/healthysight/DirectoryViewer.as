package com.healthysight {
	import flash.filesystem.*;
	import flash.events.*;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import com.healthysight.events.FileSelectEvent;
	import org.papervision3d.objects.parsers.DAE;	
	import org.papervision3d.events.FileLoadEvent;	
	
	public class DirectoryViewer{
		
		var dir:File;
		var currentFile:File;
		var defaultDirectory:File;
		var dataChanged:Boolean;
		var stream:FileStream;
		var ldr:Loader;
		var dae:DAE;		
		var p:*;  ///the parent displayobject
		
		
		public function DirectoryViewer(_p:*){
			
			p= _p;
			defaultDirectory = File.documentsDirectory;
			//openFile("Bg"); //load a bg file upon initialization
			
		}
		
		
		///////// pass in either Bg, VisionOverlay, or SceneObject as parameter /////////
		public function openFile(type:String="Bg"):void
		{ 
		
			var fileChooser:File;
			if (currentFile) 
			{
				fileChooser = currentFile;
			}
			else
			{
				fileChooser = defaultDirectory;
			}
			fileChooser.browseForOpen("Open");
			
			
			try{		
				fileChooser.removeEventListener(FileSelectEvent.SELECT, bgFileOpenSelected);	
			}catch(e:Error){}
			try{
				fileChooser.removeEventListener(FileSelectEvent.SELECT, overlayFileOpenSelected);	
			}catch(e:Error){}
			try{
				fileChooser.removeEventListener(FileSelectEvent.SELECT, objectFileOpenSelected);			
			}catch(e:Error){}
			try{
				fileChooser.removeEventListener(FileSelectEvent.SELECT, impairmentFileOpenSelected);			
			}catch(e:Error){}
			
			
			switch(type){
				case "Bg":
					fileChooser.addEventListener(FileSelectEvent.SELECT, bgFileOpenSelected);
					break;
					
				case "VisionOverlay":
					fileChooser.addEventListener(FileSelectEvent.SELECT, overlayFileOpenSelected);					
					break;
					
				case "SceneObject":
					fileChooser.addEventListener(FileSelectEvent.SELECT, objectFileOpenSelected);				
					break;
					
				case "VisionImpairment":
					fileChooser.addEventListener(FileSelectEvent.SELECT, impairmentFileOpenSelected);
					break;
			
			}
		}
		
		
		/////////////  file selection event handlers  //////////////////
		
		private function bgFileOpenSelected(event:Event):void
		{
			//event.currentTarget is a reference to the selected file
			currentFile = event.target as File;
			//get the file's url, and then load it using a loader object if it's an image
			var currentUrl:String = currentFile.url; 			
			
			/*
			ldr= new Loader();
			//configureListeners(ldr.contentLoaderInfo, "Bg");
			ldr.load(urlReq);
			*/
			trace("CURRENT URL: "+ currentUrl);
			var urlReq:URLRequest = new URLRequest(currentUrl);			
			dae= new DAE();
 	 		dae.addEventListener(FileLoadEvent.LOAD_COMPLETE, onDAELoadComplete);
  			//dae.load( "wireframes/test2.dae", daeMaterials);
			dae.load(currentUrl);			
			
		}
		
		private function onDAELoadComplete(e:FileLoadEvent){
			trace("dae file loaded");
			//dae.z=500;
			//dae.materials.getMaterialByName("Panorama1_v06_jpg").oneSide=false;
			
			//dae.rotationY=45;
			//dae.rotationX=45;
			//dae.material = 
			p.changePanoramaBg(dae);
			
		}
		
		
		private function overlayFileOpenSelected(event:Event):void
		{
			//event.currentTarget is a reference to the selected file
			currentFile = event.target as File;
			//get the file's url, and then load it using a loader object if it's an image
			var currentUrl:String = currentFile.url; 			
			ldr= new Loader();
			configureListeners(ldr.contentLoaderInfo, "VisionOverlay");
			var urlReq:URLRequest = new URLRequest(currentUrl);
			ldr.load(urlReq);
		}
		
		private function objectFileOpenSelected(event:Event):void
		{
			//event.currentTarget is a reference to the selected file
			currentFile = event.target as File;
			//get the file's url, and then load it using a loader object if it's an image
			var currentUrl:String = currentFile.url; 			
			ldr= new Loader();
			configureListeners(ldr.contentLoaderInfo, "SceneObject");
			var urlReq:URLRequest = new URLRequest(currentUrl);
			ldr.load(urlReq);
		}		
		
		private function impairmentFileOpenSelected(event:Event):void{
			//event.currentTarget is a reference to the selected file
			currentFile = event.target as File;
			//get the file's url, and then load it using a loader object if it's an image
			var currentUrl:String = currentFile.url; 			
			ldr= new Loader();
			configureListeners(ldr.contentLoaderInfo, "Impairment");
			var urlReq:URLRequest = new URLRequest(currentUrl);
			ldr.load(urlReq);			
		}
		

		//////////////  loader event handlers  ////////////////
		
        private function configureListeners(dispatcher:IEventDispatcher, type:String="Bg"):void {
			switch(type){
				case "Bg":
					dispatcher.addEventListener(Event.COMPLETE, panoramaCompleteHandler);
					dispatcher.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
					dispatcher.addEventListener(Event.OPEN, openHandler);
					dispatcher.addEventListener(Event.UNLOAD, unLoadHandler);
					break;
					
				case "VisionOverlay":
					dispatcher.addEventListener(Event.COMPLETE, visionOverlayCompleteHandler);
					dispatcher.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
					dispatcher.addEventListener(Event.OPEN, openHandler);
					dispatcher.addEventListener(Event.UNLOAD, unLoadHandler);
					break;
					
				case "SceneObject":
					dispatcher.addEventListener(Event.COMPLETE, sceneObjectCompleteHandler);
					dispatcher.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
					dispatcher.addEventListener(Event.OPEN, openHandler);
					dispatcher.addEventListener(Event.UNLOAD, unLoadHandler);
					break;		
				case "Impairment":
					dispatcher.addEventListener(Event.COMPLETE, impairmentCompleteHandler);
					dispatcher.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
					dispatcher.addEventListener(Event.OPEN, openHandler);
					dispatcher.addEventListener(Event.UNLOAD, unLoadHandler);				
					break;
				
			}
        }

		//////////////////////  complete handlers  //////////////////////
		
        private function panoramaCompleteHandler(event:Event):void {
			trace("panorama image complete");
            //trace("completeHandler: " + event.currentTarget.content);
			//send the bitmap as a parameter
			p.changePanoramaBitmap(event.currentTarget.content); 
			//p.changePanoramaBg(event.currentTarget.content);
        }
		
        private function visionOverlayCompleteHandler(event:Event):void {
			trace("vision overlay complete")
            //trace("completeHandler: " + event.currentTarget.content);
			//send the bitmap as a parameter
			p.addOverlayImage(event.currentTarget.content);
			
        }				
		
        private function sceneObjectCompleteHandler(event:Event):void {
			trace("scene object complete");
            //trace("completeHandler: " + event.currentTarget.content);
			//send the bitmap as a parameter
			p.addSceneObject(event.currentTarget.content);
			
        }		
		
		private function impairmentCompleteHandler(event:Event):void{
			trace("impairment added");
			
			p.addImpairment(event.currentTarget.content);
		}
		
		//////////////////////////////////////////////////////////////////

        private function httpStatusHandler(event:HTTPStatusEvent):void {
            trace("httpStatusHandler: " + event);
        }

        private function initHandler(event:Event):void {
            trace("initHandler: " + event);
        }

        private function ioErrorHandler(event:IOErrorEvent):void {
            trace("ioErrorHandler: " + event);
        }

        private function openHandler(event:Event):void {
            trace("openHandler: " + event);
        }

        private function progressHandler(event:ProgressEvent):void {
            trace("progressHandler: bytesLoaded=" + event.bytesLoaded + " bytesTotal=" + event.bytesTotal);
        }

        private function unLoadHandler(event:Event):void {
            trace("unLoadHandler: " + event);
        }
		
			
		
	}
	
}