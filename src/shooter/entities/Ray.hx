package shooter.entities;

import shooter.entities.AnimEntity.Anim;

/**
 * ...
 * @author 01101101
 */
class Ray extends AnimEntity {
	
	static public var ANIM_IDLE:String = "anim_idle";
	
	public function new () {
		super();
		
		anims = new Map();
		
		var a = new Anim();
		a.addFrame(4, 0, -24);
		anims.set(ANIM_IDLE, a);
		
		curAnim = ANIM_IDLE;
		anims.get(curAnim).reset();
	}
	
}