package com.sitronnier.rlskeleton.views.components.pages
{
	import com.sitronnier.rlskeleton.views.events.PageViewEvent;
	import com.sitronnier.rlskeleton.vos.PageVO;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class AbstractPage extends MovieClip
	{
		protected var _data:PageVO;
		protected var _pageXml:XML;
		protected var _id:String;
		
		public function AbstractPage(data:PageVO)
		{
			_data = data;
			_pageXml = _data.xmldata;
			_id = _data.id;
			
			super();
		}
		
		
		// PROTECTED, PRIVATE
		//________________________________________________________________________________________________
		
		protected function _onTransitionInOver():void
		{
			dispatchEvent(new PageViewEvent(PageViewEvent.ON_TRANSITION_IN_COMPLETE, _id));
		}
		
		protected function _onTransitionOutOver():void
		{
			dispatchEvent(new PageViewEvent(PageViewEvent.ON_TRANSITION_OUT_COMPLETE, _id));
		}
		
		
		// PUBLIC
		//________________________________________________________________________________________________
		
		public function draw():void
		{
			
		} 
		
		public function initialize():void
		{
			dispatchEvent(new PageViewEvent(PageViewEvent.INITIALIZED, _id));			
			draw();
		} 
		
		public function get id():String
		{
			return _id;
		} 
		
		public function transitionIn():void
		{
			dispatchEvent(new PageViewEvent(PageViewEvent.ON_TRANSITION_IN_START, _id));
			
			// override and do transition here, than call _onTransitionInOver
		} 
		
		public function transitionOut():void
		{
			dispatchEvent(new PageViewEvent(PageViewEvent.ON_TRANSITION_OUT_START, _id));
			
			// override and do transition here, than call _onTransitionOutOver
		} 
		
		public function dispose():void
		{
			trace("dispose page: " + _data.id);
		} 
	}
}