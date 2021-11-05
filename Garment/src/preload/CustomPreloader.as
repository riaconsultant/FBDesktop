package preload
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	
	import mx.preloaders.DownloadProgressBar;
		/*#########################################################################
		 Class created for http://askmeflash.com 
		 get answers to all your flash, flex, FMS problems at askmeflash.com its free
		 Flash developers website http://askmeflash.com
		 ##########################################################################*/
	public class CustomPreloader extends DownloadProgressBar {
		private var timer:Timer;
		//progress bar 
		private var pBar:Sprite= new Sprite();
		//Progress bar mask 
		private var maskBar:Sprite= new Sprite();
		//Text box to diplay loading percentage
		private var txtBox:TextField =  new TextField();
	    //loader for loading swf design of progress bar 
	    private var loader:Loader;
	    //Load swf file containing design of progress bar 
    	[ Embed(source="greenBar.swf", mimeType="application/octet-stream") ]
		public var WelcomeScreenGraphic:Class;
		//background color 
		private var bgSprite:Sprite= new Sprite();
		
		    private var txtFormat:TextFormat;
        public function CustomPreloader() 
        {
			this.addChild(bgSprite);
        	//timer
			timer = new Timer(1);
        	timer.addEventListener(TimerEvent.TIMER, drawProgress );
			timer.start();
        	//loading swf file of progress bar design
			loader= new Loader();
			loader.loadBytes( new WelcomeScreenGraphic() as ByteArray );
			pBar.addChild(loader);
			this.addChild(txtBox);
			pBar.addChild(maskBar);
			pBar.mask=maskBar;
			//position textbox
			txtBox.textColor=0xffffff;
			txtFormat= new TextFormat();
			txtFormat.font="Arial";
			//background color of preloader 
 			bgSprite.graphics.beginFill(0x000000);
        	bgSprite.graphics.drawRect(0,0,200,200)
        	bgSprite.graphics.endFill();
        }
    
        override public function set preloader( preloader:Sprite ):void 
        {   
        	preloader.addEventListener(ProgressEvent.PROGRESS, SWFDownloadProgress);
            //position progressbar to center of stage
            var centerX:Number=(this.stage.stageWidth - 475) / 2;
            var centerY:Number=(this.stage.stageHeight - 153) / 2;
            pBar.x = centerX;
			pBar.y = centerY;
			
			txtBox.x=centerX+6;
			txtBox.y=centerY-14;			
			bgSprite.width=this.stage.stageWidth;
			bgSprite.height=this.stage.stageHeight;
			this.addChild(pBar);
        }
        private var progress:Number;        
        private function SWFDownloadProgress( event:ProgressEvent ):void {
			
        	//progress multiplied by 2 cos our progress bar design is 200 px
        	var multiplier:Number=2;
        	progress=multiplier*Number(event.target.loaderInfo.bytesLoaded/event.target.loaderInfo.bytesTotal*100);
        }
        private var  currlen:Number=0;
        public function drawProgress(event: Event):void{
			//change the mask color to the color of your background
			if(currlen<progress){
				currlen+=1;
				maskBar.graphics.beginFill(0x0000ff);
		        maskBar.graphics.drawRect(0,0,currlen+10,200);
		        maskBar.graphics.endFill();
				txtBox.text="Loading.."+Math.round(currlen/2)+"%";
				txtBox.setTextFormat(txtFormat);
			}
        	if(currlen==200){
			    timer.stop();
			  	dispatchEvent( new Event( Event.COMPLETE ) );
			} 
        
        }
        
 	}
}