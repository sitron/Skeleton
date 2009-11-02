package com.sitronnier.rlskeleton.models
{
	import com.sitronnier.rlskeleton.events.DataEvent;
	import com.sitronnier.rlskeleton.vos.PageVO;
	
	import flash.utils.Dictionary;
	
	import nl.demonsters.debugger.MonsterDebugger;
	
	import org.robotlegs.mvcs.Model;
	
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
	
	public class DataModel extends Model
	{
		// is there a better way to do this?
		public static const PAGE_PACKAGE:String = "com.sitronnier.rlskeleton.views.components.pages.";
		
		// reference to sitemap base xml
		protected var _sitemap:XML;
		
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
			var b:XML = xml == null? _sitemap : xml;
			var pages:XMLList = b.descendants("page");
			
			for each (var page:XML in pages)
			{
				var pagevo:PageVO = new PageVO(page);
				if (_defaultPage == null) _defaultPage = pagevo;
				
				if (_pages[pagevo.id] != null) 
				{
					throw Errors.getErrorWithParam(Errors.DUPLICATED_ID, pagevo.id);
				}
				_pages[pagevo.id] = pagevo;	
				
				if (pagevo.isDefault) _defaultPage = pagevo;
				
				var parentname:String = XML(page.parent()).name().localName;
				if (parentname != "site")
				{
					var parentvo:PageVO = getPageById(page.parent().@id);
					parentvo.addChild(pagevo);
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
			_sitemap = xml;
			_splitForPages();
			
			dispatchEvent(new DataEvent(DataEvent.NEW_PAGE_DATA));
			
			var homepage:PageVO = getPageById("Home");
		} 
		
		/**
		 * Get a PageVO by its id
		 * @param id (sitemap @id arg) of the wanted page
		 */
		public function getPageById(id:String):PageVO
		{
			return _pages[id];	
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
			var xmllist:XMLList = _sitemap.descendants("page").((@urlfriendly.toString()).toLowerCase()==url.toLowerCase());
			MonsterDebugger.trace(this, xmllist);
			if (xmllist.length() == 0) return null;
			var xml:XML = xmllist[0] as XML;
			var id:String = xml.@id;
			return id;
		} 
	}
}