package shooter.entities;

import flash.Lib;
import shooter.entities.Entity;

/**
 * ...
 * @author 01101101
 */

class Asteroid extends Entity {
	
	public function new () {
		super();
		
		type = EEType.TAsteroid;
		lockable = true;
		
		radius = 30;
		speed = Std.random(10) / 10;
		var angle = Std.random(360) * Math.PI / 180;
		dx = Math.cos(angle) * speed;
		dy = Math.sin(angle) * speed;
		
		color = 0x808080;
		draw();
		
		sprite.buttonMode = true;
		sprite.mouseEnabled = true;
	}
	
	override public function update ()  {
		super.update();
	}
	
}
