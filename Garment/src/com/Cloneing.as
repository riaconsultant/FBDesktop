package com
{
	import flash.utils.ByteArray;
  	import flash.display.Sprite;
	public class Cloneing
	{
		private var cloneArray:ByteArray;
		public function Cloneing()
		{
		}
		
		public function doClone(source:Object):*
	   {
	    cloneArray=new ByteArray();
	    cloneArray.writeObject(source);
	    cloneArray.position = 0;
	    var result:Object = cloneArray.readObject();  
		return result;  
	    
	    
	   // return (cloneArray.readObject());
	   }

	}
}