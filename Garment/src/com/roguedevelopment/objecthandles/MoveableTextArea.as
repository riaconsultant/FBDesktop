package com.roguedevelopment.objecthandles
{
	import flash.events.TextEvent;
	
	import mx.controls.TextArea;
	import mx.events.PropertyChangeEvent;

	public class MoveableTextArea extends TextArea
	{
		protected var _model:TextDataModel;
		
		public function MoveableTextArea()
		{
			super();
			addEventListener(TextEvent.TEXT_INPUT, onTextInput );
		}
		
		public function set model( val:TextDataModel ) : void
		{
			if( _model ) _model.removeEventListener( PropertyChangeEvent.PROPERTY_CHANGE, onPropertyChange );
			_model = val;
			reposition();
			
			val.addEventListener( PropertyChangeEvent.PROPERTY_CHANGE, onPropertyChange );
		}
		
		protected function onTextInput(event:TextEvent ):void
		{
			if( _model ) { _model.text = text; }
		}
		protected function onPropertyChange(event:PropertyChangeEvent ) : void
		{
			reposition();
		}
		protected function reposition() : void
		{
			drawFocus(false);
			x = _model.x;
			y = _model.y;
			width = _model.width;
			height = _model.height;
			rotation = _model.rotation;
			text = _model.text;
		}
		
	}
}