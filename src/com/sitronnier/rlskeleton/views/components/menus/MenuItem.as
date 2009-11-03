package com.sitronnier.rlskeleton.views.components.menus
{
	import com.sitronnier.rlskeleton.vos.PageVO;
	
	import flash.display.Shape;
	import flash.display.Sprite;
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
	 * Initial Developer are Copyright (C) 2008-2009 Sitronnier.com. All Rights Reserved.</p>
	 *
	 * Thanks to Romuald Quantin for making his Soma project available (http://www.soundstep.com), great inspiration for this work. <br />
	 */
	
	public class MenuItem extends Sprite
	{
		public static const STATE_SELECTED:String = "selected";
		public static const STATE_UN_SELECTED:String = "unselected";
		
		protected var _page:PageVO;
		protected var _label:TextField;
		
		public function MenuItem(pageRef:PageVO)
		{
			super();
			
			_page = pageRef;
			
			var bg:Shape = new Shape();
			bg.graphics.beginFill(0xff9900);
			bg.graphics.drawRect(0, 0, 10, 10);
			bg.graphics.endFill();
			addChild(bg);
			
			_label = new TextField();
			_label.multiline = false;
			_label.autoSize = TextFieldAutoSize.LEFT;
			_label.text = _page.title;
			addChild(_label);
			
			bg.width = _label.width;
			bg.height = _label.height;
		}
		
		public function set state(s:String):void
		{
			if (s == STATE_SELECTED)
			{
				_label.textColor = 0xffffff;
			}
			else _label.textColor = 0x000000;
		} 
		
		public function get page():PageVO
		{
			return _page;	
		} 
	}
}