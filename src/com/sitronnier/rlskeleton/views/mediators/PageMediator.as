package com.sitronnier.rlskeleton.views.mediators
{
	import com.sitronnier.rlskeleton.events.PageEvent;
	import com.sitronnier.rlskeleton.models.DataModel;
	import com.sitronnier.rlskeleton.models.FlowModel;
	import com.sitronnier.rlskeleton.views.components.pages.AbstractPage;
	import com.sitronnier.rlskeleton.views.events.PageViewEvent;
	import com.sitronnier.rlskeleton.vos.PageVO;
	
	import org.robotlegs.mvcs.Mediator;
	
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
	
	public class PageMediator extends Mediator
	{		
		[Inject]
		public var flowModel:FlowModel;
		
		[Inject]
		public var dataModel:DataModel;
		
		public function PageMediator()
		{
			super();
		}
		
		// PROTECTED, PRIVATE
		//________________________________________________________________________________________________
		
		// System event handlers
		
		protected function _onPageChange(event:PageEvent):void
		{
			if (flowModel.currentPage.excluded)
			{
				
			}
			else 
			{
				pageView.transitionOut();	
			}
		}
		
		protected function _onPageWillChange(event:PageEvent):void
		{	
			if (event.pageId == pageView.id && pageView.willBeRemoved) 
			{
				event.preventDefault();	
			}
		} 
		
		protected function _onPageExcluded(event:PageEvent):void
		{
			var page:PageVO = dataModel.getPageById(event.pageId);
			pageView.onPageExcluded(page);
		} 
		
		protected function _onPageExcludedReset(event:PageEvent):void
		{
			var page:PageVO = dataModel.getPageById(event.pageId);
			pageView.onPageExcludedReset(page);
		} 
		
		/**
		 * Triggered when old page finishes its out-transition 
		 * @param event
		 */		
		protected function _onTransitionOutComplete(event:PageEvent):void
		{
			// TODO: the excluded model is very fragile: what if the current page is 2 depths away from non-excluded page?
			if (flowModel.currentPage.id == pageView.id) pageView.transitionIn();
			else if (flowModel.currentPage.excluded && flowModel.currentPage.parent.id == pageView.id)
			{
				pageView.transitionIn();
			}
			else{}
		}
		
		
		// View event handlers
		
		protected function _onPageTransitionOutComplete(event:PageViewEvent):void
		{
			dispatch(new PageEvent(PageEvent.ON_TRANSITION_OUT_COMPLETE, event.pageId));
		}
		
		protected function _onChangePageRequest(event:PageViewEvent):void
		{
			dispatch(new PageEvent(PageEvent.CHANGE_PAGE_REQUEST, event.pageId));
		}
		
		
		// PUBLIC
		//________________________________________________________________________________________________
		
		public function get pageView():AbstractPage
		{
			return viewComponent as AbstractPage;
		} 
		
		override public function onRegister() : void
		{
			eventMap.mapListener(eventDispatcher, PageEvent.PAGE_WILL_CHANGE, _onPageWillChange);
			eventMap.mapListener(eventDispatcher, PageEvent.ON_PAGE_CHANGE, _onPageChange);
			eventMap.mapListener(eventDispatcher, PageEvent.ON_TRANSITION_OUT_COMPLETE, _onTransitionOutComplete);
			eventMap.mapListener(eventDispatcher, PageEvent.PAGE_EXCLUDED, _onPageExcluded);
			eventMap.mapListener(eventDispatcher, PageEvent.PAGE_EXCLUDED_RESET, _onPageExcludedReset);
			
			pageView.addEventListener(PageViewEvent.CHANGE_PAGE_REQUEST, _onChangePageRequest);
			pageView.addEventListener(PageViewEvent.ON_TRANSITION_OUT_COMPLETE, _onPageTransitionOutComplete);
			
			super.onRegister();
		}
		
		override public function onRemove() : void
		{
			pageView.removeEventListener(PageViewEvent.CHANGE_PAGE_REQUEST, _onChangePageRequest);
			pageView.removeEventListener(PageViewEvent.ON_TRANSITION_OUT_COMPLETE, _onPageTransitionOutComplete);
			
			super.onRemove();
		}
	}
}