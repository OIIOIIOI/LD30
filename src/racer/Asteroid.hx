package racer;

import flash.display.Bitmap;
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
		radius = 18*scale;
		collided = true;
		
		var angle = Std.random(360) * Math.PI / 180;
		dx = Math.cos(angle) * speed;
		dy = Math.sin(angle) * speed;
		
		sprite = new Bitmap(SpriteSheet.ins.getTile("asteroid0"));
		sprite.scaleX = sprite.scaleY = scale;
		
		animDelay = 15;
		
		colSprite = new Sprite();
		colSprite.graphics.beginFill(0xFF0000);
		colSprite.graphics.drawCircle(0, 0, radius);
		colSprite.graphics.endFill();
	}
	
	override function nextFrame ()  {
		animIndex++;
		sprite.bitmapData = SpriteSheet.ins.getTile("asteroid" + (animIndex % 2));
		animDelay = 15;
	}
	
}
