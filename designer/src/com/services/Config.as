package com.services
{
	import com.components.pop;
	
	import flash.display.DisplayObject;
	import flash.display.StageDisplayState;
	import flash.events.ContextMenuEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	
	import mx.core.Application;
	import mx.managers.PopUpManager;

	public class Config
	{
		public static var gateway:String="http://localhost/projects/amf/gateway.php";
		public static var site_url:String="http://localhost/projects/flex/";
		public static var destination:String="Designme";
		public static var source:String="Designme";
		public static var APP_NAME:String="Designer Project";
		
		public function Config()
		{
		}
		
		public static function rightMenu():ContextMenu{
			var cumArr:Array=new Array();
			var conMenuItem:ContextMenuItem=new ContextMenuItem("Developed By : RIA Consultant",true);
			conMenuItem.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,openSite);
			var conMenuItem1:ContextMenuItem=new ContextMenuItem("Go Full Screen",true);
			conMenuItem1.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,fullScreenSite);
			cumArr[0]=conMenuItem;
			cumArr[1]=conMenuItem1;
			var conMenu:ContextMenu=new ContextMenu();
			conMenu.hideBuiltInItems();
			
			conMenu.builtInItems.print=false;
			conMenu.customItems=cumArr;
			return conMenu;
		}
		
		public static function openSite(event:ContextMenuEvent):void{
			//Alert.show(event.currentTarget.valueOf());
			var site:URLRequest=new URLRequest("http://www.designme.in");
			navigateToURL(site,"_blank");
		}
		public static function fullScreenSite(event:ContextMenuEvent):void{
			toogleFull();
		}
		
		public static function toogleFull():void{
			try {
				switch (Application.application.stage.displayState) {
					case StageDisplayState.FULL_SCREEN:
						/* If already in full screen mode, switch to normal mode. */
						Application.application.stage.displayState = StageDisplayState.NORMAL;
						break;
					default:
						/* If not in full screen mode, switch to full screen mode. */
						Application.application.stage.displayState = StageDisplayState.FULL_SCREEN;
						break;
				}
			} catch (err:SecurityError) {
				// ignore
			}
			
		}
		
		public function edit():void{
			/*product.selectName=product.name;
			mainTab.selectedIndex=1;*/
			//this.toggleCan('editCanvas');
		}
		
		public static function link(arg:String):void{
			switch(arg){
				case "login":{
					var log:pop=new pop();
					log.width=400;
					log.height=200;
					log.id="login";
					PopUpManager.addPopUp(log,Application.application as DisplayObject,true);
					PopUpManager.centerPopUp(log);
					break;
				}
				case "feedback":{
					var feed:pop=new pop();
					feed.width=350;
					feed.height=420;
					feed.id="feedback";
					PopUpManager.addPopUp(feed,Application.application as DisplayObject,true);
					PopUpManager.centerPopUp(feed);
					break;
				}
				case "help":{
					var help:pop=new pop();
					help.width=680;
					help.height=520;
					help.id="help";
					PopUpManager.addPopUp(help,Application.application as DisplayObject,true);
					PopUpManager.centerPopUp(help);
					break;
				}
				default:{
					break;
				}
			}
		}
	}
}