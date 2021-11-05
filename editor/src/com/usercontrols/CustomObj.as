package com.usercontrols
{
	[RemoteClass(alias="CustomObj")]
	[Bindable]
	public class CustomObj
	{
		private var  _id:String;
		private var  _name:String;
		private var  _type:String;
		private var  _value:String;
		private var  _x:Number;
		private var  _y:Number;
		private var  _width:Number;
		private var  _height:Number;
		private var  _color:String;
		private var  _size:Number;
		private var  _family:String;
		private var  _align:String;
		private var  _layer:String;
		private var  _rotation:Number;
		private var  _trans:Number;
		private var _shadow:String;
		private var _objType:String;
		//private var  _uploadImgSource;
		public function CustomObj()
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

		public function get type():String
		{
			return _type;
		}

		public function set type(value:String):void
		{
			_type = value;
		}

		public function get value():String
		{
			return _value;
		}

		public function set value(value:String):void
		{
			_value = value;
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

		public function get color():String
		{
			return _color;
		}

		public function set color(value:String):void
		{
			_color = value;
		}

		public function get size():Number
		{
			return _size;
		}

		public function set size(value:Number):void
		{
			_size = value;
		}

		public function get family():String
		{
			return _family;
		}

		public function set family(value:String):void
		{
			_family = value;
		}

		public function get align():String
		{
			return _align;
		}

		public function set align(value:String):void
		{
			_align = value;
		}

		public function get layer():String
		{
			return _layer;
		}

		public function set layer(value:String):void
		{
			_layer = value;
		}

		public function get rotation():Number
		{
			return _rotation;
		}

		public function set rotation(value:Number):void
		{
			_rotation = value;
		}

		public function get trans():Number
		{
			return _trans;
		}

		public function set trans(value:Number):void
		{
			_trans = value;
		}

		public function get shadow():String
		{
			return _shadow;
		}

		public function set shadow(value:String):void
		{
			_shadow = value;
		}

		public function get objType():String
		{
			return _objType;
		}

		public function set objType(value:String):void
		{
			_objType = value;
		}


	}
}