﻿package com.healthysight.impairments{		import flash.geom.Point;		public class DistortionPoint extends flash.geom.Point{				public var range:int;		public var mass:Number;				public function DistortionPoint(... opt){			if(opt.length >3){				mass = opt[2];			}			else{				mass = 1;			}			if(opt.length >4){			   	range = opt[3];			}			else{				range = 1;			}						this.x=opt[0];			this.y=opt[1];			super();		}			}	}				