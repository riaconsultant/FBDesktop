/**
 * Global Imports 
 * */
import com.manoj.ControlObject;
import com.manoj.ImageObject;
import com.redrock.be.TextPath;
import com.tools.CropImage;
import com.tools.controlCanvas;
import com.tools.libImage;

import flash.events.Event;
import flash.net.FileReference;
import flash.system.ApplicationDomain;
import flash.text.Font;
import flash.utils.ByteArray;

import mx.collections.ArrayCollection;
import mx.collections.XMLListCollection;
import mx.containers.Canvas;
import mx.controls.Alert;
import mx.controls.Label;
import mx.controls.Text;
import mx.core.UIComponent;
import mx.events.ListEvent;
import mx.events.SliderEvent;
import mx.events.ValidationResultEvent;
import mx.graphics.codec.PNGEncoder;
import mx.managers.PopUpManager;
import mx.rpc.events.FaultEvent;
import mx.rpc.events.ResultEvent;
import mx.states.AddChild;
import mx.styles.StyleManager;
import mx.utils.ObjectUtil;
import mx.utils.object_proxy;
/**
 * Application Variable declarations
 * */
public var topText:String;
public var midText:String;
public var botText:String;
public var topTextA:String;
public var botTextA:String;
public var img:String;

[Bindable] private var fontsize:Array = [
	{fontSize:"Extra small", data:"20"},
	{fontSize:"Small", data:"25"},
	{fontSize:"Medium", data:"30"},
	{fontSize:"Large", data:"35"},
	{fontSize:"Extra large", data:"40"},
];
[Bindable] private var imageColor:Array = [
	{imgColr:"Choose One..", imgValue:"0"},
	{imgColr:"Black & white", imgValue:"1"},
	{imgColr:"Color", imgValue:"2"}
];

[Bindable]private var fontColors:Object;
[Bindable]private var fontData:Object;
[Bindable]private var randomNum:Number = new Number (Math.floor(Math.random()* (100000 - 1 + 1)) + 1);
[Bindable]public var defaultColor:Number;
[Binable]public var nav:String;
[Binable]public var imagePath:String;
[Binable]public var retObjectMid:Object;
[Binable]public var retObjectBot:Object;
[Binable]public var isCircleImage:String;
[Binable]public var checkLibImage:String;
[Binable]public var totalColors:int;
[Binable]public var totalColorsCost:Number;

/**
 * Global Message
 * */

public var param_product:String;
public var product_type:String;
public var message_title:String = "You Design Editor 1.0";
public var site_title:String = "You Design Editor 1.0";

//public static var site_url:String="http://udesignedit.com/"; 
public static var site_url:String="http://localhost/projects/flex/"; 
//public static var site_url:String="http://64.15.136.251:8080/youdesignedit/"; 
