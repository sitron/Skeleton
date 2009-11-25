package com.sitronnier.rlskeleton.models
{
	import com.sitronnier.rlskeleton.vos.PageVO;
	
	import flash.utils.Dictionary;
	

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
	
	public class SitemapHelper
	{
		protected var _originalData:XML;
		
		// contains all the pages (as PageVO, in an unordered way)
		protected var _pages:Dictionary = new Dictionary();
		
		
		public function SitemapHelper(data:XML = null)
		{
			if (data != null) this.data = data;	
		}
		
		
		// PROTECTED, PRIVATE
		//________________________________________________________________________________________________
		
		
		
		
		// PUBLIC
		//________________________________________________________________________________________________
		
		public function getPageItemByAttribute(attribute:String, value:String, xml:XML = null):XML
		{
			var base:XML = (xml == null)? _originalData : xml;
			var xmllist:XMLList = base.descendants("page").((@[attribute].toString()).toLowerCase()==value.toLowerCase());
			if (xmllist.length() == 0) return null;
			return xmllist[0] as XML;
		} 
		
		public function shareSameVisibleParent(id1:String, id2:String):Boolean
		{
			var p1:XML = getVisibleParentItem(id1);
			var p2:XML = getVisibleParentItem(id2);
			return (p1.@id == p2.@id); 
		} 
		
		public function getVisibleParentItem(id:String):XML
		{
			var xml:XML = getPageItemByAttribute("id", id);
			if (xml.parent().@excluded.toString() == "true") return getVisibleParentItem(xml.parent().@id.toString());
			else return xml.parent();
		} 
		
		public function getChildrenPages(parent:PageVO = null):Array
		{
			var a:Array = [];
			if (parent == null)
			{
				var list:XMLList = getFirstLevelPages();
				for each (var listItem:XML in list)
				{
					a.push(getPageById(listItem.@id.toString()));
				}
				return a;
			}
			return parent.children;		
		} 
		
		public function getChildrenNonExcludedPages(parent:PageVO = null):Array
		{
			var a:Array = [];
			if (parent == null)
			{
				var list:XMLList = getFirstLevelPages();
				for each (var listItem:XML in list)
				{
					if (listItem.@excluded.toString() != "true" && listItem.@menuhidden.toString() != "true") a.push(getPageById(listItem.@id.toString()));
				}
			}
			else
			{
				for each (var page:PageVO in parent.children)
				{
					if (!page.excluded && !page.hiddenFromMenu) a.push(page);
				}	
			}
			return a;			
		} 
		
		public function getPageById(id:String):PageVO
		{
			return _pages[id];	
		} 
		
		public function getFirstLevelPages():XMLList
		{
			return _originalData.child("page");
		} 
		
		public function set data(xml:XML):void
		{
			_originalData = xml;
		} 
		
		public function get data():XML
		{
			return _originalData;	
		} 
		
		public function set pages(d:Dictionary):void
		{
			_pages = d;
		} 
	}
}