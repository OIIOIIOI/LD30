package racer;

import flash.display.Sprite;

/**
 * ...
 * @author 01101101
 */

class Player extends Entity {
	
	static public var DASH_DELAY:Int = 180;
	
	var dashTimer:Int;
	
	public function new () {
		super();
		
		speed = 0.15;
		friction = 0.96;
		radius = 20;
		collided = true;
		
		dashTimer = 0;
		
		sprite = new Sprite();
		sprite.graphics.beginFill(0xFFFFFF);
		sprite.graphics.drawCircle(0, 0, radius);
		sprite.graphics.endFill();
	}
	
	override public function update () {
		if (dashTimer > 0)	dashTimer--;
		
		super.update();
	}
	
	public function dash () {
		if (dashTimer > 0)	return;
		dx *= 3;
		dy *= 3;
		dashTimer = DASH_DELAY;
	}
	
}
