package com.sitronnier.rlskeleton.services
{
	import br.com.stimuli.loading.BulkLoader;
	
	import com.sitronnier.rlskeleton.models.Errors;
	import com.sitronnier.rlskeleton.models.LoaderModel;
	import com.sitronnier.rlskeleton.models.StyleModel;
	
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.text.StyleSheet;
	
	import org.robotlegs.mvcs.Service;
	
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
	
	public class StyleService extends Service
	{
		[Inject]
		public var stylemodel:StyleModel;
		
		[Inject]
		public var loadermodel:LoaderModel;
		
		protected var _id:String;
		
		protected var _loaderRef:BulkLoader;
		
		
		public function StyleService()
		{
			super();
		}
		
		public function loadStyleSheet(id:String):void
		{
			_id = id;
			
			var url:String = "assets/css/" + id + ".css";
			
			// load site map xml
			_loaderRef = loadermodel.getLoader(LoaderModel.INITIAL);
			_loaderRef.add(url, {id:id});
			_loaderRef.get(id).addEventListener(Event.COMPLETE, _onComplete);
			_loaderRef.get(id).addEventListener(BulkLoader.ERROR, _onError);
			if (!_loaderRef.isRunning) _loaderRef.start()	
		} 
		
		protected function _onComplete(event:Event):void
		{
			// remove listeners
			_loaderRef.get(_id).removeEventListener(Event.COMPLETE, _onComplete);
			_loaderRef.get(_id).removeEventListener(BulkLoader.ERROR, _onError);
			
			// get the stylesheet and store it in model
			var ss:StyleSheet = new StyleSheet();
			ss.parseCSS(_loaderRef.getContent(_id, true));
			stylemodel.storeStyleSheet(_id, ss);
			
			// delete loader ref
			_loaderRef = null;
		}
		
		protected function _onError(event:ErrorEvent):void
		{
			throw Errors.getErrorWithParam(Errors.LOADING_PROBLEM, event.text);
		}
	}
}