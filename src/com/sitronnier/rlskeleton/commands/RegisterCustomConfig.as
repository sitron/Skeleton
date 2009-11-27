package com.sitronnier.rlskeleton.commands
{	
	import com.sitronnier.rlskeleton.models.DataModel;
	
	import org.robotlegs.mvcs.Command;
	
	public class RegisterCustomConfig extends Command
	{
		protected var _importVOs:Array = [];
		
		public function RegisterCustomConfig()
		{
			super();
		}
		
		
		// PUBLIC
		//________________________________________________________________________________________________
		
		override public function execute() : void
		{
			// these 2 get overriden by flashvars (if any)
			DataModel.DEBUG = true;
			DataModel.VERSION = "1";
			
			// base package for AbstractPage subclasses
			DataModel.PAGE_PACKAGE = "com.sitronnier.rlskeleton.views.components.pages.";
		}
	}
}