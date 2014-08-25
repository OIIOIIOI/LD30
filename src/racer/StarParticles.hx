package racer;

import flash.display.Bitmap;
import flash.display.BitmapData;

/**
 * ...
 * @author 01101101
 */

class StarParticles extends Particle {
	
	public function new () {
		super();
		
		friction = 0.98;
		life = maxLife = 40 + Std.random(20);
		setParams(Std.random(360), 2);
		
		sprite = new Bitmap(new BitmapData(2, 2, true, 0xFFFADD58));
		sprite.scaleX = sprite.scaleY = scale;
		sprite.alpha = (4 + Std.random(7)) / 10;
	}
	
	public function setParams (deg:Float, s:Float) {
		deg += (Std.random(2)*2-1) * Std.random(5);
		deg = deg * Math.PI / 180;
		speed = s + (Std.random(2)*2-1) * (Std.random(5)/10);
		dx = Math.cos(deg) * speed;
		dy = Math.sin(deg) * speed;
	}
	
}
