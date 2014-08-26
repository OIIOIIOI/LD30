package ;

import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.net.URLLoader;
import flash.net.URLLoaderDataFormat;
import flash.net.URLRequest;
import flash.net.URLRequestMethod;
import flash.net.URLVariables;

/**
 * ...
 * @author 01101101
 */

class ScoreManager {
	
	//static var cbf:Bool->Void;
	
	static public function save (level:String, score:Float, pseudo:String) {
		
		var vars:URLVariables = new URLVariables();
		
		var req:URLRequest = new URLRequest("save.php");
		req.method = URLRequestMethod.POST;
		req.data = vars;
		
		var loader:URLLoader = new URLLoader();
		loader.dataFormat = URLLoaderDataFormat.VARIABLES;
		
		vars.level = level;
		vars.score = score;
		vars.pseudo = pseudo;
		
		//cbf = cb;
		
		loader.addEventListener(Event.COMPLETE, completeHandler);
		loader.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
		loader.load(req);
	}
	
	static function errorHandler (e:IOErrorEvent) {
		//if (cbf != null)	cbf(false);
	}
	
	static function completeHandler (e:Event) {
		//if (e.target.data.r == "error" && cbf != null)	cbf(false);
		//else if (cbf != null)	cbf(true);
	}
	
}