package racer;
import flash.display.Bitmap;

/**
 * ...
 * @author 01101101
 */
class BubbleParticle extends Particle {
	
	public function new () {
		super();
		
		friction = 0.98;
		life = maxLife = 0;
		setParams(Std.random(360), 0.5);
		
		animIndex = Std.random(2);
		sprite = new Bitmap(SpriteSheet.ins.getTile("bubble"+animIndex));
		sprite.scaleX = sprite.scaleY = scale;
		
		animDelay = 10;
	}
	
	public function setParams (deg:Float, s:Float) {
		deg += (Std.random(2)*2-1) * Std.random(5);
		deg = deg * Math.PI / 180;
		speed = s;
		dx = Math.cos(deg) * speed;
		dy = Math.sin(deg) * speed;
	}
	
	override function nextFrame ()  {
		animIndex++;
		if (animIndex == 4) {
			dead = true;
			sprite.visible = false;
			return;
		}
		sprite.bitmapData = SpriteSheet.ins.getTile("bubble" + (animIndex % 4));
		animDelay = 10;
	}
	
}