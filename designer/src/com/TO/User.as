package com.TO
{
	[Bindable]
	public class User
	{
		private var _id:int:int:int:int:int
		private var _fb_id:String; 
		private var _first_name:String;
		private var _last_name:String; 
		private var _gender:int;
		private var _location:String;
		private var _link:String;
		private var _verified:int;
		private var _access_token:String;
		private var _ad_id:int; 
		private var _ref_id:int;
		private var _plan_id:int:int;
		private var _user_type:int;
		private var _start_date:Date;
		private var _modify_date:Date
		private var _is_active:int;

		public function get id()
		{
			return _id;
		}

		public function set id(value):void
		{
			_id = value;
		}

		public function get fb_id():String
		{
			return _fb_id;
		}

		public function set fb_id(value:String):void
		{
			_fb_id = value;
		}

		public function get first_name():String
		{
			return _first_name;
		}

		public function set first_name(value:String):void
		{
			_first_name = value;
		}

		public function get last_name():String
		{
			return _last_name;
		}

		public function set last_name(value:String):void
		{
			_last_name = value;
		}

		public function get gender():int
		{
			return _gender;
		}

		public function set gender(value:int):void
		{
			_gender = value;
		}

		public function get location():String
		{
			return _location;
		}

		public function set location(value:String):void
		{
			_location = value;
		}

		public function get link():String
		{
			return _link;
		}

		public function set link(value:String):void
		{
			_link = value;
		}

		public function get verified():int
		{
			return _verified;
		}

		public function set verified(value:int):void
		{
			_verified = value;
		}

		public function get access_token():String
		{
			return _access_token;
		}

		public function set access_token(value:String):void
		{
			_access_token = value;
		}

		public function get ad_id():int
		{
			return _ad_id;
		}

		public function set ad_id(value:int):void
		{
			_ad_id = value;
		}

		public function get ref_id():int
		{
			return _ref_id;
		}

		public function set ref_id(value:int):void
		{
			_ref_id = value;
		}

		public function get plan_id()
		{
			return _plan_id;
		}

		public function set plan_id(value):void
		{
			_plan_id = value;
		}

		public function get user_type():int
		{
			return _user_type;
		}

		public function set user_type(value:int):void
		{
			_user_type = value;
		}

		public function get start_date():Date
		{
			return _start_date;
		}

		public function set start_date(value:Date):void
		{
			_start_date = value;
		}

		public function get modify_date():Date
		{
			return _modify_date;
		}

		public function set modify_date(value:Date):void
		{
			_modify_date = value;
		}

		public function get is_active():int
		{
			return _is_active;
		}

		public function set is_active(value:int):void
		{
			_is_active = value;
		}


	}
}