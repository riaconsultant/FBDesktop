import com.facebook.graph.FacebookDesktop;

import mx.collections.ArrayCollection;
import mx.events.ListEvent;
import mx.managers.CursorManager;
import mx.utils.ObjectUtil;

/***
 *
 * define all the functions
 *
 ****/


private var fbApp:ArrayCollection=new ArrayCollection();

private var fbUserWall:ArrayCollection=new ArrayCollection();

private var fbUserInfo:ArrayCollection=new ArrayCollection();

private var fbUserPhoto:ArrayCollection=new ArrayCollection();

private var fbUserFriend:ArrayCollection=new ArrayCollection();

private var fbfriend:Boolean=false;

private var fbUserApp:ArrayCollection=new ArrayCollection();

private var fbUserPage:ArrayCollection=new ArrayCollection();

private var fbPageInfo:ArrayCollection=new ArrayCollection();

private var fbAppInfo:ArrayCollection=new ArrayCollection();

/***
 *  function definitions
 ***/
private function login():void{
	CursorManager.setBusyCursor();
	FacebookDesktop.login(loginHandler,permission);
	//FacebookDesktop.manageSession=true;
}

private function loginHandler(success:Object,fail:Object):void{
	if(success){
		user.fb_id=success.uid;
		user.email=success.user.email;
		user.first_name=success.user.first_name;
		user.last_name=success.user.last_name;
		if(success.user.location){
			user.location=success.user.location.name;
		}
		user.link=success.user.link;
		user.verified=success.user.verified;
		user.gender=success.user.gender;
		user.access_token=success.accessToken;
		mydesk.saveUser(user);
		fbUserInfo=success as ArrayCollection;
		
		profileCanvas.visible=true;
		usrProfileInfo.visible=true;
		//loginCanvas.visible=false;
		_menuLoginLabel="Logout";
		sqlConn=localdb.create_db(user.fb_id);
		CursorManager.removeBusyCursor();
		//posttowall();
	}else{
		//Alert.show("Please Login ",desktopTitle);
	}
}

private function logout():void{
	
	FacebookDesktop.logout(fbLogout);
}
private function fbLogout(success:Object):void{
	if(success){
		//currentState='Start';
		loginId.visible=true;
		logoutId.visible=false;
		//shareWall.visible=false;
		usrProfileInfo.visible=false;
		//loginCanvas.visible=true;
		profileCanvas.visible=false;
	}
}



private function fbposttowall():void{
	//var access:String="access_token="+user.access_token;
	var msg:Object=new Object();
	msg['message']=m1.text;
	msg['name']=n1.text;
	msg['description']=d1.text;
	msg['picture']=p1.text;
	msg['link']=l1.text;
	msg['caption']=c1.text;
	/*
	msg['message']="I am using facebook desktop application it's wonderfull..";
	msg['name']="FB Desktop";
	msg['description']="customize facebook page and application offline,A Group of application related to facebook,facebook page management";
	msg['picture']="http://photos-b.ak.fbcdn.net/hphotos-ak-snc6/189244_211086602272827_210842718963882_555364_1775019_s.jpg";
	msg['link']="http://www.facebook.com/BrandAnalytics";
	msg['caption']="New Face Of Product Branding In Social Media";*/
	FacebookDesktop.api("/me/feed",getResponse,msg,"POST");
}

private function getResponse(success:Object,fail:Object):void{
	if(success){
		//infoId.text=ObjectUtil.toString(success);
	}
	trace(ObjectUtil.toString(success));
}

private function getInfo():void{
	var access:String="access_token="+user.access_token;
	FacebookDesktop.api("/"+user.fb_id,getInfoData);
}

private function getInfoData(success:Object,fail:Object):void{
	if(success){
		//infoId.text=ObjectUtil.toString(success);
	}
	trace(ObjectUtil.toString(success));
}
private function getWall():void{
	var access:String="access_token="+user.access_token;
	FacebookDesktop.api("/"+user.fb_id+"/feed",getWallData);
}

private function getWallData(success:Object,fail:Object):void{
	if(success){
		//wallId.text=ObjectUtil.toString(success);
	}
	trace(ObjectUtil.toString(success));
}
private function getlike():void{
	var access:String="access_token="+user.access_token;
	FacebookDesktop.api("/"+user.fb_id+"/likes",getlikeData);
}

private function getlikeData(success:Object,fail:Object):void{
	if(success){
		//likeId.text=ObjectUtil.toString(success);
	}
	trace(ObjectUtil.toString(success));
}
private function getgroup():void{
	var access:String="access_token="+user.access_token;
	FacebookDesktop.api("/"+user.fb_id+"/groups",getgroupData);
}

private function getgroupData(success:Object,fail:Object):void{
	if(success){
		//groupId.text=ObjectUtil.toString(success);
	}
	trace(ObjectUtil.toString(success));
}
private function getalbums():void{
	var access:String="access_token="+user.access_token;
	FacebookDesktop.api("/"+user.fb_id+"/albums",getalbumsData);
}

private function getalbumsData(success:Object,fail:Object):void{
	if(success){
		//photoId.text=ObjectUtil.toString(success);
	}
	trace(ObjectUtil.toString(success));
}
private function getevents():void{
	var access:String="access_token="+user.access_token;
	FacebookDesktop.api("/"+user.fb_id+"/events",geteventsData);
}

private function geteventsData(success:Object,fail:Object):void{
	if(success){
		//eventId.text=ObjectUtil.toString(success);
	}
	trace(ObjectUtil.toString(success));
}

private function getfriends():void{
	if(fbfriend ==false){
	var access:String="access_token="+user.access_token;
	FacebookDesktop.api("/"+user.fb_id+"/friends",getfriendsData);
	}
}

private function getfriendsData(success:Object,fail:Object):void{
	if(success){
		var k:int=0;
		for(var i:int=0;i<success.length;i++){
			//if(success[i]['category'] != "Application"){
				var cat:Object=new Object();
				cat['img']=FacebookDesktop.getImageUrl(success[i]['id']);
				cat['id']=success[i]['id'];
				cat['name']=success[i]['name'];
				categoryArr[i] =  cat;
				k++;
			//}
		}
		//friendId.dataProvider=categoryArr;
		fbfriend=true;
	}
	trace(ObjectUtil.toString(success));
}

private function getPage():void{ 
	var access:String="access_token="+api_accessToken;
	FacebookDesktop.api("/me/accounts",getPageData);
}

private function getPageData(success:Object,fail:Object):void{
	if(success){
		var k:int=0;
		for(var i:int=0;i<success.length;i++){
			if(success[i]['category'] != "Application"){
				var cat:Object=new Object();
				cat['img']=FacebookDesktop.getImageUrl(success[i]['id']);
				cat['id']=success[i]['id'];
				cat['name']=success[i]['name'];
				fbUserPage.addItem(cat);
			}else{
				var app:Object=new Object();
				app['img']=FacebookDesktop.getImageUrl(success[i]['id']);
				app['id']=success[i]['id'];
				app['name']=success[i]['name'];
				fbUserApp.addItem(app);
			}
			k++;
		}
		pageList.dataProvider=fbUserPage;
		appList.dataProvider=fbUserApp;
	}
	//trace(ObjectUtil.toString(success));
	//trace(ObjectUtil.toString(fail));
}
private function getFBGroup():void{
	var access:String="access_token="+api_accessToken;
	FacebookDesktop.api("/me/groups",getGroupData);
}

private function getGroupData(success:Object,fail:Object):void{
	if(success){
		var k:int=0;
		for(var i:int=0;i<success.length;i++){
			if(success[i]['category'] != "Application"){
				var cat:Object=new Object();
				cat['img']=FacebookDesktop.getImageUrl(success[i]['id']);
				cat['id']=success[i]['id'];
				cat['name']=success[i]['name'];
				categoryArr[i] =  cat;
				k++;
			}
		}
		//pageList.dataProvider=categoryArr;
	}
}
private function getNotification():void{
	var access:String="access_token="+user.access_token;
	FacebookDesktop.api("/"+user.fb_id+"/feed",getWallData);
}

private function getNotificationData(success:Object,fail:Object):void{
	if(success){
		//wallId.text=ObjectUtil.toString(success);
	}
	trace(ObjectUtil.toString(success));
}

private function showPage(event:ListEvent):void{
	trace(ObjectUtil.toString(event.currentTarget));
	//htmlView.location="http://www.facebook.com/pages/"+pageList.selectedItem.name+"/"+pageList.selectedItem.id;
}

/*public function getFBApp():void{
	//var arr:Array = new Array("Home", "Services", "Who We Are","Contact Us","About Us","Help","Custom App");
	var myAC:ArrayCollection = new ArrayCollection( [
		{ name: "Home",id:"1" },
		{ name: "Services",id:"2" },
		{ name: "Who We Are",id:"3" },
		{ name: "Contact Us",id:"4" },
		{ name: "About Us",id:"5" },
		{ name: "Help",id:"6" },
		{ name: "Custom App",id:"7" }
	] );
	//fbAppId.dataProvider=myAC;
}*/

public function selectFriend(evt:ListEvent):void{
	/*friendD.enabled=true;
	friendD.percentWidth=50;
	friendD.percentHeight=100;*/
	//trace(ObjectUtil.toString(evt));
}