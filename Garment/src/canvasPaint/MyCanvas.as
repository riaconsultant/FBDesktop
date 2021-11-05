// ActionScript file
package canvasPaint
{
	import mx.core.UIComponent;
	import flash.display.Shape;
 
	/**
	 * An empty UIComponent would suffice, but empty UIComponents are unable to receive MouseEvents.
	 * Hence this simple subclass with the white background.
	 */
	public class MyCanvas extends UIComponent
	{
		
		private var bgShape:Shape;
		
		public function MyCanvas(){
			super();
		}
		
		override protected function createChildren():void {
			bgShape = new Shape();
			addChildAt(bgShape, 0);
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void {
			with (bgShape.graphics) {
				clear();
				beginFill(0xFFFFFF, 0);
				drawRect(0, 0, unscaledWidth, unscaledHeight);
				endFill();
			}
		}
		
	}
}
