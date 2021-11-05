package com.TO
{
	[Bindable]
	public class Product
	{
		private var _id:int;
		private var _name:String;
		private var _sku:int;
		private var _weight:String;
		private var _description:String;
		private var _selectName:String;
		private var _imgArr:Array;
		private var _price:String;
		public function Product()
		{
		}

		public function get id():int
		{
			return _id;
		}

		public function set id(value:int):void
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

		public function get sku():int
		{
			return _sku;
		}

		public function set sku(value:int):void
		{
			_sku = value;
		}

		public function get weight():String
		{
			return _weight;
		}

		public function set weight(value:String):void
		{
			_weight = value;
		}

		public function get description():String
		{
			return _description;
		}

		public function set description(value:String):void
		{
			_description = value;
		}

		public function get selectName():String
		{
			return _selectName;
		}

		public function set selectName(value:String):void
		{
			_selectName = value;
		}

		public function get imgArr():Array
		{
			return _imgArr;
		}

		public function set imgArr(value:Array):void
		{
			_imgArr = value;
		}

		public function get price():String
		{
			return _price;
		}

		public function set price(value:String):void
		{
			_price = value;
		}


	}
}