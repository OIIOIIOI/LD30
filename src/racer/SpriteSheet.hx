package racer;

import flash.display.BitmapData;
import flash.errors.Error;
import flash.geom.Rectangle;

/**
 * ...
 * @author 01101101
 */

@:bitmap("assets/img/sheet.png") class Sheet extends BitmapData { }

class SpriteSheet {
	
	static public var ins:SpriteSheet;
	
	var data:BitmapData;
	var filler:BitmapData;
	
	var tiles:Map<String, BitmapData>;
	
	public function new () {
		if (ins != null)	throw new Error("SpriteSheet already created");
		ins = this;
		
		filler = new BitmapData(16, 16, true, 0x80FFFF00);
		
		data = new Sheet(256, 256);
		
		tiles = new Map();
		for (i in 0...7)	tiles.set("shrimp"+i, createTile(new Rectangle(0, i*32, 32, 32)));
		for (i in 0...2)	tiles.set("shark"+i, createTile(new Rectangle(32, i*43, 46, 43)));
		for (i in 0...2)	tiles.set("lobster"+i, createTile(new Rectangle(78, i*48, 46, 48)));
		for (i in 0...2)	tiles.set("asteroid"+i, createTile(new Rectangle(124, i*40, 42, 40)));
		for (i in 0...8)	tiles.set("star" + i, createTile(new Rectangle(166, i * 32, 32, 32)));
		tiles.set("next0", createTile(new Rectangle(124, 80, 40, 40)));
	}
	
	function createTile (r:Rectangle) :BitmapData {
		Const.TAP.x = 0;
		Const.TAP.y = 0;
		var b = new BitmapData(Std.int(r.width), Std.int(r.height), true, 0x00FFFFFF);
		b.copyPixels(data, r, Const.TAP);
		return b;
	}
	
	public function getTile (t:String) :BitmapData {
		if (!tiles.exists(t))	return filler;
		else 					return tiles.get(t);
	}
	
}
