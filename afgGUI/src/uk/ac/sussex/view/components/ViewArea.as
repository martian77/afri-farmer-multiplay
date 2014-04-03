package uk.ac.sussex.view.components {
	//import fl.controls.ScrollBar;
	import flash.display.MovieClip;

	/**
	 * This is going to be a scrolling area to take the main part of the screen. 
	 * @author em97
	 */
	public class ViewArea extends MovieClip {
		private var scroller:ScrollingContainer;
		
		public function ViewArea(width:Number, height:Number) {
			/**myContainer = new MovieClip();
			this.addChild(myContainer);
			myContainerMask = new MovieClip();
//			this.addChild(myContainerMask);
//			myContainer.mask = myContainerMask;
			vScrollBar = new ScrollBar();
			hScrollBar = new ScrollBar();*/
			scroller = new ScrollingContainer(width, height, ScrollingContainer.HORIZONTAL, false);
			
			scroller.showBackgroundFilter(false);
			scroller.hideBackground(true);
			this.addChild(scroller);
		}
		/**public function resizeArea(screenWidth:Number, screenHeight:Number):void {
			var newWidth:Number = screenWidth;
			var newHeight:Number = screenHeight;
			//var needsHScrollBar:Boolean = (myContainer.width > screenWidth);
			var needsVScrollBar:Boolean = (myContainer.height > screenHeight); 
			if(myContainer.width < screenWidth){
				//needsHScrollBar = true;
				newHeight = screenHeight - hScrollBar.height; 
			} 
			if(myContainer.height < screenHeight){
				newWidth = screenWidth - vScrollBar.width;
			}
			
			this.redrawContainer(screenWidth, screenHeight);
			
			myContainerMask.graphics.beginFill(0x000000);
			myContainerMask.graphics.drawRect(0, 0, screenWidth, screenHeight);
			myContainerMask.graphics.endFill();
			
			if(needsVScrollBar){
				this.setUpVScrollBar();
			}
		}**/
		public function addToContainer(child:MovieClip):void{
			 scroller.addItemToContainer(child);
		}
		public function refreshContainer():void {
			scroller.refreshContainer();
		}
		/**private function redrawContainer(newWidth:Number, newHeight:Number):void{
			//Don't shrink the container.
			var width:Number = ((newWidth > myContainer.width)?newWidth:myContainer.width);
			var height:Number = ((newHeight > myContainer.height)?newHeight:myContainer.height); 
			myContainer.graphics.beginFill(CONTAINER_COLOUR);
			myContainer.graphics.drawRect(0, 0, width, height);
			myContainer.graphics.endFill();
		}*/
		/**private function setUpVScrollBar():void {
			var screenHeight:Number = myContainerMask.height;
			vScrollBar.x = myContainerMask.width;
			vScrollBar.y = myContainerMask.y;
			vScrollBar.height = screenHeight;
			vScrollBar.enabled = true;
			vScrollBar.setScrollProperties(screenHeight, 0, myContainer.height - screenHeight);
			this.addChild(vScrollBar);
		}*/
	}
}
