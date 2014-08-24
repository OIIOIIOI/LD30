package shooter.entities;

import flash.display.BitmapData;
import flash.geom.Point;

/**
 * ...
 * @author 01101101
 */

class Particle extends Entity {
	
	var target:Point;
	
	public function new () {
		super();
		
		var col = (Std.random(0xCC) << 24) | 0xFFFFFF;
		data = new BitmapData(1, 1, true, col);
		
		target = new Point();
	}
	
	public function setTarget (x:Float, y:Float) {
		target.x = x;
		target.y = y;
	}
	
	override public function update ()  {
		super.update();
		
		x += (target.x - x) * 0.1;
		y += (target.y - y) * 0.1;
		
		if (Math.abs(target.x - x) < 1 && Math.abs(target.y - y) < 1) {
			dead = true;
		}
	}
	
}
