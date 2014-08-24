package shooter;

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
	
	var rects:Map<Int, Rectangle>;
	var tiles:Map<Int, BitmapData>;
	
	var filler:BitmapData;
	
	public function new () {
		if (ins != null)	throw new Error("SpriteSheet already created");
		ins = this;
		
		data = new Sheet(256, 256);
		
		rects = new Map();
		// Shrimp
		rects.set(0, new Rectangle(0, 0, 32, 32));
		rects.set(1, new Rectangle(0, 32, 32, 32));
		rects.set(2, new Rectangle(0, 64, 32, 32));
		rects.set(3, new Rectangle(0, 96, 32, 32));
		
		tiles = new Map();
		
		filler = new BitmapData(16, 16, true, 0x80FFFF00);// Filler
	}
	
	public function renderTile (t:Int, x:Float, y:Float, canvas:BitmapData) {
		if (!rects.exists(t)) {
			Const.TAP.x = x;
			Const.TAP.y = y;
			canvas.copyPixels(filler, filler.rect, Const.TAP);
		} else {
			Const.TAP.x = x;
			Const.TAP.y = y;
			canvas.copyPixels(data, rects.get(t), Const.TAP);
		}
	}
	
	public function getTile (t:Int) :BitmapData {
		// If tile data does not exist
		if (!tiles.exists(t)) {
			// See if tile rect exists
			if (rects.exists(t)) {
				// Create the tile data and store it for all later uses
				var bd = new BitmapData(Std.int(rects.get(t).width), Std.int(rects.get(t).height), true, 0x00FF00FF);
				Const.TAP.x = 0;
				Const.TAP.y = 0;
				bd.copyPixels(data, rects.get(t), Const.TAP);
				tiles.set(t, bd);
				return bd;
			}
			// Return null
			else return filler;
		}
		// If tile data is already stored, simply return it
		else return tiles.get(t);
	}
	
}
