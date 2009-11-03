package com.sitronnier.rlskeleton.views.events
{
	import flash.events.Event;
	
	/**
	 * <p><b>Author:</b> Laurent Prodon - <a href="http://www.sitronnier.com/" target="_blank">www.sitronnier.com</a><br/>
	 * <b>Class version:</b> 0.1<br/>
	 * <b>Actionscript version:</b> 3.0</p>
	 * <p><b>Copyright:</b></p>
	 * <p>The contents of this file are subject to the Mozilla Public License<br />
	 * Version 1.1 (the "License"); you may not use this file except in compliance<br />
	 * with the License. You may obtain a copy of the License at<br /></p>
	 * 
	 * <p><a href="http://www.mozilla.org/MPL/" target="_blank">http://www.mozilla.org/MPL/</a><br /></p>
	 * 
	 * <p>Software distributed under the License is distributed on an "AS IS" basis,<br />
	 * WITHOUT WARRANTY OF ANY KIND, either express or implied.<br />
	 * See the License for the specific language governing rights and<br />
	 * limitations under the License.<br /></p>
	 * 
	 * <p>The Original Code is sitronnier.<br />
	 * The Initial Developer of the Original Code is Laurent Prodon.<br />
	 * Initial Developer are Copyright (C) 2008-2009 Sitronnier.com. All Rights Reserved.</p>
	 *
	 * Thanks to Romuald Quantin for making his Soma project available (http://www.soundstep.com), great inspiration for this work. <br />
	 */
	
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