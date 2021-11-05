package com.zavoo.svg.nodes
{
	public class SVGRectNode extends SVGNode
	{				
		public function SVGRectNode(xml:XML):void {
			super(xml);
		}	
		
		protected override function generateGraphicsCommands():void {
			
			var x:Number = this.getAttribute('x',0);
			var y:Number = this.getAttribute('y',0);
			var width:Number = this.getAttribute('width',0);
			var height:Number = this.getAttribute('height',0);			
			
			this._graphicsCommands.push(['R', x, y, width, height]);
			
			
		}	
		
	}
}