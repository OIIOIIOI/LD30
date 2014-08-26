package racer;

import flash.display.Bitmap;
import flash.display.Sprite;

/**
 * ...
 * @author 01101101
 */

class Player extends Entity {
	
	static public var DASH_DELAY:Int = 180;
	
	public var dashTimer:Int;
	
	public function new () {
		super();
		
		speed = 0.15;
		friction = 0.96;
		radius = 13*scale;
		collided = true;
		bubbling = true;
		
		dashTimer = 0;
		
		sprite = new Bitmap(SpriteSheet.ins.getTile("shrimp0"));
		sprite.scaleX = sprite.scaleY = scale;
		
		animDelay = 15;
		
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
		SoundMan.ins.playSFX("dash");
	}
	
	override function nextFrame ()  {
		animIndex++;
		sprite.bitmapData = SpriteSheet.ins.getTile("shrimp" + ((animIndex % 2) + 0));
		animDelay = 15;
	}
	
}
