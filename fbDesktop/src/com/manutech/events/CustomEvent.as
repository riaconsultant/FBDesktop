package com.manutech.events
{
	import flash.events.Event;
	
	public class CustomEvent extends Event
	{
		public var data:*;
		
		public function CustomEvent(type:String,data:*)
		{
			super(type, bubbles, cancelable);
			this.data=data;
		}
	}
}