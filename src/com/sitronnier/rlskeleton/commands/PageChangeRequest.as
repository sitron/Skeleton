package com.sitronnier.rlskeleton.commands
{
	import com.sitronnier.rlskeleton.events.PageEvent;
	import com.sitronnier.rlskeleton.models.FlowModel;
	
	import org.robotlegs.mvcs.Command;
	
	public class PageChangeRequest extends Command
	{
		[Inject]
		public var event:PageEvent;
		
		[Inject]
		public var flowModel:FlowModel;
		
		public function PageChangeRequest()
		{
			super();
		}
		
		override public function execute() : void
		{
			flowModel.show(event.pageId);
		}
	}
}