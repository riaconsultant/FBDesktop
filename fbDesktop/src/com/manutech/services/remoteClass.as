
import com.facebook.graph.FacebookDesktop;

import mx.controls.Alert;
import mx.rpc.events.FaultEvent;
import mx.rpc.events.ResultEvent;
import mx.utils.ObjectUtil;

public function faultListner(evt:FaultEvent):void{
	Alert.show(evt.fault.message);
}

private function saveUserListner(evt:ResultEvent):void{
	//user
	usrName.text= user.first_name+" "+user.last_name;
	usrLoc.text=user.location;
	usrImg.source=FacebookDesktop.getImageUrl(user.fb_id);
	//loginCanvas.visible=false;
	profileCanvas.visible=true;
	loginId.visible=false;
	logoutId.visible=true;
	//shareWall.visible=true;
	usrProfileInfo.visible=true;
}

private function savePageListner(evt:ResultEvent):void{
	
}
private function getAppsListner(evt:ResultEvent):void{
	
}
private function setFeedbackListner(evt:ResultEvent):void{
	
}

private function contactListner(evt:ResultEvent):void{
	Alert.show(ObjectUtil.toString(evt.result));
}

private function sayHelloListner(evt:ResultEvent):void{
	Alert.show(ObjectUtil.toString(evt.result));
}