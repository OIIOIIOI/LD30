package ;

import flash.display.Stage;
import flash.events.KeyboardEvent;

/**
 * ...
 * @author 01101101
 */

typedef CBObject = {
	var param:Dynamic;
	var call:Dynamic;
	var once:Bool;
}

class KeyboardManager
{
	
	private static var stage:Stage;
	private static var keys:Hash<Bool>;
	private static var callbacks:Hash<CBObject>;
	
	public function new () { }
	
	static public function init (_stage:Stage) :Void {
		stage = _stage;
		keys = new Hash<Bool>();
		callbacks = new Hash<CBObject>();
		
		stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
		stage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
	}
	
	private static function keyDownHandler (_event:KeyboardEvent) :Void {
		var _key:String = Std.string(_event.keyCode);
		// Check for callback
		if (callbacks.exists(_key)) {
			var _object:CBObject = callbacks.get(_key);
			// Call it
			if (_object.param != null)	_object.call(_object.param);
			else						_object.call();
			// Delete callback once fired (if needed)
			if (_object.once)	deleteCallback(_event.keyCode);
		}
		// Store the key state
		keys.set(_key, true);
	}
	
	private static function keyUpHandler (_event:KeyboardEvent) :Void {
		var _key:String = Std.string(_event.keyCode);
		keys.remove(_key);
	}
	
	static public function isDown (_keyCode:Int) :Bool {
		var _key:String = Std.string(_keyCode);
		return keys.get(_key);
	}
	
	static public function setCallback (_keyCode:Int, _callback:Dynamic, ?_param:Dynamic, _fireOnce:Bool = false) :Void {
		var _object:CBObject = { call:_callback, param:_param, once:_fireOnce };
		// Store the callback
		var _key:String = Std.string(_keyCode);
		callbacks.set(_key, _object);
	}
	
	static public function deleteCallback (_keyCode:Int) :Void {
		// Delete the callback
		var _key:String = Std.string(_keyCode);
		callbacks.remove(_key);
	}
	
}










