package com.manutech.component.preload
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	
	import mx.events.FlexEvent;
	import mx.preloaders.DownloadProgressBar;

	public final class CustomPreloader
		extends DownloadProgressBar
	{
		
		public  var loader : LoadScreen;
		private var _timer : Timer;
    	private var txtFormat:TextFormat;
    	private var txtBox:TextField =  new TextField();
    	
        public function CustomPreloader() 
        {
            super(); 
            
        }
    	
    	override public function initialize() : void
    	{
    		super.initialize();
    		
    		this.loader = new LoadScreen();
    		this.addChild(this.loader);
    		txtBox.x=350;
    		txtBox.y=290;
    		this.addChild(txtBox);
    		txtBox.textColor=0xF52BF3;
			txtFormat= new TextFormat();
			txtFormat.font="Arial";
    		
    		this._timer = new Timer(100);
    		this._timer.addEventListener(TimerEvent.TIMER, handleTimerTick);
    		this._timer.start();
    	}
    	
    	       
        
    	
        override public function set preloader(preloader : Sprite):void 
        {                   
            preloader.addEventListener(ProgressEvent.PROGRESS,  SWFDownLoadScreen);
            preloader.addEventListener(Event.COMPLETE,          SWFDownloadComplete);
            preloader.addEventListener(FlexEvent.INIT_PROGRESS, FlexInitProgress);
            preloader.addEventListener(FlexEvent.INIT_COMPLETE, FlexInitComplete);
        }
    
    	private var prog : Number;
        private function SWFDownLoadScreen(event : ProgressEvent) : void
        {
        	prog  = event.bytesLoaded / event.bytesTotal * 100;
        	if (this.loader)
        	{
        		txtBox.text="Loading.."+Math.round(this.loader.progress)+"%";
        		txtBox.setTextFormat(txtFormat);
        		this.loader.progress = prog;
        	}
        }
        
        private function handleTimerTick(event : TimerEvent) : void
        {
        	this.stage.addChild(this);
        	this.loader.x = (this.stageWidth  - this.loader.width)  / 2;
        	this.loader.y = (this.stageHeight - this.loader.height) / 2;
        	this.loader.refresh();
        }
    
        private function SWFDownloadComplete(event : Event) : void {}
    
        private function FlexInitProgress(event : Event) : void {
        	
        }
    
        private function FlexInitComplete(event : Event) : void 
        {      
            this.loader.ready = true;
            this._timer.stop();
            this.txtBox.visible =false;
            
            this.dispatchEvent(new Event(Event.COMPLETE));
        }
        
        override protected function showDisplayForInit(elapsedTime:int, count:int):Boolean
		{
			return true;
		}
		
		override protected function showDisplayForDownloading(elapsedTime:int,
												  event:ProgressEvent):Boolean
		{
			return true;
		}
	}
}