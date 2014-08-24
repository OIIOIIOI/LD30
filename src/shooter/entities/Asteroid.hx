package shooter.entities;

import flash.display.BitmapData;
import shooter.entities.AnimEntity.Anim;

/**
 * ...
 * @author 01101101
 */

class Asteroid extends AnimEntity {
	
	static public var ANIM_IDLE:String = "anim_idle";
	
	public function new () {
		super();
		
		anims = new Map();
		
		var a = new Anim();
		a.addFrame(10, -16, -16);
		anims.set(ANIM_IDLE, a);
		
		w = h = 32;
		ox = oy = -8;
		friction = 0.97;
		
		suckable = true;
		weight = 1;
		
		curAnim = ANIM_IDLE;
		anims.get(curAnim).reset();
	}
	
}
