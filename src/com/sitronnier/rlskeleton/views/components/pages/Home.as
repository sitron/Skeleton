package com.sitronnier.rlskeleton.views.components.pages
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
	 * Initial Developer are Copyright (C) 2009-2010 Sitronnier.com. All Rights Reserved.</p>
	 */
	
	public class Home extends BasePage
	{
		protected var s:Sprite;
		
		public function Home(data:PageVO)
		{
			super(data);
			
			trace("home constructor");
		}
		
		
		// PROTECTED, PRIVATE
		//________________________________________________________________________________________________
				
		protected function _onShapeClick(event:MouseEvent):void
		{
			dispatchEvent(new PageViewEvent(PageViewEvent.CHANGE_PAGE_REQUEST, "News"));
		}
		
		
		// PUBLIC
		//________________________________________________________________________________________________
		
		override public function draw() : void
		{
			s = new Sprite();
			s.graphics.beginFill(0xff0000);
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