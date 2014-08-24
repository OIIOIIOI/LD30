package screen;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.utils.Function;

/**
 * ...
 * @author Grmpf
 */

@:bitmap("assets/img/testBtn.jpg") class TestBtnBitmap extends BitmapData {}
 
class MenuBtn extends Sprite
{
	var action :Void->Void;
	var loadedBitmap :BitmapData;
	
	public function new(btnAspect:BtnAspect,action:Void->Void) 
	{
		super();
		var currentBtnAspect = new Bitmap();
		this.action = action;
		switch(btnAspect) {
			case Test:
				loadedBitmap = new TestBtnBitmap(98, 44);
				currentBtnAspect.bitmapData = loadedBitmap;
				this.addChild(currentBtnAspect);
			default:
		}
		this.addEventListener(MouseEvent.CLICK, execute);
	}
	
	private function execute(e:MouseEvent):Void 
	{
		action();
	}
	public function kill() {
		loadedBitmap.dispose();
	}
}
enum BtnAspect {
	Test;
}
