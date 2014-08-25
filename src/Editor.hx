package ;

import flash.display.Bitmap;
import flash.display.BitmapData;
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
import haxe.Resource;
import StarEdit;

/**
 * ...
 * @author 01101101
 */

@:bitmap("assets/img/space_01.png") class SpaceBG extends BitmapData { }

@:bitmap("assets/img/c_beluga.png") class Beluga extends BitmapData {}
@:bitmap("assets/img/c_boat.png") class Boat extends BitmapData {}
@:bitmap("assets/img/c_clam.png") class Clam extends BitmapData {}
@:bitmap("assets/img/c_eel.png") class Eel extends BitmapData {}
@:bitmap("assets/img/c_jellyfish.png") class Jellyfish extends BitmapData {}
@:bitmap("assets/img/c_otter.png") class Otter extends BitmapData {}
@:bitmap("assets/img/c_rusty.png") class Rusty extends BitmapData {}
@:bitmap("assets/img/c_seagull.png") class Seagull extends BitmapData {}
@:bitmap("assets/img/c_shark.png") class Shark extends BitmapData {}
@:bitmap("assets/img/c_spliff.png") class Spliff extends BitmapData {}
@:bitmap("assets/img/c_squid.png") class Squid extends BitmapData {}
@:bitmap("assets/img/c_walrus.png") class Walrus extends BitmapData {}

class Editor extends Sprite {
	
	var bmpbg:Bitmap;
	var bmp:Bitmap;
	var bds:Array<BitmapData>;
	var bdIndex:Int;
	
	var bg:Sprite;
	var constPath:Sprite;
	var paths:Sprite;
	
	var stars:Array<StarEdit>;
	var const:Array<StarEdit>;
	
	var tf:TextField;
	
	public function new () {
		super();
		
		bds = new Array();
		bds.push(new Beluga(900, 610));
		bds.push(new Boat(900, 610));
		bds.push(new Clam(900, 610));
		bds.push(new Eel(900, 610));
		bds.push(new Jellyfish(900, 610));
		bds.push(new Otter(900, 610));
		bds.push(new Rusty(900, 610));
		bds.push(new Seagull(900, 610));
		bds.push(new Shark(900, 610));
		bds.push(new Spliff(900, 610));
		bds.push(new Squid(900, 610));
		bds.push(new Walrus(900, 610));
		bdIndex = -1;
		
		stars = new Array();
		const = new Array();
		
		bmpbg = new Bitmap(new SpaceBG(900, 610));
		addChild(bmpbg);
		
		bmp = new Bitmap();
		bmp.alpha = 0.1;
		addChild(bmp);
		
		constPath = new Sprite();
		addChild(constPath);
		
		paths = new Sprite();
		addChild(paths);
		
		bg = new Sprite();
		bg.graphics.beginFill(0xFF00FF, 0);
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
			case Keyboard.TAB:
				bdIndex++;
				if (bdIndex == bds.length) {
					bmp.bitmapData = null;
				} else if (bdIndex > bds.length) {
					bdIndex = 0;
					bmp.bitmapData = bds[bdIndex];
				} else {
					bmp.bitmapData = bds[bdIndex];
				}
		}
	}
	
	function update (e:Event) {
		drawPaths();
		drawConst();
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
		for (s in const) {
			string += s.x + "," + s.y;
			if (s != const[const.length - 1])	string += ";";
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
