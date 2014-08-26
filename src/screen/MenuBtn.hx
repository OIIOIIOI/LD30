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

@:bitmap("assets/img/startBtn.png") class StartBtnBitmap extends BitmapData {}
@:bitmap("assets/img/lftBtn.png") class LeftBtnBitmap extends BitmapData {}
@:bitmap("assets/img/rghtBtn.png") class RightBtnBitmap extends BitmapData {}
 
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
			case Start:
				loadedBitmap = new StartBtnBitmap(300, 100);
				currentBtnAspect.bitmapData = loadedBitmap;
				this.addChild(currentBtnAspect);
			case Left:
				loadedBitmap = new LeftBtnBitmap(50, 50);
				currentBtnAspect.bitmapData = loadedBitmap;
				this.addChild(currentBtnAspect);
			case Right:
				loadedBitmap = new RightBtnBitmap(50, 50);
				currentBtnAspect.bitmapData = loadedBitmap;
				this.addChild(currentBtnAspect);
			default:
		}
		this.addEventListener(MouseEvent.CLICK, execute);
		buttonMode = true;
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
	Start;
	Left;
	Right;
}
