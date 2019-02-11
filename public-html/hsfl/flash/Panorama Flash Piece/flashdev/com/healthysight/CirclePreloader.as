package com.healthysight{
	/*
	Circle Preloader for Healthy Sight Panorama
	
	Chris Natale 1/16/09
	*/
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Graphics;
    import flash.display.Shape;
	
    import flash.display.LineScaleMode;
    import flash.display.CapsStyle;
    import flash.display.JointStyle;
	
	
	public class CirclePreloader extends MovieClip{
		
		
		public var  dO = 3.6;  //multiplied by pct loaded to give us degrees of triangle mask that should be generated. i.e. d0*100=360
		public var r = 75;  //radius of mask generated (not really radius since it's a triangle, but you get the idea...)
		public var oldLoaded:Number=0, currLoaded:Number=0;
		protected var _pct:Number=0;
		
		protected var cirMask:Sprite;
		protected var m:int=2;
		
		public function CirclePreloader(){	
			this.scaleX=1;
			this.scaleY=1;
			
			cirMask = new Sprite();
			initPreloaderMask();		
			
			fillSection(0);
			pctText_txt.text="";
		}
		
		
		public function get pct():Number {
			return _pct;
		}
		
		public function set pct(value:Number):void {
			_pct=Math.ceil(value*100);
			fillSection(_pct);
		}		
		
		
		
		function initPreloaderMask(){
			oldLoaded=currLoaded=0;
			
			cirMask = new Sprite();
			this.addChild(cirMask);
			this.pctCircle_mc.mask = cirMask;
			cirMask.x=cirMask.y=0;
		}


		protected function fillSection(pct:Number){
			if(pct > 100){
				pct=100;
			}
			if(pct < 0){
				pct=0;
			}
			
			pctText_txt.text = String(pct);
			
			/*
			for(var i:int=0; i < cirMask.numChildren; i++){
				cirMask.removeChildAt(0);
			}
			*/

			while(cirMask.numChildren)
			{
				cirMask.removeChildAt(0);
			}


			//multiply pct loaded by 3.6 to get pct of 360 degrees to draw triangle
			var degrees:Number = pct * dO;
			
			
			var x1, y1:Number;
		
			x1 = r*Math.sin((degrees - 180)*(Math.PI/180));
			y1 = r*Math.cos((degrees - 180)*(Math.PI/180));				
			
            var tri:Shape = new Shape();    
			cirMask.addChild(tri);

			if(degrees==0){
				
			}
			else if(degrees <=90){
				

				with(tri)
				{
					graphics.moveTo(0,0);
					graphics.beginFill(0x000088);
					graphics.lineTo(0, -this.height);
					//graphics.curveTo(-this.width, 0, x1, y1); 
					graphics.lineTo(x1, y1);
	
					graphics.endFill();
				}			
			}

			else if(degrees <= 180){
				fillTopLeft();

				with(tri)
				{
					graphics.moveTo(0,0);
					graphics.beginFill(0x000088);
					graphics.lineTo(-this.width, 0);
					//graphics.curveTo(-this.width, 0, x1, y1); 
					graphics.lineTo(x1, y1);
	
					graphics.endFill();
				}							
			}
			
			else if(degrees <=270){
				fillTopLeft();
				fillBottomLeft();

				with(tri)
				{
					graphics.moveTo(0,0);
					graphics.beginFill(0x000088);
					graphics.lineTo(0, this.height);
					//graphics.curveTo(-this.width, 0, x1, y1); 
					graphics.lineTo(x1, y1);
	
					graphics.endFill();
				}			
			}
			
			else{ //between 270 and 360
				fillTopLeft();
				fillBottomLeft();
				fillBottomRight();

				with(tri)
				{
					graphics.moveTo(0,0);
					graphics.beginFill(0x000088);
					graphics.lineTo(this.width, 0);
					//graphics.curveTo(-this.width, 0, x1, y1); 
					graphics.lineTo(x1, y1);
	
					graphics.endFill();
				}							
				
			}

		}
		
		
		

		protected function fillBottomRight(){
            var sqr:Shape = new Shape();    
			cirMask.addChild(sqr);
            // tri.graphics.lineStyle(10, 0xFFD700, 1, false, LineScaleMode.VERTICAL, CapsStyle.NONE, JointStyle.MITER, 10);
			
			
			sqr.graphics.moveTo(0,0);
			sqr.graphics.beginFill(0x000088);
			sqr.graphics.drawRect(0, 0, this.width/2, this.height/2);
			sqr.graphics.endFill();
					
		}
		
		protected function fillBottomLeft(){
            var sqr:Shape = new Shape();    
			cirMask.addChild(sqr);
            // tri.graphics.lineStyle(10, 0xFFD700, 1, false, LineScaleMode.VERTICAL, CapsStyle.NONE, JointStyle.MITER, 10);
			
			
			sqr.graphics.moveTo(0,0);
			sqr.graphics.beginFill(0x000088);
			sqr.graphics.drawRect(-this.width/2, 0, this.width/2, this.height/2);
			sqr.graphics.endFill();			
		}
		
		protected function fillTopLeft(){
            var sqr:Shape = new Shape();    
			cirMask.addChild(sqr);
            // tri.graphics.lineStyle(10, 0xFFD700, 1, false, LineScaleMode.VERTICAL, CapsStyle.NONE, JointStyle.MITER, 10);
			
			
			sqr.graphics.moveTo(0,0);
			sqr.graphics.beginFill(0x000088);
			sqr.graphics.drawRect(-this.width/2, -this.height/2, this.width/2, this.height/2);
			sqr.graphics.endFill();			
		}
		
		
		
	}
	
}