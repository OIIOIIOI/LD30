package racer;

import flash.display.Sprite;

/**
 * ...
 * @author 01101101
 */

class Asteroid extends Entity {
	
	public function new () {
		super();
		
		speed = 5;
		friction = 1;
		radius = 20;
		collided = true;
		
		var angle = Std.random(360) * Math.PI / 180;
		dx = Math.cos(angle) * speed;
		dy = Math.sin(angle) * speed;
		
		sprite = new Sprite();
		sprite.graphics.beginFill(0xFF0000);
		sprite.graphics.drawCircle(0, 0, radius);
		sprite.graphics.endFill();
	}
	
}
