package shooter.entities;

import shooter.entities.Entity;

/**
 * ...
 * @author 01101101
 */
class Enemy extends Entity {
	
	static public var SHOOT_DELAY:Int = 180;
	
	public var dangerZone:Int;
	public var shootTimer:Int;
	
	public function new () {
		super();
		
		type = EEType.TEnemy;
		
		radius = 30;
		dangerZone = 120;
		shootTimer = SHOOT_DELAY;
		
		color = 0xFF0000;
		draw();
	}
	
	override public function update ()  {
		super.update();
		
		if (shootTimer > 0)	shootTimer--;
	}
	
}