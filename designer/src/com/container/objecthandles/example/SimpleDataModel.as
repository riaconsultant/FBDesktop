package com.container.objecthandles.example
{
	import com.container.objecthandles.IMoveable;
	import com.container.objecthandles.IResizeable;

	
	/** 
	 * This is an example and not part of the core ObjectHandles library. 
	 **/

	public class SimpleDataModel implements IResizeable, IMoveable
	{
		[Bindable] public var x:Number = 10;
		[Bindable] public var y:Number  = 10;
		[Bindable] public var height:Number = 50;
		[Bindable] public var width:Number = 50;
		[Bindable] public var rotation:Number = 0;
	}
}