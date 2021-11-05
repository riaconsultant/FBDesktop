package com.services
{
	import mx.controls.Alert;
	import mx.rpc.AbstractOperation;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.mxml.RemoteObject;

	public class RemoteService
	{
		public static var remote:RemoteObject=new RemoteObject();
		[Bindable]
		public var callName:String;
		public function RemoteService()
		{
			remote.endpoint=Config.gateway;
			remote.destination= Config.destination;
			remote.source=Config.source;
			remote.showBusyCursor=true;
			remote.addEventListener(FaultEvent.FAULT,faultHandler);
		}
		
		public function callService(arg:String):void{
			callName=arg;
			var operation:AbstractOperation=new AbstractOperation();
			operation=remote.getOperation(arg);
			operation.addEventListener(ResultEvent.RESULT,resultHandler);
			operation.send();
		}
		
		public function resultHandler(evt:ResultEvent):void{
			if(callName=="getProductCatgory"){
				var pc:ProductController=new ProductController();
				pc.productCategory(evt.result);
				
			}else if(callName==""){
				
			}else if(callName==""){
				
			}else if(callName==""){
				
			}else{
				
			}
		}
		
		public function faultHandler(evt:FaultEvent):void{
			Alert.show(""+evt.messageId,Config.APP_NAME);
		}
	}
}