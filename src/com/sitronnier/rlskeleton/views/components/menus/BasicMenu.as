package com.sitronnier.rlskeleton.views.components.menus
{
	import com.sitronnier.rlskeleton.views.events.PageViewEvent;
	import com.sitronnier.rlskeleton.vos.PageVO;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
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
	
	public class BasicMenu extends Sprite
	{
		// THIS IS JUST A BASIC IMPLEMENTATION OF A 1 LEVEL MENU
		// TODO: implement a tree menu
		
		protected static const VERTICAL_SEP:Number = 1;
		protected var _data:Array = [];
		protected var _items:Array = [];
		
		public function BasicMenu()
		{
			super();
		}
		
		// PROTECTED, PRIVATE
		//________________________________________________________________________________________________
		
		/**
		 * Draw menu
		 */
		protected function _draw():void
		{
			var h:Number = 0;
			for each (var page:PageVO in _data)
			{
				var menuItem:MenuItem = new MenuItem(page);
				menuItem.buttonMode = true;
				menuItem.mouseChildren = false;
				addChild(menuItem);
				menuItem.addEventListener(MouseEvent.CLICK, _onItemClick);
				_items.push(menuItem);
				menuItem.y = h;
				h += menuItem.height + VERTICAL_SEP;
			}
		}
		
		protected function _onItemClick(event:MouseEvent):void
		{
			var page:PageVO = (event.currentTarget as MenuItem).page;
			dispatchEvent(new PageViewEvent(PageViewEvent.CHANGE_PAGE_REQUEST, page.id));
		}
		
		
		// PUBLIC
		//________________________________________________________________________________________________
		
		/**
		 * update menu data, called only on startup (automatic) or when new pages are added (should be called manually in this case)
		 */
		public function update(a:Array):void
		{
			_data = a;
			_draw();
		} 
		
		/**
		 * On page change, update menu state
		 */
		public function updateSelection(selectedPage:PageVO):void
		{
			if (selectedPage.excluded && selectedPage.parent != null) var excludedParent:PageVO = selectedPage.parent;
			
			var item:MenuItem;
			for (var i:int=0; i<_items.length; i++)
			{
				item = _items[i] as MenuItem;
				if (item.page.id == selectedPage.id) item.state = MenuItem.STATE_SELECTED;
				else if (excludedParent != null && item.page.id == excludedParent.id) item.state = MenuItem.STATE_SELECTED;  
				else item.state = MenuItem.STATE_UN_SELECTED;
			}
		} 
	}
}