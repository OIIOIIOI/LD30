package racer;
import flash.display.Bitmap;
import flash.display.Sprite;

/**
 * ...
 * @author 01101101
 */

class DashMeter extends Entity {
	
	public function new () {
		super();
		
		scale = 3;
		
		sprite = new Bitmap(SpriteSheet.ins.getTile("dash0"));
		sprite.scaleX = sprite.scaleY = scale;
	}
	
	override public function update ()  {
		super.update();
		
		x = Const.STAGE_WIDTH - sprite.width / 2;
		y = Const.STAGE_HEIGHT - sprite.height / 2;
	}
	
	public function draw (v:Int, t:Int) {
		var i = 4 - Math.ceil(v * 4 / t);
		sprite.bitmapData = SpriteSheet.ins.getTile("dash"+i);
	}
	
}
