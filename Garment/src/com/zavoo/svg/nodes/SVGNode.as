package com.zavoo.svg.nodes
{
	import com.zavoo.svg.data.SVGColors;
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import mx.utils.ObjectUtil;
	import flash.geom.Matrix;
	
		
	/** Base node to be extended by all other SVG Nodes **/
	public class SVGNode extends Sprite
	{	
		public namespace xlink = 'http://www.w3.org/1999/xlink';
		public namespace svg = 'http://www.w3.org/2000/svg';
		
		protected var _xml:XML;
	
		protected var _graphicsCommands:Array;

		public var attributes:Object;	
		
		protected var attributeList:Array = ['stroke', 'stroke-width', 'stroke-dasharray', 'stroke-opacity',
										 'fill', 'fill-opacity', 'opacity', 
										 'font-family', 'font-size', 'letter-spacing'];	
		
		public function SVGNode(xml:XML):void {
			this.xml = xml;			
		}
		
		/** Called to generate AS3 graphics commands */
		protected function generateGraphicsCommands():void {
			// Place Holder
		}
		
		public function setAttributes():void {
			var value:*;
			
			var clipPath:String = this.getAttribute('clip-path');
			if (clipPath != null) {
				clipPath = clipPath.replace(/url\(#(.*?)\)/si,"$1");
				var cPaths:Object = this.getClipPaths();	
				var svgClipPath:SVGClipPathNode = new SVGClipPathNode(new XML(cPaths[clipPath]));
				this.addChild(svgClipPath);		
			}
			
			//Inherit parent attributes
			if (this.parent != null) {
				if (this.parent is SVGNode) {					
					this.attributes = ObjectUtil.copy(SVGNode(this.parent).attributes);  					
				}
			}
			
			// Ignore parent opacity, Sprite already handles this
			if (this.attributes.hasOwnProperty('opacity')) {
				delete(this.attributes.opacity);
			}
			
			// Load this nodes attributes
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
			
			// Set own properties
			if (this.attributes.hasOwnProperty('opacity')) {
				this.alpha = this.attributes.opacity;
			}			
						
			// Set child attributes			
			for each (var childNode:DisplayObject in this.children) {
				if (childNode is SVGNode) {
					SVGNode(childNode).setAttributes();	
				}
			}
		}
		
		protected function parseStyle(styleString:String):void {
			var styles:Array = styleString.split(';');
			for each(var style:String in styles) {
				var styleSet:Array = style.split(':');
				if (styleSet.length == 2) {
					this.attributes[styleSet[0]] = styleSet[1];
				}
			} 			
		}
		
		/**
		 * Bad Method -- Fix Me
		 **/
		public function getDefsAndSymbols():Object {
			if (this is SVGRoot) {
				return SVGRoot(this).defsAndSymbols;
			}
			return SVGNode(this.parent).getDefsAndSymbols();
		} 
		
		/**
		 * Bad Method -- Fix Me
		 **/
		public function getClipPaths():Object {
			if (this is SVGRoot) {
				return SVGRoot(this).clipPaths;
			}
			return SVGNode(this.parent).getClipPaths();
		}
		
		/** Perform any transformations needed **/
		protected function transformNode():void {
			
			var trans:String = String(this.getAttribute('transform', ''));
			
			if (trans != '') {
				var transArray:Array = trans.match(/\S+\(.*?\)/sg);
				for each(var tran:String in transArray) {
					var tranArray:Array = tran.split('(',2);
					if (tranArray.length == 2)
					{						
						var command:String = String(tranArray[0]);
						var args:String = String(tranArray[1]);
						args = args.replace(')','');
						var argsArray:Array = args.split(/[, ]/);
						//trace('Transform: ' + tran);
						switch (command) {
							case "matrix":
								if (argsArray.length == 6) {
									var nodeMatrix:Matrix = this.transform.matrix; 
									nodeMatrix.a = argsArray[0];
									nodeMatrix.b = argsArray[1];
									nodeMatrix.c = argsArray[2];
									nodeMatrix.d = argsArray[3];
									nodeMatrix.tx = argsArray[4];
									nodeMatrix.ty = argsArray[5];
									this.transform.matrix = nodeMatrix;
								}
								break;
								
							case "translate":
								if (argsArray.length == 1) {
									this.x = argsArray[0];
								}
								else if (argsArray.length == 2) {
									this.x = argsArray[0];
									this.y = argsArray[1];
								}
								break;
								
							case "scale":
								if (argsArray.length == 1) {
									this.scaleX = argsArray[0];
									this.scaleY = argsArray[0];
								}
								else if (argsArray.length == 2) {
									this.scaleX = argsArray[0];
									this.scaleY = argsArray[1];
								}
								break;
								
							case "skewX":
								// To Do
								break;
								
							case "skewY":
								// To Do
								break;
								
							default:
								trace('Unknown Transformation: ' + command);
						}
					}
				}
				
			}
			
		} 
		
		
		/** Draw SVG data to sprite **/
		public function draw():void {
			
			this.runGraphicsCommands();
			this.drawChildren();
		}
		
		/** Call children's draw command **/
		protected function drawChildren():void {
			for each (var childNode:DisplayObject in this.children) {
				if (childNode is SVGNode) {
					SVGNode(childNode).draw();
				}
			}
		}
		
		/** Load fill and stroke properties **/
		protected function nodeBeginFill():void {
			var alpha:Number;
			
			//Set Fill Style
			if (this.attributes.hasOwnProperty('fill') 
				&& this.attributes.fill != 'none'
				&& this.attributes.fill != '') {
				
				alpha = 1;
				if (this.attributes.hasOwnProperty('fill-opacity')) {
					alpha = this.attributes['fill-opacity'];
				}
				
				this.graphics.beginFill(this.getColor(this.attributes.fill),alpha);
			}			
			
			//Set Line Style
			if (this.attributes.hasOwnProperty('stroke')
				&& this.attributes.stroke != 'none'
				&& this.attributes.stroke != '') {				
				alpha = 1;
				if (this.attributes.hasOwnProperty('stroke-opacity')) {
					alpha = this.attributes['stroke-opacity'];
				}
				
				this.graphics.lineStyle(this.attributes['stroke-width'], this.getColor(this.attributes.stroke), alpha);	
			}
			else // No line
			{
				this.graphics.lineStyle(0,0,0);
			}
					
		}
		
		
		protected function nodeEndFill():void {
			this.graphics.endFill();
		}
		
		protected function runGraphicsCommands():void {
			var firstX:Number = 0;
			var firstY:Number = 0;
					
			for each (var command:Array in this._graphicsCommands) {
				switch(command[0]) {
					case "M":
						this.nodeBeginFill();
						firstX = command[1];
						firstY = command[2];						
						this.graphics.moveTo(command[1], command[2]);
						break;
					case "L":
						this.graphics.lineTo(command[1], command[2]);
						break;
					case "C":
						this.graphics.curveTo(command[1], command[2],command[3], command[4]);
						break;
					case "Z":
						this.graphics.lineTo(firstX, firstY);
						this.nodeEndFill();
						break;
					case "R":
						this.nodeBeginFill();
						this.graphics.drawRect(command[1], command[2],command[3], command[4]);
						this.nodeEndFill();
				}
			}
		}
		
		protected function parse():void {
			this._graphicsCommands = new Array();
			this.attributes = new Object();
			
			generateGraphicsCommands();
			
			for each (var childXML:XML in this._xml.children()) {				
				var nodeName:String = childXML.localName();
				nodeName = nodeName.toLowerCase();
				
				switch(nodeName) {
					case "circle":
						//Add Handling 
						//this.addChild(new SVGCircleNode(childXML));
						break;		
					case "clippath":
						//Do Nothing - clipPath handled in setAttributes()
						break;
					case "defs":
						//Do Nothing
						break;
					case "ellipse":
						//Add Handling 
						//this.addChild(new SVGEllipseNode(childXML));
						break;
					case "g":						
						this.addChild(new SVGGroupNode(childXML));
						break;
					case "image":						
						this.addChild(new SVGImageNode(childXML));
						break;
					case "line": 
						this.addChild(new SVGLineNode(childXML));
						break;
					case "metadata":
						//Do Nothing
						break;
					case "namedview":
						//Add Handling 
						break;
					case "polygon":
						this.addChild(new SVGPolygonNode(childXML));
						break;
					case "polyline":
						//Add Handling 
						//this.addChild(new SVGPolylineNode(childXML));
						break;
					case "path":						
						this.addChild(new SVGPathNode(childXML));
						break;
					case "rect":
						this.addChild(new SVGRectNode(childXML));
						break;
					case "symbol":
						//Do Nothing
						break;						
					case "text":
						//Add Handling 	
						//this.addChild(new SVGTextNode(childXML));
						break; 
					case "tspan":
						//Do Nothing - Handled By SVGTextNode
						break; 
					case "use":
						//Actual XML copied into the use node during preprocessing
						//the use nodes performas the same function as a group nodes
						this.addChild(new SVGUseNode(childXML));
						break;
						
						
					case "null":
						break;
					default:
						trace("Unknown Element: " + nodeName);
						break;	
				}					
			}			
		}
		
		public function getAttribute(attribute:*, defaultValue:* = null):* {
			// To Do: Support Style=
			var xmlList:XMLList = this._xml.attribute(attribute);
			if (xmlList.length() > 0) {
				return xmlList[0].toString();
			}			
			return defaultValue;
		}
		
		protected function getColor(color:String):Number {
			if(color.match(/^#/)) {
				color = color.replace('#', '0x');
				return parseInt(color);
			}
			else if (SVGColors.colors.hasOwnProperty(color)) {
				return SVGColors.colors[color];
			}
			
			return 0x000000;

		}
		
		protected function getHexColor(color:String):String {
			if(color.match(/^#/)) {
				return color;
			}
			else if (SVGColors.colors.hasOwnProperty(color)) {
				return SVGColors.getHexColor(SVGColors.colors[color]);
			}
			
			return '#000000';
		}
		
		public function cleanNumber(num:*):Number {
			var numString:String = String(num);
			numString = numString.replace(/[^0-9\.]+/sig,'');
			return Number(numString);
		}
				
		/**** Getters / Setters ****/
		
		public function set xml(xml:XML):void {		
			this._xml = xml;
			this.parse();
			this.transformNode();
		}
		
		public function get xml():XML {
			return this._xml;
		}

		/** Temporary function to make debugging easier **/
		 public function get children():Array {
			var myChildren:Array = new Array();
			for (var i:int = 0; i < this.numChildren; i++) {
				myChildren.push(this.getChildAt(i));
			}
			return myChildren;
		} 
		
		public function get graphicsCommands():Array {
			return this._graphicsCommands;
		}
		
		public function set graphicsCommands(commands:Array):void {
			this._graphicsCommands = commands;
		}
		
		
		
	}
}