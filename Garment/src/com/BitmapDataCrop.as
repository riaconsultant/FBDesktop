package com
{
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.controls.Alert;

	public class BitmapDataCrop extends Sprite
	{
		private var myRectangle:Shape;
		private var myRectSp:Sprite;
		private var beginX:Number; // top left x position
		private var beginY:Number; // top left y position
		private var endX:Number; // bottom right x position
		private var endY:Number; // bottom right y position
		private var btnX:Number; // button position
		private var btnY:Number; // button position
		private var copyBeginX:Number;
		private var copyBeginY:Number;
		private var copyEndX:Number; // bottom right x position
		private var copyEndY:Number; // bottom right y position
		
		private var imgLoader:Loader;
		private var holder:MovieClip;
		private var imageBMP:BitmapData;
		private var bmpWidth:int;
		private var bmpHeight:int;
		private var _name:String;

		public function BitmapDataCrop()
		{
			stage.addEventListener(MouseEvent.MOUSE_DOWN, rectStartingPoint);
			_name = 'circle';
		}
		
		public function DataCrop(name:String):void
		{
			_name = name;
		
			stage.addEventListener(MouseEvent.MOUSE_DOWN, rectStartingPoint);
			
		}

		private function imageLoaded(e:Event):void
		{
			stage.addEventListener(MouseEvent.MOUSE_DOWN, rectStartingPoint);
			//addChild(imgLoader);
		}

		private function rectStartingPoint(m:MouseEvent):void
		{
			beginX = mouseX;
			beginY = mouseY;

			stage.removeEventListener(MouseEvent.MOUSE_DOWN, rectStartingPoint);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, rectDraw);
		}

		private function rectDraw(m:MouseEvent):void
		{
			endX = mouseX;
			endY = mouseY;

			stage.addEventListener(MouseEvent.MOUSE_UP, stopRectDraw);
			
			
		
		}

		

		private function stopRectDraw(m:MouseEvent):void
		{
			
			//Rectangle Shape
			//var myRectangle:Shape = new Shape();

			//myRectangle.graphics.beginFill(0xffffff);
            //myRectangle.graphics.lineStyle(1);
            //myRectangle.graphics.drawRect(beginX, beginY, endX - beginX, endY - beginY);
            //myRectangle.graphics.endFill();

			//var myRectSp:Sprite = new Sprite();
			//myRectSp.addChild(myRectangle);
			
			Alert.show('he'+_name);
			//circle Shape
			if(_name== 'circle')
			{
				var myCircel:Shape = new Shape();
				myCircel.graphics.beginFill(0xffffff);
	            myCircel.graphics.lineStyle(1);
	            myCircel.graphics.drawCircle(beginX, beginY, endX - beginX);
	            myCircel.graphics.endFill();
	
				var myCirSp:Sprite = new Sprite();
				myCirSp.addChild(myCircel);
				stage.addChild(myCirSp);
			}
			//Round Rectangle Shape
			/* var myRoundRectangle:Shape = new Shape();
			myRoundRectangle.graphics.beginFill(0xffffff);
            myRoundRectangle.graphics.lineStyle(1);
            myRoundRectangle.graphics.drawRoundRect(beginX, beginY, endX - beginX, endY - beginY, 10);
            myRoundRectangle.graphics.endFill();

			var myRoundSp:Sprite = new Sprite();
			myRoundSp.addChild(myRoundRectangle);

			addChild(myRoundSp);*/
						
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, rectDraw);
			stage.removeEventListener(MouseEvent.MOUSE_UP, stopRectDraw);
			
			
		}

	
	}
}