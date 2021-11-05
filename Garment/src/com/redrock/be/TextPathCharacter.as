package com.redrock.be
{
	import mx.containers.Canvas;
	import mx.core.UIComponent;
	import mx.core.UITextField;
	import mx.core.mx_internal;
    use namespace mx_internal; 
	/**
	 * The <code>TextPathCharacter</code> stands a character on its origin.
	 */
	internal class TextPathCharacter extends UIComponent
	{
		/**
		 * Constructor
		 */
		public function TextPathCharacter()
		{
			super();
			createChildren();
		}
		
		
		/**
		 * TEXT FIELD
		 */
		protected var character :UITextField;
		protected var canv:Canvas;
		
		/**
		 * TEXT
		 */
		public function get text() :String
		{
			return character.text;
		}
		public function set text( value:String ) :void
		{
			character.text = value ? value.charAt(0) : null;
			invalidateDisplayList();
		}
		
		
		//------------------
		//
		// Component
		//
		//------------------
		
		/**
		 * children
		 */
		override protected function createChildren() :void
		{
			character = new UITextField();
			addChild( character );
		}
		
		
		/**
		 * update display list
		 */
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			/* character.x = character.measuredWidth / 2 * -1;
			character.y = character.measuredHeight/ 2 * -1;
			trace(character.x);
			//graphics.rotation=150;
			graphics.clear();
			graphics.beginFill(0x00FF00);
			graphics.beginFill(0xFF0000);
			//graphics.drawCircle(0,0, 2);  */
			//graphics.beginFill(0xFF0000);
			//graphics.drawCircle(0,0, 2); 
		}
		
	}
}