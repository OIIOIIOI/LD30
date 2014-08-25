package ;

import flash.display.Loader;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.ProgressEvent;
import flash.net.URLRequest;

/**
 * ...
 * @author 01101101
 */

class Test extends Sprite {
	
	var loader:Loader;
	
	public function new () {
		super();
		
		loader = new Loader();
		loader.load(new URLRequest("intro.swf?v="+Std.random(999)));
		loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, progressHandler);
		loader.contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler);
	}
	
	function completeHandler (e:Event) {
		loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, completeHandler);
		loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, progressHandler);
		addChild(loader);
	}
	
	function progressHandler (e:ProgressEvent) {
		trace(e.bytesLoaded + " / " + e.bytesTotal);
	}
	
}
