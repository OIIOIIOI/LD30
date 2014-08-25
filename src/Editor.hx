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
	var datas:Array<String>;
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
		
		datas = new Array();
		datas.push("114,493;321,473;230,432;275,365;422,348;514,334;641,395;581,286;683,231;645,119;457,162;270,303");
		datas.push("299,230;335,333;431,158;416,291;569,212;714,203;604,441;310,467;210,439;182,361;164,268;381,102;336,60;171,218;222,103;132,212");
		datas.push("343,266;200,173;187,112;395,190;572,122;715,134;740,251;602,286;467,302;375,343;276,394;382,433;580,405;683,343;611,451;645,399;697,425");
		datas.push("226,178,CHECKPOINT,14;364,192,CHECKPOINT,13;432,297,CHECKPOINT,12;562,328,CHECKPOINT,11;690,319,CHECKPOINT,10;703,229,CHECKPOINT,9;547,158,CHECKPOINT,8;282,87,CHECKPOINT,7;132,185,CHECKPOINT,6;146,324,CHECKPOINT,5;260,447,CHECKPOINT,4;513,487,CHECKPOINT,3;638,444,CHECKPOINT,2;598,411,CHECKPOINT,1;641,382,CHECKPOINT,0;289,307,LOBSTER,-1");
		datas.push("549,374;697,432;734,355;748,244;714,141;629,80;599,121;547,110;480,113;444,160;452,264;373,239;247,182;336,269;138,381;356,315;245,474;401,349;382,546;594,491;429,475;440,399;467,319");
		datas.push("285,205;289,113;219,72;143,109;176,255;188,353;235,400;289,407;323,369;440,356;518,363;481,413;569,362;670,395;755,463;563,245;397,197;328,227");
		datas.push("283,433;339,489;519,481;665,392;623,312;526,372;364,406;261,397;371,329;553,296;379,259;237,208;364,174;539,175;654,244;609,280");
		datas.push("415,396;496,484;407,538;492,535;561,511;561,545;609,471;728,410;569,378;482,292;553,258;455,207;412,244;425,134;212,95;347,162;270,250;227,361");
		datas.push("548,183;378,64;364,186;266,255;222,369;98,243;147,386;286,549;280,459;379,387;446,451;509,377;603,441;553,319;688,374;796,275;658,230");
		datas.push("152,199;181,188;421,258;652,340;597,379;633,437;770,440;670,471;772,504;602,508;452,414;593,456;543,370;200,225");
		datas.push("597,132;747,48;735,136;694,144;551,285;513,370;427,419;306,373;314,286;371,233;546,156;532,123;254,169;193,332;260,413;208,530;296,457;307,525;421,558;537,453;679,377;744,410");
		datas.push("225,330;304,229;432,227;476,98;594,38;684,128;618,179;597,380;505,413;377,498;414,399;212,369;141,492;142,401;80,379");
		
		stars = new Array();
		const = new Array();
		
		bmpbg = new Bitmap(new SpaceBG(900, 610));
		addChild(bmpbg);
		
		bmp = new Bitmap();
		bmp.alpha = 0.2;
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
				else				parseTF(tf.text);
			case Keyboard.DELETE:
				reset();
			case Keyboard.A:
				bdIndex++;
				if (bdIndex == bds.length) {
					bmp.bitmapData = null;
				} else if (bdIndex > bds.length) {
					bdIndex = 0;
					bmp.bitmapData = bds[bdIndex];
				} else {
					bmp.bitmapData = bds[bdIndex];
				}
			case Keyboard.TAB:
				bdIndex++;
				if (bdIndex == bds.length) {
					bmp.bitmapData = null;
					reset();
				} else if (bdIndex > bds.length) {
					bdIndex = 0;
					bmp.bitmapData = bds[bdIndex];
					parseTF(datas[bdIndex]);
				} else {
					bmp.bitmapData = bds[bdIndex];
					parseTF(datas[bdIndex]);
				}
		}
	}
	
	function update (e:Event) {
		//drawPaths();
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
	
	function parseTF (string:String) {
		reset();
		if (contains(tf))	removeChild(tf);
		
		//var string = tf.text;
		var a = string.split(";");
		//trace(a.length);
		for (i in 0...a.length) {
			var b = a[i].split(",");
			//if (b.length != 4)	break;
			
			var s = new StarEdit();
			s.x = Std.parseFloat(b[0]);
			s.y = Std.parseFloat(b[1]);
			if (b.length >= 3)	s.type = StarType.createByName(b[2]);
			if (b.length >= 4)	s.constIndex = Std.parseInt(b[3]);
			s.draw();
			stars.push(s);
			addChild(s);
			//trace(s);
			s.addEventListener(MouseEvent.CLICK, starClickHandler);
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
			if (contains(s))	removeChild(s);
			s.removeEventListener(MouseEvent.CLICK, starClickHandler);
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
		if (e.shiftKey && s.type == StarType.CHECKPOINT) {
			s.constIndex = const.length;
			s.draw();
			const.push(s);
			drawConst();
		}
	}
	
	function starRightClickHandler (e:MouseEvent) {
		var s:StarEdit = cast(e.currentTarget);
		s.removeEventListener(MouseEvent.RIGHT_CLICK, starRightClickHandler);
		while (stars.indexOf(s) != -1)	stars.remove(s);
		removeChild(s);
	}
	
}
