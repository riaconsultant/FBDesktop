package com.manoj
{
	import com.manoj.CustomObj;
	import com.tools.designCanvas;
	import flash.events.Event;
	import mx.controls.Alert;
	import mx.utils.ObjectUtil;
    
	public class CommanDelegate
	{
		public var custObj:CustomObj=new CustomObj();
		public var design:designCanvas;
		public function CommanDelegate()
		{
			
		}
		
		public function get_top_text_value(arg:Event):void{
			//custObj.id=arg;
			/*var youf:YouFunctions= new YouFunctions();
			youf.set_top_text_value(arg);*/
			//Alert.show(ObjectUtil.toString(arg.currentTarget));
			//design.top_label.text=arg.currentTarget.toString();
		}
		
		public function set_top_text_value():String{
			return custObj.id;
		}
	}
}