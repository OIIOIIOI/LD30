package ;

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.Lib;

/**
 * ...
 * @author 01101101
 */

class Main {
	
	
	static function main () {
		var stage = Lib.current.stage;
		stage.scaleMode = StageScaleMode.NO_SCALE;
		stage.align = StageAlign.TOP_LEFT;
		
		var shooterBG = new SpaceBG(stage.stageHeight, stage.stageWidth, 0, 0);
		stage.addChild(shooterBG);
		var starShrimp = new Shrimp();
		stage.addChild(starShrimp);
		
	
		function testAnim(e:KeyboardEvent):Void 
		{
			shooterBG.update();
		}
		stage.addEventListener(KeyboardEvent.KEY_DOWN, testAnim);
	}
}
