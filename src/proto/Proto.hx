package proto ;

import flash.display.Sprite;
import flash.errors.UninitializedError;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFormat;

/**
 * ...
 * @author 01101101
 */

class Proto extends Sprite {
	
	var nodes:List<Node>;
	var units:List<Unit>;
	
	var selUnits:Int;
	var unitsTF:TextField;
	var selected:Node;
	
	public function new () {
		super();
		
		selected = null;
		
		nodes = new List();
		units = new List();
		selUnits = 0;
		
		var n = new Node();
		n.x = 200;
		n.y = 200;
		addChild(n);
		n.addEventListener(MouseEvent.CLICK, nodeClickHandler);
		nodes.add(n);
		
		n = new Node();
		n.x = 400;
		n.y = 200;
		addChild(n);
		n.addEventListener(MouseEvent.CLICK, nodeClickHandler);
		nodes.add(n);
		
		n = new Node();
		n.x = 300;
		n.y = 380;
		addChild(n);
		n.addEventListener(MouseEvent.CLICK, nodeClickHandler);
		nodes.add(n);
		
		unitsTF = new TextField();
		unitsTF.mouseEnabled = false;
		unitsTF.selectable = false;
		unitsTF.defaultTextFormat = new TextFormat("Arial", 18, 0xFF0000, true);
		unitsTF.width = 30;
		addChild(unitsTF);
		
		addEventListener(Event.ENTER_FRAME, update);
	}
	
	function nodeClickHandler (e:MouseEvent) {
		var n:Node = cast(e.currentTarget);
		if (selected == null || selected == n) {
			n.selectOne();
			selUnits++;
			selected = n;
		} else {
			var u = new Unit(selUnits, selected, n);
			u.addEventListener(Event.CLEAR, unitClearHandler);
			units.push(u);
			addChild(u);
			
			selUnits = 0;
			selected = null;
		}
	}
	
	function unitClearHandler (e:Event) {
		var u:Unit = cast(e.currentTarget);
		u.removeEventListener(Event.CLEAR, unitClearHandler);
		u.to.addSome(u.size);
		units.remove(u);
		removeChild(u);
	}
	
	function update (e:Event) {
		unitsTF.text = Std.string(selUnits);
		unitsTF.x = mouseX;
		unitsTF.y = mouseY - 15;
		
		for (u in units) {
			u.update();
		}
	}
	
}
