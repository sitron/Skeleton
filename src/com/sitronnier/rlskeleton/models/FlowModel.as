package com.sitronnier.rlskeleton.models
{
	import com.asual.swfaddress.SWFAddress;
	import com.asual.swfaddress.SWFAddressEvent;
	import com.sitronnier.rlskeleton.events.PageEvent;
	import com.sitronnier.rlskeleton.vos.PageVO;
	
	import nl.demonsters.debugger.MonsterDebugger;
	
	import org.robotlegs.mvcs.Actor;
	
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
	 * THANKS a lot to Romuald Quantin for making his Soma project available. <br />
	 * Big part of this project is derived from his work. Check it on http://www.soundstep.com/
	 */
	
	public class FlowModel extends Actor
	{
		[Inject]
		public var dataModel:DataModel;
		
		protected var _currentPage:PageVO;
		protected var _oldPages:Array = [];
		
		// tag for swf address initialization
		protected var _hasStarted:Boolean = false;
		
		
		public function FlowModel()
		{
			super();			
			
			SWFAddress.addEventListener(SWFAddressEvent.EXTERNAL_CHANGE, _handleSWFAddress);
			SWFAddress.addEventListener(SWFAddressEvent.INIT, _handleInitSWFAddress);
//			SWFAddress.addEventListener(SWFAddressEvent.INTERNAL_CHANGE, _handleSWFAddress);
			
			MonsterDebugger.clearTraces();
		}
		
		
		// PROTECTED, PRIVATE
		//________________________________________________________________________________________________
		
		protected function _changePage(vo:PageVO):void
		{
			if (vo == null)
			{
				throw Errors.getErrorWithParam(Errors.PAGE_IS_NULL);
				return;
			}
			
			var oldPage:PageVO;
			
			if (_currentPage != null)
			{
				// check that it's not the same page
				if (_currentPage.id == vo.id)
				{
					trace("same page, no change");
					return;
				}
				
				// keep a reference to the old (soon to be changed) page
				oldPage = _currentPage;
				
				// inform actors that page will change (is this necessary?)
				dispatch(new PageEvent(PageEvent.PAGE_WILL_CHANGE, vo.id));
			}
			
			// create new page
			_currentPage = vo;
			
			if (oldPage != null) _oldPages.push(oldPage);
			
			// dispatch change event
			var e:PageEvent = new PageEvent(PageEvent.ON_PAGE_CHANGE, _currentPage.id);
			e.oldPageId = oldPage != null? oldPage.id : null;
			dispatch(e);	
						
			// if no previous page, go directly to next
			if (oldPage == null) dispatch(new PageEvent(PageEvent.ON_TRANSITION_OUT_COMPLETE));
			
			// update url
			MonsterDebugger.trace(this, "set url to : " + vo.urlFriendly.toLowerCase());
			SWFAddress.setValue(vo.urlFriendly.toLowerCase());
		} 
		
		/**
		 * On url init
		 */
		protected function _handleInitSWFAddress(event:SWFAddressEvent):void
		{
			MonsterDebugger.trace(this, "_handleInitSWFAddress: " + event.path);	
		} 
		
		/**
		 * On url change
		 */
		protected function _handleSWFAddress(event:SWFAddressEvent):void
		{
			MonsterDebugger.trace(this, "url change : " + event.path);
			var path:String = SWFAddress.getValue();
			
			if (!_hasStarted) return;
			
			// if is default path
			if ((path == "/" || path == "")) 
			{
				show();
				return;
			}
			
			if (path.substr(-1) == "/") path = path.substring(0, -1);
			if (path.substr(0, 1) == "/") path = path.substring(1);
			
			_processUrlPath(path);
		} 
		
		/**
		 * Get a page id (or null) from a path
		 * @param path string with no preceding/ending slash
		 */
		protected function _processUrlPath(path:String):void
		{
//			MonsterDebugger.trace(this, "_processUrlPath: " + path);
			var pageId:String = dataModel.getPageByUrl(path);
//			MonsterDebugger.trace(this, "page found: " + pageId);
			if (pageId == null) show();
			else show(pageId);
		} 
		
		
		// PUBLIC
		//________________________________________________________________________________________________
		
		/**
		 * Show a page
		 * @param id page id (@id in sitemap.xml)
		 */
		public function show(id:String = null):void
		{
			if (!_hasStarted) _hasStarted = true;
			
			if (id == null) 
			{
				_changePage(dataModel.getDefaultPage());
				return;
			}
			_changePage(dataModel.getPageById(id));
		} 
		
		/**
		 * Returns current page
		 */
		public function get currentPage():PageVO
		{
			return _currentPage;	
		} 
		
		public function get oldPages():Array
		{
			return _oldPages;	
		} 
	}
}