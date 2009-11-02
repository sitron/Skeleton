package com.sitronnier.rlskeleton.commands
{
	import com.sitronnier.rlskeleton.models.FlowModel;
	
	import org.robotlegs.mvcs.Command;
	
	public class OnInitialDataReady extends Command
	{
		[Inject]
		public var flowModel:FlowModel;
		
		public function OnInitialDataReady()
		{
			super();
		}
		
		override public function execute() : void
		{
			trace("initial data ready");
			flowModel.show();
		}
	}
}