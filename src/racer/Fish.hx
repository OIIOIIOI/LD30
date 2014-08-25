package racer;
import flash.display.Bitmap;

/**
 * ...
 * @author 01101101
 */
class Fish extends Entity {
	
	public var shark:Shark;
	
	public function new (s:Shark) {
		super();
		
		shark = s;
		
		sprite = new Bitmap(SpriteSheet.ins.getTile("fish0"));
		sprite.scaleX = sprite.scaleY = scale;
		
		animDelay = 5;
	}
	
	override public function update ()  {
		super.update();
		
		sprite.scaleX = shark.sprite.scaleX;
		x = shark.x + shark.target.x * 0.5;
		y = shark.y + shark.target.y * 0.5;
	}
	
	override function nextFrame ()  {
		animIndex++;
		sprite.bitmapData = SpriteSheet.ins.getTile("fish" + (animIndex % 2));
		animDelay = 5;
	}
	
}