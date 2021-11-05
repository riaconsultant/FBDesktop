package com.redrock.be
{
	import flash.geom.Point;
	
	import mx.core.mx_internal;
    use namespace mx_internal; 
	
	import mx.core.UIComponent;
	import mx.styles.StyleManager;
	import mx.styles.CSSStyleDeclaration;
	import mx.containers.Canvas;
	import mx.controls.Alert;
	import flash.display.Sprite;
	import flash.display.Shape;
	import flash.display.BitmapData;
	import mx.graphics.codec.PNGEncoder;
	import flash.utils.ByteArray;
	import mx.controls.SWFLoader;
	
	
	/**
	 * <code>TextPath</code> is a very basic component for rendering text along 
	 * a bezier curve path.
	 */
	public class TextPath extends UIComponent
	{
		/**
		 * Constructor
		 */
		 public var can:Canvas;
		public function TextPath()
		{
			super();
			// defaults
			_showPath = true;
			//
		}
		
		
		//--------------------
		//
		// Property overrides
		//
		//--------------------
		
		override public function set width(value:Number):void
		{
			// future plans to use explicit width to 'squish' the path.
			super.width = value;
		}
		
		override public function set height(value:Number):void
		{
			// future plans to use explicit height to 'squish' the path.
			super.height = value;
		} 
		
		
		//--------------------
		//
		// Properties
		//
		//--------------------
		
		protected var _text :String;
		protected var _textChanged :Boolean;
		
		/**
		 * TEXT
		 */
		public function get text() :String
		{
			return _text;
		}
		public function set text( value:String ):void
		{
			if (_text == value) return;
			_text = value;
			_textChanged = true;
			invalidateProperties();
			invalidateDisplayList();
		}
		
		
		/**
		 * @private
		 * CHARACTERS
		 */
		protected var _characters :Array = []; /* TextPathCharacter */
		
		
		
		/**
		 * @private
		 * PATH
		 */
		//protected var _path :Bezier2;
		
		protected var _pathShape :Shape;
		protected var _showPath :Boolean;
		protected var _showPathChanged :Boolean; 
		
		/**
		 * SHOW PATH?
		 */
		public function get showPath() :Boolean
		{
			return _showPath;
		}
		public function set showPath( value:Boolean ) :void
		{
			if (value == _showPath) return;
			_showPath = value;
			_showPathChanged = true;
			invalidateDisplayList();
		} 
		
		//--------------------
		//
		// UIComponent
		//
		//--------------------
		
		/**
		 * Create the initial curve.
		 */
		 override protected function createChildren():void
		 {
		 	 
            _pathShape = new Shape();
            this.addChild( _pathShape );
		 }
		
		
		/**
		 * Commit Properties will adjust the number of child character 
		 * objects as children and set their individual values.
		 */
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			
			
			//------------
			// ASSIGN TEXT
			//------------
			if (_textChanged)
			{
				// add characters if needed
				if (_text)
				{
					var difference :int = _characters.length - _text.length;
					if (difference < 0)
					{
						while (difference < 0)
						{
							 var character :TextPathCharacter = new TextPathCharacter();
							_characters.push( character );
							this.addChild( character );
							difference++;
						}
					}
					
				}
				// assign text to characters
				for (var i:uint=0; i<_characters.length; i++)
				{
					TextPathCharacter(_characters[i]).text = _text.charAt(i);
				}
			} 
		}
		
		
		/**
		 * Measure using path bounds.  Apply padding if this is inadequate.
		 */
		override protected function measure():void
		{
			
			measuredWidth = 20;
			measuredHeight = 20;
			
		}
		
		
		/**
		 * Update Display List will position child character objects
		 */
		 
		 
		 private function degrees2radians(deg:Number):Number {
			return (2 * Math.PI * deg) / 360; 
		}
		
		private function radians2degrees(rad:Number):Number {			
			return rad * 180 / Math.PI; 
		}
		
		private function radiansTodegrees(rad:Number):Number {			
			//return rad * 180 / Math.PI; 
			var degrees:Number = rad * (180 / Math.PI);
            return degrees;

			
		}
		
		private var _radius:Number = 50;
		public function get radius() :Number
		{
			return _radius;
		}
		public function set radius( value:Number ) :void
		{
			
			_radius = value;
			invalidateDisplayList();
			
		}
		
		
		private var _spacing:Number = 15;
		public function get spacing() :Number
		{
			return _spacing;
		}
		public function set spacing( value:Number ) :void
		{
			
			_spacing = value;
			invalidateDisplayList();
			
		}
		private var _color:String;
		public function get color() :String
		{
			return _color;
		}
		public function set color( value:String ) :void
		{
			
			_color = value;
			invalidateDisplayList();
			
		}
		
		private var _angle:Number = 175;
		public function get angle() :Number
		{
			return _angle;
		}
		public function set angle( value:Number ) :void
		{
			
			_angle = value;
			invalidateDisplayList();
			
		}
		
		private var _angular:Number = 180;
		public function get angular() :Number
		{
			return _angular;
		}
		public function set angular( value:Number ) :void
		{
			
			_angular = value;
			invalidateDisplayList();
			
		}
		 
		 
		private var _fontsize:Number = 180;
		public function get font() :Number
		{
			return _fontsize;
		}
		public function set font( value:Number ) :void
		{
			
			_fontsize = value;
			invalidateDisplayList();
			
		}		 
		
		
		private var _fontFamily:String;
		public function get fontF() :String
		{
			return _fontFamily;
		}
		public function set fontF( value:String ) :void
		{
			
			_fontFamily = value;
			invalidateDisplayList();
			
		}
		
		 
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth,unscaledHeight);
			
			//------------
			// RENDER TEXT
			//------------
			//Alert.show('w'+super.width+'h'+super.height);
			//Alert.show('x'+super.x+'y'+super.y);
			
			if (_textChanged)
			{
				var textLength :uint = _text ? _text.length : 0;
				var tInterval :Number = textLength > 1 ? 1 / (textLength-1) : 0;
				var t :Number = 0;
				
				for (var i:uint=0; i<textLength; i++)
				{
					var character :TextPathCharacter = _characters[i] as TextPathCharacter;
					var radius:Number = _radius
					var spacing:Number = _spacing
					var tPoint :Point = new Point( 125, 125 );
					var angleLeading:Number = _angle;
          			var angularOffset:Number = _angular;
          			character.setStyle("backgroundColor","#ff0000");
          			character.setStyle("color", '#'+_color);
					character.setStyle("fontSize", _fontsize);
					character.x = radius * Math.cos(degrees2radians(i*spacing+angularOffset)) + tPoint.x;
               		character.y = radius * Math.sin(degrees2radians(i*spacing+angularOffset)) + tPoint.y;
					var dx:Number = character.x - tPoint.y;
               		var dy:Number = character.y - tPoint.y;
               		var angle:Number = Math.atan2(dy, dx);
					character.rotation = radiansTodegrees(angle) -90 + angleLeading;
					
					t += tInterval;
				}
			}
			
			this.invalidateDisplayList();
			//----------
			// SHOW PATH
			//----------
			/* if (_showPath)
			{
				_pathShape.graphics.clear();
				if ( _showPathChanged)
				{
					_pathShape.graphics.clear();
				}
			}
			else
			{
				_pathShape.graphics.clear();
			} */ 
		}
	}
}