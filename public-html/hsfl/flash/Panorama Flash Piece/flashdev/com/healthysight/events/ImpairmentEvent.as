package com.healthysight.events{
	
	import flash.events.Event;
	
	public class ImpairmentEvent extends Event{
		
		public static const LOADED:String = "impairmentEventLoaded";
		public static const PROGRESS:String = "impairmentEventProgress";
		public static const LOAD_START:String = "impairmentEventLoadStart";
		
		public var eventName:String;
		public var bytesLoaded:int;
		public var bytesTotal:int;
		
		public function ImpairmentEvent(o:Object){
			super(o.evtType);
			eventName= o.name;
			
			try{
				bytesLoaded = o.bytesLoaded;
				bytesTotal = o.bytesTotal;
			}
			catch(e:Error){}
		}
		
		
		
		
	}
	
	
}