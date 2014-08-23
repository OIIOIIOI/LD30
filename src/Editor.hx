package ;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.Lib;
import flash.system.System;
import flash.text.TextField;
import flash.text.TextFieldType;
import flash.text.TextFormat;
import flash.ui.Keyboard;
import StarEdit;

/**
 * ...
 * @author 01101101
 */

class Editor extends Sprite {
	
	var bg:Sprite;
	var constPath:Sprite;
	var paths:Sprite;
	
	var stars:Array<StarEdit>;
	var const:Array<StarEdit>;
	
	var tf:TextField;
	
	public function new () {
		super();
		
		stars = new Array();
		const = new Array();
		
		constPath = new Sprite();
		addChild(constPath);
		
		paths = new Sprite();
		addChild(paths);
		
		bg = new Sprite();
		bg.graphics.beginFill(0xFF00FF, 0.1);
		bg.graphics.drawRect(0, 0, Lib.current.stage.stageWidth, Lib.current.stage.stageHeight);
		bg.graphics.endFill();
		addChild(bg);
		bg.addEventListener(MouseEvent.CLICK, clickHandler);
		bg.addEventListener(MouseEvent.RIGHT_CLICK, rightClickHandler);
		
		tf = new TextField();
		tf.defaultTextFormat = new TextFormat("Arial", 12);
		tf.type = TextFieldType.INPUT;
		tf.background = true;
		tf.width = Lib.current.stage.stageWidth;
		tf.height = Lib.current.stage.stageHeight;
		tf.wordWrap = tf.multiline = true;
		
		addEventListener(Event.ENTER_FRAME, update);
		Lib.current.stage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
	}
	
	function keyUpHandler (e:KeyboardEvent) {
		switch (e.keyCode) {
			case Keyboard.BACKSPACE:
				for (s in const) {
					s.constIndex = -1;
					s.draw();
				}
				while (const.length > 0)	const.shift();
				drawConst();
			case Keyboard.ENTER:
				if (!contains(tf))	openTF();
				else				parseTF();
			case Keyboard.DELETE:
				reset();
		}
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
				if (dist <= 100) {
					paths.graphics.moveTo(na.x, na.y);
					paths.graphics.lineTo(nb.x, nb.y);
				}
			}
		}
	}
	
	function drawConst () {
		constPath.graphics.clear();
		constPath.graphics.lineStyle(3, 0xFFCC00);
		
		for (i in 0...const.length-1) {
			constPath.graphics.moveTo(const[i].x, const[i].y);
			constPath.graphics.lineTo(const[i+1].x, const[i+1].y);
		}
	}
	
	function openTF () {
		addChild(tf);
	}
	
	function parseTF () {
		reset();
		removeChild(tf);
		
		var string = tf.text;
		var a = string.split(";");
		for (i in 0...a.length) {
			var b = a[i].split(",");
			if (b.length != 5)	break;
			
			var s = new StarEdit();
			s.x = Std.parseFloat(b[0]);
			s.y = Std.parseFloat(b[1]);
			s.size = Std.parseInt(b[2]);
			s.type = StarType.createByName(b[3]);
			s.constIndex = Std.parseInt(b[4]);
			s.draw();
			stars.push(s);
			addChild(s);
			s.addEventListener(MouseEvent.CLICK, starClickHandler);
			s.addEventListener(MouseEvent.MOUSE_WHEEL, starWheelHandler);
			s.addEventListener(MouseEvent.RIGHT_CLICK, starRightClickHandler);
			s.addEventListener(MouseEvent.MOUSE_DOWN, starDownHandler);
			
			if (s.constIndex != -1) {
				const.push(s);
			}
			const.sort(sortConst);
		}
		drawConst();
	}
	
	function sortConst (sa:StarEdit, sb:StarEdit) :Int {
		if (sa.constIndex > sb.constIndex)		return 1;
		else if (sa.constIndex < sb.constIndex)	return -1;
		else									return 0;
	}
	
	function reset () {
		for (s in stars) {
			removeChild(s);
			s.removeEventListener(MouseEvent.CLICK, starClickHandler);
			s.removeEventListener(MouseEvent.MOUSE_WHEEL, starWheelHandler);
			s.removeEventListener(MouseEvent.RIGHT_CLICK, starRightClickHandler);
			s.removeEventListener(MouseEvent.MOUSE_DOWN, starDownHandler);
			s.removeEventListener(MouseEvent.MOUSE_OUT, starUpHandler);
			s.removeEventListener(MouseEvent.MOUSE_UP, starUpHandler);
			s.removeEventListener(MouseEvent.MOUSE_DOWN, starDownHandler);
		}
		while (stars.length > 0)	stars.shift();
		while (const.length > 0)	const.shift();
		paths.graphics.clear();
		constPath.graphics.clear();
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
		s.addEventListener(MouseEvent.MOUSE_DOWN, starDownHandler);
	}
	
	function rightClickHandler (e:MouseEvent) {
		var string = "";
		for (s in stars) {
			string += s;
			if (s != stars[stars.length - 1])	string += ";";
		}
		System.setClipboard(string);
	}
	
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
			s.constIndex = const.length;
			s.draw();
			const.push(s);
			drawConst();
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
