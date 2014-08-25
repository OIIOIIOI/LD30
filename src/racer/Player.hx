package racer;

import flash.display.Bitmap;
import flash.display.Sprite;

/**
 * ...
 * @author 01101101
 */

class Player extends Entity {
	
	static public var DASH_DELAY:Int = 180;
	
	var dashTimer:Int;
	
	public function new () {
		super();
		
		speed = 0.15;
		friction = 0.96;
		radius = 25;
		collided = true;
		
		dashTimer = 0;
		
		sprite = new Bitmap(SpriteSheet.ins.getTile("shrimp0"));
		sprite.scaleX = sprite.scaleY = 2;
		
		colSprite = new Sprite();
		colSprite.graphics.beginFill(0xFFFFFF);
		colSprite.graphics.drawCircle(0, 0, radius);
		colSprite.graphics.endFill();
	}
	
	override public function update () {
		if (dashTimer > 0)	dashTimer--;
		
		super.update();
	}
	
	public function dash () {
		if (dashTimer > 0)	return;
		dx *= 4;
		dy *= 4;
		dashTimer = DASH_DELAY;
	}
	
}
