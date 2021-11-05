
package com.adobesamples.events
{
	import flash.events.Event;

	public class NameTextChosenEvent extends Event
	{
		
		public static var NAME_CHOSEN:String = "nameChosen";
		public var nameText:String;

        public function NameTextChosenEvent(i_eventName:String,i_name:String)
        {
            super(i_eventName,true);
			nameText = i_name
        }
		
	}
}