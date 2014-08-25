package racer;
import flash.display.Bitmap;
import flash.display.Sprite;

/**
 * ...
 * @author 01101101
 */
class Next extends Entity {
	
	public function new () {
		super();
		
		radius = 20;
		constrained = false;
		
		sprite = new Bitmap(SpriteSheet.ins.getTile("next"));
		sprite.scaleX = sprite.scaleY = scale;
		
		animDelay = 15;
		
		colSprite = new Sprite();
		colSprite.graphics.beginFill(0xFFFF00, 0.3);
		colSprite.graphics.drawCircle(0, 0, radius);
		colSprite.graphics.endFill();
	}
	
	override function nextFrame ()  {
		sprite.scaleX = -sprite.scaleX;
		animDelay = 10;
	}
	
}