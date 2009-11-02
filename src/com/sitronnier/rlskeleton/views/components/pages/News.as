package com.sitronnier.rlskeleton.views.components.pages
{
	import com.sitronnier.rlskeleton.views.events.PageViewEvent;
	import com.sitronnier.rlskeleton.vos.PageVO;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class News extends BasePage
	{
		protected var s:Sprite;
		
		public function News(data:PageVO)
		{
			super(data);
			
			trace("news constructor");
		}
		
		
		// PROTECTED, PRIVATE
		//________________________________________________________________________________________________
		
		protected function _onShapeClick(event:MouseEvent):void
		{
			dispatchEvent(new PageViewEvent(PageViewEvent.CHANGE_PAGE_REQUEST, "Contact"));
		}
		
		
		// PUBLIC
		//________________________________________________________________________________________________
		
		override public function draw() : void
		{
			s = new Sprite();
			s.graphics.beginFill(0xff9900);
			s.graphics.drawRect(0, 0, 20, 20);
			s.graphics.endFill();
			s.x = Math.random() * 500;
			s.y = Math.random() * 300;
			addChild(s);
			s.addEventListener(MouseEvent.CLICK, _onShapeClick);
			s.buttonMode = true;
			
			alpha = 0;	
		}
		
		override public function dispose() : void
		{			
			s.removeEventListener(MouseEvent.CLICK, _onShapeClick);
			removeChild(s);
			s = null;
			
			super.dispose();
		}
	}
}