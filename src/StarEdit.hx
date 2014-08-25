package ;

import flash.display.Sprite;

/**
 * ...
 * @author 01101101
 */

class StarEdit extends Sprite {
	
	public var type:StarType;
	public var constIndex:Int;
	
	public function new () {
		super();
		
		type = StarType.CHECKPOINT;
		constIndex = -1;
		
		draw();
	}
	
	public function cycleType () {
		type = switch (type) {
			case StarType.CHECKPOINT:	StarType.ASTEROID;
			case StarType.ASTEROID:		StarType.SHARK;
			case StarType.SHARK:		StarType.LOBSTER;
			case StarType.LOBSTER:		StarType.CHECKPOINT;
		}
		draw();
	}
	
	public function draw () {
		var color = 0xFF00FF;
		var size = 1;
		switch (type) {
			case StarType.CHECKPOINT:
				color = 0xFFFFFF;
				size = 1;
			case StarType.ASTEROID:
				color = 0xFF0000;
				size = 2;
			case StarType.SHARK:
				color = 0x0000FF;
				size = 2;
			case StarType.LOBSTER:
				color = 0x9900FF;
				size = 2;
		}
		graphics.clear();
		if (constIndex == 0)		graphics.lineStyle(5, 0xFF0000);
		else if (constIndex != -1)	graphics.lineStyle(5, 0xFFCC00);
		graphics.beginFill(color);
		graphics.drawCircle(0, 0, 10 * size);
		graphics.endFill();
	}
	
	override public function toString () {
		return x + "," + y + "," + type + "," + constIndex;
	}
	
}

enum StarType {
	CHECKPOINT;
	ASTEROID;
	SHARK;
	LOBSTER;
}