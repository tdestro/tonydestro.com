﻿package com.healthysight{
	

	import org.papervision3d.*;
	import org.papervision3d.objects.primitives.Plane;
	import org.papervision3d.materials.*;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import com.healthysight.impairments.DistortionBitmap;
	
	public class SceneObject extends Plane{
		private var w:int;
		private var h:int;
		public var _material:BitmapMaterial;
		
		public function SceneObject(bmp:Bitmap, ... placement){
			w = bmp.width;
			h = bmp.height;
			
			_material = new BitmapMaterial(bmp.bitmapData);
			
			super(_material, w, h, 8, 8);
			
			//optional x y and z coordinates
			if(placement.length > 0){
				this.x= placement[0];
			}
			if(placement.length > 1){
				this.y = placement[1];
			}
			if(placement.length > 2){
				this.z = placement[2];
			}			
			
			
		}
		
		
	}
		
}