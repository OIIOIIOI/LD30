package ;

import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.Lib;
import Man;
import shooter.Shooter;

/**
 * ...
 * @author 01101101
 */

class Main {
	
	static function main () {
		var stage = Lib.current.stage;
		stage.scaleMode = StageScaleMode.NO_SCALE;
		stage.align = StageAlign.TOP_LEFT;
		
		new Man();
		
		Man.ins.changeScreen(EScreen.MENU);
		
		Lib.current.stage.addEventListener(Event.ENTER_FRAME, update);
	}
	
	static function update (e:Event) {
		Man.ins.update();
	}
	
}
