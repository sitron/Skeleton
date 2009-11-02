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
	 * THANKS a lot to Romuald Quantin for making his Soma project available. <br />
	 * Big part of this project is derived from his work. Check it on http://www.soundstep.com/
	 */
	
	public class PageVO
	{
		public var xmldata:XML;
		public var id:String;
		public var title:String;
		public var urlFriendly:String;
		public var isDefault:Boolean = false;
		public var type:String;
		public var content:XML;		
		public var children:Array = [];
		public var nbChildren:int = 0;
		
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
			children.push(page);
			nbChildren = children.length;
		} 
	}
}