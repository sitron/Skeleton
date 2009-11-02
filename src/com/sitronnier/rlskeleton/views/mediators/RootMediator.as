package com.sitronnier.rlskeleton.views.mediators
{
	import com.sitronnier.rlskeleton.events.PageEvent;
	import com.sitronnier.rlskeleton.models.DataModel;
	import com.sitronnier.rlskeleton.models.FlowModel;
	import com.sitronnier.rlskeleton.views.components.pages.AbstractPage;
	import com.sitronnier.rlskeleton.vos.PageVO;
	
	import flash.display.DisplayObjectContainer;
	import flash.utils.getDefinitionByName;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class RootMediator extends Mediator
	{
		[Inject]
		public var flowModel:FlowModel;
		
		protected var _currentPage:AbstractPage;
		
		public function RootMediator()
		{
			super();
		}
		
		// PROTECTED, PRIVATE
		//________________________________________________________________________________________________
		
		protected function _onPageChange(event:PageEvent):void
		{
			var currentPageVO:PageVO = flowModel.currentPage;
			var clazz:Class = getDefinitionByName(DataModel.PAGE_PACKAGE + currentPageVO.type) as Class;
			_currentPage = new clazz(currentPageVO) as AbstractPage;
			_currentPage.initialize();
			contextView.addChild(_currentPage);
		}
		
		protected function _onTransitionOutComplete(event:PageEvent):void
		{
			for (var i:int=0; i<contextView.numChildren; i++)
			{
				var c:* = contextView.getChildAt(i);
				if (c is AbstractPage && AbstractPage(c).id == event.pageId) 
				{
					contextView.removeChild(c);
					AbstractPage(c).dispose();
					c = null;
				}
			}
		}
		
		
		// PUBLIC
		//________________________________________________________________________________________________
		
		override public function onRegister() : void
		{
			eventMap.mapListener(eventDispatcher, PageEvent.ON_PAGE_CHANGE, _onPageChange);
			eventMap.mapListener(eventDispatcher, PageEvent.ON_TRANSITION_OUT_COMPLETE, _onTransitionOutComplete);
		}
		
		public function getRootView():DisplayObjectContainer
		{
			return contextView;
		} 
	}
}