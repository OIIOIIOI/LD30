package racer;
import flash.display.Sprite;

/**
 * ...
 * @author 01101101
 */

class Player extends Entity {
	
	public function new () {
		super();
		
		speed = 0.15;
		friction = 0.97;
		radius = 20;
		
		sprite = new Sprite();
		sprite.graphics.beginFill(0xFFFFFF);
		sprite.graphics.drawCircle(0, 0, radius);
		sprite.graphics.endFill();
	}
	
}
