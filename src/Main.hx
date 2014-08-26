package ;

import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.Lib;
import flash.text.Font;
import Man;

/**
 * ...
 * @author 01101101
 */

@:font("assets/font/Audiowide-Regular.ttf") class AudioWideFont extends Font { }
@:font("assets/font/RADIOLAND.TTF") class RadioLandFont extends Font { }

class Main {
	
	static function main () {
		var stage = Lib.current.stage;
		stage.scaleMode = StageScaleMode.NO_SCALE;
		stage.align = StageAlign.TOP_LEFT;
		
		Font.registerFont(AudioWideFont);
		Font.registerFont(RadioLandFont);
		
		KeyboardManager.init(Lib.current.stage);
		
		new SoundMan();
		
		new Man();
		Man.ins.changeScreen(EScreen.TITLE);
		
		Lib.current.stage.addEventListener(Event.ENTER_FRAME, update);
	}
	
	static function update (e:Event) {
		SoundMan.ins.update();
		Man.ins.update();
	}
	
}
