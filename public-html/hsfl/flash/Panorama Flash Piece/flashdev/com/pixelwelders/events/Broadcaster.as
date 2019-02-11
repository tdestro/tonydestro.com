﻿/**
 * A central event broadcaster
 *
 * @author	Zack Jordan
 * 			{ P I X E L W E L D E R S . C O M }
 */
package com.pixelwelders.events
{
	import flash.events.Event;
	import flash.events.EventDispatcher;

	public class Broadcaster
	{

		private static var eventDispatcher			: EventDispatcher;

		/**
		 * Broadcasts an event to all listeners
		 * To listen to any and all events, use Broadcaster.addEventListener()
		 *
		 * @param	event		The Event to broadcast
		 * @return				nothing
		 */
		public static function broadcast( event:Event ): void
		{
			dispatchEvent( event );
		}

		// === S T A T I C   E V E N T   D I S P A T C H E R ===
		public static function addEventListener( type:String, listener:Function, useCapture:Boolean=false,
			priority:int=0, useWeakReference:Boolean=true ):void
		{
			if ( !eventDispatcher ) eventDispatcher = new EventDispatcher();
			eventDispatcher.addEventListener( type, listener, useCapture, priority, useWeakReference );
		}

		public static function removeEventListener( type:String, listener:Function, useCapture:Boolean=false ):void
		{
			if ( eventDispatcher ) eventDispatcher.removeEventListener( type, listener, useCapture );
  	    	}

		public static function dispatchEvent( p_event:Event ):void
		{
			if ( eventDispatcher ) eventDispatcher.dispatchEvent( p_event );
		}

	}
}
