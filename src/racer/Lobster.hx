package racer;
import flash.display.Sprite;

/**
 * ...
 * @author 01101101
 */

class Lobster extends Entity {
	
	public var sightRadius:Int;
	
	public function new () {
		super();
		
		speed = 10;
		friction = 0.95;
		radius = 20;
		collided = true;
		
		sightRadius = 150;
		
		sprite = new Sprite();
		sprite.graphics.beginFill(0x9900FF);
		sprite.graphics.drawCircle(0, 0, radius);
		sprite.graphics.endFill();
	}
	
	public function goForEntity (e:Entity) {
		if (dx != 0 || dy != 0)	return;
		
		var distX = x - e.x;
		var distY = y - e.y;
		var dist = Math.sqrt(distX * distX + distY * distY);
		if (dist < sightRadius) {
			var a = Math.atan2(e.y - y, e.x - x);
			dx = Math.cos(a) * speed;
			dy = Math.sin(a) * speed;
		}
	}
	
}
