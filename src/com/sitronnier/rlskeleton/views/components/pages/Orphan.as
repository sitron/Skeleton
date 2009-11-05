package com.sitronnier.rlskeleton.views.components.pages
{
	import com.sitronnier.rlskeleton.views.events.PageViewEvent;
	import com.sitronnier.rlskeleton.vos.PageVO;
	
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	public class Orphan extends BasePage
	{
		protected var _text:TextField;
		
		public function Orphan(data:PageVO)
		{
			super(data);
			
			trace("orphan constructor");
		}
		
		// PROTECTED, PRIVATE
		//________________________________________________________________________________________________
		
		protected function _onShapeClick(event:MouseEvent):void
		{
			dispatchEvent(new PageViewEvent(PageViewEvent.CHANGE_PAGE_REQUEST, "Home"));
		}
		
		
		// PUBLIC
		//________________________________________________________________________________________________
		
		override public function draw() : void
		{
			_text = new TextField();
			_text.x = 150;
			_text.y = 140;
			addChild(_text);
			_text.autoSize = TextFieldAutoSize.LEFT;
			_text.multiline = true;
			_text.width = 200;
			_text.htmlText = _data.title;
		}
		
		override public function dispose() : void
		{
			removeChild(_text);
			_text = null;
			
			super.dispose();
		}
	}
}