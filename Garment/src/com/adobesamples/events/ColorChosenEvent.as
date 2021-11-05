package com.adobesamples.events
{
	import flash.events.Event;

	public class ColorChosenEvent extends Event
	{
		
		public static var BASE_COLOR_CHOSEN:String = "baseColorChosen";
		public static var TRIM_COLOR_CHOSEN:String = "trimColorChosen";
		public static var NAME_LABEL_COLOR_CHOSEN:String = "nameLabelColorChosen";
		
		public var color:Number;

        public function ColorChosenEvent(i_eventName:String,i_color:Number)
        {
            super(i_eventName,true);
			color = i_color
        }
		
	}
}