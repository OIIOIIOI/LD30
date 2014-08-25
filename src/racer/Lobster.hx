package racer;
import flash.display.Bitmap;
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
		radius = 30;
		offset.x = 7;
		collided = true;
		
		sightRadius = 150;
		
		sprite = new Bitmap(SpriteSheet.ins.getTile("lobster0"));
		sprite.scaleX = sprite.scaleY = 2;
		
		colSprite = new Sprite();
		colSprite.graphics.beginFill(0x9900FF);
		colSprite.graphics.drawCircle(0, 0, radius);
		colSprite.graphics.endFill();
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
