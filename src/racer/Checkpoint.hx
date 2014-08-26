package racer;

import flash.display.Bitmap;
import flash.display.Sprite;

/**
 * ...
 * @author 01101101
 */

class Checkpoint extends Entity {
	
	public var order(default, null):Int;
	var version:Int;
	
	public function new (o:Int) {
		super();
		
		order = o;
		version = Std.random(8);
		
		radius = 14*scale;
		
		sprite = new Bitmap(SpriteSheet.ins.getTile("starOff"));
		sprite.scaleX = sprite.scaleY = scale;
		
		colSprite = new Sprite();
		colSprite.graphics.beginFill(0x999999);
		colSprite.graphics.drawCircle(0, 0, radius);
		colSprite.graphics.endFill();
	}
	
	public function turnOn () {
		sprite.bitmapData = SpriteSheet.ins.getTile("star"+version+"on");
	}
	
	public function toString () {
		return x + ", " + y;
	}
	
}
