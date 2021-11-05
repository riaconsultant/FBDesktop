package com.zavoo.svg.nodes
{
	public class SVGLineNode extends SVGNode
	{		
		public function SVGLineNode(xml:XML):void {
			super(xml);
		}	
		
		
		protected override function generateGraphicsCommands():void {
			
			var x1:Number = this.getAttribute('x1',0);
			var y1:Number = this.getAttribute('y1',0);
			var x2:Number = this.getAttribute('x2',0);
			var y2:Number = this.getAttribute('y2',0);
			
			this._graphicsCommands.push(['M', x1, y1]);
			this._graphicsCommands.push(['L', x2, y2]);
		}
		
		/**
		 * We don't want to have to close the graphic for a line
		 * so call nodeEndFill after line command since there is no "Z" command
		 */
		protected override function runGraphicsCommands():void {
			var firstX:Number = 0;
			var firstY:Number = 0;
					
			for each (var command:Array in this._graphicsCommands) {
				switch(command[0]) {
					case "M":
						this.nodeBeginFill();
						this.graphics.moveTo(command[1], command[2]);
						break;
					case "L":
						this.graphics.lineTo(command[1], command[2]);
						this.nodeEndFill();
						break;
				}
			}
		}
	}
}