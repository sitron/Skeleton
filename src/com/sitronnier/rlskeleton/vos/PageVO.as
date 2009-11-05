package com.sitronnier.rlskeleton.vos
{
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
	
	public class PageVO
	{
		public var xmldata:XML;
		public var id:String;
		public var title:String;
		public var urlFriendly:String;
		public var excluded:Boolean;
		public var hiddenFromMenu:Boolean;
		public var isDefault:Boolean = false;
		public var type:String;
		public var content:XML;		
		public var children:Array = [];
		public var parent:PageVO;
		
		// helper result cache
		protected var _excludedChildren:Array;
		
		public function PageVO(xml:XML = null)
		{
			if (xml != null) _build(xml);
		}
		
		// PROTECTED, PRIVATE
		//________________________________________________________________________________________________
		
		protected function _build(xml:XML):void
		{
			xmldata = xml;
			id = xml.@id.toString();
			type = xml.@type.toString();
			excluded = xml.@excluded.toString() == "true"? true:false;
			hiddenFromMenu = xml.@menuhidden.toString() == "true"? true:false;
			urlFriendly = xml.@urlfriendly != null? xml.@urlfriendly.toString() : "";
			isDefault = xml.@isDefault != null? xml.@isDefault.toString() : false;
			title = xml.title != null? xml.title : "";
			content = xml.content[0] is XML? xml.content[0] : null;
		}
		
		// PUBLIC
		//________________________________________________________________________________________________
		
		/**
		 * So that each page has a ref to its children
		 */
		public function addChild(page:PageVO):void
		{
			refresh();
			children.push(page);
		} 
		
		/**
		 * Helper method to know if a page has visible children (could be useful for menus for ex.)
		 */
		public function hasNonExcludedChildren():Boolean
		{
			if (nbChildren == 0) return false;
			for each (var p:PageVO in children)
			{
				if (!p.excluded && !p.hiddenFromMenu) return true;
			}
			return false;
		} 
		
		/**
		 * Helper method to get all excluded children
		 */
		public function get excludedChildren():Array
		{
			if (_excludedChildren != null) return _excludedChildren;
			_excludedChildren = [];
			for each (var p:PageVO in children)
			{
				if (p.excluded) _excludedChildren.push(p);
			}
			return _excludedChildren;
		} 
		
		/**
		 * Helper
		 */
		public function get nbChildren():int
		{
			return children.length;	
		} 
		
		/**
		 * If new data is added on the fly (after initialization) clear caches
		 */
		public function refresh():void
		{
			_excludedChildren = null;
		} 
	}
}