package racer;
import flash.display.Sprite;

/**
 * ...
 * @author 01101101
 */
class Next extends Entity {
	
	public function new () {
		super();
		
		radius = 20;
		constrained = false;
		
		sprite = new Sprite();
		sprite.graphics.beginFill(0xFFFF00, 0.3);
		sprite.graphics.drawCircle(0, 0, radius);
		sprite.graphics.endFill();
	}
	
}