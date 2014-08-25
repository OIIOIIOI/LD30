package racer;
import flash.display.Bitmap;

/**
 * ...
 * @author 01101101
 */

class Cockpit extends Entity {
	
	public function new () {
		super();
		
		scale = 3;
		
		sprite = new Bitmap(SpriteSheet.ins.getTile("cockpit0"));
		sprite.scaleX = sprite.scaleY = scale;
		
		animDelay = 15;
	}
	
	public function hurt () {
		animIndex = 2;
		sprite.bitmapData = SpriteSheet.ins.getTile("cockpit" + animIndex);
		animDelay = 60;
	}
	
	override function nextFrame ()  {
		if (animIndex == 0) {
			animIndex = 1;
			animDelay = 5;
		} else {
			animIndex = 0;
			animDelay = 90 + Std.random(120);
		}
		sprite.bitmapData = SpriteSheet.ins.getTile("cockpit"+animIndex);
	}
	
	override public function update ()  {
		super.update();
		
		x = Const.STAGE_WIDTH - sprite.width / 2;
		y = Const.STAGE_HEIGHT - 30 - sprite.height / 2;
	}
	
}
