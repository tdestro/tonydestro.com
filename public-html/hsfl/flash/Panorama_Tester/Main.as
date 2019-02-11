package{
	
	import org.papervision3d.objects.primitives.*;
	import org.papervision3d.materials.*;
	import org.papervision3d.materials.shadematerials.*;
	import org.papervision3d.scenes.*;
	import org.papervision3d.cameras.*;
	import org.papervision3d.core.math.Number3D;
	import org.papervision3d.lights.*;
	import org.papervision3d.objects.parsers.DAE;	
	//import org.papervision3d.objects.parsers.Max3DS;
	import org.papervision3d.events.FileLoadEvent;	
	import org.papervision3d.materials.utils.MaterialsList;	
	import org.papervision3d.PaperBase;	
	
	import flash.display.Stage;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.NativeMenu;	
	import flash.display.NativeMenuItem;
	import flash.display.NativeWindow;
	import flash.desktop.*;
	import flash.utils.Dictionary;
	import flash.events.*;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.filters.BlurFilter;	
	import flash.filters.BitmapFilterQuality;
	
	//import gs.TweenLite;
	import caurina.transitions.Tweener;
	import flash.display.Stage;
	import com.healthysight.DirectoryViewer;
	import com.healthysight.InfoPanel;
	import com.healthysight.SceneObject;

	import fl.controls.ComboBox;
	import com.healthysight.controls.SceneObjectsDropdown;
	import com.healthysight.impairments.MovingImpairment;
	import com.healthysight.impairments.DistortionBitmap;
	
	import flash.display.Loader;
	import flash.net.URLRequest;	
	
	public class Main extends PaperBase{
	
		var container:Sprite;
		var p:Cube;
		public var s:Sphere;
		private var lightSource:PointLight3D;
		public var dae:DAE;
		//public var max:Max3DS;
		var daeMaterials:MaterialsList;
		var plane:Plane;
		public var bam:BitmapAssetMaterial;
		var planeMam:MovieMaterial;
		var myPlaneDictionary:Dictionary;
		var myPlaneContainer:Sprite;
		var loaded_mc:MovieClip;
		var loadedBitmapData:BitmapData;

		var ctrX, ctrY:int, xRatio, yRatio;
		var blur:BlurFilter;
		var filtersArray:Array;
		
		var infoPanel:InfoPanel;
		var dview:DirectoryViewer;
		
		public var xRange:Number;
		public var yRange:Number;
		
		public var overlaySprite:Sprite;
		public var sceneObjectBmp:Bitmap;

		public var distortionSprite:Sprite;
		public var mi:MovingImpairment;
		
		/////////////  constructor  ///////////////
		 
		public function Main():void{
			
			init();  //calls init function from base class to load all the papervision essentials into memory
			
			xRange=45;
			yRange=20;
			
			createRootMenu();
			
			dview = new DirectoryViewer(this);
			
			myPlaneDictionary = new Dictionary();
			loaded_mc = new hello();
			
			bam = new BitmapAssetMaterial("test");
			//bam = new BitmapAssetMaterial("M1_ABRAM");
			bam.maxU=1;
			bam.maxV=1;
			bam.tiled=true;
			bam.oneSide=false;
			bam.smooth = true;			
			
			planeMam = new MovieMaterial(loaded_mc, true);
			planeMam.smooth=true;
			planeMam.oneSide=false;
			//planeMam.interactive=true;
			
			

			//s = new Sphere(bam, 2000, 20, 20);
			s=new Sphere();
			s.x=0;
			s.y=0;
			s.z=0;
			s.rotationY=120;
			
			////////////////////////  test loading a collada dae file  ///////////////////////
			dae= new DAE();
			/*
			lightSource = new PointLight3D(true, true);
			lightSource.position = new Number3D(0, 0, 0);
			current_scene.addChild(lightSource);
			
			daeMaterials = new MaterialsList();
			
			daeMaterials.addMaterial(new FlatShadeMaterial(lightSource, 0x0000ff), "lambert2SG" );
			//daeMaterials.addMaterial(bam, "lambert2SG");
			
			
			
 	 		dae.addEventListener(FileLoadEvent.LOAD_COMPLETE, onDAELoadComplete);
  			//dae.load( "wireframes/test2.dae", daeMaterials);
			dae.load("wireframes/test2.dae");
			*/
			//////////////////////////////////////////////////////////////////////////////////
			
		
			trace("current_scene: "+ current_scene);
			//current_scene.addChild(s);
			
			//set up the camera for correct fov/zoom
			initCamera(350);		
			
			//ctrX = container.width *.5;
			ctrX = 480;  //forcing half width
			//ctrY = container.height * .5;  //container height is returning 900 for some reason
			ctrY = 270;  //forcing half height

			setXRatio();
			setYRatio();

			//this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			//this.addEventListener(MouseEvent.CLICK, onClick);
			
			//add debugging panel
			infoPanel = new InfoPanel(Sprite(this));		
			
			
		}
		
		///////////////////  dae load handler test  /////////////////////////
		private function onDAELoadComplete(e:FileLoadEvent){
			/*
			trace("dae file loaded");
			dae.z=500;
			dae.materials.getMaterialByName("Panorama1_v06_jpg").oneSide=false;
			
			//dae.rotationY=45;
			//dae.rotationX=45;
			//dae.material = 
			current_scene.addChild(dae);
			*/
		}
		
		
		
		//////////  create camera  //////////////
		
		public function initCamera(foc:int):void{
			default_camera.x=0;
			default_camera.y=0;
			default_camera.z=-250;
			default_camera.culled=false;
			default_camera.near=0;
			default_camera.far= 2200;
			default_camera.focus=31;
			default_camera.fov=60;
			default_camera.zoom=80;
		}
		
		public function setXRatio(){
			xRatio = ctrX/xRange; //150 degree up and down vertical viewing angle
		}
		public function setYRatio(){
			yRatio = ctrY/yRange;  //45 degree up and down vertical viewing angle		
		}
		

		/////////////////////////////////////////
		
		function keyDownHandler(e:KeyboardEvent):void{
			//trace("keyCode: " + e.keyCode);
			
			///hotkeys///
			if(e.keyCode == 79){ // 'O', options hotkey
				this.stage.addChild(infoPanel);
			}
			if(e.keyCode == 80){// 'P', new photo hotkey
				dview.openFile("Bg"); 
			}
			if(e.keyCode == 219){// left bracket, new scene object
				dview.openFile("SceneObject");
			}
			if(e.keyCode == 221){// right bracket, new vision overlay image
				dview.openFile("VisionOverlay");
			}
			
		}
		
		
		override protected function processFrame():void{
			
			/////////////  rotation  ////////
					/*
			var xpos:int = (mouseX - ctrX)/xRatio;
			var ypos:int = (ctrY - mouseY)/yRatio;
			
			Tweener.addTween(default_camera, { rotationY:xpos, rotationX:ypos, time:2 } );			
			*/
			
			/////////////  rotation  ////////
			var mx:int;
			var my:int;
			
			if(this.mouseX < 0){
				mx=0;
			}
			else if(this.mouseX > 960){
				mx=960;
			}
			else{
				mx=this.mouseX;
			}
			
			if(mouseY < 0){
				my=0;
			}
			else if(this.mouseY > 540){
				my=540;
			}
			else{
				my=this.mouseY;
			}
			
			
			
			mx=this.mouseX;
			my=this.mouseY;
			
			var xpos:int = (mouseX - ctrX)/xRatio;
			var ypos:int = -(ctrY - mouseY)/yRatio;
			
			var dx:Number= xpos - default_camera.rotationY;
			var dy:Number= ypos - default_camera.rotationX;
			var vx:Number = dx* .17; //.17 is easing value
			var vy:Number = dy* .17;	

			default_camera.rotationX += vy;			
			default_camera.rotationY += vx;			
			
			
			
		}
				
				
				
		//////////////////////////////////////////////////////////////////////////
		/////////////////  graphical content swap functionality  /////////////////
		//////////////////////////////////////////////////////////////////////////			
				
		public function changePanoramaBitmap(bmpd:Bitmap, u:int=1, v:int=1){
			loadedBitmapData = bmpd.bitmapData;
			var bmat:BitmapMaterial = new BitmapMaterial(loadedBitmapData);
			bmat.oneSide=false;
			bmat.smooth = true;
			
			if(u > 1 || v > 1){
				bmat.maxU=u;
				bmat.maxV=v;
				bmat.tiled=true;
			}
			
			s.material = bmat;
		
		}
		
		public function changePanoramaBg(d:DAE){
			try{
				current_scene.removeChild(dae);
			}
			catch(e:Error){}
			dae=d;
			for each (var m:* in dae.materials.materialsByName){
				m.oneSide=false;
				m.smooth=true;
			}
			current_scene.addChild(dae);
		}
		
	
		public function addSceneObject(bmpd:Bitmap){
			
			infoPanel.objectsX_txt.type = "input";
			infoPanel.objectsY_txt.type = "input";
			infoPanel.objectsZ_txt.type = "input";
	
			//sceneObjectBmp = bmpd;
			//this.addChild(sceneObjectBmp);
			var so:SceneObject = new SceneObject(bmpd, 0, 0, 500);
			so._material.smooth=true;
			so._material.oneSide=true;
			so.name = "Object " + String(infoPanel.sceneObjectsBox.length);			
			
			
			default_scene.addChild(/*sceneObjects[sceneObjects.length-1]*/ so);
			infoPanel.sceneObjectsBox.addItem({label:so.name, data:so});
			infoPanel.sceneObjectsBox.selectedIndex = infoPanel.sceneObjectsBox.length-1;		
			//previous line doesn't automatically trigger the change event, so I have to copy function code here
			infoPanel.setTextToSelectedItem();
			
			//if this is the only object loaded, set the x y and z boxes to its values		
			if(infoPanel.sceneObjectsBox.length == 1){
				infoPanel.objectsX_txt.text = String(so.x);
				infoPanel.objectsY_txt.text = String(so.y);
				infoPanel.objectsZ_txt.text = String(so.z);							
				
			}
					
		}
		
		public function addOverlayImage(bmpd:Bitmap){
			var overlaySprite:Sprite = new Sprite();
			bmpd.x=0;
			bmpd.y=0;
			overlaySprite.addChild(bmpd);
			overlaySprite.x=0;
			overlaySprite.y=0;
			overlaySprite.width = bmpd.width;
			overlaySprite.height = bmpd.height;
			trace("bmpd.width: "+ bmpd.width);
			trace("bmpd.height: "+ bmpd.height);
			
			//this.addChild(overlaySprite);
			this.addChild(bmpd);
		}
		
		
		
		/////////////////////////////////////////////////////////////////////////
		///////////////  faces papervision planes toward camera  ////////////////
		/////////////////////////////////////////////////////////////////////////		
		
		public function faceTowardCamera(sceneObj:SceneObject){
			//rotate on y axis
			var planeRads:Number = Math.atan2(sceneObj.x, sceneObj.z);
			sceneObj.rotationY = (planeRads * 180 / Math.PI) ;
			
			//rotate on x axis
			
			planeRads = Math.atan2(sceneObj.y, sceneObj.z);
			sceneObj.rotationX = (planeRads * 180 / Math.PI);
			
		}
		
		
		
		/////////////////////////////////////////////////////////////////////////
		//////////////////////////  menu functionality  /////////////////////////
		/////////////////////////////////////////////////////////////////////////
		
		
		private function createRootMenu(){
			var newPanoramaImgItem:NativeMenuItem = new NativeMenuItem("New Collada File", false);			
			var newSceneObjectItem:NativeMenuItem = new NativeMenuItem("New Scene Object", false);
			var newVisionOverlayItem:NativeMenuItem = new NativeMenuItem("New Image Overlay", false);
			var newImpairmentItem:NativeMenuItem = new NativeMenuItem("New Mouse-Based Impairment", false);
			var optionsItem:NativeMenuItem = new NativeMenuItem("Panorama Options", false);

			var optionsSubmenu:NativeMenu = new NativeMenu();
			optionsSubmenu.addItem(newPanoramaImgItem);
			optionsSubmenu.addItem(newSceneObjectItem);
			optionsSubmenu.addItem(newVisionOverlayItem);	
			optionsSubmenu.addItem(newImpairmentItem);
			optionsSubmenu.addItem(optionsItem);
			
			///////  have to create menu's differently depending on if this is a pc or mac  ////////
  			if(NativeApplication.supportsMenu){//mac
				NativeApplication.nativeApplication.menu.addSubmenu(optionsSubmenu, "Options");
			} 
			else if(NativeWindow.supportsMenu){//windows, linux
				var windowMenu:NativeMenu = new NativeMenu();
				this.stage.nativeWindow.menu = windowMenu;
				windowMenu.addSubmenu(optionsSubmenu, "Options");
			}
			
			newPanoramaImgItem.addEventListener(Event.SELECT, onNewPanoramaItemSelect);
			newSceneObjectItem.addEventListener(Event.SELECT, onNewSceneObjectSelect);
			newVisionOverlayItem.addEventListener(Event.SELECT, onNewVisionOverlaySelect);
			newImpairmentItem.addEventListener(Event.SELECT, onVisionImpairmentSelect);
			optionsItem.addEventListener(Event.SELECT, onOptionsItemSelect);
		}		
				
		private function onOptionsItemSelect(e:Event){
			this.stage.addChild(infoPanel);
			
		}
		
		private function onNewPanoramaItemSelect(e:Event){
			dview.openFile("Bg"); 		
		}
		
		private function onNewVisionOverlaySelect(e:Event){
			dview.openFile("VisionOverlay");
		}
		private function onNewSceneObjectSelect(e:Event){
			dview.openFile("SceneObject");
		}

		private function onVisionImpairmentSelect(e:Event){
			dview.openFile("VisionImpairment");
		}

		//////////////////////////////////////////////////////////////////
		////////////////  testing the vision impairment  /////////////////
		//////////////////////////////////////////////////////////////////

		private function movingImpairmentInit(){
			//load a test bitmap
			var currentUrl:String = "glare.png"; 			
			var ldr:Loader;
			ldr= new Loader();
			configureListeners(ldr.contentLoaderInfo);
			var urlReq:URLRequest = new URLRequest(currentUrl);
			ldr.load(urlReq);			
					
		}
		
		// the function we'll be calling from editor
		public function addImpairment(bmp:Bitmap){
			try{
				mi.cleanup();
			}catch(e:Error){}
			mi = new MovingImpairment(this, bmp);
			this.addChild(mi);		
		}
		
		//////////////  loader event handlers for impairment test  ////////////////
		
        private function configureListeners(dispatcher:IEventDispatcher):void {
			dispatcher.addEventListener(Event.COMPLETE, DistortionLoadCompleteHandler);
			//dispatcher.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			//dispatcher.addEventListener(Event.OPEN, openHandler);
			//dispatcher.addEventListener(Event.UNLOAD, unLoadHandler);
        }		
		
		private function DistortionLoadCompleteHandler(e:Event){
			//add test overlay to stage
			//e.currentTarget.content is the bitmap
			var mi:MovingImpairment = new MovingImpairment(this, e.currentTarget.content);
			this.addChild(mi);
		}



	}
	
}








	
	

