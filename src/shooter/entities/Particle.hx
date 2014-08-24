package shooter.entities;

import flash.display.BitmapData;

/**
 * ...
 * @author 01101101
 */

class Particle extends Entity {
	
	public function new () {
		super();
		
		data = new BitmapData(1, 1, true, 0x80FFFFFF);
	}
	
	override public function update ()  {
		super.update();
		
		//e.x += (e.x - x) * 0.5;
		//e.y += (e.y - y) * 0.5;
	}
	
}
