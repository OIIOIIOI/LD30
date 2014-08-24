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
	
	var data:BitmapData;
	
	public function new () {
		rotation = 0;
		scaleX = scaleY = 1;
	}
	
	public function update () {
		x = Std.random(800);
		y = Std.random(510);
	}
	
	public function getData () :BitmapData {
		if (data == null) {
			data = new BitmapData(w, h, true, 0xFF000000 + Std.random(0xFFFFFF));
		}
		return data;
	}
	
	public function useCopyPixels () :Bool {
		return (rotation == 0 && scaleX == 1 && scaleY == 1);
	}
	
}