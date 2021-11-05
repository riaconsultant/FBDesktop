/**
 * @author : Manoj Chaurasiya
 * 
 * */
include "globalConfigs.as";

public function init():void{
	/*param_product=Application.application.parameters.template_id;
	product_type=Application.application.parameters.type;*/
	param_product='12';
	product_type='black';
	myObj.endpoint=site_url+"cpamf/gateway";
	//Alert.show(myObj.endpoint);
	//myObj.sayHello('manoj');
	myObj.getTemplate(param_product);
	myObj.getColor();
	myObj.getFont();
	this.setbackImage(product_type);
	//this.arcTextData("manoj");
}

public function arcTextData(arg:String,canvasId:String):void{
	if(canvasId == "top_text_controls_tool"){
		if(top_text_controls_tool.top_text_arch_yes.selected==true){
			top_label.visible=false;
			this.drawLabelInTopArc(arg,canvasId);
		}
	}else if(canvasId == "bottom_text_controls_tool"){
		if(bottom_text_controls_tool.top_text_arch_yes.selected==true){
			bottom_label.visible=false;
			this.drawLabelInBottomArc(arg,canvasId);
		}
	}
	
}

private function drawLabelInTopArc(arg:String,canvasId:String):void{
			var radius:Number = 150;
			var angleLeading:Number = 180 ;
			var spacing:Number = 11; //for 20 arial 
			var centerText:Point = new Point(radius,radius);
			var angularOffset:Number;
			var temDegree:Number;
			/*if(fontsize[top_text_controls_tool.font_size.selectedIndex].data == '20'){
				spacing = 5.5; //for 20 arial 
				angularOffset =  this.getOffsetValueTopText(arg.length*5.8);
				temDegree=90;
			}else if(fontsize[top_text_controls_tool.font_size.selectedIndex].data == '25'){
				spacing = 7.8;
				angularOffset =  this.getOffsetValueTopText(arg.length*8.2);
				temDegree=88;
			}else if(fontsize[top_text_controls_tool.font_size.selectedIndex].data == '30'){
				spacing = 10.8;
				angularOffset =  this.getOffsetValueTopText(arg.length*8.5);
				temDegree=82;
			}else if(fontsize[top_text_controls_tool.font_size.selectedIndex].data == '35'){
				spacing = 11.2;
				angularOffset =  this.getOffsetValueTopText(arg.length*11.8);
				temDegree=84;
			}else if(fontsize[top_text_controls_tool.font_size.selectedIndex].data == '40'){
				spacing = 15.2;
				angularOffset =  this.getOffsetValueTopText(arg.length*15.8);// for 40
				temDegree=82;
			}else{	}*/
			
			angularOffset =  this.getOffsetValueTopText(arg.length*11);// for 30
			temDegree=82;
			if(textCanvas.getChildByName('curveText') as Canvas){
				textCanvas.removeChild(textCanvas.getChildByName('curveText') as Canvas);
			}
			var txtContainer:Canvas = new Canvas();
			txtContainer.x = 0;
			txtContainer.y = 0;
			txtContainer.name = 'curveText';
			//txtContainer.setStyle('borderStyle','none');
			txtContainer.width = textCanvas.width;
			txtContainer.height = textCanvas.height;
			txtContainer.setStyle('verticalCenter',0);
			txtContainer.setStyle('horizontalCenter',0);
			txtContainer.setStyle('horizontalScrollPolicy','off');
			txtContainer.setStyle('verticalScrollPolicy','off');
			for (var char:uint=0;char<arg.length;char++)
			{
				var tempText:Label = new Label();
				tempText.setStyle('fontSize',fontsize[top_text_controls_tool.font_size.selectedIndex].data);
				//tempText.setStyle('fontSize','20');
				tempText.setStyle('fontFamily',fontData[top_text_controls_tool.text_font.selectedIndex].fontLabel);
				tempText.setStyle('textAlign','center');
				tempText.setStyle('color',fontColors[top_text_controls_tool.font_color.selectedIndex].colorCode.toString());
				//tempText.setStyle('border','solid');
				tempText.filters = top_label.filters;
				tempText.x = radius * Math.cos(degrees2radians(char*spacing+angularOffset)) + centerText.x;
				tempText.y = radius * Math.sin(degrees2radians(char*spacing+angularOffset)) + centerText.y;
				var dx:Number = centerText.x-tempText.x;
				var dy:Number = centerText.y-tempText.y;
				var angle:Number = Math.atan2(dy, dx);
				tempText.rotation = radians2degrees(angle) - temDegree;
				tempText.text = arg.charAt(char);
				
				/*if(tempText.text.toLowerCase() == "m" || tempText.text.toLowerCase() == "w"){
					//Alert.show(tempText.text.toLowerCase());
					tempText.setStyle('paddingLeft','.7');
				}*/
				//trace("x:"+tempText.x+" y:"+tempText.y+" width "+char*spacing);
				txtContainer.addChild(tempText);
			}
			textCanvas.addChild(txtContainer);
}

private function drawLabelInBottomArc(arg:String,canvasId:String):void{
	var radius1:Number = 150 - (Number(fontsize[bottom_text_controls_tool.font_size.selectedIndex].data)+17);
	var spacing1:Number =5.5;//for 20
	var centerText1:Point = new Point(150,150);
	var angularOffset1:Number;
	var temDegree1:Number;
	angularOffset1 =  this.getOffsetValueBottomText(arg.length*5.8);// for 20
	
	if(fontsize[bottom_text_controls_tool.font_size.selectedIndex].data == '20'){
		spacing1 = 5.5; //for 20 arial 
		angularOffset1 =  this.getOffsetValueBottomText(arg.length*5.8);
		temDegree1=90;
		radius1 = 150 - (Number(fontsize[bottom_text_controls_tool.font_size.selectedIndex].data)+9);
	}else if(fontsize[bottom_text_controls_tool.font_size.selectedIndex].data == '25'){
		spacing1 = 7.8;
		angularOffset1 =  this.getOffsetValueBottomText(arg.length*8.2);
		temDegree1=88;
		radius1 = 150 - (Number(fontsize[bottom_text_controls_tool.font_size.selectedIndex].data)+11);
	}else if(fontsize[bottom_text_controls_tool.font_size.selectedIndex].data == '30'){
		spacing1 = 8.1;
		angularOffset1 =  this.getOffsetValueBottomText(arg.length*8.5);
		temDegree1=85;
		radius1 = 150 - (Number(fontsize[bottom_text_controls_tool.font_size.selectedIndex].data)+13);
	}else if(fontsize[bottom_text_controls_tool.font_size.selectedIndex].data == '35'){
		spacing1 = 11.2;
		angularOffset1 =  this.getOffsetValueBottomText(arg.length*11.8);
		temDegree1=84;
		radius1 = 150 - (Number(fontsize[bottom_text_controls_tool.font_size.selectedIndex].data)+15);
	}else if(fontsize[bottom_text_controls_tool.font_size.selectedIndex].data == '40'){
		spacing1 = 15.2;
		angularOffset1 =  this.getOffsetValueBottomText(arg.length*15.8);// for 40
		temDegree1=82;
		radius1 = 150 - (Number(fontsize[bottom_text_controls_tool.font_size.selectedIndex].data)+17);
	}else{	}
	
	//angularOffset1 =  this.getOffsetValueTopText(arg.length*7.5);
	if(textCanvas.getChildByName('curveText1') as Canvas){
		textCanvas.removeChild(textCanvas.getChildByName('curveText1') as Canvas);
	}
	var txtContainer1:Canvas = new Canvas();
	txtContainer1.x = 0;
	txtContainer1.y = 0;
	txtContainer1.name = 'curveText1';
	txtContainer1.width = textCanvas.width;
	txtContainer1.height = textCanvas.height;
	txtContainer1.setStyle('verticalCenter',0);
	txtContainer1.setStyle('horizontalCenter',0);
	for (var char1:uint=0;char1<arg.length;char1++)
	{
		var tempText1:Label = new Label();
		/*tempText1.setStyle('fontSize','20');
		tempText1.setStyle('fontFamily','Arial');
		tempText1.setStyle('textAlign','center');
		tempText1.setStyle('color','#FFFFFF');*/
		//tempText1.setStyle('fontSize','20');
		tempText1.setStyle('fontSize',fontsize[bottom_text_controls_tool.font_size.selectedIndex].data);
		tempText1.setStyle('fontFamily',fontData[bottom_text_controls_tool.text_font.selectedIndex].fontLabel);
		tempText1.setStyle('textAlign','center');
		tempText1.setStyle('color',fontColors[bottom_text_controls_tool.font_color.selectedIndex].colorCode.toString());
		
		tempText1.filters = bottom_label.filters;
		tempText1.x = radius1 * Math.cos(degrees2radians(char1*spacing1+angularOffset1)) + centerText1.x ;
		tempText1.y = - radius1 * Math.sin(degrees2radians(char1*spacing1+angularOffset1)) + centerText1.y ;
		var dx1:Number = centerText1.x-tempText1.x;
		var dy1:Number = centerText1.y-tempText1.y;
		var angle1:Number = Math.atan2(dy1, dx1);
		tempText1.rotation = radians2degrees(angle1) + temDegree1; //+90;
		tempText1.text = arg.charAt(char1);
		trace("x:"+tempText1.x+" y:"+tempText1.y+" width "+char1*spacing1+" char1 "+char1+" text "+tempText1.text);
		txtContainer1.addChild(tempText1);
	}
	textCanvas.addChild(txtContainer1);
}

private function degrees2radians(deg:Number):Number {
	return (2 * Math.PI * deg) / 360; 
}

private function radians2degrees(rad:Number):Number {            
	return rad * 180 / Math.PI; 
}

private function getOffsetValueTopText(offsetnum:Number):Number {				
	var dd:* = 270  - Math.round(offsetnum/2);
	return dd;
}
private function getOffsetValueBottomText(offsetnum:Number):Number {				
	var dd:* =  270  - Math.round(offsetnum/2);
	return dd;
}

public function setbackImage(arg:String):void{
	if(arg == "black"){
		blackBG.visible=true;
		blackBG.source=site_url+"flex/youDesign/assets/img/1_black.png";
		//blackBG.source=site_url+"img/black.png";
		defaultColor=0xffffff;
	}else if(arg == "silver"){
		silverBG.visible=true;
		silverBG.source=site_url+"img/silver.png";
		defaultColor=0x000000;
	}else{}
}

public function setTabNav(arg1:String,arg2:String,arg3:String,arg4:String):void{
	if(arg1 == "1"){
		topTextCanvas.enabled=true;
		top_label.visible=true;
	}
	if(arg2 == "1"){
		midTextCanvas.enabled=true;
		middle_label.visible=true;
	}
	if(arg3 == "1"){
		bottomTextCanvas.enabled=true;
		bottom_label.visible=true;
	}
	if(arg4 == "1"){
		imgTabCanvas.enabled=true;
	}
}

public function setCircleImage():void{
	if(isCircleImage == "Yes"){
		radioYes.selected = true;
	}
	if(isCircleImage == "No"){
		radioNo.selected = true;
	}
}

/***
 * Remote Service Listners
 * */
public function sayHelloListner(evt:ResultEvent):void{
	//Alert.show(evt.result.toString(),message_title);
}

public function faultListner(event:FaultEvent):void{
	Alert.show(event.fault.faultString,message_title);
}

public function getTemplateListner(evt:ResultEvent):void{
	if(evt.result){
		topText=evt.result.Template.top_text;
		midText=evt.result.Template.middle_text;
		botText=evt.result.Template.bottom_text;
		topTextA=evt.result.Template.top_text_arc;
		botTextA=evt.result.Template.bottom_text_arc;
		img=evt.result.Template.is_image;
		basePrice.text=evt.result.Template.base_price;
		this.setTabNav(topText,midText,botText,img);
	}
	//Alert.show(ObjectUtil.toString(evt.result),message_title);
}
public function getColorListner(evt:ResultEvent):void{
	if(evt.result){
		fontColors=evt.result;
		top_text_controls_tool.text_shadow_color.dataProvider=evt.result;
		top_text_controls_tool.text_outline_color.dataProvider=evt.result;
		top_text_controls_tool.font_color.dataProvider=evt.result;
		if(product_type == "black"){
			top_text_controls_tool.font_color.selectedIndex=1;
			top_text_controls_tool.text_outline_color.selectedIndex=1;
			top_text_controls_tool.text_shadow_color.selectedIndex=1;
		}else if(product_type == "silver"){
			top_text_controls_tool.font_color.selectedIndex=8;
			top_text_controls_tool.text_outline_color.selectedIndex=8;
			top_text_controls_tool.text_shadow_color.selectedIndex=8;
		}else{}
	}
}
public function getFontListner(evt:ResultEvent):void{
	if(evt.result){
		fontData=evt.result;
		for(var i:int;i<evt.result.length;i++){
			StyleManager.loadStyleDeclarations(site_url+"img/fonts/"+evt.result[i].file);
			//Font.registerFont(evt.result[i].fontLabel);
		}
		top_text_controls_tool.text_font.dataProvider=evt.result;
	}
}


public function getCatgoryLibraryListner(evt:ResultEvent):void{
	//Alert.show(ObjectUtil.toString(evt.result));
	libraryCategory.dataProvider=evt.result;
	libraryCategory.visible=true;
}
public function getCatgoryLibraryImageListner(e:ResultEvent):void{
	catImage.visible=true;
	catImage.dataProvider=e.result;
}
public function saveDesignImageListner(e:ResultEvent):void{
	//Alert.show(e.result.toString());
	if(e.result.toString() != ''){
		var url:String = site_url+"templates/tiresize";
		var request:URLRequest = new URLRequest(url);
		try {            
			navigateToURL(request,"_self");
		}
		catch (e:Error) {

		}	
	}
}
public function saveDesignListner(e:ResultEvent):void{
	//Alert.show(e.result.toString());
}

public function saveSessionListner(e:ResultEvent):void{
	//Alert.show(e.result.message);
}

private var openDesignArray:Array = new Array();
public function openDesignListner(e:ResultEvent):void{
	//Alert.show(ObjectUtil.toString(e.result[0].obj));
	if(e.result[0].obj != null){
		openDesignArray = e.result[0].obj as Array;
		var n:int = openDesignArray.length;
		for(var i:int=0; i<n; i++){
			if(openDesignArray[i].id == "top_text_controls_tool"){
				//set Text
				Application.application.top_label.text = openDesignArray[i].text;
				//set Color
				Application.application.top_label.setStyle("color",fontColors[openDesignArray[i].fontColor].colorCode.toString());
				//set font
				Application.application.top_label.setStyle("fontFamily",fontData[openDesignArray[i].fontName].fontLabel);
				//set fontsize
				Application.application.top_label.setStyle("fontSize",fontsize[openDesignArray[i].fontSize].data);
				//set textOutline & Shadow
				if(openDesignArray[i].textShadow == true && openDesignArray[i].textOutline == true)
					Application.application.top_label.filters=setShadowColor(fontColors[openDesignArray[i].textShadowColor].colorCode,'outline','shadow',fontColors[openDesignArray[i].textOutlineColor].colorCode);
				if(openDesignArray[i].textShadow == true && openDesignArray[i].textOutline == false)
					Application.application.top_label.filters=setShadowColor(fontColors[openDesignArray[i].textShadowColor].colorCode,'','shadow',fontColors[openDesignArray[i].textOutlineColor].colorCode);
				if(openDesignArray[i].textOutline == true && openDesignArray[i].textShadow== false)
					Application.application.top_label.filters=setShadowColor(fontColors[openDesignArray[i].textShadowColor].colorCode,'outline','',fontColors[openDesignArray[i].textOutlineColor].colorCode);
				
				if(top_text_controls_tool !=null)
					this.setOpenDesignText(openDesignArray[i]);
			}
			if(openDesignArray[i].id == "mid_text_controls_tool"){
				//set Text
				Application.application.middle_label.text = openDesignArray[i].text;
				//set Color
				Application.application.middle_label.setStyle("color",fontColors[openDesignArray[i].fontColor].colorCode.toString());
				//set font
				Application.application.middle_label.setStyle("fontFamily",fontData[openDesignArray[i].fontName].fontLabel);
				//set fontsize
				Application.application.middle_label.setStyle("fontSize",fontsize[openDesignArray[i].fontSize].data);
				//set textOutline & Shadow
				if(openDesignArray[i].textShadow == true && openDesignArray[i].textOutline == true)
					Application.application.middle_label.filters=setShadowColor(fontColors[openDesignArray[i].textShadowColor].colorCode,'outline','shadow',fontColors[openDesignArray[i].textOutlineColor].colorCode);
				if(openDesignArray[i].textShadow == true && openDesignArray[i].textOutline == false)
					Application.application.middle_label.filters=setShadowColor(fontColors[openDesignArray[i].textShadowColor].colorCode,'','shadow',fontColors[openDesignArray[i].textOutlineColor].colorCode);
				if(openDesignArray[i].textOutline == true && openDesignArray[i].textShadow== false)
					Application.application.middle_label.filters=setShadowColor(fontColors[openDesignArray[i].textShadowColor].colorCode,'outline','',fontColors[openDesignArray[i].textOutlineColor].colorCode);
				
				if(mid_text_controls_tool !=null)
					this.setOpenDesignText(openDesignArray[i]);
				retObjectMid=openDesignArray[i];
			}
			if(openDesignArray[i].id == "bottom_text_controls_tool"){
				// set text
				Application.application.bottom_label.text = openDesignArray[i].text;
				//set Color
				Application.application.bottom_label.setStyle("color",fontColors[openDesignArray[i].fontColor].colorCode.toString());
				//set font
				Application.application.bottom_label.setStyle("fontFamily",fontData[openDesignArray[i].fontName].fontLabel);
				//set fontsize
				Application.application.bottom_label.setStyle("fontSize",fontsize[openDesignArray[i].fontSize].data);
				//set textOutline & Shadow
				if(openDesignArray[i].textShadow == true && openDesignArray[i].textOutline == true)
					Application.application.bottom_label.filters=setShadowColor(fontColors[openDesignArray[i].textShadowColor].colorCode,'outline','shadow',fontColors[openDesignArray[i].textOutlineColor].colorCode);
				if(openDesignArray[i].textShadow == true && openDesignArray[i].textOutline == false)
					Application.application.bottom_label.filters=setShadowColor(fontColors[openDesignArray[i].textShadowColor].colorCode,'','shadow',fontColors[openDesignArray[i].textOutlineColor].colorCode);
				if(openDesignArray[i].textOutline == true && openDesignArray[i].textShadow== false)
					Application.application.bottom_label.filters=setShadowColor(fontColors[openDesignArray[i].textShadowColor].colorCode,'outline','',fontColors[openDesignArray[i].textOutlineColor].colorCode);
				
				if(bottom_text_controls_tool !=null)
					this.setOpenDesignText(openDesignArray[i]);
				retObjectBot=openDesignArray[i];
			}
			if(openDesignArray[i].id == "mid_image" || openDesignArray[i].id == "draw_mid_image"){
				this.setOpenDesignImage(openDesignArray[i]);
			}
		}
	}else{
		Alert.show('Record not found',message_title);
	}
}

public function setOpenDesignText(obj:*):void{
	//Alert.show(ObjectUtil.toString(fontsize[obj.fontSize]));
	
	if(obj.id == "top_text_controls_tool"){
		top_text_controls_tool.top_text.text = obj.text;
		top_text_controls_tool.text_font.selectedIndex = obj.fontName;
		top_text_controls_tool.font_color.selectedIndex = obj.fontColor;
		top_text_controls_tool.font_size.selectedIndex = obj.fontSize;
		top_text_controls_tool.textShadowYes.selected = obj.textShadow;
		top_text_controls_tool.text_shadow_color.selectedIndex = obj.textShadowColor;
		top_text_controls_tool.text_outline_yes.selected = obj.textOutline;
		top_text_controls_tool.text_outline_color.selectedIndex = obj.textOutlineColor;
	}
	if(obj.id == "mid_text_controls_tool"){
		mid_text_controls_tool.top_text.text = obj.text;
		mid_text_controls_tool.text_font.selectedIndex = obj.fontName;
		mid_text_controls_tool.font_color.selectedIndex = obj.fontColor;
		mid_text_controls_tool.font_size.selectedIndex = obj.fontSize;
		mid_text_controls_tool.textShadowYes.selected = obj.textShadow;
		mid_text_controls_tool.text_shadow_color.selectedIndex = obj.textShadowColor;
		mid_text_controls_tool.text_outline_yes.selected = obj.textOutline;
		mid_text_controls_tool.text_outline_color.selectedIndex = obj.textOutlineColor;
	}
	if(obj.id == "bottom_text_controls_tool"){
		bottom_text_controls_tool.top_text.text = obj.text;
		bottom_text_controls_tool.text_font.selectedIndex = obj.fontName;
		bottom_text_controls_tool.font_color.selectedIndex = obj.fontColor;
		bottom_text_controls_tool.font_size.selectedIndex = obj.fontSize;
		bottom_text_controls_tool.textShadowYes.selected = obj.textShadow;
		bottom_text_controls_tool.text_shadow_color.selectedIndex = obj.textShadowColor;
		bottom_text_controls_tool.text_outline_yes.selected = obj.textOutline;
		bottom_text_controls_tool.text_outline_color.selectedIndex = obj.textOutlineColor;
	}
}

public function setOpenDesignImage(obj:*):void{
	if(obj.id == "draw_mid_image" ){
		drawImgCanvas.width = obj.width;
		drawImgCanvas.height= obj.height;
		imagePath = obj.imagePath;
		imgCanvas.visible = false; 
		drawImgCanvas.visible = true;
		draw_mid_image.source=obj.imagePath;
		this.setImageMaskWidth(obj.width);
		isCircleImage = 'Yes';
		//obj.cropArray = draw_mid_image.source;
	}
	if(obj.id == "mid_image" ){
		imgCanvas.width = obj.width ;
		imgCanvas.height = obj.height;
		imagePath = obj.imagePath;
		imgCanvas.visible = true; 
		drawImgCanvas.visible = false;
		mid_image.source=obj.imagePath;
		isCircleImage = 'No';
	}
	
	/*if(libraryCategory.selectedItem.id != null){
		obj.imgCat =String(libraryCategory.selectedItem.id);
		obj.imgId = String(catImage.selectedItem.imgId);
		obj.imagelib = true;
	}*/
	
	special.text =obj.special;
	basePrice.text = obj.basePrice;
	totalColor.text = obj.colors;
	colorPrice.text = obj.colorCost;
	//totalCost.text = String(totalCost);
}

public function testData(arg1:String):void{
	top_text_controls_tool.top_text.text=arg1;
	//Alert.show(arg1);
}

public function componentFontChange(evt:ListEvent):void{
	//Alert.show(evt.currentTarget.selectedItem);
}

public function getlibImage(arg:String):void{
	//mid_image.source=arg;
	//draw_mid_image.source=arg;
	imagePath=arg;
	checkLibImage = "Yes";
	if(radioCrop.selectedValue.toString()=="Yes"){
		draw_mid_image.source=imagePath;
		imgCanvas.visible = false; 
		drawImgCanvas.visible = true;
		//draw_mid_image.visible=true;
	}else if(radioCrop.selectedValue.toString()=="No"){
		mid_image.source=imagePath;
		drawImgCanvas.visible = false;
		imgCanvas.visible = true; 
		//mid_image.visible=true;
	}
	//Alert.show(arg,message_title);
}
private var refAddFiles:FileReference;
private var arr:Array=new Array();
public function imageBrowse():void{
	var imageTypes:FileFilter = new FileFilter("Images (*.jpg, *.jpeg, *.gif, *.png)", "*.jpg; *.jpeg; *.gif; *.png");
	var allTypes:Array = new Array(imageTypes);
	refAddFiles = new FileReference();
	refAddFiles.addEventListener(Event.SELECT, onSelectFile);
	refAddFiles.browse(allTypes);
}
private var UploadId:int = 300;
public function onSelectFile(event:Event):void{
	event.target.removeEventListener(event.type,onSelectFile);
	UploadId = UploadId+1;
	var sendVars:URLVariables = new URLVariables();
	sendVars.imgname = UploadId;
	//sendVars.dirname = sessionId;
	var request:URLRequest = new URLRequest();
	request.url = site_url+"filesave.php?imgname="+UploadId;
	request.data = sendVars;
	request.method = URLRequestMethod.POST;
	refAddFiles.addEventListener(Event.COMPLETE, onUploadComplete);
	refAddFiles.upload(request, "file", false);
}

private function onUploadComplete(e:Event):void {
	e.target.removeEventListener(e.type,onUploadComplete);
	var img:String = site_url+"temp_data/"+UploadId+e.target.type.toString();
	
	arr.push({image:img});
	uploadImageList.dataProvider=arr;
	//userUploadedImage.push({img:img});
	//userUploadImages.dataProvider = userUploadedImage;
}

private function backNav():void{
	var url:String = site_url+"templates/select";
	/*if(nav =='udesign'){
		url = "http://udesignedit.com/templates/select";
	}*/
	//Alert.show(url);
	var request:URLRequest = new URLRequest(url);
	try {            
		navigateToURL(request,"_self");
	}
	catch (e:Error) {
		// handle error here
	}
}

private function printCanvas(arg1:Canvas):void{
	myObj.saveDesignImage(this.takeSnap(arg1));
	myObj.saveSession(this.saveDesignArrayCollection());
}

private function takeSnap(arg1:Canvas):ByteArray{
	var bitmapdata:BitmapData = new BitmapData(arg1.width,arg1.height);
	bitmapdata.draw(arg1);
	var posPoint:Point = new Point(0,0);
	var bitM:BitmapData = new BitmapData(arg1.width+5,arg1.height+5,true,0xFFFFFFFF);
	bitM.copyPixels(bitmapdata, new Rectangle(designPreview.x-5, designPreview.y-2, arg1.width+5, arg1.height+5),posPoint);
	
	//var bitmap:Bitmap = new Bitmap(bitM,"auto",true);
	var png:PNGEncoder = new PNGEncoder();
	var byteArray:ByteArray = png.encode(bitM);
	byteArray.compress();
	return byteArray;
}

private function changeImageSize(arg:Number):void{
	//Alert.show(evt.currentTarget);
	
	if(radioCrop.selectedValue.toString()=="Yes"){
		imgCanvas.visible = false; 
		drawImgCanvas.visible = true;
		imgCanvas.width=arg;
		imgCanvas.height=arg;
		drawImgCanvas.width = arg;
		drawImgCanvas.height = arg;
		setImageMaskWidth(arg);
	}else if(radioCrop.selectedValue.toString()=="No"){
		drawImgCanvas.visible = false;
		imgCanvas.visible = true; 
		drawImgCanvas.width = arg;
		drawImgCanvas.height = arg;
		imgCanvas.width=arg;
		imgCanvas.height=arg;
	}
}

public function uploadImage(arg:String):void{
	imagePath=arg;
	if(radioCrop.selectedValue.toString()=="Yes"){
		draw_mid_image.source = imagePath;
		imgCanvas.visible = false; 
		drawImgCanvas.visible = true;
		draw_mid_image.visible=true;
	}else if(radioCrop.selectedValue.toString()=="No"){
		mid_image.source=imagePath;
		drawImgCanvas.visible = false;
		imgCanvas.visible = true; 
		mid_image.visible=true;
	}
	//Alert.show(arg);
}

public function saveDesign(arg:String):void{
	var validate:ValidationResultEvent=mailValidator.validate();
	
	if (validate.type == ValidationResultEvent.VALID){
		myObj.saveDesign(email.text,this.saveDesignArrayCollection());
	}
}

public function saveDesignArrayCollection():ArrayCollection{
	var customizeArray:ArrayCollection = new ArrayCollection();
	//Alert.show(" imgTabCanvas "+editImageCanvas+" midTextCanvas "+mid_text_controls_tool+" bottomTextCanvas "+bottom_text_controls_tool);
	if(topText=="1" && top_text_controls_tool != null){
		customizeArray.addItem(this.setDesignObject(top_text_controls_tool));
	}
	if(midText=="1" && mid_text_controls_tool !=null){
		customizeArray.addItem(this.setDesignObject(mid_text_controls_tool));
	}
	if(botText=="1" && bottom_text_controls_tool!=null){
		customizeArray.addItem(this.setDesignObject(bottom_text_controls_tool));
	}
	
	customizeArray.addItem(this.setDesignImageObject());
	
	
	return customizeArray;
}

public function setDesignObject(control:*):Object{
	var obj:ControlObject=new ControlObject();
	//var obj1:Canvas=control as controlCanvas;
	//Alert.show(ObjectUtil.toString(top_label.filters));
		obj.id=control.id;
		obj.text=control.top_text.text;
		obj.fontName=control.text_font.selectedIndex;
		obj.fontColor=control.font_color.selectedIndex;
		obj.fontSize=control.font_size.selectedIndex;
		//obj.arc=control.
	    obj.textShadow=control.textShadowYes.selected;
		obj.textShadowColor=control.text_shadow_color.selectedIndex;
		obj.textOutline=control.text_outline_yes.selected;
		obj.textOutlineColor=control.text_outline_color.selectedIndex;
		
	return obj;
}

public function setDesignImageObject():Object{
	var obj:ImageObject=new ImageObject();
	if(img == '1' && editImageCanvas!=null){
		if(radioCrop.selectedValue.toString() == "Yes"){
			obj.id = draw_mid_image.id;
			obj.name = draw_mid_image.name;
			
			obj.x = drawImgCanvas.x;
			obj.y = drawImgCanvas.y;
			obj.width = drawImgCanvas.width;
			obj.height= drawImgCanvas.height;
			obj.imagePath = imagePath;
			//obj.cropArray = draw_mid_image.source;
		}
		if(radioCrop.selectedValue.toString() == "No"){
			obj.id = mid_image.id;
			obj.name = mid_image.name;
			
			obj.x = imgCanvas.x;
			obj.y = imgCanvas.y;
			obj.width = imgCanvas.width;
			obj.height= imgCanvas.height;
			obj.imagePath = imagePath;
		}
		
		if(checkLibImage == "Yes"){
			obj.imgCat =String(libraryCategory.selectedItem.id);
			obj.imgId = String(catImage.selectedItem.imgId);
			obj.imagelib = true;
		}
	}
	if(imgChoice){
		obj.imgType = imgChoice.selectedItem.imgValue;
	}
	obj.special = special.text;
	obj.basePrice = basePrice.text;
	obj.colors = totalColor.text;
	obj.colorCost = colorPrice.text;
	obj.totalCost = Number(basePrice.text) + Number(colorPrice.text);
	return obj;
}

public function getDesignObject():ArrayCollection{
	var myDesign:ArrayCollection=new ArrayCollection();
	
	return myDesign;
}

public function retrieveDesign(arg:String):void{
	var validate:ValidationResultEvent=mailValidator.validate();
	if (validate.type == ValidationResultEvent.VALID){
		// working for save design
		myObj.openDesign(email.text);
	}
}

public function cropImageSelect():void{
	//Alert.show(radioCrop.selectedValue);
	if(radioCrop.selectedValue.toString() == "Yes"){
		if(imagePath){
			this.cropImage();
		}
	}else if(radioCrop.selectedValue.toString() == "No"){
		/*if(drawImgCanvas.getChildByName('maskArea') as UIComponent){
			drawImgCanvas.removeChild(drawImgCanvas.getChildByName('maskArea') as UIComponent);
		}*/
		
		mid_image.source = imagePath;
		drawImgCanvas.visible = false;
		imgCanvas.visible = true;
	}
}
private var mask1:Sprite = new Sprite();
public function setImageMaskWidth(arg:Number):void{
	drawImgCanvas.width = arg;
	drawImgCanvas.height= arg;
	mask1 = imgMask(arg/2);
	draw_mid_image.mask = mask1;
}

private function imgMask(r:Number):Sprite{
	if(drawImgCanvas.getChildByName('maskArea') as UIComponent){
		drawImgCanvas.removeChild(drawImgCanvas.getChildByName('maskArea') as UIComponent);
	}
	var ui:UIComponent = new UIComponent();
	ui.name = 'maskArea';
	var rect:Sprite = new Sprite();
	rect.graphics.clear();
	rect.graphics.beginFill(0x000000);
	rect.graphics.drawCircle(drawImgCanvas.width/2,drawImgCanvas.height/2,r);
	rect.graphics.endFill();
	ui.addChild(rect);
	drawImgCanvas.addChild(ui);
	
	return rect;
}
public var cimgbytearray:ByteArray = new ByteArray();
private function cropImage():void{
	var _cropImage:CropImage= new CropImage();
	_cropImage.image_path = imagePath;
	_cropImage.site_url = '';
	_cropImage.sessionId = '';
	_cropImage.random_no = 123;
	_cropImage.uploadId = 222;
	PopUpManager.addPopUp(_cropImage,this,true);
	PopUpManager.centerPopUp(_cropImage);
	
	_cropImage['saveImage'].addEventListener(MouseEvent.CLICK, function(e:MouseEvent):void{
		addCropedImage(e,_cropImage);
		e.target.removeEventListener(e.type,arguments.callee);
	});
}

private function addCropedImage(e:MouseEvent,cropImg:CropImage):void{
	cimgbytearray = cropImg.croptearray;
	draw_mid_image.source = cimgbytearray;
	imgCanvas.visible = false;
	drawImgCanvas.visible = true;
	this.setImageMaskWidth(imgStepper.value);
} 