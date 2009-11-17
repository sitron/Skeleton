package com.sitronnier.rlskeleton.models
{
	import br.com.stimuli.loading.BulkLoader;
	
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
	 * Thanks to Romuald Quantin for making his Soma project available (http://www.soundstep.com), great inspiration for this work. <br />
	 */
	
	public class LoaderModel extends Actor
	{
		public static const MAIN:String = "MAIN";
		public static const INITIAL:String = "INITIAL";
		
		protected var _loaders:Dictionary = new Dictionary();
		
		public function LoaderModel()
		{
			super();
		}
		
		public function getLoader(name:String = null):BulkLoader
		{
			if (name == null) 
			{
				if (_loaders[MAIN] == null) _loaders[MAIN] = new BulkLoader(MAIN);
				return _loaders[MAIN] as BulkLoader;	
			}
			else
			{
				if (_loaders[name] == null) 
				{
					var loader:BulkLoader = new BulkLoader(name); 
					_loaders[name] = loader;
				}
				return _loaders[name] as BulkLoader;	
			}
		} 
		
		public function disposeLoader(name:String):void
		{
			var loader:BulkLoader = _loaders[name];
			if (loader != null)
			{
				loader.clear();
				loader = null;
				_loaders[name] = null;
			}
		} 
	}
}