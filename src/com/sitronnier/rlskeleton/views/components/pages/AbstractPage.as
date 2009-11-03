package com.sitronnier.rlskeleton.views.components.pages
{
	import com.sitronnier.rlskeleton.views.events.PageViewEvent;
	import com.sitronnier.rlskeleton.vos.PageVO;
	
	import flash.display.MovieClip;
	
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
	
	public class AbstractPage extends MovieClip
	{
		protected var _data:PageVO;
		protected var _pageXml:XML;
		protected var _id:String;
		
		public function AbstractPage(data:PageVO)
		{
			_data = data;
			_pageXml = _data.xmldata;
			_id = _data.id;
			
			super();
		}
		
		
		// PROTECTED, PRIVATE
		//________________________________________________________________________________________________
		
		protected function _onTransitionInOver():void
		{
			dispatchEvent(new PageViewEvent(PageViewEvent.ON_TRANSITION_IN_COMPLETE, _id));
		}
		
		protected function _onTransitionOutOver():void
		{
			dispatchEvent(new PageViewEvent(PageViewEvent.ON_TRANSITION_OUT_COMPLETE, _id));
		}
		
		
		// PUBLIC
		//________________________________________________________________________________________________
		
		public function draw():void
		{
			
		} 
		
		public function initialize():void
		{
			dispatchEvent(new PageViewEvent(PageViewEvent.INITIALIZED, _id));			
			draw();
		} 
		
		public function get id():String
		{
			return _id;
		} 
		
		public function transitionIn():void
		{
			dispatchEvent(new PageViewEvent(PageViewEvent.ON_TRANSITION_IN_START, _id));
			
			// override and do transition here, than call _onTransitionInOver
		} 
		
		public function transitionOut():void
		{
			dispatchEvent(new PageViewEvent(PageViewEvent.ON_TRANSITION_OUT_START, _id));
			
			// override and do transition here, than call _onTransitionOutOver
		} 
		
		public function dispose():void
		{
			trace("dispose page: " + _data.id);
		} 
	}
}