package ;

import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.Lib;
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
		
		Lib.current.stage.addChild(new Shooter());
	}
}
