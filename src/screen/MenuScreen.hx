package screen;

import screen.Screen;
import Man;

/**
 * ...
 * @author 01101101
 */

class MenuScreen extends Screen {
	var testBtn :MenuBtn;
	
	public function new () {
		super();
		testBtn = new MenuBtn(Test, btnAction);
		addChild(testBtn);
	}
	override public function kill ()  {
		super.kill();
		testBtn.kill();
	}
	function btnAction() {
		Man.ins.changeScreen(EScreen.SHOOTER);
	}
	
}