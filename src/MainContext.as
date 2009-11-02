package
{
	import com.sitronnier.rlskeleton.commands.LoadSiteMapCommand;
	import com.sitronnier.rlskeleton.commands.LoadStyleSheetCommand;
	import com.sitronnier.rlskeleton.commands.OnInitialDataReady;
	import com.sitronnier.rlskeleton.commands.PageChangeRequest;
	import com.sitronnier.rlskeleton.commands.StartupCommand;
	import com.sitronnier.rlskeleton.events.DataEvent;
	import com.sitronnier.rlskeleton.events.PageEvent;
	import com.sitronnier.rlskeleton.models.LoaderModel;
	import com.sitronnier.rlskeleton.views.components.pages.AbstractPage;
	import com.sitronnier.rlskeleton.views.components.pages.Contact;
	import com.sitronnier.rlskeleton.views.components.pages.Home;
	import com.sitronnier.rlskeleton.views.components.pages.News;
	
	import flash.display.DisplayObjectContainer;
	
	import org.robotlegs.base.ContextEvent;
	import org.robotlegs.mvcs.Context;
	
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
	 * Big part of this project is inspired by his work. Check it on http://www.soundstep.com/
	 */
	
	public class MainContext extends Context
	{		
		
		public function MainContext(contextView:DisplayObjectContainer, autoStartup:Boolean=true)
		{
			super(contextView, autoStartup);
		}
		
		override public function startup() : void
		{
			// create loader model
			injector.mapSingleton(LoaderModel);
			
			commandMap.mapEvent(StartupCommand, ContextEvent.STARTUP, ContextEvent, true);
			commandMap.mapEvent(LoadSiteMapCommand, DataEvent.LOAD_SITEMAP, DataEvent, false);
			commandMap.mapEvent(LoadStyleSheetCommand, DataEvent.LOAD_STYLESHEET, DataEvent, false);
			commandMap.mapEvent(OnInitialDataReady, DataEvent.INITIAL_DATA_READY, DataEvent, false);
			commandMap.mapEvent(PageChangeRequest, PageEvent.CHANGE_PAGE_REQUEST, PageEvent, false);
						
			dispatchEvent(new ContextEvent(ContextEvent.STARTUP));
		}
	}
}