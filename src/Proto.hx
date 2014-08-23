package ;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Point;

/**
 * ...
 * @author 01101101
 */
class Proto extends Sprite {
	
	var nodes:Array<Node>;
	var currentNode:Int;
	
	var paths:Sprite;
	var activePath:Sprite;
	
	public function new () {
		super();
		
		nodes = new Array();
		
		paths = new Sprite();
		addChild(paths);
		
		activePath = new Sprite();
		activePath.graphics.lineStyle(3, 0xFFFFFF);
		addChild(activePath);
		
		for (i in 0...30) {
			var n = new Node(i);
			n.x = Std.random(700) + 50;
			n.y = Std.random(500) + 50;
			addChild(n);
			nodes.push(n);
			//n.addEventListener(MouseEvent.CLICK, clickHandler);
		}
		currentNode = Std.random(nodes.length);
		//nodes[currentNode].setState(Node.ACTIVE);
		
		drawPaths();
		
		addEventListener(Event.ENTER_FRAME, update);
	}
	
	function update (e:Event) {
		drawPaths();
	}
	
	function drawPaths () {
		paths.graphics.clear();
		paths.graphics.lineStyle(1, 0x666666);
		
		for (i in 0...nodes.length) {
			var na = nodes[i];
			for (j in i+1...nodes.length) {
				var nb = nodes[j];
				var dist = Math.sqrt((na.x-nb.x)*(na.x-nb.x)+(na.y-nb.y)*(na.y-nb.y));
				if (dist <= 150) {
					na.links.push(nb.index);
					nb.links.push(na.index);
					paths.graphics.moveTo(na.x, na.y);
					paths.graphics.lineTo(nb.x, nb.y);
				}
			}
		}
	}
	
	function clickHandler (e:MouseEvent) {
		var n:Node = cast(e.currentTarget);
		
		if (nodes[currentNode].links.indexOf(n.index) == -1)	return;
		
		nodes[currentNode].setState(Node.VISITED);
		var start:Point = new Point(nodes[currentNode].x, nodes[currentNode].y);
		currentNode = n.index;
		n.setState(Node.ACTIVE);
		var end:Point = new Point(nodes[currentNode].x, nodes[currentNode].y);
		activePath.graphics.moveTo(start.x, start.y);
		activePath.graphics.lineTo(end.x, end.y);
	}
	
}