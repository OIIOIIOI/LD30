package shooter.entities;

import flash.geom.Point;
import shooter.entities.AnimEntity.Anim;

/**
 * ...
 * @author 01101101
 */

class StarShrimp extends AnimEntity {
	
	static public var ANIM_IDLE:String = "anim_idle";
	static public var ANIM_SHOOT:String = "anim_shoot";
	static public var ANIM_SUCK:String = "anim_suck";
	static public var ANIM_DEAD:String = "anim_dead";
	
	var target:Point;
	var offset:Point;
	
	public function new () {
		super();
		
		anims = new Map();
		
		var a = new Anim();
		a.addFrame(0, -16, -16);
		a.addFrame(1, -16, -16);
		anims.set(ANIM_IDLE, a);
		
		a = new Anim();
		a.addFrame(2, -16, -16);
		a.addFrame(3, -16, -16);
		anims.set(ANIM_SHOOT, a);
		
		a = new Anim();
		a.addFrame(4, -16, -16);
		a.addFrame(5, -16, -16);
		anims.set(ANIM_SUCK, a);
		
		a = new Anim();
		a.addFrame(6, -16, -16);
		anims.set(ANIM_DEAD, a);
		
		curAnim = ANIM_IDLE;
		anims.get(curAnim).reset();
		
		w = h = 32;
		
		target = new Point(Const.CANVAS_WIDTH / 2, Const.CANVAS_HEIGHT / 2);
		setOffset();
	}
	
	public function setTarget (x:Float, y:Float) {
		target.x = x;
		target.y = y;
	}
	
	function setOffset () {
		if (offset == null)	offset = new Point();
		offset.x = Std.random(5) * (Std.random(2)*2-1);
		offset.y = Std.random(5) * (Std.random(2)*2-1);
	}
	
	public function suck (v:Bool = true) {
		if (v)	curAnim = ANIM_SUCK;
		else	curAnim = ANIM_IDLE;
		anims.get(curAnim).reset();
	}
	
	override public function update ()  {
		super.update();
		
		x += ((target.x + offset.x) - x) * 0.05;
		y += ((target.y + offset.y) - y) * 0.05;
		
		if (Math.abs((target.x + offset.x) - x) < 1 && Math.abs((target.y + offset.y) - y) < 1) {
			setOffset();
		}
	}
	
}
