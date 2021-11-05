package com.container.objecthandles.decorators
{
	
	
	import com.container.objecthandles.ObjectChangedEvent;
	import com.container.objecthandles.ObjectHandles;
	import com.container.objecthandles.SelectionEvent;
	
	import flash.display.Sprite;
	import flash.events.Event;

	public class DecoratorManager
	{
		protected var drawLayer:Sprite;
		protected var decorators:Array = [];
		protected var subDrawLayers:Object = {};
		protected var objectHandles:ObjectHandles;
		
		public function DecoratorManager(objectHandles:ObjectHandles, drawLayer:Sprite)
		{
			this.drawLayer = drawLayer;
			this.objectHandles = objectHandles;
			
			objectHandles.selectionManager.addEventListener(SelectionEvent.ADDED_TO_SELECTION, onSelectionChanged );
			objectHandles.selectionManager.addEventListener(SelectionEvent.REMOVED_FROM_SELECTION, onSelectionChanged );
			objectHandles.selectionManager.addEventListener(SelectionEvent.SELECTION_CLEARED, onSelectionChanged );
			objectHandles.selectionManager.addEventListener(SelectionEvent.SELECTED, onSelectionChanged );
			
			objectHandles.addEventListener(ObjectChangedEvent.OBJECT_MOVING, onPositionChanged );
			objectHandles.addEventListener(ObjectChangedEvent.OBJECT_RESIZING, onPositionChanged );
			objectHandles.addEventListener(ObjectChangedEvent.OBJECT_ROTATING, onPositionChanged );
			
		}
		
		protected function onSelectionChanged(event:Event):void
		{
			for each(var decorator:IDecorator in decorators )
			{				
				decorator.updateSelected( objectHandles.modelList, objectHandles.selectionManager.currentlySelected, subDrawLayers[decorator] );
			}
			
		}
		
		protected function onPositionChanged(event:ObjectChangedEvent):void
		{
			for each(var decorator:IDecorator in decorators )
			{				
				decorator.updatePosition( objectHandles.modelList, objectHandles.selectionManager.currentlySelected, event.relatedObjects ,subDrawLayers[decorator] );
			}
			
		}		
		public function addDecorator( decorator:IDecorator ) : void
		{
			var subDrawLayer:Sprite = new Sprite();
			drawLayer.addChild(subDrawLayer);
			
			decorators.push(decorator);
			subDrawLayers[decorator] = subDrawLayer;
			
		}


		
	}
}