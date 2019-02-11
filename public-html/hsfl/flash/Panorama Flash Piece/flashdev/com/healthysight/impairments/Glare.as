package com.healthysight.impairments{
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	import org.papervision3d.PaperBase;
	import com.healthysight.PanoramaModule;
	import org.papervision3d.materials.*;
	import org.papervision3d.objects.primitives.*;	
	import org.papervision3d.view.layer.util.ViewportLayerSortMode;	
	import com.healthysight.events.ImpairmentEvent;
	import com.healthysight.graphics.*;
	import gs.*;
	
	public class Glare extends Sprite{
		
		var container:PanoramaModule;
		import org.papervision3d.view.layer.ViewportLayer;			
		import flash.events.Event;
		
		public var lensFlareLayer:ViewportLayer;		
		
		//the planes needed for glare effect
		var backRing:Plane;
		var ring2:Plane;
		var ring3:Plane;
		var outerRing:Plane;
		
		var ring2_mc:MovieClip;
		var ring3_mc:MovieClip;
		var backRing_mc:MovieClip;
		var outerRing_mc:MovieClip;
		
		public function Glare(_container:PanoramaModule){
			//this impairment doesn't load any outside content, so we can dispatch loaded event immediately
			
			container = _container;
			container.loaderBg_mc.dispatchEvent(new ImpairmentEvent({evtType:ImpairmentEvent.LOADED, name:"glare"}));
			
		}
		
		public function init(){
			//create instances of lens flare movieclips
			
			
			backRing_mc = new BackFlare();
			var backRingMam:MovieMaterial = new MovieMaterial(backRing_mc, true, true);
			backRingMam.smooth=true;
			backRingMam.oneSide=true;	
			backRing = new Plane(backRingMam, 407, 407, 4, 4);
			backRing.useOwnContainer=true;
			lensFlareLayer = container.viewport.getChildLayer(backRing, true);	
			
			ring2_mc = new Ring2();
			var ring2Mam:MovieMaterial = new MovieMaterial(ring2_mc, true, true);
			ring2 = new Plane(ring2Mam, 143, 143, 4, 4);
			
			ring3_mc = new Ring3();
			var ring3Mam:MovieMaterial = new MovieMaterial(ring3_mc, true, true);
			ring3 = new Plane(ring3Mam, 160, 160, 4, 4);
			ring3Mam.smooth=true;
			
			outerRing_mc = new OuterRing();
			var outerRingMam:MovieMaterial = new MovieMaterial(new OuterRing, true, true);
			outerRing = new Plane(outerRingMam, 280, 280, 4, 4);
			outerRingMam.smooth=true;
			backRing.x=ring2.x=ring3.x=outerRing.x=-600;
			backRing.y=ring2.y=ring3.y=outerRing.y=600;
			backRing.z=1800;
			ring2.z=1600;
			ring3.z=1400;
			outerRing.z=800;
			
			
			faceTowardCamera(backRing);
			faceTowardCamera(ring2);
			faceTowardCamera(ring3);
			faceTowardCamera(outerRing);
			
			//place rings based on backRing's position
			
			ring2.x = xVal(backRing, ring2.z);
			ring3.x = xVal(backRing, ring3.z);
			outerRing.x = xVal(backRing, outerRing.z);
			
			ring2.y = yVal(backRing, ring2.z);
			ring3.y = yVal(backRing, ring3.z);
			outerRing.y = yVal(backRing, outerRing.z);
			
			
			/////add to stage
			container.current_scene.addChild(backRing);
			container.current_scene.addChild(ring2);
			container.current_scene.addChild(ring3);
			container.current_scene.addChild(outerRing);			
			
			
			MovieMaterial(backRing.material).movie.alpha=0;
			MovieMaterial(ring2.material).movie.alpha=0;
			MovieMaterial(ring3.material).movie.alpha=0;
			MovieMaterial(outerRing.material).movie.alpha=0;			
			//TweenFilterLite.to(container, 3, {colorMatrixFilter:{brightness:2.5, contrast:1.7, saturation:.8}, onComplete:glareMin});



			//////  lets try positioning the glare on top of everything else  ///////
			//outerRing.useOwnContainer=true;
			//parentLayer.getChildLayer(outerRing, true).layerIndex = 10;
			
			//container.current_viewport.getChildLayer(plane2, true).layerIndex = 1; 			
			
			

			glareMax();		
									
		}
		
		private function yVal(farPlane:Plane, zVal:Number):Number{
			var ratio:Number = zVal / farPlane.z ;
			return farPlane.y * ratio;
		}
		
		private function xVal(farPlane:Plane, zVal:Number):Number{
			var ratio:Number = zVal / farPlane.z;
			return farPlane.x * ratio;
		}
		
		private function faceTowardCamera(p:Plane):void{
			var planeRads:Number = Math.atan2(p.x, p.z);
			p.rotationY = (planeRads * 180 / Math.PI) ;			
		}
		
		private function updateFlare(e:Event){
				
		}
		
		public function glareMin():void{
			trace("glaremin called");
			var t:int=2;
			//TweenFilterLite.to(container, 3, {colorMatrixFilter:{brightness:2, contrast:1.4, saturation:.9}, onComplete:glareMax});
			TweenFilterLite.to(container, t, {colorMatrixFilter:{brightness:1, contrast:1, saturation:1}, onComplete:glareMax});

			TweenLite.to(ring2, t, {x: xVal(backRing, ring2.z) + 45, y: yVal(backRing, ring2.z) - 45  });
			TweenLite.to(ring3, t, {x: xVal(backRing, ring3.z) + 55, y:yVal(backRing, ring3.z) - 55});
			TweenLite.to(outerRing, t, {scale:.8, x: xVal(backRing, outerRing.z) + 50, y:yVal(backRing, outerRing.z)-50}); 
			
		}
		
		public function glareMax():void{
			trace("glaremax called");
			var t:int=2;
			
			TweenLite.to(MovieMaterial(backRing.material).movie, t, {alpha:1});
			TweenLite.to(MovieMaterial(ring2.material).movie, t, {alpha:1});
			TweenLite.to(MovieMaterial(ring3.material).movie, t, {alpha:1});
			TweenLite.to(MovieMaterial(outerRing.material).movie, t, {alpha:1});			
			//TweenFilterLite.to(container, 3, {colorMatrixFilter:{brightness:2.5, contrast:1.7, saturation:.8}, onComplete:glareMin});
			TweenFilterLite.to(container, t, {colorMatrixFilter:{brightness:1.6, contrast:1.5, saturation:.8}/*, onComplete:glareMin*/});

			TweenLite.to(ring2, t, {x: xVal(backRing, ring2.z) + 90, y: yVal(backRing, ring2.z) - 90  });
			TweenLite.to(ring3, t, {x: xVal(backRing, ring3.z) + 110, y:yVal(backRing, ring3.z) - 110});
			TweenLite.to(outerRing, t, {scale:1, x: xVal(backRing, outerRing.z) + 100, y:yVal(backRing, outerRing.z)-100}); 
			
		}
		
		public function glareOff():void{
			var t:int=1;
			
			TweenLite.to(MovieMaterial(backRing.material).movie, t, {alpha:0});
			TweenLite.to(MovieMaterial(ring2.material).movie, t, {alpha:0});
			TweenLite.to(MovieMaterial(ring3.material).movie, t, {alpha:0});
			TweenLite.to(MovieMaterial(outerRing.material).movie, t, {alpha:0});
			TweenLite.to(ring2, t, {x: xVal(backRing, ring2.z) + 45, y: yVal(backRing, ring2.z) - 45  });
			TweenLite.to(ring3, t, {x: xVal(backRing, ring3.z) + 55, y:yVal(backRing, ring3.z) - 55});
			TweenLite.to(outerRing, t, {scale:.8, x: xVal(backRing, outerRing.z) + 50, y:yVal(backRing, outerRing.z)-50}); 
			TweenFilterLite.to(container, t, {colorMatrixFilter:{brightness:1, contrast:1, saturation:1}, onComplete:finishDisabling});
	

		}
		
		private function finishDisabling():void{
			// everything has been tweened back to normal, now remove the flare planes from stage
	
			container.current_scene.removeChild(backRing);
			container.current_scene.removeChild(ring2);
			container.current_scene.removeChild(ring3);
			container.current_scene.removeChild(outerRing);	
			backRing_mc = null;
			ring2_mc = null;
			ring3_mc = null;
			outerRing_mc = null;
	
		}
		/////////////////////////////////////////////////////////////
		/////////////////////  disable effect  //////////////////////
		/////////////////////////////////////////////////////////////
		
		public function disable():void{
			glareOff();
		}

		
		
	}
	
	
}