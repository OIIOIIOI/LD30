package shooter.entities;

import shooter.entities.Entity;

/**
 * ...
 * @author 01101101
 */
class Bullet extends Entity {
	
	public function new () {
		super();
		
		type = EEType.TBullet;
		
		radius = 4;
		speed = 4;
		
		color = 0xFFFF00;
		draw();
	}
	
}