package com.adobesamples.vo
{

	
	public class ConfigurationData
	{
	
		[Bindable]
		public var designsArray:Array = [
								{name:"Stripe",front:"Shirt1Front"},
								{name:"Plain",front:"Shirt2Front"},
								{name:"Band",front:"Shirt3Front"},
								{name:"Cuff",front:"Shirt4Front"},
								{name:"Colar",front:"Shirt5Front"}
								];
		
		[Bindable]
		public var logoArray:Array = [
								{name:"Evil Ball",image:"images/logo/evil_ball.swf"},
								{name:"Purple Ball",image:"images/logo/purple_ball.swf"},
								{name:"Target",image:"images/logo/target.swf"},
								{name:"Flaming Pins",image:"images/logo/flaming_pins.swf"},
								{name:"Retro",image:"images/logo/retro_bowling.swf"},
								{name:"Stars",image:"images/logo/stars_bowling.swf"}
								];
	}
}