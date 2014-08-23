package ;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

/**
 * ...
 * @author 01101101
 */

class Editor extends Sprite {
	
	var bg:Sprite;
	var paths:Sprite;
	
	var stars:Array<StarEdit>;
	
	public function new () {
		super();
		
		stars = new Array();
		
		paths = new Sprite();
		addChild(paths);
		
		bg = new Sprite();
		bg.graphics.beginFill(0xFF00FF, 0.1);
		bg.graphics.drawRect(0, 0, 800, 600);
		bg.graphics.endFill();
		addChild(bg);
		bg.addEventListener(MouseEvent.CLICK, clickHandler);
		
		addEventListener(Event.ENTER_FRAME, update);
	}
	
	function update (e:Event) {
		drawPaths();
	}
	
	function drawPaths () {
		paths.graphics.clear();
		paths.graphics.lineStyle(1, 0x666666);
		
		for (i in 0...stars.length) {
			var na = stars[i];
			for (j in i+1...stars.length) {
				var nb = stars[j];
				var dist = Math.sqrt((na.x-nb.x)*(na.x-nb.x)+(na.y-nb.y)*(na.y-nb.y));
				if (dist <= 150) {
					paths.graphics.moveTo(na.x, na.y);
					paths.graphics.lineTo(nb.x, nb.y);
				}
			}
		}
	}
	
	function clickHandler (e:MouseEvent) {
		var s = new StarEdit();
		s.x = e.stageX;
		s.y = e.stageY;
		stars.push(s);
		addChild(s);
		s.addEventListener(MouseEvent.CLICK, starClickHandler);
		s.addEventListener(MouseEvent.MOUSE_WHEEL, starWheelHandler);
		s.addEventListener(MouseEvent.RIGHT_CLICK, starRightClickHandler);
		//s.addEventListener(MouseEvent.DOUBLE_CLICK, starDoubleClickHandler);
		s.addEventListener(MouseEvent.MOUSE_DOWN, starDownHandler);
	}
	
	/*function starDoubleClickHandler (e:MouseEvent) {
		var s:StarEdit = cast(e.currentTarget);
	}*/
	
	function starDownHandler (e:MouseEvent) {
		var s:StarEdit = cast(e.currentTarget);
		s.removeEventListener(MouseEvent.MOUSE_DOWN, starDownHandler);
		s.addEventListener(MouseEvent.MOUSE_MOVE, starMoveHandler);
		s.addEventListener(MouseEvent.MOUSE_OUT, starUpHandler);
		s.addEventListener(MouseEvent.MOUSE_UP, starUpHandler);
	}
	
	function starMoveHandler (e:MouseEvent) {
		var s:StarEdit = cast(e.currentTarget);
		s.x = e.stageX;
		s.y = e.stageY;
	}
	
	function starUpHandler (e:MouseEvent) {
		var s:StarEdit = cast(e.currentTarget);
		s.removeEventListener(MouseEvent.MOUSE_MOVE, starMoveHandler);
		s.removeEventListener(MouseEvent.MOUSE_OUT, starUpHandler);
		s.removeEventListener(MouseEvent.MOUSE_UP, starUpHandler);
		s.addEventListener(MouseEvent.MOUSE_DOWN, starDownHandler);
	}
	
	function starClickHandler (e:MouseEvent) {
		var s:StarEdit = cast(e.currentTarget);
		if (e.ctrlKey)	s.cycleType();
		if (e.shiftKey) {
			
		}
	}
	
	function starWheelHandler (e:MouseEvent) {
		var s:StarEdit = cast(e.currentTarget);
		s.resize(e.delta);
	}
	
	function starRightClickHandler (e:MouseEvent) {
		var s:StarEdit = cast(e.currentTarget);
		s.removeEventListener(MouseEvent.RIGHT_CLICK, starRightClickHandler);
		while (stars.indexOf(s) != -1)	stars.remove(s);
		removeChild(s);
	}
	
}
