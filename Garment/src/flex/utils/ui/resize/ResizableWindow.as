package flex.utils.ui.resize
{
	import mx.containers.TitleWindow;
	import mx.core.mx_internal;
	import mx.styles.CSSStyleDeclaration;
	import mx.styles.StyleManager;
	//use namespace mx_internal;

	
	/** 
	 * Dispatched when this component starts being dragged.
	 */
	[Event(name="dragStart", type="flash.events.Event")]

	/** 
	 * Dispatched when this component is being dragged. 
	 */
	[Event(name="dragStart", type="flash.events.Event")]

	/** 
	 * Dispatched when this component stops being dragged. 
	 */
	[Event(name="dragEnd", type="flash.events.Event")]
	
		
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
	 *  The alpha value for the move handle.
	 *  @default 0x666666
	 */
	[Style(name="moveHandleColor", type="Color", inherit="no")]

	/**
	 *  The alpha value for the move handle.
	 *  @default 1
	 */
	[Style(name="moveHandleAlpha", type="Number", inherit="no")]

	/**
	 * Extends the TitleWindow class to let the user resize the window by dragging on a small
	 * 16x16 resize handle in the bottom right corner of the window.  Also has support
	 * for adding a move handle too for moving the window around (requires that this window's
	 * parent is a Canvas or similar container with no layout).
	 * 
	 * See the ResizeManager class for more details.
	 * 
	 * You can also specify the minWidth, minHeight, maxWidth, and maxHeight properties
	 * to restrict the size of the window.
	 * 
	 *  <pre>
 	 *  &lt;ResizableWindow
	 *   <strong>Styles</strong>
	 *   resizeHandleColor="0x666666"
	 *   resizeHandleAlpha="1"
	 *   moveHandleColor="0x666666"
	 *   moveHandleAlpha="1"
	 * &gt;
 	 *      ...
 	 *      <i>child tags</i>
 	 *      ...
 	 *  &lt;/ui:ResizableWindow&gt;
 	 *  </pre>
 	 * 
	 * @author Chris Callendar
	 * @date March 17th, 2009
	 */
	public class ResizableWindow extends TitleWindow
	{
		// setup the default styles
		private static var classConstructed:Boolean = classConstruct(); 
		private static function classConstruct():Boolean {
            var style:CSSStyleDeclaration = StyleManager.getStyleDeclaration("ResizableWindow"); 
            if (!style) {
                style = new CSSStyleDeclaration();
            }
            if (style.getStyle("roundedBottomCorners") == undefined) {
            	style.setStyle("roundedBottomCorners", false);	// looks better with resize handle
            }
            style.defaultFactory = function():void {
               	this.resizeHandleColor = 0x666666;
                this.resizeHandleAlpha = 1;
                this.moveHandleColor = 0x666666;
                this.moveHandleAlpha = 1;
            };
			StyleManager.setStyleDeclaration("ResizableWindow", style, true);
            return true;
        };
        		
		private var resizeManager:ResizeManager;
		private var moveManager:MoveManager;
		
		public function ResizableWindow(canResize:Boolean = true, canMove:Boolean = false) {
			super();
			this.resizeManager = new ResizeManager(this);
			this.moveManager = new MoveManager();
			this.resizable = canResize;
			this.movable = canMove;
			
			// set a minimum size for this window
			minWidth = 24;
			minHeight = 24;
		}
				
		[Inspectable(category="Common")]
		public function get resizable():Boolean {
			return resizeManager.enabled;
		}
		
		public function set resizable(canResize:Boolean):void {
			resizeManager.enabled = canResize;
			if (canResize) {
				// looks better for the resize handle
				setStyle("roundedBottomCorners", false);
			}
		}	
		
		[Inspectable(category="Common")]
		public function get movable():Boolean {
			return moveManager.enabled;
		}
		
		public function set movable(canMove:Boolean):void {
			if (canMove != moveManager.enabled) {
				moveManager.enabled = canMove;
				if (titleBar) {
					if (canMove) {
						moveManager.addMoveSupport(this, titleBar, titleBar);
					} else {
						moveManager.removeMoveSupport();
					}
				}
				invalidateDisplayList();
			}
		}
		
		override protected function createChildren():void {
			super.createChildren();
			if (movable && titleBar) {
				moveManager.addMoveSupport(this, titleBar, titleBar);
			}
		}
		
		override public function styleChanged(styleProp:String):void {
			super.styleChanged(styleProp);

			if ((styleProp == "resizeHandleColor") || (styleProp == "resizeHandleAlpha") || 
				(styleProp == "moveHandleColor") || (styleProp == "moveHandleAlpha")) {
				invalidateDisplayList();
			}
		}
			
		override protected function layoutChrome(w:Number, h:Number):void {
			super.layoutChrome(w, h);
			
			// position the move handle - the x position defaults to the title textfield's x value
			if (movable && titleTextField) {
				var moveX:Number = titleTextField.x;
				if (mx_internal::titleIconObject != null) {
					// shift the title icon over, and use it's x value for the move handle
					moveX = mx_internal::titleIconObject.x;
					mx_internal::titleIconObject.x += moveManager.moveHandle.width + 4;
				}
				moveManager.moveHandle.move(moveX, titleTextField.y);
				titleTextField.x += moveManager.moveHandle.width + 4;
			}
		}
			
		override protected function updateDisplayList(w:Number, h:Number):void {
			super.updateDisplayList(w, h);
			
			// Draw resize handle
			var color:uint = uint(getStyle("resizeHandleColor"));
			var alpha:Number = Number(getStyle("resizeHandleAlpha"));
			resizeManager.drawResizeHandle(w, h, color, alpha);
			
			color = uint(getStyle("moveHandleColor"));
			alpha = Number(getStyle("moveHandleAlpha"));
			moveManager.drawMoveHandle(w, h, color, alpha);
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