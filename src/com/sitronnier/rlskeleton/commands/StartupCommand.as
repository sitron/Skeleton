package com.sitronnier.rlskeleton.commands
{
	import br.com.stimuli.loading.BulkLoader;
	
	import com.sitronnier.rlskeleton.events.DataEvent;
	import com.sitronnier.rlskeleton.models.DataModel;
	import com.sitronnier.rlskeleton.models.FlowModel;
	import com.sitronnier.rlskeleton.models.LayerModel;
	import com.sitronnier.rlskeleton.models.LoaderModel;
	import com.sitronnier.rlskeleton.models.StyleModel;
	import com.sitronnier.rlskeleton.services.SitemapService;
	import com.sitronnier.rlskeleton.services.StyleService;
	import com.sitronnier.rlskeleton.views.components.pages.Contact;
	import com.sitronnier.rlskeleton.views.components.pages.Home;
	import com.sitronnier.rlskeleton.views.components.pages.News;
	import com.sitronnier.rlskeleton.views.mediators.PageMediator;
	import com.sitronnier.rlskeleton.views.mediators.RootMediator;
	
	import flash.events.Event;
	
	import org.robotlegs.mvcs.Command;
	
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
	 * This work was inspired by the Soma project (thanks to Romuald Quantin for making it available). Check it on http://www.soundstep.com/<br />
	 */
	
	public class StartupCommand extends Command
	{
		[Inject]
		public var loaderModel:LoaderModel;
		
		
		public function StartupCommand()
		{
			super();
		}
		
		override public function execute() : void
		{
			// create needed models
			injector.mapSingleton(DataModel);
			injector.mapSingleton(StyleModel);
			injector.mapSingleton(LayerModel);
			injector.mapSingleton(FlowModel);
			
			// create needed services
			injector.mapSingleton(SitemapService);
			injector.mapSingleton(StyleService);
			
			// register main view and its mediator
			mediatorMap.mapView(Skeleton, RootMediator);
			mediatorMap.createMediator(contextView);
			
			// register needed views
//			mediatorMap.mapView(AbstractPage, PageMediator); // this is never wired as page is a subclass of AbstractPage (is this normal?)
			mediatorMap.mapView(Home, PageMediator);
			mediatorMap.mapView(News, PageMediator);
			mediatorMap.mapView(Contact, PageMediator);
			
			// get base data
			loaderModel.getLoader(LoaderModel.INITIAL).addEventListener(BulkLoader.COMPLETE, _onInitialDataLoaded);
			dispatchEvent(new DataEvent(DataEvent.LOAD_SITEMAP));
			dispatchEvent(new DataEvent(DataEvent.LOAD_STYLESHEET));
		}
		
		protected function _onInitialDataLoaded(event:Event):void
		{
			loaderModel.getLoader(LoaderModel.INITIAL).removeEventListener(BulkLoader.COMPLETE, _onInitialDataLoaded);
			loaderModel.disposeLoader(LoaderModel.INITIAL);
			dispatchEvent(new DataEvent(DataEvent.INITIAL_DATA_READY));
		}
	}
}