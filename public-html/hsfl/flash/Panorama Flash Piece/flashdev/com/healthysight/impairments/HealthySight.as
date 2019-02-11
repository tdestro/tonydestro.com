package com.healthysight.impairments{
	/*
	 A skeleton vision impairment class for setting vision back to normal.
	 
	 Chris Natale - 12/23/08
	*/
	
	
	import flash.display.Sprite;	
	import com.healthysight.events.ImpairmentEvent;
	import com.healthysight.PanoramaModule;	
	
	public class HealthySight extends Sprite{
		
		var container:PanoramaModule;		
		
		public function HealthySight(_container:PanoramaModule){
			container = _container;
			container.loaderBg_mc.dispatchEvent(new ImpairmentEvent({evtType:ImpairmentEvent.LOADED, name:"healthySight"}));
						
		}
		
		public function init(){
			
		}
		
	}
	
	
}