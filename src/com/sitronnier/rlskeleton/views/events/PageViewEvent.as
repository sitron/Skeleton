package com.sitronnier.rlskeleton.views.events
{
	import flash.events.Event;
	
	public class PageViewEvent extends Event
	{
		public static const CHANGE_PAGE_REQUEST:String = "CHANGE_PAGE_REQUEST";
		
		public static const INITIALIZED:String = "INITIALIZED";
		
		public static const ON_TRANSITION_IN_START:String = "ON_TRANSITION_IN_START";
		public static const ON_TRANSITION_IN_COMPLETE:String = "ON_TRANSITION_IN_COMPLETE";
		public static const ON_TRANSITION_OUT_START:String = "ON_TRANSITION_OUT_START";
		public static const ON_TRANSITION_OUT_COMPLETE:String = "ON_TRANSITION_OUT_COMPLETE";
		
		public var pageId:String;
		
		public function PageViewEvent(type:String, id:String=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			pageId = id;
			
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			return new PageViewEvent(type, pageId, bubbles, cancelable);
		}
	}
}