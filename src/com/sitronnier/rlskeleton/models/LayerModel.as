package com.sitronnier.rlskeleton.models
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	
	import org.robotlegs.mvcs.Actor;
	
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
	
	public class LayerModel extends Actor
	{
		public static const BACKGROUND_LAYER:String = "BACKGROUND_LAYER";
		public static const UI_LAYER:String = "UI_LAYER";
		public static const TOP_LAYER:String = "TOP_LAYER";
		
		protected var _layers:Dictionary = new Dictionary();
		protected var _rootLayer:DisplayObjectContainer;
		
		public function LayerModel()
		{
			super();
		}
		
		
		// PROTECTED, PRIVATE
		//________________________________________________________________________________________________
		
		protected function _createLayers():void
		{
			var background:Sprite = new Sprite();
			background.name = BACKGROUND_LAYER;
			_rootLayer.addChild(background);
			
			var ui:Sprite = new Sprite();
			ui.name = UI_LAYER;
			_rootLayer.addChild(ui);
			
			var top:Sprite = new Sprite();
			top.name = TOP_LAYER;
			_rootLayer.addChild(top);
		} 
		
		
		// PUBLIC
		//________________________________________________________________________________________________
		
		/**
		 * Returns layer by name
		 * @param name string constant (see LayerModel)
		 */
		public function getLayer(name:String):Sprite
		{
			return _rootLayer.getChildByName(name) as Sprite;
		}
		
		public function set rootLayer(d:DisplayObjectContainer):void
		{
			_rootLayer = d;
//			_createLayers();
		} 
	}
}