// ActionScript file
package canvasPaint
{
	import flash.display.Sprite;
	
	/**
	 * CursorManager accepts classes only. This is a Sprite subclass 
	 * that paints a simple crosshair.
	 */
	public class CrossHair extends Sprite {
		
		public function CrossHair() {
			super();
			with (graphics) {
				lineStyle(1, 0);
				moveTo(-10, 0);
				lineTo(10, 0);
				moveTo(0, -10);
				lineTo(0, 10);
			}
		}
		
	}
}
