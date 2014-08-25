package racer;
import flash.display.Bitmap;
import flash.display.BitmapData;

/**
 * ...
 * @author 01101101
 */

class Particle extends Entity {
	
	var life:Int;
	var maxLife:Int;
	
	public function new () {
		super();
		
		life = maxLife = 30;
	}
	
	override public function update ()  {
		if (life > 0) {
			life--;
			if (life == 0)	dead = true;
		}
		
		super.update();
	}
	
}
