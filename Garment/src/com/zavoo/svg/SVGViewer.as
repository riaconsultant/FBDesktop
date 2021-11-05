package com.zavoo.svg
{
	import com.zavoo.svg.nodes.SVGRoot;
	
	import mx.containers.Canvas;
	import mx.controls.Alert;

	public class SVGViewer extends Canvas
	{
		private var svgRoot:SVGRoot;
		
		public var _width:Number;
		public var _height:Number;
		
		public function SVGViewer()
		{
			svgRoot = new SVGRoot();	
			this.rawChildren.addChild(svgRoot);				
		}
				
		/**
		 * Get / Set Functions 
		 **/
		 
		public function set scale(scale:Number):void {
			svgRoot.scale = scale;

			//Scale canvas to match size of  SVG
			this.width = svgRoot.origWidth * scale;
			this.height = svgRoot.origHeight * scale; 
			//Alert.show(''+svgRoot.origWidth);
			
		}
		
		public function get scale():Number {
			return svgRoot.scale;				
		}
	
		public function get xml():XML {
			return svgRoot.xml;
		}
		
		public function myWidth(width:Number):void
		{
			svgRoot.width = width
		}
		public function myHeight(height:Number):void
		{
			svgRoot.height = height
		}
		
		public function set xml(xml:XML):void {
						
			//Pass XML off to svgDocReader
			this.svgRoot.xml = xml;
			
			
			//Have svgDocReader draw SVG
			svgRoot.draw();
			//Alert.show('width'+_width+'height'+_height);
			
			svgRoot.width=_width;
			svgRoot.height=_height;
			// Set/Reset scale
			//this.scale = 1;	
		}
		

	
		override public function set scaleX(value:Number):void {
			trace('scaleX: Use SVGViewer.scale');
			
		}
		
		override public function set scaleY(value:Number):void {
			trace('scaleY: Use SVGViewer.scale');
		}
		
	}
}