
import air.update.ApplicationUpdaterUI;
import air.update.events.UpdateEvent;

import com.facebook.graph.FacebookDesktop;
import com.manutech.TO.User;
import com.manutech.component.AboutUswin;
import com.manutech.component.SettingWin;
import com.manutech.component.popWindow;
import com.manutech.services.LocalDB;

import flash.data.SQLConnection;
import flash.display.Bitmap;
import flash.display.NativeMenu;
import flash.display.NativeMenuItem;
import flash.events.ErrorEvent;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.ui.ContextMenu;

import mx.controls.Alert;
import mx.managers.PopUpManager;

import spark.components.Application;

private var appUpdater:ApplicationUpdaterUI = new ApplicationUpdaterUI();

[Bindable]
public var user:User=new User();

[Bindable]
private var maxValue:int=0;

[Bindable]
private var conMenu:ContextMenu;

private var menuOptions:NativeMenu=new NativeMenu();

private var window:AboutUswin=new AboutUswin();
private var settingWin:SettingWin=new SettingWin();

private var iconURL:String="assets/Facebook3d.png";
private var loadScreen:String="assets/fbdesk.png";
private var bmp: Bitmap = null;

private var _menuLoginLabel:String="Login/Logout";

private var localdb:LocalDB=new LocalDB();

private var sqlConn:SQLConnection=new SQLConnection();

include 'services/fbFunction.as';
/**
 * Application creation complete.
 * 1. check for update new version.
 * 2. facebook sessions.
 * 3. create local db. 
 * */
public function init():void{
	checkUpdate();
	if(FacebookDesktop.getSession() == null){
		FacebookDesktop.init(api_id,loginHandler);
	}else{
		logout();
	}
	//NativeApplication.nativeApplication.startAtLogin=true;
	winRightDockMenu();
	//nativeWindow.maximize();
	//var user:User=new User();
	var loader: Loader = new Loader();
	loader.contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler);
	loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
	
	var request: URLRequest = new URLRequest(iconURL);
	loader.load(request);
	var appXML:XML = NativeApplication.nativeApplication.applicationDescriptor;
	var ns:Namespace = appXML.namespace();
	app_version.text = appXML.ns::versionLabel;
	app_name.text = appXML.ns::name;
	
	
}

private function completeHandler(event: Event): void
{
	bmp = Bitmap(Loader(event.target.loader).content);
	fbDockIcon(bmp);
}

private function ioErrorHandler(event: IOErrorEvent): void
{
	trace("Unable to load image: " + iconURL);
}

private function fbDockIcon(bmp:Bitmap):void{
	if(NativeApplication.supportsDockIcon){
		var dockIcon:DockIcon = NativeApplication.nativeApplication.icon as DockIcon;
		dockIcon.bitmaps=new Array(bmp);
		dockIcon.menu=menuOptions;
		dockIcon.bounce(NotificationType.INFORMATIONAL);
		//NativeApplication.nativeApplication.addEventListener(InvokeEvent.INVOKE,undock);
	} else if (NativeApplication.supportsSystemTrayIcon){
		var sysTrayIcon:SystemTrayIcon = NativeApplication.nativeApplication.icon as SystemTrayIcon;
		sysTrayIcon.tooltip = "Facebook Application";
		sysTrayIcon.menu=menuOptions;
		sysTrayIcon.bitmaps=new Array(bmp);
		sysTrayIcon.addEventListener(MouseEvent.CLICK,function(e:MouseEvent):void{nativeWindow.visible=true;});
	}
}


private function checkUpdate():void {
	setApplicationVersion();
	// we set the URL for the update.xml file
	appUpdater.updateURL = AppupdateURL;
	//we set the event handlers for INITIALIZED and ERROR
	appUpdater.addEventListener(UpdateEvent.INITIALIZED, onUpdate);
	appUpdater.addEventListener(ErrorEvent.ERROR, onError);
	appUpdater.isCheckForUpdateVisible = false;
	appUpdater.isFileUpdateVisible = false;
	appUpdater.isInstallUpdateVisible = false;
	appUpdater.initialize();
}
private function setApplicationVersion():void {
	var appXML:XML = NativeApplication.nativeApplication.applicationDescriptor;
	var ns:Namespace = appXML.namespace();
	//lblAppVersion.text = "App version: " + appXML.ns::version;
	//Alert.show("App version: " + appXML.ns::version,desktopTitle);
}

private function onUpdate(event:UpdateEvent):void {
	appUpdater.checkNow();
}

private function onError(event:ErrorEvent):void {
	Alert.show(event.toString());
}

private function winClose():void{
	nativeWindow.close();
}
private function winMaxRes():void{
	if(maxValue==0){
		nativeWindow.maximize();
		restoreId.toolTip="Restore Window";
		maxValue=1;
	}else{
		nativeWindow.restore();
		restoreId.toolTip="Maximize Window";
		maxValue=0;
	}
}
private function winMinimize():void{
	//nativeWindow.minimize();
	nativeWindow.visible=false;
	//fbDockIcon();
}
private function winDockMenu():void{
	
}
private function winRightDockMenu():void{
	var cumArr:Array=new Array();
	var conMenuItem:ContextMenuItem=new ContextMenuItem("Developed By : Manoj Chaurasiya",true);
	conMenuItem.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,openSite);
	var conMenuItem1:ContextMenuItem=new ContextMenuItem("Go Full Screen",true);
	conMenuItem1.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,fullScreenSite);
	cumArr[0]=conMenuItem;
	cumArr[1]=conMenuItem1;
	conMenu=new ContextMenu();
	conMenu.hideBuiltInItems();
	conMenu.builtInItems.print=false;
	conMenu.customItems=cumArr;
	this.contextMenu=conMenu;
	Nativemanu();
}

public function openSite(event:ContextMenuEvent):void{
	var site:URLRequest=new URLRequest(dev_url);
	navigateToURL(site,"_blank");
}
public function fullScreenSite(event:ContextMenuEvent):void{
	this.winMaxRes();
}

private function Nativemanu():void{
	var exitItem:NativeMenuItem=new NativeMenuItem("Exit",false);
	exitItem.addEventListener(Event.SELECT,exitWindow);
	var openItem:NativeMenuItem=new NativeMenuItem("Open Window",false);
	openItem.addEventListener(Event.SELECT,openWindow);
	var sepItem:NativeMenuItem=new NativeMenuItem("-",true);
	var sepItem1:NativeMenuItem=new NativeMenuItem("-",true);
	var setting:NativeMenuItem=new NativeMenuItem("Setting",false);
	setting.addEventListener(Event.SELECT,Settings);
	var aboutUs:NativeMenuItem=new NativeMenuItem("About Us",false);
	aboutUs.addEventListener(Event.SELECT,aboutUsAction);
	var logout:NativeMenuItem=new NativeMenuItem(_menuLoginLabel,false);
	logout.addEventListener(Event.SELECT,menuLogout);
	menuOptions.addItem(openItem);
	menuOptions.addItem(setting);
	menuOptions.addItem(aboutUs);
	menuOptions.addItem(sepItem);
	menuOptions.addItem(logout);
	menuOptions.addItem(sepItem1);
	menuOptions.addItem(exitItem);
	
}

private function menuLogout(evt:Event):void{
	if(_menuLoginLabel=="Login"){
		login();
	}else{
		logout();
	}
}

private function exitWindow(evt:Event):void{
	this.nativeWindow.close();
}

private function openWindow(evt:Event):void{
	this.nativeWindow.visible=true;
}
private function aboutUsAction(evt:Event):void{
	var mainScreen:Screen = Screen.mainScreen;
	if(window!=null)window.close();
	window= new AboutUswin();
	window.open();
	myMov.target = window;
	myMov.xTo = myMov.xFrom = mainScreen.visibleBounds.width - window.width - 10;
	myMov.yFrom = mainScreen.visibleBounds.height;
	myMov.yTo = mainScreen.visibleBounds.height - window.height + 0; 
	myMov.duration = 1000;
	myMov.play();
}
private function Settings(evt:Event):void{
	var mainScreen:Screen = Screen.mainScreen;
	if(settingWin!=null)settingWin.close();
	settingWin= new SettingWin();
	settingWin.open();
	myMov.target = settingWin;
	myMov.xTo = myMov.xFrom = mainScreen.visibleBounds.width - settingWin.width - 10;
	myMov.yFrom = mainScreen.visibleBounds.height;
	myMov.yTo = mainScreen.visibleBounds.height - window.height + 0; 
	myMov.duration = 1000;
	myMov.play();
}

public function dock(event:Event = null):void{
	stage.nativeWindow.visible = false;
	//NativeApplication.nativeApplication.icon.bitmaps = [clock.bitmapData];
}	

public function undock(event:Event = null):void{
	stage.nativeWindow.visible = true;
	NativeApplication.nativeApplication.icon.bitmaps = [];
}

public function navigatorClick(evt:Event):void{
	if(tabNav.selectedIndex==0){
		//getInfo();
		title_id.text="Wall / Publisher"
	}else if(tabNav.selectedIndex==1){
		//getWall();
		title_id.text="Facebook Pages/Applications ";
	}else if(tabNav.selectedIndex==2){
		//getalbums();
		title_id.text="Facebook Groups";
	}else if(tabNav.selectedIndex==3){
		//getfriends();
		title_id.text="Facebook Media";
	}else if(tabNav.selectedIndex==4){
		//getPage();
		title_id.text="Facebook Birth Day Alarm";
	}
	/*else if(tabNav.selectedIndex==5){
		title_id.text="Facebook TO-DO List";
	}*/
	else if(tabNav.selectedIndex==5){
		//getgroup();
		title_id.text="Facebook Tab Designer";
	}else if(tabNav.selectedIndex==6){
		//getevents();
		title_id.text="Image Designer";
	}else if(tabNav.selectedIndex==7){
		//getWall();
		title_id.text="Facebook Event Alarm";
	}else if(tabNav.selectedIndex==8){
		//getWall();
		title_id.text="Affliate System";
	}else{
		
	}
}

private function createFBPage():void{
	var fbPageWin:popWindow=new popWindow();
	fbPageWin.popTitle="facebook page";
	fbPageWin._w=800;
	fbPageWin._h=400;
	fbPageWin._location=create_page_url;
	PopUpManager.addPopUp(fbPageWin,this,true);
	PopUpManager.centerPopUp(fbPageWin);
}

private function createFBapp():void{
	var fbPageWin:popWindow=new popWindow();
	fbPageWin.popTitle="facebook Application";
	fbPageWin._w=800;
	fbPageWin._h=400;
	fbPageWin._location=create_app_url;
	PopUpManager.addPopUp(fbPageWin,this,true);
	PopUpManager.centerPopUp(fbPageWin);
}