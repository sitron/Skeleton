package com.sitronnier.rlskeleton.models
{
	import com.sitronnier.rlskeleton.events.DataEvent;
	
	import flash.text.StyleSheet;
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
	 * Initial Developer are Copyright (C) 2009-2010 Sitronnier.com. All Rights Reserved.</p>
	 */
	
	public class StyleModel extends Actor
	{
		// stores all the style sheets
		protected var _stylesheets:Dictionary = new Dictionary();
		
		// global style sheet id
		public static const MAIN_ID:String = "main";
		
		public function StyleModel()
		{
			super();
		}
		
		public function storeStyleSheet(id:String, ss:StyleSheet):void
		{
			_stylesheets[id] = ss;	
			
			dispatch(new DataEvent(DataEvent.NEW_STYLESHEET_DATA));
		} 
		
		public function getStyleSheet(id:String = null):StyleSheet
		{
			if (id == null) return _stylesheets[MAIN_ID];
			return _stylesheets[id];
		} 
	}
}