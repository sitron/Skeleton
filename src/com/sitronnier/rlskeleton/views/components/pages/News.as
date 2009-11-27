package com.sitronnier.rlskeleton.views.components.pages
{
	import com.sitronnier.rlskeleton.views.components.uis.NewsItem;
	import com.sitronnier.rlskeleton.views.events.PageViewEvent;
	import com.sitronnier.rlskeleton.vos.PageVO;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
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
	
	public class News extends BasePage
	{
		protected var _title:TextField;
		protected var _newsItems:Array = [];
		protected var _newsTextContainer:TextField;
		
		public function News(data:PageVO)
		{
			super(data);
			
			trace("news constructor");
		}
		
		
		// PROTECTED, PRIVATE
		//________________________________________________________________________________________________
		
		protected function _onNewsClick(event:MouseEvent):void
		{
			var vo:PageVO = (event.currentTarget as NewsItem).data; 
			dispatchEvent(new PageViewEvent(PageViewEvent.CHANGE_PAGE_REQUEST, vo.id));
		}
		
		protected function _showNews(p:PageVO):void
		{
			if (_newsTextContainer != null) 
			{
				removeChild(_newsTextContainer);
				_newsTextContainer = null;
			}
			_newsTextContainer = new TextField();
			_newsTextContainer.x = 250;
			_newsTextContainer.y = 140;
			addChild(_newsTextContainer);
			_newsTextContainer.autoSize = TextFieldAutoSize.LEFT;
			_newsTextContainer.multiline = true;
			_newsTextContainer.width = 200;
			_newsTextContainer.htmlText = p.content.text.toString();
		} 
		
		protected function _resetNews():void
		{
			trace("reset news");
		} 
		
		
		// PUBLIC
		//________________________________________________________________________________________________
		
		override public function draw() : void
		{
			_title = new TextField();
			_title.text = "NEWS";
			_title.x = 100;
			_title.y = 100;
			addChild(_title);
			
			var h:Number = 0;
			var newsContainer:Sprite = new Sprite();
			addChild(newsContainer);
			newsContainer.x = 100;
			newsContainer.y = 140;
			
			// for each excluded child create a link (this is just an example of how handling excluded pages can be done)
			for each (var p:PageVO in _data.excludedChildren)
			{
				var newsitem:NewsItem = new NewsItem(p);
				newsitem.addEventListener(MouseEvent.CLICK, _onNewsClick, false, 0, true);
				newsitem.buttonMode = true;
				newsitem.mouseChildren = false;
				_newsItems.push(newsitem);
				newsContainer.addChild(newsitem);
				newsitem.y = h;
				h += newsitem.height + 2;
			}
			
			alpha = 0;	
		}
		
		override public function onPageExcluded(page:PageVO) : void
		{
			_showNews(page);
		}
		
		override public function onPageExcludedReset(page:PageVO) : void
		{
			_resetNews();
		}
		
		override public function dispose() : void
		{			
			for each (var item:NewsItem in _newsItems)
			{
				item.removeEventListener(MouseEvent.CLICK, _onNewsClick);
				item.parent.removeChild(item);
			}
			_newsItems.splice(0);
			_title = null;
			
			super.dispose();
		}
	}
}