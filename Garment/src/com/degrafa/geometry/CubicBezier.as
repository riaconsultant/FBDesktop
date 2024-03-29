////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2008 The Degrafa Team : http://www.Degrafa.com/team
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
////////////////////////////////////////////////////////////////////////////////
package com.degrafa.geometry{
	
	import com.degrafa.IGeometry;
	import com.degrafa.geometry.command.CommandStackItem;
	import com.degrafa.geometry.utilities.GeometryUtils;
	
	import flash.display.Graphics;
	import flash.geom.Rectangle;
	
	
	//--------------------------------------
	//  Other metadata
	//--------------------------------------
	
	[IconFile("CubicBezier.png")]
	
	[Bindable]
	/**
 	*  The CubicBezier element draws a cubic Bézier using the specified start point,
 	*  end point and 2 control points.
 	*  
 	*  @see http://degrafa.com/samples/CubicBezier_Element.html
 	*  
 	**/	
	public class CubicBezier extends Geometry implements IGeometry{
		
		/**
	 	* Constructor.
	 	*  
	 	* <p>The cubic Bézier constructor accepts 8 optional arguments that define it's 
	 	* start, end and controls points.</p>
	 	* 
	 	* @param x0 A number indicating the starting x-axis coordinate.
	 	* @param y0 A number indicating the starting y-axis coordinate.
	 	* @param cx A number indicating the first control x-axis coordinate. 
	 	* @param cy A number indicating the first control y-axis coordinate.
	 	* @param cx1 A number indicating the second control x-axis coordinate.
	 	* @param cy1 A number indicating the second control y-axis coordinate.
	 	* @param x1 A number indicating the ending x-axis coordinate.
	 	* @param y1 A number indicating the ending y-axis coordinate. 
	 	*/		
		public function CubicBezier(x0:Number=NaN,y0:Number=NaN,cx:Number=NaN,cy:Number=NaN,cx1:Number=NaN,cy1:Number=NaN,x1:Number=NaN,y1:Number=NaN){
			super();
			
			this.x0=x0;
			this.y0=y0;
			this.cx=cx;
			this.cy=cy;
			this.cx1=cx1;
			this.cy1=cy1;
			this.x1=x1;
			this.y1=y1;
			
			
		}
		
		/**
		* CubicBezier short hand data value.
		* 
		* <p>The cubic Bézier data property expects exactly 8 values x0, 
		*  y0, cx, cy, cx1, cy1, x1 and y1 separated by spaces.</p>
		* 
		* @see Geometry#data
		* 
		**/
		override public function set data(value:String):void{
			if(super.data != value){
				super.data = value;
			
				//parse the string on the space
				var tempArray:Array = value.split(" ");
				
				if (tempArray.length == 8){
					_x0=tempArray[0];
					_y0=tempArray[1];
					_cx=tempArray[2];
					_cy=tempArray[3];
					_cx1=tempArray[4];
					_cy1=tempArray[5];
					_x1=tempArray[6];
					_y1=tempArray[7];
				}	
				
				invalidated = true;
			}
		} 
		
		
		private var _x0:Number;
		/**
		* The x0-coordinate of the start point of the curve. If not specified 
		* a default value of 0 is used.
		**/
		public function get x0():Number{
			if(!_x0){return 0;}
			
			return _x0;
		}
		public function set x0(value:Number):void{
			if(_x0 != value){
				_x0 = value;
				invalidated = true;
			}
		}
		
		
		private var _y0:Number;
		/**
		* The y0-coordinate of the start point of the curve. If not specified 
		* a default value of 0 is used.
		**/
		public function get y0():Number{
			if(!_y0){return (hasLayout)? 2:0;}
			return _y0;
		}
		public function set y0(value:Number):void{
			if(_y0 != value){
				_y0 = value;
				invalidated = true;
			}
		}
		
		
		private var _x1:Number;
		/**
		* The x-coordinate of the end point of the curve. If not specified 
		* a default value of 0 is used.
		**/
		public function get x1():Number{
			if(!_x1){return (hasLayout)? 2:0;}
			return _x1;
		}
		public function set x1(value:Number):void{
			if(_x1 != value){
				_x1 = value;
				invalidated = true;
			}
			
		}
		
		
		private var _y1:Number;
		/**
		* The y-coordinate of the end point of the curve. If not specified 
		* a default value of 0 is used.
		**/
		public function get y1():Number{
			if(!_y1){return (hasLayout)? 2:0;}
			return _y1;
		}
		public function set y1(value:Number):void{
			if(_y1 != value){
				_y1 = value;
				invalidated = true;
			}
		}
		
		
		private var _cx:Number;
		/**
		* The x-coordinate of the first control point of the curve. If not specified 
		* a default value of 0 or cx1 if specified is used.
		**/
		public function get cx():Number{
			if(!_cx){return (hasLayout)? 1:0;}
			return _cx;
		}
		public function set cx(value:Number):void{
			if(_cx != value){
				_cx = value;
				invalidated = true;
			}
		}
		
		
		private var _cy:Number;
		/**
		* The y-coordinate of the first control point of the curve. If not specified 
		* a default value of 0 or cy1 if specified is used.
		**/
		public function get cy():Number{
			if(!_cy){return (hasLayout)? .66:0;}
			return _cy;
		}
		public function set cy(value:Number):void{
			if(_cy != value){
				_cy = value;
				invalidated = true;
			}
		}
		
		
		private var _cx1:Number;
		/**
		* The x-coordinate of the second control point of the curve. If not specified 
		* a default value of 0 or cx if specified is used.
		**/
		public function get cx1():Number{
			if(!_cx1){return (hasLayout)? 1:0;}
			return _cx1;
		}
		public function set cx1(value:Number):void{
			if(_cx1 != value){
				_cx1 = value;
				invalidated = true;
			}
		}
		
		
		private var _cy1:Number;
		/**
		* The y-coordinate of the second control point of the curve. If not specified 
		* a default value of 0 or cy if specified is used.
		**/
		public function get cy1():Number{
			if(!_cy1){return (hasLayout)? .66:0;}
			return _cy1;
		}
		public function set cy1(value:Number):void{
			if(_cy1 != value){
				_cy1 = value;
				invalidated = true;
			}
		}
		
		private var _close:Boolean=false;
		/**
		* If true draws a line from the end point to the start point to 
		* close this curve.
		**/
		[Inspectable(category="General", enumeration="true,false")]
		public function get close():Boolean{
			return _close;
		}
		public function set close(value:Boolean):void{
			if(_close != value){
				_close = value;
				invalidated = true;
			}
		}
				
		/**
		* @inheritDoc 
		**/
		override public function preDraw():void{
			if(invalidated){
								
				//if the last controly and the y are the same add a 
				//minute offset to avoid a display parasite that 
				//can sometimes occur from this
				var cy1Offset:Number=0;
				if(cy1Offset==y)
				{
					cy1Offset=0.000001;
				}
				
				commandStack.length=0;
				
				//add a MoveTo at the start of the commandStack 
				//rendering chain
				commandStack.addMoveTo(x0,y0);
				
				commandStack.addCubicBezierTo(x0,y0,cx,cy,cx1,cy1+cy1Offset
				,x1,y1,1);
				
				if(close){
					commandStack.addLineTo(x0,y0);	
				}
								
				invalidated = false;
			}
			
		}
		
		/**
		* Performs the specific layout work required by this Geometry.
		* @param childBounds the bounds to be layed out. If not specified a rectangle
		* of (0,0,1,1) is used. 
		**/
		override public function calculateLayout(childBounds:Rectangle=null):void{
			
			if(_layoutConstraint){
				if (_layoutConstraint.invalidated){
					var tempLayoutRect:Rectangle = new Rectangle(0,0,1,1);
					if(isNaN(_layoutConstraint.width)){
						tempLayoutRect.width = bounds.width;
					}
					 
					if(isNaN(_layoutConstraint.height)){
						tempLayoutRect.height = bounds.height;
					}
					
					if(isNaN(_layoutConstraint.x)){
			 			tempLayoutRect.x = bounds.x;
			 		}
			 		
			 		if(isNaN(_layoutConstraint.y)){
			 			tempLayoutRect.y = bounds.y;
					}		 		
			 		super.calculateLayout(tempLayoutRect);	
			 					
					_layoutRectangle = _layoutConstraint.layoutRectangle;

				}
			}
		}
		
		/**
		* Begins the draw phase for geometry objects. All geometry objects 
		* override this to do their specific rendering.
		* 
		* @param graphics The current context to draw to.
		* @param rc A Rectangle object used for fill bounds. 
		**/	
		override public function draw(graphics:Graphics,rc:Rectangle):void{	
							
			//re init if required
		 	if (invalidated) preDraw(); 
			
			//init the layout in this case done after predraw.
			if (_layoutConstraint) calculateLayout();
						
			super.draw(graphics, (rc)? rc:bounds);
			
		}
		
		/**
		* An object to derive this objects properties from. When specified this 
		* object will derive it's unspecified properties from the passed object.
		**/
		public function set derive(value:CubicBezier):void{
			
			if (!fill){fill=value.fill;}
			if (!stroke){stroke = value.stroke}
			if (!_x0){_x0 = value.x0;}
			if (!_y0){_y0 = value.y0;}
			if (!_x1){_x1 = value.x1;}
			if (!_y1){_y1 = value.y1;}
			if (!_cx){_cx = value.cx;}
			if (!_cy){_cy = value.cy;}
			if (!_cx1){_cx1 = value.cx1;}
			if (!_cy1){_cy1 = value.cy1;}
			
		}
		
	}
}