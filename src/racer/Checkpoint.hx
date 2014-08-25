package racer;
import flash.display.Sprite;

/**
 * ...
 * @author 01101101
 */

class Checkpoint extends Entity {
	
	public var order(default, null):Int;
	
	public function new (o:Int) {
		super();
		
		order = o;
		
		radius = 10;
		
		sprite = new Sprite();
		sprite.graphics.beginFill(0x999999);
		sprite.graphics.drawCircle(0, 0, radius);
		sprite.graphics.endFill();
	}
	
}
