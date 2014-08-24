package shooter.entities;

import flash.display.BitmapData;

/**
 * ...
 * @author 01101101
 */

class Entity {
	
	public var x:Float;
	public var y:Float;
	public var rotation:Float;
	public var scaleX:Float;
	public var scaleY:Float;
	public var w:Int;
	public var h:Int;
	
	var tile:Int;
	
	public function new () {
		x = y = 0;
		rotation = 0;
		scaleX = scaleY = 1;
		tile = -1;
	}
	
	public function update () {
		
	}
	
	public function getTile () :Int {
		return tile;
	}
	
	public function useCopyPixels () :Bool {
		return (rotation == 0 && scaleX == 1 && scaleY == 1);
	}
	
}
