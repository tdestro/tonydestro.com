package com.healthysight{
	
	import flash.events.*;
	import flash.display.MovieClip;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.text.TextField;
	
	public class InfoPanel extends MovieClip{
		var p:*; //stores parent clip
		
		
		public function InfoPanel(_p:*){
			disableObjectsTextFields();
			
			this.x=64;
			this.y=170;
			
			p= _p;
			
			//set camera textfield values
			
			
			//add event listeners
			this.close_btn.addEventListener(MouseEvent.CLICK, onCloseBtnClick);
			this.xRange_txt.addEventListener(Event.CHANGE, onXRangeTxtChange);
			this.yRange_txt.addEventListener(Event.CHANGE, onYRangeTxtChange);
			
			//sphere rotation listeners
			this.xAxisRotation_txt.addEventListener(Event.CHANGE, onSphereXRotationChange);
			this.yAxisRotation_txt.addEventListener(Event.CHANGE, onSphereYRotationChange);
			this.zAxisRotation_txt.addEventListener(Event.CHANGE, onSphereZRotationChange);			
			
			//camera event listeners
			this.cameraFocus_txt.addEventListener(Event.CHANGE, onCameraFocusTxtChange);
			this.cameraFov_txt.addEventListener(Event.CHANGE, onCameraFovTxtChange);
			this.cameraZoom_txt.addEventListener(Event.CHANGE, onCameraZoomTxtChange);
			this.cameraZVal_txt.addEventListener(Event.CHANGE, onCameraZValTxtChange);
			
			// collada x y z coordinates listeners
			this.colladaX_txt.addEventListener(Event.CHANGE, onColladaXChange);
			this.colladaY_txt.addEventListener(Event.CHANGE, onColladaYChange);			
			this.colladaZ_txt.addEventListener(Event.CHANGE, onColladaZChange);			
			
			//object editor event listeners
			this.objectsX_txt.addEventListener(Event.CHANGE, onObjectXChange);
			this.objectsY_txt.addEventListener(Event.CHANGE, onObjectYChange);
			this.objectsZ_txt.addEventListener(Event.CHANGE, onObjectZChange);	
			
			///////  add object selection combobox event listeners  ////////
			sceneObjectsBox.addEventListener(Event.CHANGE, onSceneObjectsBoxChange);			
			
			//remove items
			removeObjectBtn_mc.addEventListener(MouseEvent.CLICK, onRemoveObjectBtnClick);
			
			//set fields with their initial values
			updateColladaPositionFields();
			updateSphereRotationFields();
			updateCameraFields();
			this.cameraZVal_txt.text = p.default_camera.z;
		}
		
		
		
		private function onSceneObjectsBoxChange(e:Event){
			setTextToSelectedItem();
		}		
		
		public function setTextToSelectedItem(){
			this.objectsX_txt.text = sceneObjectsBox.selectedItem.data.x;
			this.objectsY_txt.text = sceneObjectsBox.selectedItem.data.y;
			this.objectsZ_txt.text = sceneObjectsBox.selectedItem.data.z;			
		}
		
		
		private function onCloseBtnClick(e:MouseEvent){
			
			this.stage.removeChild(this);
			
		}
		
		////////////////////////  camera rotation  //////////////////////////
		
		private function updateCameraFields(){
			this.cameraFocus_txt.text = p.default_camera.focus.toFixed(2);
			this.cameraFov_txt.text = p.default_camera.fov.toFixed(2);
			this.cameraZoom_txt.text = p.default_camera.zoom.toFixed(2);
		}
		
		private function onCameraFocusTxtChange(e:Event){
			try{
				trace("p.default_camera.focus value: "+ p.default_camera.focus);
				p.default_camera.focus = Number(this.cameraFocus_txt.text);
				updateCameraFields();
			}
			catch(err:Error){}
		}
		
		private function onCameraFovTxtChange(e:Event){
			try{
				trace("p.default_camera.fov value: "+ p.default_camera.fov);
				p.default_camera.fov = Number(this.cameraFov_txt.text);
				updateCameraFields();
			}
			catch(err:Error){}
		}
		
		private function onCameraZoomTxtChange(e:Event){
			try{
				trace("p.default_camera value: "+ p.default_camera.zoom);
				p.default_camera.zoom = Number(this.cameraZoom_txt.text);
				updateCameraFields();
			}
			catch(err:Error){}
		}		
		
		private function onCameraZValTxtChange(e:Event){
			try{
				p.default_camera.z = Number(this.cameraZVal_txt.text);
			}
			catch(err:Error){}
		}
		
		
		/////////////////////////  sphere rotation  ///////////////////////////////
		private function updateSphereRotationFields(){
			try{
			this.xAxisRotation_txt.text = p.dae.rotationX.toFixed(2);
			this.yAxisRotation_txt.text = p.dae.rotationY.toFixed(2);
			this.zAxisRotation_txt.text = p.dae.rotationZ.toFixed(2);			
			}
			catch(e:Error){}
		}
		
		private function onSphereXRotationChange(e:Event){
			try{
			p.dae.rotationX = Number(this.xAxisRotation_txt.text);
			}
			catch(e:Error){}
			
		}
		
		private function onSphereYRotationChange(e:Event){
			try{
				p.dae.rotationY = Number(this.yAxisRotation_txt.text);
			}
			catch(e:Error){}
		}
		
		private function onSphereZRotationChange(e:Event){
			try{
				p.dae.rotationZ = Number(this.zAxisRotation_txt.text);
			}
			catch(e:Error){}
		}
		
		////////////////////////// u v repeat for sphere texture  /////////////////
		private function updateColladaPositionFields(){
			this.colladaX_txt.text = p.dae.x;
			this.colladaY_txt.text = p.dae.y;
			this.colladaZ_txt.text = p.dae.z;
		}
		
		private function onColladaXChange(e:Event){
			try{
				p.dae.x = Number(this.colladaX_txt.text);
			}
			catch(e:Error){}
			
		}
		
		private function onColladaYChange(e:Event){
			try{
				p.dae.y = Number(this.colladaY_txt.text);
			}
			catch(e:Error){}
		}
		
		private function onColladaZChange(e:Event){
			try{
				p.dae.z = Number(this.colladaZ_txt.text);
			}
			catch(e:Error){}
			
		}
		
		
		/////////////////////////  x and y camera rotation  ///////////////////////
		
		private function onXRangeTxtChange(e:Event){
			p.xRange = Number(this.xRange_txt.text);
			p.setXRatio();
		}
		
		private function onYRangeTxtChange(e:Event){
			p.yRange = Number(this.yRange_txt.text);
			p.setYRatio();
		}
		
		
		///////////  object editor listeners  ////////////  
		
		//change the x, y, and z positions of objects in the scene
		private function onObjectXChange(e:Event){
			var cleanTxt = objectsX_txt.text.replace("-", "-");
			cleanTxt = cleanTxt.replace("[", "");
			if(cleanTxt == "-"){cleanTxt = "0";}
			
			if(sceneObjectsBox.length > 0){  //make sure we have an object to edit
				try{
					//try{
						this.sceneObjectsBox.selectedItem.data.x = Number(cleanTxt);
					//}catch(e:Error){}
					//if(cleanTxt != "NaN"){
						p.faceTowardCamera(this.sceneObjectsBox.selectedItem.data);	
					//}
				}catch(e:Error){}
			}
		}
		
		private function onObjectYChange(e:Event){
			trace("onObjectYChange called");
			trace("objectsY_txt: " + objectsY_txt.text);
			var cleanTxt = objectsY_txt.text.replace("-", "-");			
		
			cleanTxt = cleanTxt.replace("[", "");			
			if(cleanTxt == "-"){cleanTxt = "0";}			
			trace("cleanTxt: " + cleanTxt);	

			if(sceneObjectsBox.length > 0){
				try{
					//try{
						this.sceneObjectsBox.selectedItem.data.y = Number(cleanTxt);
					//}catch(e:Error){}
					//if(cleanTxt != "NaN"){
						p.faceTowardCamera(this.sceneObjectsBox.selectedItem.data);
					//}
				}catch(e:Error){}				
			}

		}
		
		private function onObjectZChange(e:Event){
			var cleanTxt = objectsZ_txt.text.replace("-", "-");	
			cleanTxt = cleanTxt.replace("[", "");			
			if(cleanTxt == "-"){cleanTxt = "0";}			
			
			if(sceneObjectsBox.length > 0){
				try{
					//try{
						this.sceneObjectsBox.selectedItem.data.z = Number(cleanTxt);
					//}catch(e:Error){}
					//if(cleanTxt != "NaN"){
						p.faceTowardCamera(this.sceneObjectsBox.selectedItem.data);			
					//}
				}catch(e:Error){}			
			}			
		}
		
		
		
		///////////////////////////////////////////////////////////////////////////
		/////////////////////  Object removal button listener  ////////////////////
		///////////////////////////////////////////////////////////////////////////
		
		private function onRemoveObjectBtnClick(e:MouseEvent){
			//don't take what we don't have
			if(sceneObjectsBox.length > 0){
				var indexToRemove:int = sceneObjectsBox.selectedIndex;
				trace("index to remove: "+ sceneObjectsBox.selectedIndex);
				trace("sceneObjectsBox value at this index: "+ sceneObjectsBox.selectedItem.data);
				
				p.current_scene.removeChild(sceneObjectsBox.selectedItem.data);
				sceneObjectsBox.removeItemAt(indexToRemove);
				
				sceneObjectsBox.selectedIndex = 0;
				
				if(sceneObjectsBox.length > 0){
				setTextToSelectedItem();
				}
				else{
					disableObjectsTextFields();
				}
				
				
			}
			
		}
		
		
		private function disableObjectsTextFields(){
			objectsX_txt.text = "0";
			objectsX_txt.type = "dynamic";
			objectsY_txt.text = "0";
			objectsY_txt.type = "dynamic";
			objectsZ_txt.text = "0";
			objectsZ_txt.type = "dynamic";	
			
		}
		
		
	}
}