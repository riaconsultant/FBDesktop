package com.zavoo.svg.nodes
{
	import com.zavoo.svg.nodes.SVGNode;
	import com.zavoo.svg.nodes.SVGDefsNode;
	import com.zavoo.svg.nodes.SVGSymbolNode;
	import com.zavoo.svg.nodes.SVGUseNode;


	import flash.geom.Rectangle;
	import flash.display.Sprite;
	import mx.core.UIComponent;
	import mx.utils.StringUtil;
	import flash.display.Shape;
		
	public class SVGRoot extends SVGNode
	{		
		public var defsAndSymbols:Object;
		
		public var clipPaths:Object;
		
		private var spriteMask:Shape;
		
		private var _scale:Number = 1;
		private var _origWidth:Number;
		private var _origHeight:Number;
		
		public function SVGRoot(xml:* = null):void {
			if (xml != null) {				
				super(XML(xml)); 		
			}
		}	
		
		public function set scale(scale:Number):void {
			this._scale = scale;
			this.scaleX = scale;
			this.scaleY = scale;
		}
		
		public function get scale():Number {
			return this._scale;
		}
		
		public function get origWidth():Number {
			return this._origWidth;
		}
		
		public function get origHeight():Number {
			return this._origHeight;
		}
		
		public override function set xml(xml:XML):void {
			default xml namespace = svg;			
			this.mask = null;
			this.defsAndSymbols = new Object();
			this.clipPaths = new Object();
			this._scale = 1;
			
			var nChildren:int = this.numChildren;
			for(var i:int = 0; i < nChildren; i++) {
				this.removeChildAt(0);
			}
			this._xml = this.preprocessXML(xml);
			this._origWidth = this.cleanNumber(this._xml.@width);
			this._origHeight = this.cleanNumber(this._xml.@height);
			
			this.parse();	
			this.transformNode();
						
			this.setAttributes();
			this.addSpriteMask();
			
		}	
		
		private function addSpriteMask():void {
			
			spriteMask = new Shape();
			
			spriteMask.graphics.beginFill(0x000000);
			spriteMask.graphics.drawRect(0,0,this._origWidth, this._origHeight);
			spriteMask.graphics.endFill();
			this.addChild(spriteMask);
			this.mask = spriteMask;
		}
		
		
		
		public override function setAttributes():void {
			default xml namespace = svg;
			
			var value:*;
			
			// Setup default values
			this.attributes['opacity'] = 1;
			
			this.attributes['fill'] = 'black';
			this.attributes['fill-opacity'] = 1;
			
			this.attributes['stroke'] = 'none';
			this.attributes['stroke-width'] = 1;
			this.attributes['stroke-opacity'] = 1;
			
					
			for each(var attribute:String in this.attributeList) {
				value = this.getAttribute(attribute);
				if (value != null) {
					this.attributes[attribute] = String(value);		
				}
			}
			
			value = this.getAttribute("style");
			if (value != null) {				
				this.parseStyle(value);				
			}
			
			// Set child attributes			
			for each (var childNode:SVGNode in this.children) {
				childNode.setAttributes();
			}
		}	
		
		/**
		 * Handle symbols and defs by replacing use tags with
		 * path and shape content
		 **/
		private function preprocessXML(xmlData:XML):XML {				
			
			var xmlString:String;
			
			xmlString = xmlData.toXMLString();
			
			var xmlNode:XML;
			var defNode:XML;
			
			
			defsAndSymbols = new Object();
			
			//Get a list of symbols		
			for each (xmlNode in xmlData..symbol) {
				xmlString = xmlNode.toXMLString();
				xmlString = xmlString.replace(/^<symbol.*?>\s*/si,'');
				xmlString = xmlString.replace(/\s*<\/symbol>$/si,'');
				this.defsAndSymbols[xmlNode.@id] = xmlString;			
			}			
			
			//Get a list of defs
			for each (xmlNode in xmlData..defs) {
				for each (defNode in xmlNode.children()) {
					xmlString = defNode.toXMLString();
					this.defsAndSymbols[defNode.@id] = xmlString;	
				}
			}			
			
			//Replace use references with symbol/def xml
			for each (var useXMLNode:XML in xmlData.descendants('use')) {				
				
				var href:String = useXMLNode.@xlink::href;
				href = href.replace(/^#/,'');
				if (this.defsAndSymbols.hasOwnProperty(href)) {
					useXMLNode.appendChild(new XMLList(this.defsAndSymbols[href]));
				}
			}
			
			/* for each (xmlNode in xmlData..clipPath) {
				this.clipPaths[xmlNode.@id] = xmlNode.toXMLString();		
			} */
			
			return xmlData;
		}	
		
	}
}