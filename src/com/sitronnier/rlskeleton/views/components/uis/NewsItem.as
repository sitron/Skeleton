package com.sitronnier.rlskeleton.views.components.uis
{
	import com.sitronnier.rlskeleton.vos.PageVO;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	public class NewsItem extends Sprite
	{
		protected var _data:PageVO;
		protected var _bg:Shape = new Shape();
		protected var _label:TextField = new TextField();;
		
		public function NewsItem(data:PageVO)
		{
			super();
			
			_data = data;
			
			init();
		}
		
		public function init():void
		{
			_label.text = _data.title;
			_label.autoSize = TextFieldAutoSize.LEFT;
			_label.multiline = false;
			
			_bg.graphics.beginFill(0x00ff00);
			_bg.graphics.drawRect(0, 0, _label.width, _label.height);
			_bg.graphics.endFill();
			
			addChild(_bg);
			addChild(_label);
		} 	
		
		public function get data():PageVO
		{
			return _data;	
		} 
	}
}