package shooter.entities;

import flash.display.BitmapData;
import haxe.Timer;

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
	
	public var tile(default, null):Int;
	public var ox(default, null):Float;
	public var oy(default, null):Float;
	public var data(default, null):BitmapData;
	
	public var dx:Float;
	public var dy:Float;
	public var friction:Float;
	
	public var dead:Bool;
	public var suckable:Bool;
	public var weight:Int;
	
	public function new () {
		x = y = 0;
		ox = oy = 0;
		dx = dy = 0;
		friction = 1;
		rotation = 0;
		scaleX = scaleY = 1;
		tile = -1;
		data = null;
		dead = false;
		suckable = false;
		weight = 0;
	}
	
	public function update () {
		dx *= friction;
		if (Math.abs(dx) < 0.01)	dx = 0;
		dy *= friction;
		if (Math.abs(dy) < 0.01)	dy = 0;
		x += dx;
		y += dy;
	}
	
	public function setForce (a:Float, f:Float = -0.7) {
		dx = Math.cos(a) * f;
		dy = Math.sin(a) * f;
	}
	
	public function useCopyPixels () :Bool {
		return (rotation == 0 && scaleX == 1 && scaleY == 1);
	}
	
}

