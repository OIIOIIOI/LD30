package racer ;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.Lib;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.ui.Keyboard;
import haxe.Timer;
import Main;
import Man;
import racer.Entity.EEntityType;
import screen.MenuScreen;
import screen.Screen;

/**
 * ...
 * @author 01101101
 */

@:bitmap("assets/img/space_01.png")		class Space1BG extends BitmapData { }
@:bitmap("assets/img/space_02.png")		class Space2BG extends BitmapData { }
@:bitmap("assets/img/space_03.png")		class Space3BG extends BitmapData { }

@:bitmap("assets/img/c_beluga.png")		class CBeluga extends BitmapData { }
@:bitmap("assets/img/c_boat.png")		class CBoat extends BitmapData { }
@:bitmap("assets/img/c_clam.png")		class CClam extends BitmapData { }
@:bitmap("assets/img/c_eel.png")		class CEel extends BitmapData { }
@:bitmap("assets/img/c_jellyfish.png")	class CJellyfish extends BitmapData { }
@:bitmap("assets/img/c_otter.png")		class COtter extends BitmapData { }
@:bitmap("assets/img/c_rusty.png")		class CRusty extends BitmapData { }
@:bitmap("assets/img/c_seagull.png")	class CSeagull extends BitmapData { }
@:bitmap("assets/img/c_shark.png")		class CShark extends BitmapData { }
@:bitmap("assets/img/c_spliff.png")		class CSpliff extends BitmapData { }
@:bitmap("assets/img/c_squid.png")		class CSquid extends BitmapData { }
@:bitmap("assets/img/c_walrus.png")		class CWalrus extends BitmapData { }

class Racer extends Screen {
	
	var level:ELevel;
	
	var entities:Array<Entity>;
	var particles:Array<Particle>;
	var container:Sprite;
	var canvas:Bitmap;
	var overlay:Bitmap;
	var player:Player;
	var next:Next;
	var checkpoints:Array<Checkpoint>;
	var targetCP:Int;
	var paths:Sprite;
	var raceComplete:Bool;
	var cockpit:Cockpit;
	var dashmeter:DashMeter;
	
	var shakeTimer:Int;
	
	var showCol:Bool;
	
	var tick:Int;
	var cbTimer:Int;
	var cb:Void->Void;
	var step:Int;
	
	var startTime:Float;
	var endTime:Float;
	var timeTF:TextField;
	var timerFont:RadioLandFont;
	
	public function new (l:ELevel) {
		super();
		
		level = l;
		
		if (SpriteSheet.ins == null)	new SpriteSheet();
		
		showCol = false;
		
		tick = 0;
		shakeTimer = 0;
		cbTimer = 0;
		cb = null;
		
		entities = new Array();
		particles = new Array();
		
		container = new Sprite();
		
		canvas = switch (Std.random(3)) {
			case 0:		new Bitmap(new Space1BG(900, 610));
			case 1:		new Bitmap(new Space2BG(900, 610));
			default:	new Bitmap(new Space3BG(900, 610));
		}
		container.addChild(canvas);
		
		overlay = new Bitmap();
		overlay.alpha = 0;
		container.addChild(overlay);
		
		paths = new Sprite();
		container.addChild(paths);
		
		initMap(level);
		
		next = new Next();
		//container.addChild(next.sprite);
		if (showCol)	container.addChild(next.colSprite);
		entities.push(next);
		
		player = new Player();
		player.x = checkpoints[targetCP].x;
		player.y = checkpoints[targetCP].y;
		container.addChild(player.sprite);
		if (showCol)	container.addChild(player.colSprite);
		entities.push(player);
		
		//container.scaleX = container.scaleY = Const.SCALE;
		addChild(container);
		
		cockpit = new Cockpit();
		addChild(cockpit.sprite);
		entities.push(cockpit);
		
		dashmeter = new DashMeter();
		addChild(dashmeter.sprite);
		entities.push(dashmeter);
		
		container.x = -player.x * Const.SCALE + canvas.width / 2;
		container.y = -player.y * Const.SCALE + canvas.height / 2;
		container.x = Math.max(Math.min(container.x, 0), -(container.width - Const.STAGE_WIDTH));
		container.y = Math.max(Math.min(container.y, 0), -(container.height - Const.STAGE_HEIGHT));
		
		timerFont = new RadioLandFont();
		timeTF = new TextField();
		timeTF.embedFonts = true;
		timeTF.defaultTextFormat = new TextFormat(timerFont.fontName, 36, 0xFFFFFF);
		timeTF.selectable = false;
		timeTF.width = 200;
		timeTF.height = 60;
		timeTF.x = 10;
		timeTF.y = Const.STAGE_HEIGHT - timeTF.height;
		
		step = 0;
		cb = startGame;
		cbTimer = 120;
		
		SoundMan.ins.playSFX("start");
	}
	
	function startGame () {
		Lib.current.stage.focus = null;
		
		container.scaleX = container.scaleY = Const.SCALE;
		container.addChild(next.sprite);
		
		container.x = -player.x * Const.SCALE + canvas.width / 2;
		container.y = -player.y * Const.SCALE + canvas.height / 2;
		container.x = Math.max(Math.min(container.x, 0), -(container.width - Const.STAGE_WIDTH));
		container.y = Math.max(Math.min(container.y, 0), -(container.height - Const.STAGE_HEIGHT));
		
		step = 1;
		
		startTime = Timer.stamp();
		addChild(timeTF);
		
		SoundMan.ins.setActive( -1);
	}
	
	function endGame () {
		MenuScreen.discovered[getIndex(level)] = true;
		ScoreManager.save(level.getName(), (endTime - startTime), Main.pseudo);
		SoundMan.ins.setActive(-1);
		if (level == ELevel.LSquid)	Man.ins.changeScreen(EScreen.END);
		else						Man.ins.changeScreen(EScreen.MENU);
	}
	
	public function initMap (l:ELevel) {
		overlay.bitmapData = switch (l) {
			case ELevel.LBeluga:	new CBeluga(900, 610);
			case ELevel.LBoat:		new CBoat(900, 610);
			case ELevel.LClam:		new CClam(900, 610);
			case ELevel.LEel:		new CEel(900, 610);
			case ELevel.LJellyfish:	new CJellyfish(900, 610);
			case ELevel.LOtter:		new COtter(900, 610);
			case ELevel.LRusty:		new CRusty(900, 610);
			case ELevel.LSeagull:	new CSeagull(900, 610);
			case ELevel.LShark:		new CShark(900, 610);
			case ELevel.LSpliff:	new CSpliff(900, 610);
			case ELevel.LSquid:		new CSquid(900, 610);
			case ELevel.LWalrus:	new CWalrus(900, 610);
		}
		
		var s = switch (l) {
			case ELevel.LBeluga:	"114,493,CHECKPOINT,1;321,473,CHECKPOINT,0;230,432,CHECKPOINT,2;275,365,CHECKPOINT,3;422,348,CHECKPOINT,11;514,334,CHECKPOINT,10;641,395,CHECKPOINT,9;581,286,CHECKPOINT,8;683,231,CHECKPOINT,7;645,119,CHECKPOINT,6;457,162,CHECKPOINT,5;270,303,CHECKPOINT,4;547,200,ASTEROID,-1;171,156,ASTEROID,-1";
			case ELevel.LBoat:		"299,230,CHECKPOINT,6;336,333,CHECKPOINT,5;431,158,CHECKPOINT,3;416,291,CHECKPOINT,2;569,212,CHECKPOINT,1;714,203,CHECKPOINT,0;604,441,CHECKPOINT,15;310,467,CHECKPOINT,14;210,439,CHECKPOINT,13;182,361,CHECKPOINT,12;164,268,CHECKPOINT,11;381,102,CHECKPOINT,4;334,59,CHECKPOINT,7;171,218,CHECKPOINT,8;222,103,CHECKPOINT,9;132,212,CHECKPOINT,10;717,349,ASTEROID,-1;215,37,ASTEROID,-1;217,248,LOBSTER,-1;425,353,LOBSTER,-1;489,195,SHARK,-1;209,511,SHARK,-1";
			case ELevel.LClam:		"343,266,CHECKPOINT,12;200,173,CHECKPOINT,13;187,112,CHECKPOINT,14;395,190,CHECKPOINT,15;572,122,CHECKPOINT,16;715,134,CHECKPOINT,0;740,251,CHECKPOINT,1;602,286,CHECKPOINT,11;467,302,CHECKPOINT,10;375,343,CHECKPOINT,9;276,394,CHECKPOINT,8;382,433,CHECKPOINT,7;580,405,CHECKPOINT,6;683,343,CHECKPOINT,2;611,451,CHECKPOINT,5;645,399,CHECKPOINT,4;697,425,CHECKPOINT,3;439,94,ASTEROID,-1;344,95,ASTEROID,-1;263,323,ASTEROID,-1;656,180,ASTEROID,-1;811,376,ASTEROID,-1;474,485,ASTEROID,-1;606,351,LOBSTER,-1";
			case ELevel.LEel:		"226,178,CHECKPOINT,14;364,192,CHECKPOINT,13;432,297,CHECKPOINT,12;562,328,CHECKPOINT,11;690,319,CHECKPOINT,10;703,229,CHECKPOINT,9;547,158,CHECKPOINT,8;282,87,CHECKPOINT,7;132,185,CHECKPOINT,6;146,324,CHECKPOINT,5;260,447,CHECKPOINT,4;513,487,CHECKPOINT,3;638,444,CHECKPOINT,2;598,411,CHECKPOINT,1;641,382,CHECKPOINT,0;289,307,LOBSTER,-1;379,556,ASTEROID,-1;105,386,ASTEROID,-1;380,56,ASTEROID,-1;564,246,LOBSTER,-1;726,539,SHARK,-1;457,375,SHARK,-1;142,118,SHARK,-1";
			case ELevel.LJellyfish:	"549,374,CHECKPOINT,11;697,432,CHECKPOINT,0;734,355,CHECKPOINT,1;748,244,CHECKPOINT,2;714,141,CHECKPOINT,3;629,80,CHECKPOINT,4;599,121,CHECKPOINT,5;547,110,CHECKPOINT,6;480,113,CHECKPOINT,7;444,160,CHECKPOINT,8;452,264,CHECKPOINT,9;373,239,CHECKPOINT,16;247,182,CHECKPOINT,17;336,269,CHECKPOINT,15;138,381,CHECKPOINT,20;356,315,CHECKPOINT,14;245,474,CHECKPOINT,22;401,349,CHECKPOINT,13;382,546,CHECKPOINT,23;594,491,CHECKPOINT,24;440,399,CHECKPOINT,12;467,319,CHECKPOINT,10;239,353,CHECKPOINT,19;324,307,CHECKPOINT,18;375,370,CHECKPOINT,21;608,208,ASTEROID,-1;154,506,ASTEROID,-1;608,338,SHARK,-1;520,210,SHARK,-1;314,228,SHARK,-1;392,443,SHARK,-1;533,567,SHARK,-1;413,300,LOBSTER,-1;497,438,LOBSTER,-1";
			case ELevel.LOtter:		"285,205,CHECKPOINT,12;289,113,CHECKPOINT,11;219,72,CHECKPOINT,10;143,109,CHECKPOINT,9;176,255,CHECKPOINT,8;188,353,CHECKPOINT,7;235,400,CHECKPOINT,6;288,403,CHECKPOINT,4;323,369,CHECKPOINT,3;439,358,CHECKPOINT,2;518,363,CHECKPOINT,1;481,413,CHECKPOINT,0;569,362,CHECKPOINT,18;670,395,CHECKPOINT,17;755,463,CHECKPOINT,16;565,238,CHECKPOINT,15;397,197,CHECKPOINT,14;328,227,CHECKPOINT,13;239,360,CHECKPOINT,5;507,110,ASTEROID,-1;220,153,LOBSTER,-1;412,266,SHARK,-1";
			case ELevel.LRusty:		"283,433,CHECKPOINT,15;339,489,CHECKPOINT,14;519,481,CHECKPOINT,13;665,392,CHECKPOINT,12;623,312,CHECKPOINT,11;526,372,CHECKPOINT,0;364,406,CHECKPOINT,1;261,397,CHECKPOINT,2;371,329,CHECKPOINT,3;553,296,CHECKPOINT,4;379,259,CHECKPOINT,5;237,208,CHECKPOINT,6;364,174,CHECKPOINT,7;539,175,CHECKPOINT,8;654,244,CHECKPOINT,9;609,280,CHECKPOINT,10;381,119,ASTEROID,-1;570,398,ASTEROID,-1;568,259,LOBSTER,-1;329,380,LOBSTER,-1;461,339,SHARK,-1";
			case ELevel.LSeagull:	"415,396,CHECKPOINT,7;496,484,CHECKPOINT,8;404,533,CHECKPOINT,9;492,535,CHECKPOINT,10;561,511,CHECKPOINT,12;561,545,CHECKPOINT,11;609,471,CHECKPOINT,13;728,410,CHECKPOINT,14;569,378,CHECKPOINT,15;482,292,CHECKPOINT,16;553,258,CHECKPOINT,17;455,207,CHECKPOINT,5;412,244,CHECKPOINT,6;425,134,CHECKPOINT,4;212,95,CHECKPOINT,3;347,162,CHECKPOINT,2;270,250,CHECKPOINT,1;227,361,CHECKPOINT,0;279,435,ASTEROID,-1;385,191,LOBSTER,-1;461,245,LOBSTER,-1;523,508,LOBSTER,-1;598,419,SHARK,-1;279,162,SHARK,-1;386,339,SHARK,-1";
			case ELevel.LShark	:	"548,183,CHECKPOINT,2;378,64,CHECKPOINT,4;389,173,CHECKPOINT,5;266,255,CHECKPOINT,6;222,369,CHECKPOINT,7;98,243,CHECKPOINT,8;147,386,CHECKPOINT,9;286,549,CHECKPOINT,10;280,459,CHECKPOINT,12;379,387,CHECKPOINT,13;446,451,CHECKPOINT,14;509,377,CHECKPOINT,15;603,441,CHECKPOINT,16;553,319,CHECKPOINT,18;688,374,CHECKPOINT,19;796,275,CHECKPOINT,0;658,230,CHECKPOINT,1;593,373,LOBSTER,-1;432,377,LOBSTER,-1;427,133,LOBSTER,-1;256,402,LOBSTER,-1;669,296,SHARK,-1;360,287,SHARK,-1;711,174,ASTEROID,-1;390,489,ASTEROID,-1;235,134,ASTEROID,-1;480,167,CHECKPOINT,3;631,403,CHECKPOINT,17";
			case ELevel.LSpliff:	"152,199,CHECKPOINT,2;181,188,CHECKPOINT,1;421,258,CHECKPOINT,0;652,340,CHECKPOINT,5;597,379,CHECKPOINT,6;633,437,CHECKPOINT,13;770,440,CHECKPOINT,12;670,471,CHECKPOINT,10;766,499,CHECKPOINT,11;602,508,CHECKPOINT,8;452,414,CHECKPOINT,7;593,456,CHECKPOINT,9;543,370,CHECKPOINT,4;200,225,CHECKPOINT,3;721,455,LOBSTER,-1;651,383,LOBSTER,-1;534,416,LOBSTER,-1;241,221,LOBSTER,-1;650,502,SHARK,-1;536,307,SHARK,-1;356,195,ASTEROID,-1;380,410,ASTEROID,-1;526,528,ASTEROID,-1;148,283,ASTEROID,-1";
			case ELevel.LSquid:		"597,132,CHECKPOINT,18;747,48,CHECKPOINT,19;735,136,CHECKPOINT,20;694,144,CHECKPOINT,21;551,285,CHECKPOINT,7;513,370,CHECKPOINT,6;427,419,CHECKPOINT,5;306,373,CHECKPOINT,11;314,286,CHECKPOINT,16;371,233,CHECKPOINT,15;546,156,CHECKPOINT,17;532,123,CHECKPOINT,14;254,169,CHECKPOINT,13;200,335,CHECKPOINT,12;260,413,CHECKPOINT,10;211,527,CHECKPOINT,9;296,457,CHECKPOINT,8;307,525,CHECKPOINT,4;418,561,CHECKPOINT,3;535,452,CHECKPOINT,2;679,377,CHECKPOINT,1;744,410,CHECKPOINT,0;343,394,LOBSTER,-1;631,136,LOBSTER,-1;473,253,SHARK,-1;304,220,SHARK,-1;475,448,SHARK,-1;721,241,ASTEROID,-1;655,483,ASTEROID,-1;183,385,ASTEROID,-1;313,82,ASTEROID,-1;575,203,ASTEROID,-1;385,492,ASTEROID,-1";
			case ELevel.LWalrus:	"225,330,CHECKPOINT,9;304,229,CHECKPOINT,8;432,227,CHECKPOINT,7;476,98,CHECKPOINT,6;594,38,CHECKPOINT,5;684,128,CHECKPOINT,4;618,179,CHECKPOINT,3;597,380,CHECKPOINT,2;505,413,CHECKPOINT,1;377,498,CHECKPOINT,0;414,399,CHECKPOINT,14;212,369,CHECKPOINT,10;141,492,CHECKPOINT,13;142,401,CHECKPOINT,12;80,379,CHECKPOINT,11;565,107,LOBSTER,-1;364,303,SHARK,-1;163,184,ASTEROID,-1;602,439,SHARK,-1";
		}
		
		var a = s.split(";");
		
		checkpoints = new Array();
		
		for (i in 0...a.length) {
			var b = a[i].split(",");
			
			if (b.length != 4)	continue;
			
			var e = switch (EEntityType.createByName(b[2])) {
				case EEntityType.CHECKPOINT:	new Checkpoint(Std.parseInt(b[3]));
				case EEntityType.ASTEROID:		new Asteroid();
				case EEntityType.SHARK:			new Shark();
				case EEntityType.LOBSTER:		new Lobster();
			}
			e.x = Std.parseInt(b[0]);
			e.y = Std.parseInt(b[1]);
			
			if (Std.is(e, Checkpoint))	checkpoints.push(cast(e));
			else if (Std.is(e, Shark)) {
				var f = new Fish(cast(e));
				f.x = f.shark.target.x;
				f.y = f.shark.target.y;
				container.addChild(f.sprite);
				entities.push(f);
			}
			
			container.addChild(e.sprite);
			if (showCol)	container.addChild(e.colSprite);
			entities.push(e);
		}
		
		checkpoints.sort(sortCP);
		
		//trace(checkpoints.length);
		
		targetCP = 0;
		raceComplete = false;
	}
	
	function sortCP (a:Checkpoint, b:Checkpoint) :Int {
		if (a.order > b.order)		return 1;
		else if (a.order < b.order)	return -1;
		else						return 0;
	}
	
	override public function update () {
		super.update();
		
		tick++;
		if (tick == 100000)	tick = 0;
		
		if (cbTimer > 0) {
			cbTimer--;
			if (cbTimer == 0 && cb != null)	cb();
		}
		
		if (!raceComplete && step > 0) {
			var time = Std.int((Timer.stamp() - startTime) * 100) / 100;
			timeTF.text = time + "s";
			// Controls
			var dx = 0.0;
			var dy = 0.0;
			if (KeyboardManager.isDown(Keyboard.UP))	dy -= player.speed;
			if (KeyboardManager.isDown(Keyboard.DOWN))	dy += player.speed;
			if (KeyboardManager.isDown(Keyboard.LEFT))	dx -= player.speed;
			if (KeyboardManager.isDown(Keyboard.RIGHT))	dx += player.speed;
			if (KeyboardManager.isDown(Keyboard.SPACE))	player.dash();
			player.dx += dx;
			player.dy += dy;
			
			// Next
			next.x = checkpoints[targetCP].x;
			if (next.x < -container.x / 2)
				next.x = checkpoints[targetCP].x - container.x / 2 - next.x;
			if (next.x > -container.x / 2 + Const.STAGE_WIDTH / 2)
				next.x = checkpoints[targetCP].x - container.x / 2 + Const.STAGE_WIDTH / 2 - next.x;
			next.y = checkpoints[targetCP].y;
			if (next.y < -container.y / 2)
				next.y = checkpoints[targetCP].y - container.y / 2 - next.y;
			if (next.y > -container.y / 2 + Const.STAGE_HEIGHT / 2)
				next.y = checkpoints[targetCP].y - container.y / 2 + Const.STAGE_HEIGHT / 2 - next.y;
			
			// Capture point
			var dx = player.x - checkpoints[targetCP].x;
			var dy = player.y - checkpoints[targetCP].y;
			var dist = Math.sqrt(dx * dx + dy * dy);
			if (dist < player.radius + checkpoints[targetCP].radius / 2) {
				// Turn star on
				SoundMan.ins.setActive(SoundMan.ins.active+1);
				checkpoints[targetCP].turnOn();
				for (i in 0...targetCP+1) {
					starParticles(checkpoints[i]);
				}
				//
				if (targetCP > 0) {
					paths.graphics.lineStyle(1, 0xFFFFFF);
					paths.graphics.moveTo(checkpoints[targetCP-1].x, checkpoints[targetCP-1].y);
					paths.graphics.lineTo(checkpoints[targetCP].x, checkpoints[targetCP].y);
				}
				targetCP++;
				if (targetCP == checkpoints.length) {
					endTime = Timer.stamp();
					raceComplete = true;
					container.x = container.y = 0;
					container.scaleX = container.scaleY = 1;
					next.dead = true;
					player.dead = true;
					killAll();
					SoundMan.ins.playSFX("complete");
				} else {
					SoundMan.ins.playSFX("star");
				}
			}
		} else if (raceComplete) {
			if (overlay.alpha < 0.4) {
				overlay.alpha += 0.005;
			} else if (cbTimer == 0) {
				cb = endGame;
				cbTimer = 120;
			}
		}
		
		// Update
		for (e in entities) {
			e.update();
			if ((e.bubbling && tick % 10 == 0) ||
				(Std.is(e, Player) && cast(e, Player).dashTimer > 120)) bubbleParticle(e);
			if (Std.is(e, Lobster))	cast(e, Lobster).goForEntity(player);
		}
		for (e in particles) {
			e.update();
		}
		
		dashmeter.draw(player.dashTimer, Player.DASH_DELAY);
		
		// Collisions
		var collEntities = entities.filter(filterCollided);
		for (i in 0...collEntities.length) {
			for (j in i+1...collEntities.length) {
				checkCollisions(collEntities[i], collEntities[j]);
			}
		}
		
		// Filter dead
		entities = entities.filter(filterDead);
		particles = particles.filter(filterDead);
		//trace(particles.length);
		
		// Camera
		moveCamera();
		if (shakeTimer > 0) {
			shakeTimer--;
			cameraShake();
		}
	}
	
	function killAll () {
		for (e in entities) {
			if (Std.is(e, Lobster) || Std.is(e, Shark) || Std.is(e, Asteroid) || Std.is(e, Fish)) {
				e.dead = true;
			}
		}
		entities = entities.filter(filterDead);
	}
	
	function filterDead (e:Entity) :Bool {
		var dead = e.dead;
		if (dead) {
			if (e.sprite != null && e.sprite.parent != null) {
				e.sprite.parent.removeChild(e.sprite);
				if (e.colSprite != null && e.colSprite.parent != null)	e.colSprite.parent.removeChild(e.colSprite);
			}
		}
		return !dead;
	}
	
	function filterCollided (e:Entity) :Bool {
		return e.collided;
	}
	
	function checkCollisions (e:Entity, f:Entity) {
		var distX = e.x - f.x;
		var distY = e.y - f.y;
		var dist = Math.sqrt(distX * distX + distY * distY);
		var totalRad = e.radius + f.radius;
		if (dist < totalRad) {
			var edx = (e.dx * (e.radius - f.radius) + (2 * f.radius * f.dx)) / totalRad;
			var edy = (e.dy * (e.radius - f.radius) + (2 * f.radius * f.dy)) / totalRad;
			var fdx = (f.dx * (f.radius - e.radius) + (2 * e.radius * e.dx)) / totalRad;
			var fdy = (f.dy * (f.radius - e.radius) + (2 * e.radius * e.dy)) / totalRad;
			
			e.dx = edx;
			e.dy = edy;
			f.dx = fdx;
			f.dy = fdy;
			
			e.x += e.dx;
			e.y += e.dy;
			f.x += f.dx;
			f.y += f.dy;
			
			if (Std.is(e, Shark))	cast(e, Shark).refreshTarget();
			if (Std.is(f, Shark))	cast(f, Shark).refreshTarget();
			if (Std.is(e, Player) || Std.is(f, Player)) {
				if (Std.is(e, Lobster) || Std.is(f, Lobster))			SoundMan.ins.playSFX("lobster");
				else if (Std.is(e, Shark) || Std.is(f, Shark))			SoundMan.ins.playSFX("shark");
				else if (Std.is(e, Asteroid) || Std.is(f, Asteroid))	SoundMan.ins.playSFX("asteroid");
				cockpit.hurt();
				shakeTimer = 15;
				SoundMan.ins.setActive(Std.int(Math.max(0, SoundMan.ins.active-1)));
			}
		}
	}
	
	function moveCamera () {
		var tx = -player.x * Const.SCALE + canvas.width / 2;
		var ty = -player.y * Const.SCALE + canvas.height / 2;
		container.x += (tx - container.x) * 0.1;
		container.y += (ty - container.y) * 0.1;
		container.x = Math.max(Math.min(container.x, 0), -(Const.STAGE_WIDTH * container.scaleX - Const.STAGE_WIDTH));
		container.y = Math.max(Math.min(container.y, 0), -(Const.STAGE_HEIGHT * container.scaleY - Const.STAGE_HEIGHT));
	}
	
	function cameraShake () {
		var sx = (Std.random(2) * 2 - 1) * 5;
		var sy = (Std.random(2) * 2 - 1) * 5;
		container.x += sx;
		container.y += sy;
		cockpit.x += sx;
		cockpit.y += sy;
		dashmeter.x += sx;
		dashmeter.y += sy;
	}
	
	function starParticles (s:Entity) {
		for (i in 0...24) {
			var p = new StarParticles();
			p.x = s.x;
			p.y = s.y;
			switch (i % 3) {
				case 0:		p.setParams(i * 15, 0.8);
				case 1:		p.setParams(i * 15, 1.2);
				default:	p.setParams(i * 15, 1.6);
			}
			container.addChild(p.sprite);
			particles.push(p);
		}
	}
	
	function bubbleParticle (s:Entity) {
		var p = new BubbleParticle();
		p.x = s.x - s.radius * s.sprite.scaleX;
		p.y = s.y + 8;
		container.addChild(p.sprite);
		particles.push(p);
	}
	
	static public function getIndex (l:ELevel) :Int {
		return switch (l) {
			case ELevel.LBeluga:	0;
			case ELevel.LOtter:		1;
			case ELevel.LWalrus:	2;
			case ELevel.LRusty:		3;
			case ELevel.LBoat:		4;
			case ELevel.LSeagull:	5;
			case ELevel.LEel:		6;
			case ELevel.LClam:		7;
			case ELevel.LShark:		8;
			case ELevel.LSpliff:	9;
			case ELevel.LJellyfish:	10;
			case ELevel.LSquid:		11;
		}
	}
	
}

enum ELevel {
	LBeluga;
	LBoat;
	LClam;
	LEel;
	LJellyfish;
	LOtter;
	LRusty;
	LSeagull;
	LShark;
	LSpliff;
	LSquid;
	LWalrus;
}
