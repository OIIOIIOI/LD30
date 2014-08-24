package shooter.entities;

/**
 * ...
 * @author 01101101
 */

class AnimEntity extends Entity {
	
	var anims:Map<String, Anim>;
	var curAnim:String;
	
	public function new () {
		super();
	}
	
	override public function update () {
		// Update anim
		if (anims != null && curAnim != null) {
			anims.get(curAnim).update();
			
			tile = anims.get(curAnim).tile;
			ox = anims.get(curAnim).ox;
			oy = anims.get(curAnim).oy;
		}
		
		super.update();
	}
	
}

class Anim {
	
	var tiles:Array<Int>;
	var durations:Array<Int>;
	var xOffsets:Array<Float>;
	var yOffsets:Array<Float>;
	
	public var curFrame(default, null):Int;
	var tick:Int;
	var ended:Bool;
	
	public var manual:Bool;
	
	public var tile(get, null):Int;
	public var ox(get, null):Float;
	public var oy(get, null):Float;
	
	public var endCallback:Void->Void;
	
	public function new () {
		manual = false;
	}
	
	public function addFrame (t:Int, ox:Float = 0, oy:Float = 0, d:Int = 15) {
		if (tiles == null)		tiles = new Array();
		if (durations == null)	durations = new Array();
		if (xOffsets == null)	xOffsets = new Array();
		if (yOffsets == null)	yOffsets = new Array();
		
		tiles.push(t);
		durations.push(d);
		xOffsets.push(ox);
		yOffsets.push(oy);
	}
	
	public function reset () {
		if (tiles == null)	return;
		
		curFrame = 0;
		tick = durations[curFrame];
		ended = false;
	}
	
	public function update () {
		if (ended || manual)	return;
		
		tick--;
		if (tick == 0) {
			curFrame++;
			if (curFrame >= tiles.length) {
				if (endCallback == null)	curFrame = 0;
				else {
					curFrame--;
					ended = true;
					endCallback();
				}
			}
			if (!ended)	tick = durations[curFrame];
		}
	}
	
	public function next () {
		curFrame++;
		if (curFrame >= tiles.length) {
			if (endCallback == null)	curFrame = 0;
			else {
				curFrame--;
				ended = true;
				endCallback();
			}
		}
	}
	
	function get_tile () :Int {
		if (tiles == null)	return -1;
		else				return tiles[curFrame];
	}
	
	function get_ox () :Float {
		if (xOffsets == null)	return 0;
		else					return xOffsets[curFrame];
	}
	
	function get_oy () :Float {
		if (yOffsets == null)	return 0;
		else					return yOffsets[curFrame];
	}
	
}
