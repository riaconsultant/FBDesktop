package com.adobesamples.controls
{
	import flash.display.DisplayObject;
	
	public class DesignItemFactory
	{
		/////////////////////////////////////////////////////
		// 	IMPORTS
			
		import com.adobesamples.controls.DesignItem;
		
		/////////////////////////////////////////////////////
		// 	PUBLIC METHODS
		
		/**
		* This creates and returns the DesignItem which matches the parameters you pass in.
		*
		* @param i_item_name The string reference to the DesignItem.
		* @param i_include_back A boolean indicating whether or not to add the back of the shirt
		* to the DesignItem.
		*/
			
		static public function getItem(i_item_name:String,i_include_back:Boolean=false):DesignItem{
			
			var newDesignItem:DesignItem = new DesignItem();
			DesignItemFactory.addItems(i_item_name,i_include_back,newDesignItem);
			return newDesignItem;
		}
		
		/////////////////////////////////////////////////////
		// 	PRIVATE METHODS
		
		/**
		* This adds the appropriate UIMovieClip from the ShirtConfigurator.swc based apon the i_item_name.
		*
		* @param i_item_name The string reference to the DesignItem.
		* @param i_include_back A boolean indicating whether or not to add the back of the shirt
		* to the DesignItem.
		* @param i_design_item The designItem which gets children added to it.
		*/
		
		static private function addItems(i_item_name:String,i_include_back:Boolean,i_design_item:DesignItem):void{
			
			if(i_item_name == "Shirt1Front"){
				var newDisplayObject:Shirt1Front = new Shirt1Front();
				i_design_item.addNewItem(newDisplayObject);
				if(i_include_back == true){
					var newDisplayObjectBack1:Shirt1Back = new Shirt1Back();
					i_design_item.addNewItem(newDisplayObjectBack1);
				}
			}else if(i_item_name == "Shirt2Front"){
				var newDisplayObject1:Shirt2Front = new Shirt2Front();
				i_design_item.addNewItem(newDisplayObject1);
				if(i_include_back == true){
					var newDisplayObjectBack2:Shirt2Back = new Shirt2Back();
					i_design_item.addNewItem(newDisplayObjectBack2);
				}
			}else if(i_item_name == "Shirt3Front"){
				var newDisplayObject2:Shirt3Front = new Shirt3Front();
				i_design_item.addNewItem(newDisplayObject2);
				if(i_include_back == true){
					var newDisplayObjectBack3:Shirt3Back = new Shirt3Back();
					i_design_item.addNewItem(newDisplayObjectBack3);
				}
			}else if(i_item_name == "Shirt4Front"){
				var newDisplayObject3:Shirt4Front = new Shirt4Front();
				i_design_item.addNewItem(newDisplayObject3);
				if(i_include_back == true){
					var newDisplayObjectBack4:Shirt4Back = new Shirt4Back();
					i_design_item.addNewItem(newDisplayObjectBack4);
				}
			}else if(i_item_name == "Shirt5Front"){
				var newDisplayObject4:Shirt5Front = new Shirt5Front();
				i_design_item.addNewItem(newDisplayObject4);
				if(i_include_back == true){
					var newDisplayObjectBack5:Shirt5Back = new Shirt5Back();
					i_design_item.addNewItem(newDisplayObjectBack5);
				}
			}
			
		}
		
		
	}
}