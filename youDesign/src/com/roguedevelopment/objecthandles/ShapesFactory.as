// ActionScript file
package com.roguedevelopment.objecthandles {
   
import flash.display.*;
import flash.geom.Matrix;

import mx.controls.Image;
import mx.core.UIComponent;
public class ShapesFactory extends Sprite
{
    //some initial values

  	public var _topleftx:int=100;
    public var _toplefty:int=100;
    public var _downrightx:int=100;
    public var _downrighty:int=100;
    public var radius:int=50;
    public var color:String="0x0000FF";
  
  	//public function set TopLeftY(value:Number):void
  	//{
  		//_toplefty1 = value;
  	//}
  	 public function ShapesFact(topleftx:Number, toplefty:Number, downrightx:Number, downrighty:Number):void
     {
        
    	_topleftx = topleftx;
    	_toplefty = toplefty;
    	_downrighty = downrighty;
    	_downrightx = downrightx;
    	
     }
  	
    public function Rectangle():UIComponent
    {	
	    var rect:UIComponent=new UIComponent();
	    rect.graphics.lineStyle(1);
	    rect.graphics.beginFill(0x0000FF,1);
	    rect.graphics.drawRect(_topleftx,_toplefty,_downrightx,_downrighty);
	    rect.graphics.endFill();
	    return rect; 
    }
    
    private function getBitmapData( target : UIComponent ) : BitmapData
	{
		var bd : BitmapData = new BitmapData( 200, 200,true);
		var m : Matrix = new Matrix();
		bd.draw( target,null);
		return bd;
	}
    
    public function Circle(t:Number,l:Number,r:Number):Image
    {
	    var circle:UIComponent=new UIComponent();
	    circle.graphics.lineStyle(1);
	    circle.graphics.beginFill(0x00FF00,1);
	    circle.graphics.drawCircle(t,l,r);
	    circle.graphics.endFill();
	    //return circle;
	    var bd : BitmapData = getBitmapData( circle );
	    var img:Image = new Image();
	    img.alpha =0.2;
		img.load(new Bitmap( bd ));
		return img;
    }
    
     
}//class
}//package