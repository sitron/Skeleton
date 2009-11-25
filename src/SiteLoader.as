package
{
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	[SWF(frameRate="40", width="800", height="600")]
	public class SiteLoader extends Sprite
	{
		public static var FLASH_VARS:Object = {};
		
		protected var _loader:Loader;
		
		public function SiteLoader()
		{
			FLASH_VARS = loaderInfo.parameters;
			
			if (stage == null) addEventListener(Event.ADDED_TO_STAGE, _onAddedToStage);
			else _onAddedToStage(null);
		}
		
		
		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		protected function _onAddedToStage(event : Event) : void
		{
			removeEventListener(Event.ADDED_TO_STAGE, _onAddedToStage);
			
			if (stage.stageWidth == 0 || stage.stageHeight == 0)
			{
				addEventListener(Event.ENTER_FRAME, _checkStageSize);
			}
			else
			{
				_init();
			}
		}
		
		protected function _checkStageSize(event : Event) : void
		{
			if (stage.stageWidth == 0 || stage.stageHeight == 0) return;
			_init();
		}
		
		protected function _init():void
		{
			removeEventListener(Event.ENTER_FRAME, _checkStageSize);
			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.frameRate = 30;
						
			_loadMainSwf();
		}	
		
		/**
		 * Load main swf 
		 */		
		protected function _loadMainSwf():void
		{			
			// start loading main swf
			_loader = new Loader();
			_loader.contentLoaderInfo.addEventListener(Event.OPEN, _onStart, false, 0, true);
			_loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, _onProgress, false, 0, true);
			_loader.contentLoaderInfo.addEventListener(Event.INIT, _onInit, false, 0, true);
			_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, _onError, false, 0, true);
			_loader.load(new URLRequest(_getMainSwfURL()));
			addChild(_loader);
			
			// loader ui
			// add your loader UI here
			
			// position of ui
			_replace();
		} 
		
		/**
		 * Center UI 
		 */		
		protected function _replace():void
		{
			// position ie center your loader UI here
//			if (_loaderUI == null || stage == null) return;
//			_loaderUI.x = (stage.stageWidth - _loaderUI.width) / 2;
//			_loaderUI.y = (stage.stageHeight - _loaderUI.height) / 2;
		} 
		
		/**
		 * Start handler 
		 * @param event
		 */		
		protected function _onStart(event:Event):void
		{
			_replace();
		}
		
		/**
		 * Progress handler 
		 * @param event
		 */		
		protected function _onProgress(event:ProgressEvent):void
		{
			var pc:Number = event.bytesLoaded / event.bytesTotal; 
			
			// update your loader UI progress here
			
			_replace();
		} 
		
		/**
		 * End handler 
		 * @param event
		 */		
		protected function _onInit(event:Event):void
		{
			// remove your loader UI here
		} 
		
		/**
		 * Error handler 
		 * @param event
		 */		
		protected function _onError(event:IOErrorEvent):void
		{
			trace(this + " _onError: " + event.text);
		} 
		
		/**
		 * To get main swf path 
		 * Skeleton.swf String should be replaced by the name of your main swf (if you don't use flashvars to pass the name)
		 * @return a String which is the path to main swf 
		 */				
		protected function _getMainSwfURL():String
		{
			return loaderInfo.parameters.mainswfURL == null? "Skeleton.swf" : loaderInfo.parameters.mainswfURL;	
		} 
	}
}