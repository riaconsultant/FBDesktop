package com.zavoo.svg.nodes
{
	import flash.display.Sprite;
	
	public class SVGClipPathNode extends SVGNode
	{	
		
		public function SVGClipPathNode(xml:XML):void {	
			super(xml);
		}
		
		/**
		 * We only want to draw a solid object so
		 * ignore any attribute settings
		 */
		public override function setAttributes():void {
			this.attributes['fill'] = 'black';
			this.attributes['fill-opacity'] = 1;			
			this.attributes['stroke'] = 'none';
			
			// Set child attributes			
			for each (var childNode:SVGNode in this.children) {
				childNode.setAttributes();
			}
		}		
		
		/**
		 * Draw self & set self as parent's mask
		 */
		public override function draw():void {
			super.draw();			
			Sprite(this.parent).mask = this;	
		}
	}
}