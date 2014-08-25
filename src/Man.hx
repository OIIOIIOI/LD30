package ;

import flash.Lib;
import racer.Racer;
import screen.MenuScreen;
import screen.Screen;
import shooter.Shooter;

/**
 * ...
 * @author 01101101
 */

class Man {
	
	public static var ins:Man;
	
	var curEScr:EScreen;
	var curScr:Screen;
	
	public function new () {
		if (Man.ins != null)	return;
		
		Man.ins = this;
	}
	
	public function changeScreen (e:EScreen) {
		// Kill current screen
		if (curScr != null) {
			//trace("KILL " + curEScr);
			if (Lib.current.stage.contains(curScr))	Lib.current.stage.removeChild(curScr);
			curScr.kill();
			curScr = null;
		}
		// Set up new screen
		//trace("CREATE " + e);
		curScr = switch (e) {
			case EScreen.MENU:			new MenuScreen();
			case EScreen.SHOOTER:		new Shooter();
			case EScreen.RACER:			new Racer();
		}
		Lib.current.stage.addChild(curScr);
		curEScr = e;
	}
	
	public function update () {
		if (curScr != null) {
			curScr.update();
		}
	}
	
}

enum EScreen {
	MENU;
	SHOOTER;
	RACER;
}
