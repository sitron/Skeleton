package com.sitronnier.rlskeleton.views.components.pages
{
	import com.sitronnier.rlskeleton.views.events.PageViewEvent;
	import com.sitronnier.rlskeleton.vos.PageVO;
	
	import flash.display.MovieClip;
	
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
	 * Initial Developer are Copyright (C) 2009-2010 Sitronnier.com. All Rights Reserved.</p>
	 */
	
	public class AbstractPage extends MovieClip
	{
		protected var _data:PageVO;
		protected var _pageXml:XML;
		protected var _id:String;
		
		// dirty flags
		protected var _willBeRemoved:Boolean = false;
		
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
		
		/**
		 * Override to "draw" your page (ie: add visual content)
		 */
		public function draw():void
		{
			
		} 
		
		/**
		 * Initialize page
		 */
		public function initialize():void
		{
			dispatchEvent(new PageViewEvent(PageViewEvent.INITIALIZED, _id));			
			draw();
		} 
		
		/**
		 * Override to react when new excluded page is selectioned
		 */
		public function onPageExcluded(page:PageVO):void
		{
			
		} 
		
		/**
		 * Override to react when actual page is excluded and wanted page is its parent (reset)
		 */
		public function onPageExcludedReset(page:PageVO):void
		{
			
		} 
		
		/**
		 * Override and do transition here, than call _onTransitionInOver 
		 */
		public function transitionIn():void
		{
			dispatchEvent(new PageViewEvent(PageViewEvent.ON_TRANSITION_IN_START, _id));
		} 
		
		/**
		 * Override and do transition here, than call _onTransitionOutOver 
		 */
		public function transitionOut():void
		{
			_willBeRemoved = true;
			dispatchEvent(new PageViewEvent(PageViewEvent.ON_TRANSITION_OUT_START, _id));
		} 
		
		/**
		 * Delete current page
		 */
		public function dispose():void
		{
			trace("dispose page: " + _data.id);
		} 
		
		/**
		 * helper (not really necessary... but...)
		 */
		public function get id():String
		{
			return _id;
		} 
		
		/**
		 * To know if a page is in transitionOut-dispose process 
		 * @return Boolean
		 */		
		public function get willBeRemoved():Boolean
		{
			return _willBeRemoved;
		} 
	}
}