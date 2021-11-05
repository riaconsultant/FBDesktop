import flash.filters.DropShadowFilter;
import flash.filters.GlowFilter;

import mx.controls.Alert;
import mx.core.Application;
import mx.events.ListEvent;
import mx.events.SliderEvent;
import mx.rpc.xml.QualifiedResourceManager;
import mx.utils.ObjectUtil;

[Bindable]public var fontColor:String="#FF0000";
[Bindable]public var fontSize:String="30";
[Bindable]public var fontFamily:String="Tahoma";
[Bindable]public var fontShadowColor:String='';
[Bindable]public var fontOutlineColor:String='';
//public var fontColor:String;

private function setShadowColor(arg1:String,arg2:String,arg3:String,arg4:String):Array{
	var color:uint=uint(arg1.replace('#',"0x"));
	var color1:uint=uint(arg4.replace('#',"0x"));
	var txtFilters:Array = new Array();
	//Alert.show(arg1+arg2+arg3);
	if(arg2=="outline"){
		var f:GlowFilter = new GlowFilter(color1,2.0,2.0,2.0,2,15,false,false);
		f.quality=BitmapFilterQuality.MEDIUM;
		txtFilters.push(f);
		//fontOutlineColor=arg1;
	}
	if(arg3=="shadow"){
		var fd:DropShadowFilter = new DropShadowFilter(3,100,color,1);
		txtFilters.push(fd);
		//fontShadowColor=arg1;
	}
	//Application.application.colorPrice.text=this.setprice(arg2,arg3);
	return txtFilters;
}
/*public function setOutline(arg:String):Array{
	var color:uint=uint(arg.replace('#',"0x"));
	var txtFilters:Array = new Array();
	var f:GlowFilter = new GlowFilter(color,2.0,2.0,2.0,2,15,false,false);
	f.quality=BitmapFilterQuality.MEDIUM;
	txtFilters.push(f);
	return txtFilters;
}*/

private function getFilterObject(arg1:Array):void{
	for(var i:int=0;i<arg1.length;i++){
		var g:GlowFilter=arg1[i] as GlowFilter;
		var f:DropShadowFilter=arg1[i] as DropShadowFilter;
	}
}

private function removeFilter(arg1:int):void{
	if(arg1 != 3){
		if(id == "top_text_controls_tool"){
			//Alert.show(ObjectUtil.toString(Application.application.top_label.filters));
			if(Application.application.top_label.filters){
				Application.application.top_label.filters=null;
				this.removeFilterTopCurveText();
			}
		}
		if(id == "mid_text_controls_tool"){
			Application.application.middle_label.filters=null;
		}
		if(id == "bottom_text_controls_tool"){
			Application.application.bottom_label.filters=null;
			this.removeFilterBottomCurveText();
		}
		
	}
	/*if(arg2 == "shadow"){
		if(id == "top_text_controls_tool"){
			//Alert.show(event.currentTarget.selectedItem.colorCode);
			Application.application.top_label.filters[1]='';
		}
		if(id == "mid_text_controls_tool"){
			Application.application.middle_label.filters[1]='';
		}
		if(id == "bottom_text_controls_tool"){
			Application.application.bottom_label.filters[1]='';
		}
	}else{}*/
}

private function setColor(arg:String,arg1:String,arg2:String,arg3:String):void{
	if(arg1 == "outline"){
		if(id == "top_text_controls_tool"){
			//Alert.show(event.currentTarget.selectedItem.colorCode);
			Application.application.top_label.filters=this.setShadowColor(arg,arg1,arg2,arg3);
				this.setShadowOnTopCurveText(arg,arg1,arg2,arg3);
		}
		if(id == "mid_text_controls_tool"){
			Application.application.middle_label.filters=this.setShadowColor(arg,arg1,arg2,arg3);
		}
		if(id == "bottom_text_controls_tool"){
			Application.application.bottom_label.filters=this.setShadowColor(arg,arg1,arg2,arg3);
			this.setShadowOnBottomCurveText(arg,arg1,arg2,arg3);
		}
	}
	if(arg2 == "shadow"){
		if(id == "top_text_controls_tool"){
			//Alert.show(event.currentTarget.selectedItem.colorCode);
			Application.application.top_label.filters=this.setShadowColor(arg,arg1,arg2,arg3);
			this.setShadowOnTopCurveText(arg,arg1,arg2,arg3);
		}
		if(id == "mid_text_controls_tool"){
			Application.application.middle_label.filters=this.setShadowColor(arg,arg1,arg2,arg3);
		}
		if(id == "bottom_text_controls_tool"){
			Application.application.bottom_label.filters=this.setShadowColor(arg,arg1,arg2,arg3);
			this.setShadowOnBottomCurveText(arg,arg1,arg2,arg3);
		}
	}else{}
}


public function setprice(arg1:String,arg2:String):String{
	//var bpr:Number = Number(Application.application.basePrice.text);
	var tPr:Number=0;
	if(arg1=="outline" && arg2 != 'shadow'){
		tPr=15.00;
		Application.application.totalColor.text="2";
		Application.application.colorPrice.text="15.00";
	}else if(arg1 != 'outline' && arg2=="shadow"){
		tPr=15.00;
		Application.application.totalColor.text="2";
		Application.application.colorPrice.text="15.00";
	}else if(arg2=="shadow" && arg1=="outline"){
		tPr=25.00;
		Application.application.totalColor.text="3";
		Application.application.colorPrice.text="25.00";
	}else if(arg2=="" && arg1==""){
		tPr=00.00;
		Application.application.totalColor.text="1";
		Application.application.colorPrice.text="00.00";
	}else{}
	return tPr.toString();
}

private function setShadowOnTopCurveText(arg1:String,arg2:String,arg3:String,arg4:String):void{
	var cnv:Canvas = Application.application.textCanvas.getChildByName('curveText') as Canvas;
	var lblArray:Array = new Array();
	if(cnv != null){
		lblArray = cnv.getChildren();
		//trace(lblArray.length);
	}
	if(lblArray.length > 0 ){
		for(var i:int = 0; i<lblArray.length; i++){
			//trace(lblArray[0]);
			//Alert.show(ObjectUtil.toString(lblArray[i]));
			var lbl:Label = lblArray[i] as Label;
			lbl.filters = this.setShadowColor(arg1,arg2,arg3,arg4);
		}
	}
}
private function setShadowOnBottomCurveText(arg1:String,arg2:String,arg3:String,arg4:String):void{
	var cnv:Canvas = Application.application.textCanvas.getChildByName('curveText1') as Canvas;
	var lblArray:Array = new Array();
	if(cnv != null){
		lblArray = cnv.getChildren();
		//trace(lblArray.length);
	}
	if(lblArray.length > 0 ){
		for(var i:int = 0; i<lblArray.length; i++){
			//trace(lblArray[0]);
			//Alert.show(ObjectUtil.toString(lblArray[i]));
			var lbl:Label = lblArray[i] as Label;
			lbl.filters = this.setShadowColor(arg1,arg2,arg3,arg4);
		}
	}
}

private function removeFilterTopCurveText():void{
	var cnv:Canvas = Application.application.textCanvas.getChildByName('curveText') as Canvas;
	var lblArray:Array = new Array();
	if(cnv != null){
		lblArray = cnv.getChildren();
	}
	if(lblArray.length > 0 ){
		for(var i:int = 0; i<lblArray.length; i++){
			var lbl:Label = lblArray[i] as Label;
			lbl.filters = null;
		}
	}
}
private function removeFilterBottomCurveText():void{
	var cnv:Canvas = Application.application.textCanvas.getChildByName('curveText1') as Canvas;
	var lblArray:Array = new Array();
	if(cnv != null){
		lblArray = cnv.getChildren();
	}
	if(lblArray.length > 0 ){
		for(var i:int = 0; i<lblArray.length; i++){
			var lbl:Label = lblArray[i] as Label;
			lbl.filters = null;
		}
	}
}