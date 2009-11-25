package com.sitronnier.rlskeleton.views.components.uis
{
	import com.sitronnier.rlskeleton.vos.PageVO;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	
	public class PorfolioItem extends Sprite
	{
		protected var _data:PageVO;
		protected var _index:int;
		
		public function PorfolioItem(p:PageVO)
		{
			_data = p;
			
			super();
		}
		
		
		// PUBLIC
		//________________________________________________________________________________________________
		
		public function setImage(bm:Bitmap):void
		{
			addChild(bm);	
		} 
		
		public function set index(n:int):void
		{
			_index = n;	
		} 
		
		public function get index():int
		{
			return _index;
		} 
		
		public function get data():PageVO
		{
			return _data;
		}
		
		public function get id():String
		{
			return _data.id;
		} 
	}	
}