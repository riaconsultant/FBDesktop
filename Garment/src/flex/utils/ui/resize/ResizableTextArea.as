package flex.utils.ui.resize
{
	import mx.controls.TextArea;
	import mx.styles.CSSStyleDeclaration;
	import mx.styles.StyleManager;
	
	
	/**
	 *  The alpha value for the resize handle.
	 *  @default 0x666666
	 */
	[Style(name="resizeHandleColor", type="Color", inherit="no")]

	/**
	 *  The alpha value for the resize handle.
	 *  @default 1
	 */
	[Style(name="resizeHandleAlpha", type="Number", inherit="no")]

	/**
	 * Extends the TextArea class to let the user resize the textarea by dragging on a small
	 * 16x16 resize handle in the bottom right corner of the textarea.
	 * 
	 * See the ResizeManager class for more details.
	 * 
	 * You can also specify the minWidth, minHeight, maxWidth, and maxHeight properties
	 * to restrict the size of the textarea.
	 * 
	 *  <pre>
 	 *  &lt;ResizableTextArea
	 *   <strong>Styles</strong>
	 *   resizeHandleColor="0x666666"
	 *   resizeHandleAlpha="1"
	 * &gt;
 	 *      ...
 	 *      <i>child tags</i>
 	 *      ...
 	 *  &lt;/ui:ResizableTextArea&gt;
 	 *  </pre>
 	 * 
	 * @author Chris Callendar
	 * @date March 17th, 2009
	 */
	public class ResizableTextArea extends TextArea
	{
		// setup the default styles
		private static var classConstructed:Boolean = classConstruct(); 
		private static function classConstruct():Boolean {
			var style:CSSStyleDeclaration = StyleManager.getStyleDeclaration("ResizableTextArea");
            if (!style) {
                style = new CSSStyleDeclaration();
            }
            style.defaultFactory = function():void {
                this.resizeHandleColor = 0x666666;
                this.resizeHandleAlpha = 1;
            };
			StyleManager.setStyleDeclaration("ResizableTextArea", style, true);
            return true;
        };
        		
		private var resizeManager:ResizeManager;
		
		public function ResizableTextArea() {
			super();
			this.resizeManager = new ResizeManager(this);
			
			// set a minimum size for this textarea
			minWidth = 24;
			minHeight = 24;
		}
		
		[Inspectable(category="Common")]
		public function get resizable():Boolean {
			return resizeManager.enabled;
		}
		
		public function set resizable(resize:Boolean):void {
			resizeManager.enabled = resize;
		}
		
		override public function styleChanged(styleProp:String):void {
			super.styleChanged(styleProp);

			if ((styleProp == "resizeHandleColor") || (styleProp == "resizeHandleAlpha")) {
				invalidateDisplayList();
			}
		}
			
		override protected function updateDisplayList(w:Number, h:Number):void {
			super.updateDisplayList(w, h);

			// make the scrollbars not overlap our resize handle
			resizeManager.adjustScrollBars(horizontalScrollBar, verticalScrollBar);
			
			// Draw resize handle
			var color:uint = uint(getStyle("resizeHandleColor"));
			var alpha:Number = Number(getStyle("resizeHandleAlpha"));
			resizeManager.drawResizeHandle(w, h, color, alpha);
		}
		
		
	}
}