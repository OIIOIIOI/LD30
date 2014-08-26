package screen;

import flash.display.Loader;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.ProgressEvent;
import flash.net.URLRequest;
import Man;

/**
 * ...
 * @author 01101101
 */
class EndScreen extends Screen {
	
	var loader:Loader;
	
	var bar:Sprite;
	var barbg:Sprite;
	
	public function new () {
		super();
		
		loader = new Loader();
		loader.load(new URLRequest("ending.swf"));
		loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, progressHandler);
		loader.contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler);
		
		barbg = new Sprite();
		barbg.graphics.beginFill(0x000000);
		barbg.graphics.drawRect(0, 0, 400, 10);
		barbg.graphics.endFill();
		barbg.x = (Const.STAGE_WIDTH - barbg.width) / 2;
		barbg.y = Const.STAGE_HEIGHT / 2;
		addChild(barbg);
		
		bar = new Sprite();
		bar.graphics.beginFill(0xCCCCCC);
		bar.graphics.drawRect(0, 0, 400, 10);
		bar.graphics.endFill();
		bar.x = barbg.x;
		bar.y = barbg.y;
		bar.scaleX = 0;
		addChild(bar);
	}
	
	override public function update ()  {
		super.update();
		
		if (loader.content != null) {
			var mc = cast(loader.content, MovieClip);
			if (mc.currentFrame == mc.totalFrames) {
				mc.stop();
				removeChild(loader);
				Man.ins.changeScreen(EScreen.TITLE);
			}
		}
	}
	
	function completeHandler (e:Event) {
		removeChild(bar);
		removeChild(barbg);
		
		SoundMan.ins.killAll(null);
		
		loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, completeHandler);
		loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, progressHandler);
		addChild(loader);
	}
	
	function progressHandler (e:ProgressEvent) {
		bar.scaleX = e.bytesLoaded / e.bytesTotal;
	}
	
}