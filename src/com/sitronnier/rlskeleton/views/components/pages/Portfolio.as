package com.sitronnier.rlskeleton.views.components.pages
{
	import br.com.stimuli.loading.BulkLoader;
	
	import com.sitronnier.rlskeleton.views.components.uis.PorfolioItem;
	import com.sitronnier.rlskeleton.views.events.PageViewEvent;
	import com.sitronnier.rlskeleton.vos.PageVO;
	
	import flash.display.Sprite;
	import flash.events.Event;
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
	 * Initial Developer are Copyright (C) 2009-2010 Sitronnier.com. All Rights Reserved.</p>
	 */
	
	public class Portfolio extends BasePage
	{
		protected var _portfolioItems:Array = [];
		protected var _loader:BulkLoader;
		
		public function Portfolio(data:PageVO)
		{
			super(data);
		}
		
		
		// PROTECTED, PRIVATE
		//________________________________________________________________________________________________
		
		protected function _onItemClick(event:MouseEvent):void
		{
			var itemIndex:int = (event.currentTarget as PorfolioItem).index;
			var nextIndex:int = _getNextIndex(itemIndex);
			var nextId:String = PorfolioItem(_portfolioItems[nextIndex]).id
			dispatchEvent(new PageViewEvent(PageViewEvent.CHANGE_PAGE_REQUEST, nextId, true, true));
		} 
		
		protected function _getNextIndex(current:int):int
		{
			if (current < _portfolioItems.length - 1) return ++current;
			else return 0;
		} 
		
		protected function _showPorfolioItem(p:PageVO):void
		{
			// find corresponding item and show it
			for each (var item:PorfolioItem in _portfolioItems)
			{
				if (item.id == p.id) item.visible = true;
				else item.visible = false;
			}
		} 
		
		protected function _onItemLoaded(event:Event):void
		{
			var index:int = int(event.currentTarget.id);
			PorfolioItem(_portfolioItems[index]).setImage(_loader.getBitmap(String(index), true));
		} 
		
		
		// PUBLIC
		//________________________________________________________________________________________________
		
		override public function draw() : void
		{			
			alpha = 0;	
		}
		
		public function start():void
		{
			var itemsContainer:Sprite = new Sprite();
			addChild(itemsContainer);
			itemsContainer.x = 100;
			itemsContainer.y = 140;
			
			// for each excluded child create a link (this is just an example of how handling excluded pages can be done)
			var index:int = 0;
			for each (var p:PageVO in _data.excludedChildren)
			{
				var item:PorfolioItem = new PorfolioItem(p);
				item.index = index;
				item.addEventListener(MouseEvent.CLICK, _onItemClick, false, 0, true);
				item.buttonMode = true;
				item.mouseChildren = false;
				_portfolioItems.push(item);
				itemsContainer.addChild(item);
				item.visible = false;
				
				_loader.add(p.content.img.@src.toString(), {id:index});
				_loader.get(String(index)).addEventListener(Event.COMPLETE, _onItemLoaded);
				index++;
			}
			
			_loader.start();	
		} 
		
		public function set loader(l:BulkLoader):void
		{
			_loader = l;	
		} 
		
		override public function onPageExcluded(page:PageVO) : void
		{
			_showPorfolioItem(page);
		}
		
		override public function onPageExcludedReset(page:PageVO) : void
		{
			
		}
		
		override public function dispose() : void
		{			
			for each (var item:PorfolioItem in _portfolioItems)
			{
				item.removeEventListener(MouseEvent.CLICK, _onItemClick);
				item.parent.removeChild(item);
			}
			_portfolioItems.splice(0);
			
			super.dispose();
		}
	}
}