package shooter.entities;

import shooter.entities.Entity;

/**
 * ...
 * @author 01101101
 */
class Player extends Entity {
	
	public function new () {
		super();
		
		type = EEType.TPlayer;
		life = 3;
		radius = 40;
		
		color = 0xFFFFFF;
		draw();
	}
	
	override public function damage (d:Int = 1) {
		super.damage(d);
		trace("Player health: " + life);
	}
	
}