
/**
 * all imports
 * */
		import com.roguedevelopment.objecthandles.ObjectHandleEvent;
		import com.roguedevelopment.objecthandles.ObjectHandles;
		import com.roguedevelopment.objecthandles.SelectionManager;
		import com.usercontrols.CustomObj;
		
		import fabulousFlex.PreloadingImage;
		import fabulousFlex.ProgressPreloadingWindow;
		import fabulousFlex.SquaresPreloadingWindow;
		import fabulousFlex.SquaresSpinnerPreloadingWindow;
		import fabulousFlex.WheelPreloadingWindow;
		
		import flash.net.FileFilter;
		
		import mx.collections.ArrayCollection;
		import mx.collections.XMLListCollection;
		import mx.controls.Alert;
		import mx.controls.Text;
		import mx.core.UIComponent;
		import mx.events.ChildExistenceChangedEvent;
		import mx.events.CloseEvent;
		import mx.events.FlexEvent;
		import mx.events.IndexChangedEvent;
		import mx.events.ListEvent;
		import mx.events.SliderEvent;
		import mx.graphics.codec.PNGEncoder;
		import mx.managers.PopUpManager;
		import mx.rpc.Fault;
		import mx.rpc.events.FaultEvent;
		import mx.rpc.events.ResultEvent;
		import mx.utils.ObjectUtil;
		
		import popups.ImageCrop;
		import popups.LargeView;
		import popups.Loading;
		import popups.Login;
		import popups.SendMail;
		
/***
 * 
 * Bindable variables
 * */
		[Bindable]private var centerImage:String = "";
		[Bindable]private var leftImage:String = "";
		[Bindable]private var rightImage:String = "";
		[Bindable]private var _x:int =0;
		[Bindable]private var _y:int =0;
		[Bindable]private var _w:int =0;
		[Bindable]private var _h:int =0;
		[Bindable]private var userUploadedImage:Array = new Array();
		[Bindable]private var selectedObject:ObjectHandles = null;
		[Bindable]private var xmlListColls:XMLListCollection = new XMLListCollection();
		[Bindable]private var randomNum:Number = new Number (Math.floor(Math.random()* (100000 - 1 + 1)) + 1);
		
		[Bindable] private var cards:Array = [
			{label:"Arial", data:"Arial"},
			{label:"ALGER", data:"ALGER"},
			{label:"BAUHS93", data:"BAUHS93"},
			{label:"BKANT", data:"BKANT"},
			{label:"BOD_PSTC", data:"BOD_PSTC"},
			{label:"CONSTAN", data:"CONSTAN"},
			{label:"COOPBL", data:"COOPBL"},
			{label:"HARNGTON", data:"HARNGTON"},
			{label:"MATURASC", data:"MATURASC"},
			{label:"PLAYBILL", data:"PLAYBILL"},
			{label:"POORICH", data:"POORICH"},
			{label:"WTF", data:"WTF"},
		];

/**
 * return functions
 * */
		private function setShadow(color:Number):Array{
			var txtFilters:Array = new Array();
			var f:DropShadowFilter = new DropShadowFilter(5,30,color,.8);
			txtFilters.push(f);
			return txtFilters;
		}

		private function getColorData(num:Number):String{
			var color:String;
			var prefix_label:String = "000000";
			var str_lable:String = String(prefix_label + num.toString(16));
			color = str_lable.substr(-6).toUpperCase();
			return 	color;
		}
		/* create category Array*/
		public function getCatergoryArr(obj:Object):Array{
			var rsArray:Object = obj;
			var rsLength:int = obj.length;
			var categoryArr:Array = new Array();
			var cat:Object=new Object();
			cat['id']="";
			cat['name']="Please select";
			categoryArr[0]=cat;
			var k:int=0;
			for(var i:int=1;i<= rsLength;i++){
				cat=rsArray[k];
				categoryArr[i] =  cat;
				k++;
			}
			return categoryArr;
		}
		/* create Library Image Array*/
		public function getLibraryImgArr(obj:Object):Array{
			var libraryArr:Array=new Array();
			for(var i:int=0;i < obj.length;i++){
				var libImage:Object=new Object();
				libImage=obj[i];
				libImage['image']=site_url+"img/design_images/"+libImage['image'];
				libraryArr[i] =  libImage;
			}
			return libraryArr;
		}
		
		
		
/***
 * @2010
 * configuration setting
 * */

		/*[Bindable]
		public var gateway_url:String = "http://localhost/projects/amf/gateway.php";
		public var site_url:String = "http://localhost/projects/flex/";
		public var font_url:String="assets/css/fonts.swf";
		public var style_url:String=site_url+"assets/css/comman.swf";*/

		[Bindable]
		public var gateway_url:String = "http://amf.brandanalytic.in/gateway.php";
		public var site_url:String = "http://www.designme.in/";
		public var font_url:String=site_url+"flex/assets/css/fonts.swf";
		public var style_url:String=site_url+"flex/assets/css/comman.swf";


		public var message_title:String = "Flex Editor 1.0";
		public var site_title:String = "Flex Editor 1.0";

