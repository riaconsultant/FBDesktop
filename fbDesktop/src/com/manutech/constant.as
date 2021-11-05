// ActionScript file
public var site_url:String="http://bookinginhotel.com/";
//public var site_url:String="http://localhost/bookinginhotel.com/";

public var AppupdateURL:String="http://bookinginhotel.com/fb/apps/desktop/update.xml";

//public var AppupdateURL:String=site_url+"fb/apps/desktop/update.xml";

[Bindable]
public var remote_endpoint:String=site_url+"amf/gateway.php";

public var dev_url:String="http://www.facebook.com/manoj.chaurasiya";

public var desktop_page_url:String="http://www.facebook.com/pages/FB-Desktop/210842718963882";

public var page_url:String="http://www.facebook.com/pages/";

public var app_url:String="http://www.facebook.com/apps/application.php?id=";

public var create_page_url:String="https://www.facebook.com/pages/create.php";

public var create_app_url:String="https://developers.facebook.com/apps";

public var desktopTitle:String="Facebook On Desktop";

private var api_id:String="221752477864418";

private var api_accessToken:String="203932206284241|2.AQA7OrQZ_udgwKt-.3600.1313733600.0-621038261|11Z9kSx9CjoMxhvzD94swWhKJgc";

private var permission:Array=new Array('email','manage_pages','read_stream','offline_access','read_insights',
										'manage_notifications','publish_stream','read_friendlists','rsvp_event',
										'friends_birthday','user_birthday');

private var extendedPermission:Array=new Array('status_update','share_item');
[Bindable]
public var categoryArr:Array = new Array();

/***
 * tables create queries
 * */
public var birthday_query:String='CREATE  TABLE  IF NOT EXISTS "main"."birthday" ("id" INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL , "fb_id" VARCHAR, "first_name" VARCHAR, "last_name" VARCHAR, "dob" VARCHAR, "link" TEXT)';

public var page_app_query:String='CREATE  TABLE  IF NOT EXISTS "main"."account" ("id" INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL , "fb_id" VARCHAR, "name" VARCHAR, "access_token" TEXT, "category" VARCHAR, "profile_id" VARCHAR)';

public var page_app_detail_query:String='CREATE  TABLE "main"."profile_details" ("id" integer PRIMARY KEY  AUTOINCREMENT  NOT NULL , "profile_id" varchar, "name" varchar, "link" text, "likes" INTERGER, "type" varchar)';

public var page_app_tab_query:String='CREATE  TABLE "main"."profile_tab" ("id" integer PRIMARY KEY  AUTOINCREMENT  NOT NULL , "profile_id" varchar, "name" varchar, "link" TEXT, "app_name" varchar, "app_id" varchar, "position" varchar, "type" varchar)';






