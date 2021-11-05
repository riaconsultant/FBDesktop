package com.zavoo.svg.nodes
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import mx.utils.Base64Decoder;
	import flash.utils.ByteArray;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.net.URLLoader;
	import flash.geom.Matrix;
	import flash.display.Sprite;
	
	import mx.utils.Base64Encoder;
	
	public class SVGImageNode extends SVGNode
	{		
		private var bitmap:Bitmap;	
                   
		public function SVGImageNode(xml:XML):void {
			super(xml);
		}	
				
		public override function draw():void {
			var decoder:Base64Decoder = new Base64Decoder();
			var byteArray:ByteArray;
			
			var base64String:String = this._xml.@xlink::href;
		
			if (base64String.match(/^data:[a-z\/]*;base64,/)) {
				base64String = base64String.replace(/^data:[a-z\/]*;base64,/, '');
				
				decoder.decode( base64String );
				byteArray = decoder.flush();
				
				loadBytes(byteArray);
					
			}
		}
				
		private function loadBytes(byteArray:ByteArray):void {
			
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener( Event.COMPLETE, onBytesLoaded );			
			loader.loadBytes( byteArray );				
		}

		private function onBytesLoaded( event:Event ) :void
		{
			var content:DisplayObject = LoaderInfo( event.target ).content;
			var bitmapData:BitmapData = new BitmapData( content.width, content.height, true, 0x00000000 );
			bitmapData.draw( content );
			
			bitmap = new Bitmap( bitmapData );
			bitmap.opaqueBackground = null;
			this.addChild(bitmap);
			
			//this.addImageMask();	
			this.transformImage();
			
		}
		
		/* private function addImageMask():void {
			spriteMask = new Shape();
			spriteMask.graphics.beginFill(0x000000,1);
			spriteMask.graphics.drawRect(0,0,bitmap.width,bitmap.height);
			spriteMask.graphics.endFill();
			this.mask = spriteMask;
			this.addChild(spriteMask);
		} */
		
		private function transformImage():void {
			var trans:String = String(this.getAttribute('transform', ''));
			this.transform.matrix = this.getTransformMatrix(trans);
			//spriteMask.transform.matrix = bitmap.transform.matrix.clone();			
		}	
				
		override protected function transformNode():void {
			
		}		
		
		private function getTransformMatrix(transform:String):Matrix {
			var newMatrix:Matrix = new Matrix();
			var trans:String = String(this.getAttribute('transform', ''));
			
			if (trans != '') {
				var transArray:Array = trans.match(/\S+\(.*?\)/sg);
				for each(var tran:String in transArray) {
					var tranArray:Array = tran.split('(',2);
					if (tranArray.length == 2)
					{						
						var command:String = String(tranArray[0]);
						var args:String = String(tranArray[1]);
						args = args.replace(')','');
						var argsArray:Array = args.split(/[, ]/);
						//trace('Transform: ' + tran);
						switch (command) {
							case "matrix":
								if (argsArray.length == 6) {									
									newMatrix.a = argsArray[0];
									newMatrix.b = argsArray[1];
									newMatrix.c = argsArray[2];
									newMatrix.d = argsArray[3];
									newMatrix.tx = argsArray[4];
									newMatrix.ty = argsArray[5];
									return newMatrix;									
								}
								break;
								
							default:
								//trace('Unknown Transformation: ' + command);
						}
					}
				}			
			}			
			return null;
		}
		
	}
}