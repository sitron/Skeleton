package com.sitronnier.rlskeleton.events
{
	import com.sitronnier.rlskeleton.views.components.pages.AbstractPage;
	
	import flash.events.Event;
	
	public class PageEvent extends Event
	{
		// request type event (bad? really?)
		public static const CHANGE_PAGE_REQUEST:String = "CHANGE_PAGE_REQUEST";
		
		// notification events
		public static const INITIALIZED:String = "INITIALIZED";
		public static const PAGE_WILL_CHANGE:String = "PAGE_WILL_CHANGE";
		public static const ON_PAGE_CHANGE:String = "ON_PAGE_CHANGE";		
		public static const ON_TRANSITION_IN_START:String = "ON_TRANSITION_IN_START";
		public static const ON_TRANSITION_IN_COMPLETE:String = "ON_TRANSITION_IN_COMPLETE";
		public static const ON_TRANSITION_OUT_START:String = "ON_TRANSITION_OUT_START";
		public static const ON_TRANSITION_OUT_COMPLETE:String = "ON_TRANSITION_OUT_COMPLETE";
		
		public var pageId:String;
		public var oldPageId:String;
		public var page:AbstractPage;
		
		public function PageEvent(type:String, id:String=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			pageId = id;
			
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			return new PageEvent(type, pageId, bubbles, cancelable);
		}
	}
}