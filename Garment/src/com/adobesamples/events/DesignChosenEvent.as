package com.adobesamples.events
{
	import flash.events.Event;

	public class DesignChosenEvent extends Event
	{
		
		import flash.display.*;
		import mx.flash.UIMovieClip;
		import com.adobesamples.controls.*;
		
		public static var DESIGN_CHOSEN:String = "designChosen";
		public var design:Object;

        public function DesignChosenEvent(i_eventName:String,i_design:Object)
        {
            super(i_eventName,true);
			design = i_design
        }
		
	}
}