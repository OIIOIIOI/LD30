package ;

import flash.display.Sprite;

/**
 * ...
 * @author 01101101
 */

class StarEdit extends Sprite {
	
	public var size:Int;
	public var type:StarType;
	public var constIndex:Int;
	
	public function new () {
		super();
		
		type = StarType.REGULAR;
		size = Std.random(5) + 1;
		constIndex = -1;
		
		draw();
	}
	
	public function resize (d:Int) {
		if (d > 0)	size++;
		else		size--;
		size = Std.int(Math.min(Math.max(size, 1), 5));
		draw();
	}
	
	public function cycleType () {
		var t = switch (type) {
			case StarType.REGULAR:	StarType.BONUS;
			case StarType.BONUS:	StarType.START;
			case StarType.START:	StarType.REGULAR;
		}
		type = t;
		draw();
	}
	
	public function draw () {
		var color = switch (type) {
			case StarType.REGULAR:	0xFFFFFF;
			case StarType.BONUS:	0x00FF00;
			case StarType.START:	0xFF0000;
		}
		graphics.clear();
		if (constIndex != -1)	graphics.lineStyle(5, 0xFFCC00);
		graphics.beginFill(color);
		graphics.drawCircle(0, 0, 5 + size * 3);
		graphics.endFill();
	}
	
	override public function toString () {
		return x + "," + y + "," + size + "," + type + "," + constIndex;
	}
	
}

enum StarType {
	REGULAR;
	BONUS;
	START;
}