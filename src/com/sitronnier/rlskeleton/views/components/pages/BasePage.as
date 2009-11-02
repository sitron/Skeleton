package com.sitronnier.rlskeleton.views.components.pages
{
	import caurina.transitions.Tweener;
	
	import com.sitronnier.rlskeleton.vos.PageVO;
	
	public class BasePage extends AbstractPage
	{
		public function BasePage(data:PageVO)
		{
			super(data);
		}
		
		
		// PUBLIC
		//________________________________________________________________________________________________
		
		override public function transitionOut() : void
		{
			super.transitionOut();
			
			Tweener.addTween(this, {time:.3, alpha:0, onComplete:_onTransitionOutOver});
		}
		
		override public function transitionIn() : void
		{
			Tweener.addTween(this, {time:.3, alpha:1, onComplete:_onTransitionInOver});
		}		
	}
}