package com.sitronnier.rlskeleton.views.mediators
{
	import com.sitronnier.rlskeleton.events.DataEvent;
	import com.sitronnier.rlskeleton.events.PageEvent;
	import com.sitronnier.rlskeleton.models.DataModel;
	import com.sitronnier.rlskeleton.models.Errors;
	import com.sitronnier.rlskeleton.models.FlowModel;
	import com.sitronnier.rlskeleton.views.components.menus.BasicMenu;
	import com.sitronnier.rlskeleton.views.components.pages.AbstractPage;
	import com.sitronnier.rlskeleton.vos.PageVO;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.ContextMenuEvent;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	
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
	
	public class RootMediator extends Mediator
	{		
		public static const BACKGROUND_LAYER:String = "BACKGROUND_LAYER";
		public static const PAGE_LAYER:String = "PAGE_LAYER";
		public static const MENU_LAYER:String = "MENU_LAYER";
		public static const TOP_LAYER:String = "TOP_LAYER";
		
		[Inject]
		public var flowModel:FlowModel;
		
		[Inject]
		public var dataModel:DataModel;
		
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
			if (currentPageVO.type == null && !currentPageVO.excluded) 
			{
				throw Errors.getErrorWithParam(Errors.NO_CLASS_TYPE_DEFINED, currentPageVO.id);
				return;
			} 
			
			if (currentPageVO.excluded)
			{
				dispatch(new PageEvent(PageEvent.PAGE_EXCLUDED, currentPageVO.id));
			}
			else
			{
				var clazz:Class = getDefinitionByName(DataModel.PAGE_PACKAGE + currentPageVO.type) as Class;
				_currentPage = new clazz(currentPageVO) as AbstractPage;
				_currentPage.initialize();
				getLayer(PAGE_LAYER).addChild(_currentPage);	
			}
		}
		
		protected function _onTransitionOutComplete(event:PageEvent):void
		{
			var pl:Sprite = getLayer(PAGE_LAYER);
			for (var i:int=0; i<pl.numChildren; i++)
			{
				var c:* = pl.getChildAt(i);
				if (c is AbstractPage && AbstractPage(c).id == event.pageId) 
				{
					pl.removeChild(c);
					AbstractPage(c).dispose();
					c = null;
				}
			}
		}
		
		protected function _onInitData(event:DataEvent):void
		{
			_addMenu();
			_createContextMenu();
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
		
		protected function _createContextMenu():void
		{
			var cm:ContextMenu = new ContextMenu();
			cm.hideBuiltInItems();
			
			// only first level menu is used for context menu
			var firstLevel_menudata:Array = dataModel.getMenuPagesByParent();
			for each (var page:PageVO in firstLevel_menudata)
			{
				var cmenuitem:ContextMenuItem = new ContextMenuItem(page.urlFriendly);
				cmenuitem.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, _onContextMenuClick);
				cm.customItems.push(cmenuitem);
			}			
			contextView.contextMenu = cm;
		}
		
		protected function _onContextMenuClick(event:ContextMenuEvent):void
		{
			var pageid:String = dataModel.getPageByUrl((event.currentTarget as ContextMenuItem).caption);
			dispatch(new PageEvent(PageEvent.CHANGE_PAGE_REQUEST, pageid));
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
			_createLayers();
			
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