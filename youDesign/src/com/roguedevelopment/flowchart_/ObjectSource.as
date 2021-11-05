
/**
 *  Latest information on this project can be found at http://www.rogue-development.com/objectHandles.xml
 * 
 *  Copyright (c) 2008 Marc Hughes 
 * 
 *  Permission is hereby granted, free of charge, to any person obtaining a 
 *  copy of this software and associated documentation files (the "Software"), 
 *  to deal in the Software without restriction, including without limitation 
 *  the rights to use, copy, modify, merge, publish, distribute, sublicense, 
 *  and/or sell copies of the Software, and to permit persons to whom the Software 
 *  is furnished to do so, subject to the following conditions:
 * 
 *  The above copyright notice and this permission notice shall be included in all 
 *  copies or substantial portions of the Software.
 * 
 *  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, 
 *  INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A 
 *  PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT 
 *  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION 
 *  OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE 
 *  SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE. 
 * 
 * 
 * 
 **/


package com.roguedevelopment.flowchart
{
	import com.roguedevelopment.objecthandles.ObjectHandleEvent;
	import com.roguedevelopment.objecthandles.ObjectHandles;
	import com.roguedevelopment.objecthandles.SelectionManager;
	
	import flash.events.Event;
	import flash.geom.Point;
	
	import mx.containers.Canvas;
	import mx.core.ClassFactory;
	
	public class ObjectSource 
	{
		protected var _factory:ClassFactory;
		protected var _position:Point;
		protected var _parent:Canvas;
		public var selectedObjectNew:ObjectHandles;
		public var curObj:ObjectHandles=null;
		
		public function ObjectSource(factory:ClassFactory, parent:Canvas, position:Point)
		{
			_factory = factory;
			_position = position;
			_parent = parent;
			createObject();
			
		}
		
		public function createObject() : void
		{
			 var obj:ObjectHandles = _factory.newInstance() as ObjectHandles;
			 obj.removeEventListener(ObjectHandleEvent.OBJECT_MOVING_EVENT, onMoved );	
			 obj.select();
			 
			 obj.x = _position.x;
			 obj.y = _position.y;
			 SelectionManager.instance.removeSelectable(obj);
			 _parent.x=_position.x;
			 _parent.y=_position.x;
			 curObj=obj;
			 curObj.id=obj.name;
			 
			 
			
		}
		
		protected function onMoved(event:Event) : void
		{
			var obj:ObjectHandles = event.target as ObjectHandles;
			obj.removeEventListener(ObjectHandleEvent.OBJECT_MOVING_EVENT, onMoved );
			//createObject();
		}
		
		private function OnObjectHandlesSelected1(event:ObjectHandleEvent):void
   		{
   			var obj:ObjectHandles = event.currentTarget as ObjectHandles;
   			if(obj != null)
   			{
   				selectedObjectNew = obj;
   			}
   		}
   		
   	}
}