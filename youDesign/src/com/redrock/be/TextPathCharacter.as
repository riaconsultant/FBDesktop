package com.redrock.be
{
	import mx.core.UIComponent;
	import mx.core.UITextField;
	
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
			
			//character.x = character.measuredWidth / 2 * -1;
			//character.y = character.measuredHeight * -1;
			/*
			graphics.clear();
			graphics.beginFill(0x00FF00);
			graphics.drawCircle(0,0, 3);
			*/
		}
		
	}
}