package racer;
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.geom.Point;

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
	
	var scale:Int;
	var offset:Point;
	
	public var dead:Bool;
	public var constrained:Bool;
	public var collided:Bool;
	public var bubbling:Bool;
	
	var wasConstrained:Bool;
	
	public var sprite:Bitmap;
	var animDelay:Int;
	var animIndex:Int;
	
	public var colSprite:Sprite;
	
	public function new () {
		x = y = 0;
		dx = dy = 0;
		speed = 0;
		friction = 1;
		radius = 0;
		scale = 1;
		offset = new Point();
		dead = false;
		constrained = true;
		collided = false;
		bubbling = false;
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
			// Anim
			if (animDelay > 0) {
				animDelay--;
				if (animDelay == 0) nextFrame();
			}
			// Sprite
			var dir = sprite.scaleX / scale;
			if (dx < 0)			dir = -1;
			else if (dx > 0) 	dir = 1;
			sprite.scaleX = dir * scale;
			sprite.x = x - (sprite.width / 2 + offset.x) * dir;
			sprite.y = y - sprite.height / 2 + offset.y;
		}
		// Debug collision
		if (colSprite != null) {
			colSprite.alpha = 0.5;
			colSprite.x = x;
			colSprite.y = y;
		}
	}
	
	function nextFrame () { }
	
}

enum EEntityType {
	CHECKPOINT;
	ASTEROID;
	SHARK;
	LOBSTER;
}
