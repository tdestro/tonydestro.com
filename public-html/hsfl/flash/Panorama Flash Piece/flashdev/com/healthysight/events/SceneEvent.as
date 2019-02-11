package com.healthysight.events{
	
	import flash.events.Event;
	
	public class SceneEvent extends Event{
		
		public static const LOADED:String = "sceneEventLoaded";
		public static const PROGRESS:String = "sceneEventProgress";
		public static const LOAD_START:String = "sceneEventLoadStart";
		
		public var eventName:String;
		public var bytesLoaded:int;
		public var bytesTotal:int;
		public var currentAsset:int;
		public var totalAssets:int;
		
		public function SceneEvent(o:Object){
			super(o.evtType);
			eventName= o.name;
			
			try{
				bytesLoaded = o.bytesLoaded;
				bytesTotal = o.bytesTotal;
			}
			catch(e:Error){}
			try{
				currentAsset = o.currentAsset;
				totalAssets = o.totalAssets;
			}
			catch(e:Error){}
		}
		
		
		
		
	}
	
	
}