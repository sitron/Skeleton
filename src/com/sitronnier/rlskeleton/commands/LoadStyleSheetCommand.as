package com.sitronnier.rlskeleton.commands
{
	import com.sitronnier.rlskeleton.models.StyleModel;
	import com.sitronnier.rlskeleton.services.StyleService;
	
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
	 * Initial Developer are Copyright (C) 2009-2010 Sitronnier.com. All Rights Reserved.</p>
	 */
	
	public class LoadStyleSheetCommand extends Command
	{
		[Inject]
		public var styleService:StyleService;
		
		public function LoadStyleSheetCommand()
		{
			super();
		}
		
		override public function execute() : void
		{
			if (StyleModel.MAIN_ID != null) 
			{
				styleService.loadStyleSheet(StyleModel.MAIN_ID);
			}	
		}
	}
}