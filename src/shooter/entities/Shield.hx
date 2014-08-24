package shooter.entities;

import shooter.entities.Entity;

/**
 * ...
 * @author 01101101
 */
class Shield extends Entity {
	
	public function new () {
		super();
		
		type = EEType.TShield;
		
		radius = 35;
		
		color = 0xFFFFFF;
		draw();
		
		sprite.alpha = 0.4;
	}
	
}