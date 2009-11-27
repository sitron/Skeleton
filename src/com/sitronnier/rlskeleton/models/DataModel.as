package com.sitronnier.rlskeleton.models
{
	import com.sitronnier.rlskeleton.events.DataEvent;
	import com.sitronnier.rlskeleton.vos.PageVO;
	
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	
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
	 * Initial Developer are Copyright (C) 2009-2010 Sitronnier.com. All Rights Reserved.</p>
	 */
	
	public class DataModel extends Actor
	{
		// is there a better way to do this?
		public static const PAGE_PACKAGE:String = "com.sitronnier.rlskeleton.views.components.pages.";
		
		// reference to sitemap base xml
		protected var _sitemap:SitemapHelper;
		
		// contains all the pages (as PageVO, in an unordered way)
		protected var _pages:Dictionary = new Dictionary();
		
		// the default page, use on startup or if the request page is not valid
		protected var _defaultPage:PageVO;
		
		
		public function DataModel()
		{
			super();
		}
		
		// PROTECTED, PRIVATE
		//________________________________________________________________________________________________
		
		/**
		 * Split site map xml into page objects and page dictionary
		 */
		protected function _splitForPages(xml:XML = null):void
		{
			var b:XML = xml == null? _sitemap.data : xml;
			var pages:XMLList = b.descendants("page");
			
			for each (var page:XML in pages)
			{
				var pagevo:PageVO;
				var votype:String = page.@voType.toString();
				
				// create correct pagevo type
				// don't forget to include the necessary classes in the swf, otherwise you'll have a compile time error (anything then PageVO)
				if (page.@voType.toString() != "")
				{
					var clazz:Class = getDefinitionByName(page.@voType.toString()) as Class;
					pagevo = new clazz(page) as PageVO;
				}
				else
				{
					pagevo = new PageVO(page);
				}
				
				// if first make it default page (overriden after if a page is marked as @default)
				if (_defaultPage == null) _defaultPage = pagevo;
				
				if (_pages[pagevo.id] != null) 
				{
					throw Errors.getErrorWithParam(Errors.DUPLICATED_ID, pagevo.id);
				}
				
				// add to hash map
				_pages[pagevo.id] = pagevo;	
				
				// is default
				if (pagevo.isDefault) _defaultPage = pagevo;
				
				// store hierarchy info
				var parentname:String = XML(page.parent()).name().localName;
				if (parentname != "site")
				{
					var parentvo:PageVO = getPageById(page.parent().@id);
					parentvo.addChild(pagevo);
					pagevo.parent = parentvo;
				}
			}			 
		}
		
		
		// PUBLIC
		//________________________________________________________________________________________________
		
		/**
		 * Store site map data 
		 * @param xml data loaded from sitemap.xml
		 */
		public function storeSiteMap(xml:XML):void
		{
			_sitemap = new SitemapHelper(xml);
			_splitForPages();
			
			// not fantastic...
			_sitemap.pages = _pages;
			
			dispatch(new DataEvent(DataEvent.NEW_PAGE_DATA));
			
			// test
//			var homepage:PageVO = getPageById("Home");
//			var b:Boolean = _sitemap.shareSameVisibleParent("Portfolio_2_1", "Portfolio_2");
//			var p:PageVO = getNonExcludedParent(getPageById("Portfolio_2_1"));
		} 
		
		/**
		 * Get a PageVO by its id
		 * @param id (sitemap @id arg) of the wanted page
		 */
		public function getPageById(id:String):PageVO
		{
			return _pages[id] as PageVO;	
		} 
		
		/**
		 * Get default page (attribute @isDefault)
		 */
		public function getDefaultPage():PageVO
		{
			return _defaultPage;
		} 
		
		/**
		 * Get page by urlFriendly param
		 * @return PageVO id
		 */
		public function getPageByUrl(url:String):String
		{
			var item:XML = _sitemap.getPageItemByAttribute("urlfriendly", url);
			return item == null? null : item.@id;
		} 
					
		/**
		 * To know if 2 pages share the same non-excluded parent 
		 * @param page1 PageVO instance
		 * @param page2 PageVO instance
		 * @return Boolean indicating if the page share the same non-excluded parent
		 */	
		public function areBrotherPages(page1:PageVO, page2:PageVO):Boolean
		{
			return _sitemap.shareSameVisibleParent(page1.id, page2.id);
		} 
		
		/**
		 * To get the first non-excluded parent page 
		 * @param page instance of PageVO
		 * @return the parent PageVO
		 */		
		public function getNonExcludedParent(page:PageVO):PageVO
		{
			return _pages[_sitemap.getVisibleParentItem(page.id).@id.toString()];	
		} 
		
		/**
		 * Get children pages. 
		 * @param parent if null 1 level pages are returned
		 * @return Array of pages
		 */		
		public function getChildrenPages(parent:PageVO = null):Array
		{
			return _sitemap.getChildrenPages(parent);	
		} 
		
		/**
		 * Same as getChildrenPages but without the pages marked as "excluded" or "menuhidden" (see sitemap.xml)
		 * @param parent page if null 1 level pages are returned
		 */
		public function getChildrenNonExcludedPages(parent:PageVO = null):Array
		{
			return _sitemap.getChildrenNonExcludedPages(parent);	
		} 
	}
}