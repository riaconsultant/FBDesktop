package com.adobesamples.events
{
	import flash.events.Event;

	public class LogoChosenEvent extends Event
	{

		public static var LOGO_CHOSEN:String = "logoChosen";
		public var logo:Object;

        public function LogoChosenEvent(i_eventName:String,i_logo:Object)
        {
            super(i_eventName,true);
			logo = i_logo
        }
		
	}
}