package proto;

import flash.display.Sprite;
import flash.events.Event;

/**
 * ...
 * @author 01101101
 */

class Unit extends Sprite {
	
	public var size:Int;
	public var from:Node;
	public var to:Node;
	
	public function new (size:Int, from:Node, to:Node) {
		super();
		
		this.size = size;
		this.from = from;
		this.to = to;
		
		x = from.x;
		y = from.y;
		scaleX = scaleY = 1 + (size / 10);
		
		graphics.beginFill(0xFF0000);
		graphics.drawCircle(0, 0, 5);
		graphics.endFill();
	}
	
	public function update () {
		var angle = Math.atan2(to.y - y, to.x - x);
		x += 2 * Math.cos(angle);
		y += 2 * Math.sin(angle);
		
		if (Math.abs(to.x - x) < 2 && Math.abs(to.y - y) < 2) {
			dispatchEvent(new Event(Event.CLEAR));
		}
	}
	
}
