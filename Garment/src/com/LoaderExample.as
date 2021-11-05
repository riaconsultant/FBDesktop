package com
{
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.ProgressEvent;
    
    import mx.preloaders.DownloadProgressBar;
     
    public class FlashPreloader extends DownloadProgressBar
    {    
        private var myPreloader:Preloader;
        
        public function FlashPreloader():void
        {
            super();
            myPreloader = new Preloader();
            addChild( myPreloader );
        }
         
        public override function set preloader(preloader:Sprite):void
        {
            preloader.addEventListener( ProgressEvent.PROGRESS, progress_handler );
            preloader.addEventListener( Event.COMPLETE, complete_handler );
            preloader.addEventListener( FlexEvent.INIT_COMPLETE, initComplete_handler  );
            
            centerPreloader();
        }    
 
        private function centerPreloader():void
        {
            x = (stageWidth / 2) - (myPreloader.width / 2);
            y = (stageHeight / 2) - (myPreloader.height / 2);
        }
 
        private function progress_handler( event:ProgressEvent ):void
        {
            myPreloader.loadProgress_handler( event );
        }
         
        private function complete_handler( event:Event ):void
        {
            removeChild( myPreloader );
        }
         
        private function initComplete_handler ( event:FlexEvent ):void
        {
            dispatchEvent( new Event( Event.COMPLETE ) );
        }
    }
}