package shooter.entities;

import shooter.entities.AnimEntity.Anim;

/**
 * ...
 * @author 01101101
 */

class StarShrimp extends AnimEntity {
	
	static public var ANIM_IDLE:String = "anim_idle";
	
	public function new () {
		super();
		
		anims = new Map();
		
		var a = new Anim();
		a.addFrame(0);
		a.addFrame(1);
		anims.set(ANIM_IDLE, a);
		
		curAnim = ANIM_IDLE;
		anims.get(curAnim).reset();
		
		w = h = 32;
	}
	
}
