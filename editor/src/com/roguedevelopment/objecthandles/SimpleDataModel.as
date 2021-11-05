package com.roguedevelopment.objecthandles
{
	import com.roguedevelopment_new.objecthandles_new.IMoveable;
	import com.roguedevelopment_new.objecthandles_new.IResizeable;

	public class SimpleDataModel implements IResizeable, IMoveable
	{
		[Bindable] public var x:Number = 10;
		[Bindable] public var y:Number  = 10;
		[Bindable] public var height:Number = 50;
		[Bindable] public var width:Number = 50;
		[Bindable] public var rotation:Number = 0;
	}
}