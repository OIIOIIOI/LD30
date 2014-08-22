package ;

import flash.display.Sprite;
import flash.events.Event;
import flash.Lib;

/**
 * ...
 * @author 01101101
 */

class Main extends Sprite {
	
	public static function main () {
		Lib.current.stage.align = flash.display.StageAlign.TOP_LEFT;
		Lib.current.stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;
		Lib.current.addChild(new Main());
	}
	
	public function new () {
		super();
		
		var s = new Sprite();
		s.graphics.beginFill(0xFF00FF);
		s.graphics.drawRect(0, 0, 100, 100);
		s.graphics.endFill();
		this.addChild(s);
		
		trace("ok");
	}
	
}
