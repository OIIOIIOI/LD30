package screen;
import flash.display.Bitmap;
import flash.display.BitmapData;
import Man;

/**
 * ...
 * @author Grmpf
 */

@:bitmap("assets/img/title_screen.png") class TitleBG extends BitmapData { }

class TitleScreen extends Screen
{
	var titleScreen :Bitmap;
	
	public function new() 
	{
		super();
		titleScreen = new Bitmap();
		titleScreen.bitmapData = new TitleBG(900,610);
		addChild(titleScreen);
		KeyboardManager.setCallback(13, gotoLvlSelect);
		var startBtn = new MenuBtn(Start, gotoLvlSelect);
		startBtn.x = 180;
		startBtn.y = 530;
		startBtn.scaleX = 0.5;
		startBtn.scaleY = 0.5;
		addChild(startBtn);
	}
	private function gotoLvlSelect() {
		kill();
		Man.ins.changeScreen(EScreen.MENU);
	}
	override public function kill() {
		KeyboardManager.deleteCallback(13);
		titleScreen.bitmapData.dispose();
	}
	
}