package com.zavoo.svg.nodes
{
	public class SVGDefsNode extends SVGNode
	{
		
		public function SVGDefsNode(xml:XML):void {
			super(xml);
		}	
		
		/**
		 * Ignore defs and their children, they were handled in preprocessing of XML
		 * So there is no need to do any parsing
		 */
		protected override function parse():void {
			this._graphicsCommands = new Array();
			this.attributes = new Object();
		}
	}
}