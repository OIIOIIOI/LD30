package shooter.entities;

import flash.display.Sprite;

/**
 * ...
 * @author 01101101
 */

class Entity {
	
	public var x:Float;
	public var y:Float;
	public var dx:Float;
	public var dy:Float;
	public var friction:Float;
	public var radius:Int;
	public var speed:Float;
	public var dead:Bool;
	public var lockable:Bool;
	public var life:Int;
	
	public var type:EEType;
	
	public var sprite:EntitySprite;
	var color:UInt;
	
	public function new () {
		x = y = 0;
		friction = 1;
		radius = 20;
		dx = dy = 0;
		life = 1;
		
		type = EEType.TUnknown;
		dead = false;
		lockable = false;
		
		color = 0xFF00FF;
		draw();
	}
	
	public function draw () {
		if (sprite == null) {
			sprite = new EntitySprite(this);
			sprite.mouseEnabled = false;
		}
		else sprite.graphics.clear();
		sprite.graphics.beginFill(color);
		sprite.graphics.drawCircle(0, 0, radius);
		sprite.graphics.endFill();
	}
	
	public function damage (d:Int = 1) {
		life -= d;
		if (life <= 0)	dead = true;
	}
	
	public function update () {
		dx *= friction;
		if (Math.abs(dx) < 0.01)	dx = 0;
		dy *= friction;
		if (Math.abs(dy) < 0.01)	dy = 0;
		x += dx;
		y += dy;
		
		sprite.x = x;
		sprite.y = y;
	}
	
}

class EntitySprite extends Sprite {
	
	public var entity:Entity;
	
	public function new (e:Entity) {
		super();
		
		entity = e;
	}
	
}

enum EEType {
	TAsteroid;
	TPlayer;
	TEnemy;
	TBullet;
	TShield;
	TUnknown;
}
