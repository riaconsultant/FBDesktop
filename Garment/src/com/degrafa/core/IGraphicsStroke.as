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
package com.degrafa.core{
	import flash.display.Graphics;
	import flash.geom.Rectangle;
	
	/**
 	* Base interface for all Degrafa stroke objects.
 	**/ 	
	public interface IGraphicsStroke extends IDegrafaObject{
		
		function get weight():Number;
		function set weight(value:Number):void;
		
		function get scaleMode():String;
		function set scaleMode(value:String):void;
		
		function get pixelHinting():Boolean;
		function set pixelHinting(value:Boolean):void;
		
		function get miterLimit():Number;
		function set miterLimit(value:Number):void;
		
		function get joints():String;
		function set joints(value:String):void;
		
		function get caps():String;
		function set caps(value:String):void;
		
		function apply(graphics:Graphics, rc:Rectangle):void 
		
		function get reApplyFunction():Function;
		function get lastArgs():Array;
		function get lastRectangle():Rectangle;
		
	}
}