package com.sitronnier.rlskeleton.views.mediators
{
	import com.sitronnier.rlskeleton.events.DataEvent;
	import com.sitronnier.rlskeleton.events.PageEvent;
	import com.sitronnier.rlskeleton.models.DataModel;
	import com.sitronnier.rlskeleton.models.FlowModel;
	import com.sitronnier.rlskeleton.views.components.menus.BasicMenu;
	import com.sitronnier.rlskeleton.views.components.pages.AbstractPage;
	import com.sitronnier.rlskeleton.vos.PageVO;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class RootMediator extends Mediator
	{		
		public static const BACKGROUND_LAYER:String = "BACKGROUND_LAYER";
		public static const PAGE_LAYER:String = "PAGE_LAYER";
		public static const MENU_LAYER:String = "MENU_LAYER";
		public static const TOP_LAYER:String = "TOP_LAYER";
		
		[Inject]
		public var flowModel:FlowModel;
		
		protected var _currentPage:AbstractPage;
		
		protected var _layers:Dictionary = new Dictionary();
		
		
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
		
		protected function _onInitData(event:DataEvent):void
		{
			_createLayers();
			_addMenu();
		}
		
		protected function _addMenu():void
		{
			var menu:BasicMenu = new BasicMenu();
			getLayer(MENU_LAYER).addChild(menu);
		}
		
		protected function _createLayers():void
		{
			contextView.addChild(_createLayer(BACKGROUND_LAYER));
			contextView.addChild(_createLayer(PAGE_LAYER));
			contextView.addChild(_createLayer(MENU_LAYER));
			contextView.addChild(_createLayer(TOP_LAYER));
		}
		
		protected function _createLayer(layerName:String):Sprite
		{
			var layer:Sprite = new Sprite();
			layer.name = layerName;
			return layer;
		}
		
		
		// PUBLIC
		//________________________________________________________________________________________________
		
		/**
		 * Returns a layer by its name
		 * @param name string constant (see RootMediator)
		 */
		public function getLayer(name:String):Sprite
		{
			return contextView.getChildByName(name) as Sprite;
		}
		
		override public function onRegister() : void
		{
			eventMap.mapListener(eventDispatcher, DataEvent.INITIAL_DATA_READY, _onInitData, DataEvent);
			eventMap.mapListener(eventDispatcher, PageEvent.ON_PAGE_CHANGE, _onPageChange);
			eventMap.mapListener(eventDispatcher, PageEvent.ON_TRANSITION_OUT_COMPLETE, _onTransitionOutComplete);
		}
		
		public function getRootView():DisplayObjectContainer
		{
			return contextView;
		} 
	}
}