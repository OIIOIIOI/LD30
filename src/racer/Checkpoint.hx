package racer;
import flash.display.Bitmap;
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
		
		radius = 20;
		
		sprite = new Bitmap(SpriteSheet.ins.getTile("star" + Std.random(8)));
		sprite.scaleX = sprite.scaleY = 2;
		
		colSprite = new Sprite();
		colSprite.graphics.beginFill(0x999999);
		colSprite.graphics.drawCircle(0, 0, radius);
		colSprite.graphics.endFill();
	}
	
	public function toString () {
		return x + ", " + y;
	}
	
}
