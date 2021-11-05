package com.services
{
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;

	public class ProductController
	{
		public function ProductController()
		{
		}
		
		public function productCategory(obj:Object):void{
			if(obj){
				var arrCol:ArrayCollection=new ArrayCollection();
				for each(var tempObj:Object in obj){
					
				}
				//catAccord.data=arrCol;
				
			}else{
				Alert.show("Invalid Product Category..",Config.APP_NAME);
			}
		}
		
		public function imgPath():String{
			var str:String;
			
			return str;
		}
	}
}