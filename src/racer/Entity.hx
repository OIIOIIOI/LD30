package racer;
import flash.display.Sprite;

/**
 * ...
 * @author 01101101
 */

class Entity {
	
	public var x:Float;
	public var y:Float;
	public var dx:Float;
	public var dy:Float;
	public var speed:Float;
	public var friction:Float;
	public var radius:Int;
	public var dead:Bool;
	public var constrained:Bool;
	public var collided:Bool;
	
	var wasConstrained:Bool;
	
	public var sprite:Sprite;
	
	public function new () {
		x = y = 0;
		dx = dy = 0;
		speed = 0;
		friction = 1;
		radius = 0;
		dead = false;
		constrained = true;
		collided = false;
	}
	
	public function update () {
		wasConstrained = false;
		
		dx *= friction;
		if (Math.abs(dx) < 0.01)	dx = 0;
		dy *= friction;
		if (Math.abs(dy) < 0.01)	dy = 0;
		x += dx;
		y += dy;
		
		if (constrained) {
			// Constrain x
			if (x < radius) {
				x = radius;
				dx = -dx;
				wasConstrained = true;
			} else if (x > Const.STAGE_WIDTH - radius) {
				x = Const.STAGE_WIDTH - radius;
				dx = -dx;
				wasConstrained = true;
			}
			// Constrain y
			if (y < radius) {
				y = radius;
				dy = -dy;
				wasConstrained = true;
			} else if (y > Const.STAGE_HEIGHT - radius) {
				y = Const.STAGE_HEIGHT - radius;
				dy = -dy;
				wasConstrained = true;
			}
		}
		
		if (sprite != null) {
			sprite.x = x;
			sprite.y = y;
		}
	}
	
}
