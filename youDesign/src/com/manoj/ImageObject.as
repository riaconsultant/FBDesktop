package com.manoj
{
	import flash.utils.ByteArray;

	public class ImageObject
	{
		private var _id:String;
		private var _name:String;
		private var _imgType:String;
		private var _imgCat:String;
		private var _imgId:String;
		private var _imagelib:Boolean;
		private var _imagePath:String;
		private var _cropArray:ByteArray;
		private var _x:Number;
		private var _y:Number;
		private var _width:Number;
		private var _height:Number;
		private var _special:String;
		private var _basePrice:String;
		private var _colors:String;
		private var _colorCost:String;
		private var _totalCost:Number;
		
		public function ImageObject()
		{
		}

		public function get id():String
		{
			return _id;
		}

		public function set id(value:String):void
		{
			_id = value;
		}

		public function get name():String
		{
			return _name;
		}

		public function set name(value:String):void
		{
			_name = value;
		}

		public function get imgType():String
		{
			return _imgType;
		}

		public function set imgType(value:String):void
		{
			_imgType = value;
		}

		public function get imgCat():String
		{
			return _imgCat;
		}

		public function set imgCat(value:String):void
		{
			_imgCat = value;
		}

		public function get imgId():String
		{
			return _imgId;
		}

		public function set imgId(value:String):void
		{
			_imgId = value;
		}

		public function get imagelib():Boolean
		{
			return _imagelib;
		}

		public function set imagelib(value:Boolean):void
		{
			_imagelib = value;
		}

		public function get imagePath():String
		{
			return _imagePath;
		}

		public function set imagePath(value:String):void
		{
			_imagePath = value;
		}

		public function get x():Number
		{
			return _x;
		}

		public function set x(value:Number):void
		{
			_x = value;
		}

		public function get y():Number
		{
			return _y;
		}

		public function set y(value:Number):void
		{
			_y = value;
		}

		public function get width():Number
		{
			return _width;
		}

		public function set width(value:Number):void
		{
			_width = value;
		}

		public function get height():Number
		{
			return _height;
		}

		public function set height(value:Number):void
		{
			_height = value;
		}

		public function get special():String
		{
			return _special;
		}

		public function set special(value:String):void
		{
			_special = value;
		}

		public function get basePrice():String
		{
			return _basePrice;
		}

		public function set basePrice(value:String):void
		{
			_basePrice = value;
		}

		public function get colors():String
		{
			return _colors;
		}

		public function set colors(value:String):void
		{
			_colors = value;
		}

		public function get colorCost():String
		{
			return _colorCost;
		}

		public function set colorCost(value:String):void
		{
			_colorCost = value;
		}

		public function get totalCost():Number
		{
			return _totalCost;
		}

		public function set totalCost(value:Number):void
		{
			_totalCost = value;
		}

		public function get cropArray():ByteArray
		{
			return _cropArray;
		}

		public function set cropArray(value:ByteArray):void
		{
			_cropArray = value;
		}


	}
}