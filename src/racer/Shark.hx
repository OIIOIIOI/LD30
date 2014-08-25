package racer;

import flash.display.Bitmap;
import flash.display.Sprite;
import flash.geom.Point;

/**
 * ...
 * @author 01101101
 */

class Shark extends Entity {
	
	static var T_OFFSET:Int = 100;
	static var T_RADIUS:Int = 10;
	static var T_ANGLE:Int = 10;
	
	var angle:Float;
	var subAngle:Float;
	public var target:Point;
	
	public function new () {
		super();
		
		speed = 2;
		friction = 1;
		radius = 15*scale;
		offset.x = 3*scale;
		collided = true;
		bubbling = true;
		
		angle = Std.random(360) * Math.PI / 180;
		dx = Math.cos(angle) * speed;
		dy = Math.sin(angle) * speed;
		target = new Point(Math.cos(angle) * T_OFFSET, Math.sin(angle) * T_OFFSET);
		subAngle = Std.random(360);
		
		sprite = new Bitmap(SpriteSheet.ins.getTile("shark0"));
		sprite.scaleX = sprite.scaleY = scale;
		
		animDelay = 15;
		
		colSprite = new Sprite();
		colSprite.graphics.beginFill(0x0000FF);
		colSprite.graphics.drawCircle(0, 0, radius);
		colSprite.graphics.endFill();
	}
	
	public function refreshTarget () {
		angle = Math.atan2(dy, dx);
		subAngle = angle * 180 / Math.PI;
		target.x = Math.cos(angle) * T_OFFSET;
		target.y = Math.sin(angle) * T_OFFSET;
	}
	
	override public function update () {
		subAngle += (Std.random(2)*2-1) * Std.random(T_ANGLE);
		target.x += Math.cos(subAngle * Math.PI / 180) * T_RADIUS;
		target.y += Math.sin(subAngle * Math.PI / 180) * T_RADIUS;
		
		angle = Math.atan2(target.y, target.x);
		target.x = Math.cos(angle) * T_OFFSET;
		target.y = Math.sin(angle) * T_OFFSET;
		dx = Math.cos(angle) * speed;
		dy = Math.sin(angle) * speed;
		
		/*sprite.graphics.clear();
		sprite.graphics.beginFill(0x0000FF);
		sprite.graphics.drawCircle(0, 0, radius);
		sprite.graphics.endFill();
		sprite.graphics.beginFill(0x0000FF);
		sprite.graphics.drawCircle(target.x, target.y, T_RADIUS);
		sprite.graphics.endFill();*/
		
		super.update();
		
		if (wasConstrained)	refreshTarget();
	}
	
	override function nextFrame ()  {
		animIndex++;
		sprite.bitmapData = SpriteSheet.ins.getTile("shark" + (animIndex % 2));
		animDelay = 15;
	}
	
}







