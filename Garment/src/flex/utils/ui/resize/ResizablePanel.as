package flex.utils.ui.resize
{
	import mx.containers.Panel;
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
	 * Extends the Panel class to let the user resize the panel by dragging on a small
	 * 16x16 resize handle in the bottom right corner of the panel. 
	 * 
	 * See the ResizeManager class for more details.
	 * 
	 * You can also specify the minWidth, minHeight, maxWidth, and maxHeight properties
	 * to restrict the size of the panel.
	 * 
	 *  <pre>
 	 *  &lt;ResizablePanel
	 *   <strong>Styles</strong>
	 *   resizeHandleColor="0x666666"
	 *   resizeHandleAlpha="1"
	 * &gt;
 	 *      ...
 	 *      <i>child tags</i>
 	 *      ...
 	 *  &lt;/ui:ResizablePanel&gt;
 	 *  </pre>
 	 * 
	 * @author Chris Callendar
	 * @date March 17th, 2009
	 */
	public class ResizablePanel extends Panel
	{
		// setup the default styles
		private static var classConstructed:Boolean = classConstruct(); 
		private static function classConstruct():Boolean {
			var style:CSSStyleDeclaration = StyleManager.getStyleDeclaration("ResizablePanel");
            if (!style) {
                style = new CSSStyleDeclaration();
            }
            if (style.getStyle("roundedBottomCorners") == undefined) {
            	style.setStyle("roundedBottomCorners", false);	// looks better with resize handle
            }
            style.defaultFactory = function():void {
                this.resizeHandleColor = 0x666666;
                this.resizeHandleAlpha = 1;
            };
			StyleManager.setStyleDeclaration("ResizablePanel", style, true);
            return true;
        };
        		
		private var resizeManager:ResizeManager;
		
		public function ResizablePanel() {
			super();
			this.resizeManager = new ResizeManager(this);
			
			// set a minimum size for this panel
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
			
			// Draw resize handle
			var color:uint = uint(getStyle("resizeHandleColor"));
			var alpha:Number = Number(getStyle("resizeHandleAlpha"));
			resizeManager.drawResizeHandle(w, h, color, alpha);
		}
		
		override public function validateDisplayList():void {
			super.validateDisplayList();
			// prevent the scrollbars from covering up the resize handle
			// if you have no border padding, then you will want to un-comment this line
			// but by default panels have border padding, so the resize handle isn't covered up by scrollbars 
			//resizeManager.adjustScrollBars(horizontalScrollBar, verticalScrollBar);
    	}
    	
	}
}