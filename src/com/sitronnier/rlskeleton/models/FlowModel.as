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
	 * Thanks to Romuald Quantin for making his Soma project available (http://www.soundstep.com), great inspiration for this work. <br />
	 */
	
	public class FlowModel extends Actor
	{
		[Inject]
		public var dataModel:DataModel;
		
		protected var _currentPage:PageVO;
		protected var _oldPages:Array = [];
		
		// tag for swf address initialization
		protected var _hasStarted:Boolean = false;
		
		protected var _initialPath:String;
		
		
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
			MonsterDebugger.trace(this, "_changePage: " + vo.id, MonsterDebugger.COLOR_ERROR);
			
			if (vo == null)
			{
				throw Errors.getErrorWithParam(Errors.PAGE_IS_NULL);
				return;
			}
			
			var oldPage:PageVO;
			var e:PageEvent;
			
			if (_currentPage != null)
			{
				// check that it's not the same page
				if (_currentPage.id == vo.id)
				{
					MonsterDebugger.trace(this, "same page, no change");
					return;
				}
				
				// keep a reference to the old (soon to be changed) page
				oldPage = _currentPage;
				
				// inform actors that page will change (is this necessary?)
				dispatch(new PageEvent(PageEvent.PAGE_WILL_CHANGE, vo.id));
			}
			
			// if the page is just a container show its "showChild" index child (see @showChild in sitemap.xml)
			if (vo.showChild != -1) vo = vo.children[vo.showChild] as PageVO;
			
			if (vo.excluded)
			{
				if (oldPage == null)
				{
					_currentPage = vo.parent;
					dispatch(new PageEvent(PageEvent.ON_PAGE_CHANGE, _currentPage.id));
				}
				else
				{
					if (oldPage.id == vo.parent.id) {}
					else if (oldPage.excluded && oldPage.parent.id == vo.parent.id) {}
					else
					{
						_currentPage = vo.parent;
						e = new PageEvent(PageEvent.ON_PAGE_CHANGE, _currentPage.id);
						e.oldPageId = oldPage.id;
						dispatch(e);	
					}
				}
			}
			
			// create new page
			_currentPage = vo;
			
			if (oldPage != null) 
			{
				_oldPages.push(oldPage);
				
				// if current page is excluded and wanted page is parent
				if (oldPage.excluded && !_currentPage.excluded && _currentPage.id == oldPage.parent.id)
				{
					e = new PageEvent(PageEvent.PAGE_EXCLUDED_RESET, _currentPage.id);
					e.oldPageId = oldPage.id;
					dispatch(e);	
					
					SWFAddress.setValue(vo.urlFriendly.toLowerCase());
					
					return;
				}
			}
			
			// dispatch change event
			e = new PageEvent(PageEvent.ON_PAGE_CHANGE, _currentPage.id);
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
			
			if (!_hasStarted) 
			{
				MonsterDebugger.trace(this, "initial path: " + path, MonsterDebugger.COLOR_WARNING);
				if (path != "" && path != "/") _initialPath = path;
				return;	
			}
			
			// if is default path
			if ((path == "/" || path == "")) 
			{
				show();
				return;
			}
			
			var pid:String = _getPageIdFromPath(path);
			if (pid == null) show();
			else show(pid);
		} 
		
		/**
		 * Get a page id (or null) from a path
		 * @param path string with no preceding/ending slash
		 */
		protected function _getPageIdFromPath(path:String):String
		{
			if (path.substr(-1) == "/") path = path.substring(0, -1);
			if (path.substr(0, 1) == "/") path = path.substring(1);
			
			//			MonsterDebugger.trace(this, "_processUrlPath: " + path);
			var pageId:String = dataModel.getPageByUrl(path);
			//			MonsterDebugger.trace(this, "page found: " + pageId);
			return pageId;
		} 
		
		
		// PUBLIC
		//________________________________________________________________________________________________
		
		/**
		 * Show a page
		 * @param id page id (@id in sitemap.xml)
		 */
		public function show(id:String = null):void
		{
			MonsterDebugger.trace(this, "show: " + id, MonsterDebugger.COLOR_WARNING);
			if (!_hasStarted) _hasStarted = true;
			
			if (id == null) 
			{
				if (_initialPath != null)
				{
					var initPageId:String = _getPageIdFromPath(_initialPath);
					MonsterDebugger.trace(this, "use initial page: " + initPageId);
					_changePage(dataModel.getPageById(initPageId));
					_initialPath = null;
					return;
				}
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