package com.zavoo.svg.nodes
{
	public class SVGSymbolNode extends SVGNode
	{		
		public function SVGSymbolNode(xml:XML):void {
			super(xml);
		}	
		
		protected override function parse():void {
			this._graphicsCommands = new Array();
			this.attributes = new Object();
		}
		
	}
}