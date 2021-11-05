package com.redrock.be
{
	import Singularity.Geom.Bezier2;
	
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import mx.controls.Alert;
	
	import mx.core.UIComponent;
	
	/**
	 * <code>TextPath</code> is a very basic component for rendering text along 
	 * a bezier curve path.
	 */
	public class TextPath extends UIComponent
	{
		/**
		 * Constructor
		 */
		public function TextPath()
		{
			super();
			
			// defaults
			_showPath = false;
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
		 * HANDLES
		 */
		protected var _handles :Array = []; /* Sprite */
		
		
		protected var _showHandles :Boolean;
		protected var _showHandlesChanged :Boolean;
		
		/**
		 * SHOW HANDLES?
		 */
		public function get showHandles() :Boolean
		{
			return _showHandles;
		}
		public function set showHandles( value:Boolean ) :void
		{
			if (value == _showHandles) return;
			_showHandles = value;
			_showHandlesChanged = true;
			invalidateDisplayList();
		}
		
		
		
		/**
		 * @private
		 * PATH
		 */
		protected var _path :Bezier2;
		protected var _pathShape :Shape;
		
		
		protected var _controlPoints :Array;
		protected var _controlPointsChanged :Boolean;
		
		
		/**
		 * CONTROL POINTS
		 */
		public function get controlPoints() :Array
		{
			return _controlPoints;
		}
		public function set controlPoints( value:Array ) :void
		{
			_controlPoints = value.length == 3 ? value : [{X:0,Y:0},{X:0,Y:0},{X:0,Y:0}];
			_controlPointsChanged = true;
			invalidateSize();
			invalidateProperties();
			invalidateDisplayList();
		}
		
		
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
		
		
		protected var _pathColor :uint;
		protected var _pathColorChanged :Boolean;
		
		/**
		 * PATH LINE COLOR
		 */
		public function get pathColor() :uint
		{
			return _pathColor;
		}
		public function set pathColor( value:uint ) :void
		{
			if (_pathColor == value) return;
			_pathColor = value;
			_pathColorChanged = true;
			invalidateDisplayList();
		}
		
		
		protected var _pathThickness :uint;
		protected var _pathThicknessChanged :Boolean;
		
		/**
		 * PATH LINE THICKNESS
		 */
		public function get pathThickness() :uint
		{
			return _pathThickness;
		}
		public function set pathThickness( value:uint ) :void
		{
			if (_pathThickness == value) return;
			_pathThickness = value;
			_pathThicknessChanged = true;
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
		 	_path = new Bezier2();
		 	_pathShape = new Shape();
		 	_path.container = _pathShape;
		 	
		 	this.addChild( _pathShape );
		 	
		 	var g :Graphics;
		 	var handle1 :Sprite = new Sprite();
		 		g = handle1.graphics;
		 		g.beginFill( 0x000000 );
		 		g.drawCircle( 0,0, 5 );
		 		g.endFill();
		 	_handles
		 	var handle2 :Sprite = new Sprite();
		 		g = handle2.graphics;
		 		g.beginFill( 0x000000 );
		 		g.drawCircle( 0,0, 5 );
		 		g.endFill();
		 	_handles
		 	var handle3 :Sprite = new Sprite();
		 		g = handle3.graphics;
		 		g.beginFill( 0x000000 );
		 		g.drawCircle( 0,0, 5 );
		 		g.endFill();
		 	_handles.push( handle1 );
		 	_handles.push( handle2 );
		 	_handles.push( handle3 );
		 	
		 	handle1.addEventListener( MouseEvent.MOUSE_DOWN, handleMouseDownEvent );
			handle1.addEventListener( MouseEvent.MOUSE_UP, handleMouseUpEvent );
		 	handle2.addEventListener( MouseEvent.MOUSE_DOWN, handleMouseDownEvent );
			handle2.addEventListener( MouseEvent.MOUSE_UP, handleMouseUpEvent );
		 	handle3.addEventListener( MouseEvent.MOUSE_DOWN, handleMouseDownEvent );
			handle3.addEventListener( MouseEvent.MOUSE_UP, handleMouseUpEvent );
		 }
		
		
		/**
		 * Commit Properties will adjust the number of child character 
		 * objects as children and set their individual values.
		 */
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			// recalculate curve
			if (_controlPointsChanged) 
			{
				_path.interpolate( _controlPoints );
			}
			
			// path color
			if (_pathColorChanged)
			{
				_path.color = _pathColor;
			}
			
			// path thickness
			if (_pathThicknessChanged)
			{
				_path.thickness = _pathThickness;
			}
			
			//------------
			// ASSIGN TEXT
			//------------
			if 	(_textChanged)
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
			/*
			measuredWidth = ;
			measuredHeight = ;
			*/
		}
		
		
		/**
		 * Update Display List will position child character objects
		 */
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth,unscaledHeight);
			
			//------------
			// RENDER TEXT
			//------------
			if (_textChanged)
			{
				var textLength :uint = _text ? _text.length : 0;
				var tInterval :Number = textLength > 1 ? 1 / (textLength-1) : 0;
				var t :Number = 0;
				
				var cp1 :Point = _path.getControlPoint(0);
				var cp2 :Point = _path.getControlPoint(1);
				var cp3 :Point = _path.getControlPoint(2);
				
				// position characters
				graphics.clear();
				graphics.lineStyle(1,0x666666);
				
				for (var i:uint=0; i<textLength; i++)
				{
					var character :TextPathCharacter = _characters[i] as TextPathCharacter;
					// Rotation					
					var radius:Number = _radius
					var spacing:Number = _spacing
					var angleLeading:Number = _angle;
					var angularOffset:Number = _angular;
					
					// points
					var p1 :Point = Point.interpolate( cp2, cp1, t );
					var p2 :Point = Point.interpolate( cp3, cp2, t );
					var tPoint :Point = new Point( _path.getX(t), _path.getY(t) );
					
					// location
					//character.x = tPoint.x;
					//character.y = tPoint.y;
					character.x = radius * Math.cos(degrees2radians(i*spacing+angularOffset)) + _x;
					character.y = radius * Math.sin(degrees2radians(i*spacing+angularOffset)) + _y;
					
					character.setStyle('fontFamily',_fontFamily);
					character.setStyle('fontSize',_fontSize);
					
					var dx:Number = character.x - _x;
					var dy:Number = character.y - _y;
					var angle:Number = Math.atan2(dy, dx);
					character.rotation = radians2degrees(angle) -90 + angleLeading;
					// rotation
					//character.rotation = (Math.atan2( (p2.y - p1.y), (p2.x - p1.x) ) * 180 / Math.PI);
					/* 
					graphics.moveTo( tPoint.x,tPoint.y );
					graphics.lineTo(p2.x, p2.y);
					graphics.moveTo( tPoint.x,tPoint.y );
					graphics.lineTo(p1.x, p1.y);
					 */
					t += tInterval;
				}
			}
			
			
			//----------
			// SHOW PATH
			//----------
			if (_showPath)
			{
				if ( _showPathChanged || _controlPointsChanged || _pathThicknessChanged || _pathColorChanged)
				{
					_pathShape.graphics.clear();
					_path.draw( 1 );
					_controlPointsChanged = false;
					_showPathChanged = false;
					_pathThicknessChanged = false;
					_pathColorChanged = false;
				}
			}
			else
			{
				_pathShape.graphics.clear();
			}
			
			
			//-------------
			// SHOW HANDLES
			//-------------
			if (_showHandlesChanged)
			{
				var handle :Sprite;
				
				if (_showHandles)
				{
					// add handles
					for each (handle in _handles)
					{
						addChild(handle);
					}
				}
				else
				{
					// remove handles
					for each (handle in _handles)
					{
						removeChild(handle);
					}
				}
				// position handles
				if (_showHandles) 
				{
					for (var h:uint=0; h<_handles.length; h++)
					{
						_handles[h].x = _controlPoints[h].X;
						_handles[h].y = _controlPoints[h].Y;
					}
				}
			}
			
		}
		
		
		//--------------------
		//
		// Event Listeners
		//
		//--------------------
		
		protected var draggingHandle :Sprite;
		
		protected function handleMouseDownEvent( event:MouseEvent ) :void
		{
			stage.addEventListener( MouseEvent.MOUSE_MOVE, handleMouseMoveEvent );
			draggingHandle = event.target as Sprite;
		}
		
		protected function handleMouseMoveEvent( event:MouseEvent ) :void
		{
			draggingHandle.x = mouseX;
			draggingHandle.y = mouseY;
			
			var handleIndex :uint = _handles.lastIndexOf( draggingHandle );
			_controlPoints[handleIndex].X = mouseX;
			_controlPoints[handleIndex].Y = mouseY;
			controlPoints = _controlPoints;
		}
		
		protected function handleMouseUpEvent( event:MouseEvent ) :void
		{
			stage.removeEventListener( MouseEvent.MOUSE_MOVE, handleMouseMoveEvent );
			draggingHandle = null;
		}
		
		// Rotation 
		
		private function degrees2radians(deg:Number):Number {
			return (2 * Math.PI * deg) / 360; 
		}
		
		private function radians2degrees(rad:Number):Number {			
			return rad * 180 / Math.PI; 
		}
		
		private var _x:Number = 50;
		public function get center_x() :Number
		{
			return _x;
		}
		public function set center_x( value:Number ) :void
		{
			_x = value;
			invalidateDisplayList();
		}
		
		private var _y:Number = 15;
		public function get center_y() :Number
		{
			return _y;
		}
		public function set center_y( value:Number ) :void
		{
			_y = value;
			invalidateDisplayList();
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
		
		private var _spacing:Number = 5;
		public function get spacing() :Number
		{
			return _spacing;
		}
		public function set spacing( value:Number ) :void
		{
			_spacing = value;
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
		
		private var _fontSize:int = 20;
		public function get fontSize() :int
		{
			return _fontSize;
		}
		public function set fontSize( value:int) :void
		{
			//Alert.show(''+value) ;
			_fontSize = value;
			invalidateDisplayList();
		}
		
		private var _fontFamily:String = "Arial";
		public function get fontFamily() :String
		{
			return _fontFamily;
		}
		public function set fontFamily( value:String) :void
		{
			_fontFamily = value;
			invalidateDisplayList();
		}
	}
}