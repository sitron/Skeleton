package com.sitronnier.rlskeleton.views.mediators
{
	import com.sitronnier.rlskeleton.events.PageEvent;
	import com.sitronnier.rlskeleton.models.DataModel;
	import com.sitronnier.rlskeleton.models.FlowModel;
	import com.sitronnier.rlskeleton.views.components.menus.BasicMenu;
	import com.sitronnier.rlskeleton.views.events.PageViewEvent;
	
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
	
	public class MenuMediator extends Mediator
	{
		[Inject]
		public var menu:BasicMenu;
		
		[Inject]
		public var dataModel:DataModel;
		
		[Inject]
		public var flowModel:FlowModel;
		
		public function MenuMediator()
		{
			super();
		}
		
		// PROTECTED, PRIVATE
		//________________________________________________________________________________________________
		
		protected function _onChangePageRequest(event:PageViewEvent):void
		{
			dispatch(new PageEvent(PageEvent.CHANGE_PAGE_REQUEST, event.pageId));
		}
		
		protected function _onPageChange(event:PageEvent):void
		{
			menu.updateSelection(flowModel.currentPage);
		}
		
		
		// PUBLIC
		//________________________________________________________________________________________________
		
		override public function onRegister() : void
		{
			// view event handler
			menu.addEventListener(PageViewEvent.CHANGE_PAGE_REQUEST, _onChangePageRequest);
			
			// system event handlers
			// menu reacts when the actual page ends its transition or when an excluded page is called
			eventMap.mapListener(eventDispatcher, PageEvent.ON_TRANSITION_OUT_COMPLETE, _onPageChange, PageEvent);
			eventMap.mapListener(eventDispatcher, PageEvent.PAGE_EXCLUDED, _onPageChange, PageEvent);
			
			// THIS IS JUST A BASIC IMPLEMENTATION OF A 1 LEVEL MENU
			// TODO: implement a tree menu			
			// get menu data
			var firstLevel_menudata:Array = dataModel.getChildrenNonExcludedPages();
			menu.update(firstLevel_menudata);
			menu.updateSelection(flowModel.currentPage);
		}
		
		override public function onRemove():void
		{
			menu.removeEventListener(PageViewEvent.CHANGE_PAGE_REQUEST, _onChangePageRequest);
		} 
	}
}