package com.manutech.TO
{
	[Bindable]
	public class Page
	{
		private var _id:int;
		private var _fb_page_id:String;
		private var _fb_usr_id:String;
		private var _page_name:String;
		private var _category:String;
		private var _sub_category:String;
		private var _page_type:String;
		private var _likes:int;
		private var _website:String;
		private var _access_token:String;
		private var _start_date:String;
		private var _modify_date:String;
		private var _is_active:int;
		
		public function Page()
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

		public function get fb_page_id():String
		{
			return _fb_page_id;
		}

		public function set fb_page_id(value:String):void
		{
			_fb_page_id = value;
		}

		public function get fb_usr_id():String
		{
			return _fb_usr_id;
		}

		public function set fb_usr_id(value:String):void
		{
			_fb_usr_id = value;
		}

		public function get page_name():String
		{
			return _page_name;
		}

		public function set page_name(value:String):void
		{
			_page_name = value;
		}

		public function get category():String
		{
			return _category;
		}

		public function set category(value:String):void
		{
			_category = value;
		}

		public function get sub_category():String
		{
			return _sub_category;
		}

		public function set sub_category(value:String):void
		{
			_sub_category = value;
		}

		public function get page_type():String
		{
			return _page_type;
		}

		public function set page_type(value:String):void
		{
			_page_type = value;
		}

		public function get likes():int
		{
			return _likes;
		}

		public function set likes(value:int):void
		{
			_likes = value;
		}

		public function get website():String
		{
			return _website;
		}

		public function set website(value:String):void
		{
			_website = value;
		}

		public function get access_token():String
		{
			return _access_token;
		}

		public function set access_token(value:String):void
		{
			_access_token = value;
		}

		public function get start_date():String
		{
			return _start_date;
		}

		public function set start_date(value:String):void
		{
			_start_date = value;
		}

		public function get modify_date():String
		{
			return _modify_date;
		}

		public function set modify_date(value:String):void
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