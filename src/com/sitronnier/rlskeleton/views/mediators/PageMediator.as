package com.sitronnier.rlskeleton.views.mediators
{
	import com.sitronnier.rlskeleton.events.PageEvent;
	import com.sitronnier.rlskeleton.models.FlowModel;
	import com.sitronnier.rlskeleton.views.components.pages.AbstractPage;
	import com.sitronnier.rlskeleton.views.events.PageViewEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class PageMediator extends Mediator
	{
//		[Inject]
//		public var pageView:AbstractPage;
		
		[Inject]
		public var flowModel:FlowModel;
		
		public function PageMediator()
		{
			super();
		}
		
		// PROTECTED, PRIVATE
		//________________________________________________________________________________________________
		
		protected function _onPageChange(event:PageEvent):void
		{
			if (event.oldPageId == pageView.id) pageView.transitionOut();
		}
		
		protected function _onTransitionOutComplete(event:PageEvent):void
		{
			if (flowModel.currentPage.id == pageView.id) pageView.transitionIn();
		}
		
		protected function _onPageTransitionOutComplete(event:PageViewEvent):void
		{
			dispatchEvent(new PageEvent(PageEvent.ON_TRANSITION_OUT_COMPLETE, event.pageId));
		}
		
		protected function _onChangePageRequest(event:PageViewEvent):void
		{
			dispatchEvent(new PageEvent(PageEvent.CHANGE_PAGE_REQUEST, event.pageId));
		}
		
		
		// PUBLIC
		//________________________________________________________________________________________________
		
		public function get pageView():AbstractPage
		{
			return viewComponent as AbstractPage;
		} 
		
		override public function onRegister() : void
		{
			addEventListenerTo(eventDispatcher, PageEvent.ON_PAGE_CHANGE, _onPageChange);
			addEventListenerTo(eventDispatcher, PageEvent.ON_TRANSITION_OUT_COMPLETE, _onTransitionOutComplete);
			
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