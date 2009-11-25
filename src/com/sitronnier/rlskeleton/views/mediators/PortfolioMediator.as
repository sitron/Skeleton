package com.sitronnier.rlskeleton.views.mediators
{
	import com.sitronnier.rlskeleton.models.LoaderModel;
	import com.sitronnier.rlskeleton.views.components.pages.Portfolio;

	public class PortfolioMediator extends PageMediator
	{
		public static const PORTFOLIO_LOADER:String = "PORTFOLIO_LOADER";
		
		[Inject]
		public var loaderModel:LoaderModel;
		
		[Inject]
		public var view:Portfolio;
		
		public function PortfolioMediator()
		{
			super();
		}
		
		
		// PUBLIC
		//________________________________________________________________________________________________
		
		override public function onRegister() : void
		{
			super.onRegister();
			
			view.loader = loaderModel.getLoader(PORTFOLIO_LOADER);
			view.start();
		}
		
		override public function onRemove() : void
		{
			super.onRemove();
			
			loaderModel.disposeLoader(PORTFOLIO_LOADER);
		}
	}
}