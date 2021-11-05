package com.adobesamples.events
{
	import flash.events.Event;

	public class FontChosenEvent extends Event
	{
		
		import flash.display.*;
		
		public static var FONT_CHOSEN:String = "fontChosen";
		public var font:String;

        public function FontChosenEvent(i_eventName:String,i_font:String)
        {
            super(i_eventName,true);
			font = i_font
        }
		
	}
}