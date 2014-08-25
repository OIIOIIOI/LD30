package racer ;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.ui.Keyboard;
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
	
	var entities:Array<Entity>;
	var container:Sprite;
	var canvas:Bitmap;
	var overlay:Bitmap;
	var player:Player;
	var next:Next;
	var checkpoints:Array<Checkpoint>;
	var targetCP:Int;
	var paths:Sprite;
	var raceComplete:Bool;
	
	public function new () {
		super();
		
		entities = new Array();
		
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
		
		initMap(ELevel.LSeagull);
		
		next = new Next();
		container.addChild(next.sprite);
		entities.push(next);
		
		player = new Player();
		player.x = checkpoints[targetCP].x;
		player.y = checkpoints[targetCP].y;
		container.addChild(player.sprite);
		entities.push(player);
		
		container.scaleX = container.scaleY = Const.SCALE;
		addChild(container);
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
			case ELevel.LBeluga:	"114,493;321,473;230,432;275,365;422,348;514,334;641,395;581,286;683,231;645,119;457,162;270,303";
			case ELevel.LBoat:		"299,230;335,333;431,158;416,291;569,212;714,203;604,441;310,467;210,439;182,361;164,268;381,102;336,60;171,218;222,103;132,212";
			case ELevel.LClam:		"343,266;200,173;187,112;395,190;572,122;715,134;740,251;602,286;467,302;375,343;276,394;382,433;580,405;683,343;611,451;645,399;697,425";
			case ELevel.LEel:		"226,178;364,192;432,297;562,328;690,319;703,229;547,158;282,87;132,185;146,324;260,447;513,487;638,444;598,411;641,382";
			case ELevel.LJellyfish:	"549,374;697,432;734,355;748,244;714,141;629,80;599,121;547,110;480,113;444,160;452,264;373,239;247,182;336,269;138,381;356,315;245,474;401,349;382,546;594,491;429,475;440,399;467,319";
			case ELevel.LOtter:		"285,205;289,113;219,72;143,109;176,255;188,353;235,400;289,407;323,369;440,356;518,363;481,413;569,362;670,395;755,463;563,245;397,197;328,227";
			case ELevel.LRusty:		"283,433;339,489;519,481;665,392;623,312;526,372;364,406;261,397;371,329;553,296;379,259;237,208;364,174;539,175;654,244;609,280";
			case ELevel.LSeagull:	"415,396;496,484;407,538;492,535;561,511;561,545;609,471;728,410;569,378;482,292;553,258;455,207;412,244;425,134;212,95;347,162;270,250;227,361";
			case ELevel.LShark	:	"548,183;378,64;364,186;266,255;222,369;98,243;147,386;286,549;280,459;379,387;446,451;509,377;603,441;553,319;688,374;796,275;658,230";
			case ELevel.LSpliff:	"152,199;181,188;421,258;652,340;597,379;633,437;770,440;670,471;772,504;602,508;452,414;593,456;543,370;200,225";
			case ELevel.LSquid:		"597,132;747,48;735,136;694,144;551,285;513,370;427,419;306,373;314,286;371,233;546,156;532,123;254,169;193,332;260,413;208,530;296,457;307,525;421,558;537,453;679,377;744,410";
			case ELevel.LWalrus:	"225,330;304,229;432,227;476,98;594,38;684,128;618,179;597,380;505,413;377,498;414,399;212,369;141,492;142,401;80,379";
		}
		var a = s.split(";");
		
		checkpoints = new Array();
		var cp:Checkpoint;
		for (i in 0...a.length) {
			var b = a[i].split(",");
			cp = new Checkpoint(i);
			cp.x = Std.parseInt(b[0]);
			cp.y = Std.parseInt(b[1]);
			checkpoints.push(cp);
			container.addChild(cp.sprite);
			entities.push(cp);
		}
		targetCP = 0;
		raceComplete = false;
	}
	
	override public function update () {
		super.update();
		
		if (!raceComplete) {
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
				if (targetCP > 0) {
					paths.graphics.lineStyle(1, 0xFFFFFF);
					paths.graphics.moveTo(checkpoints[targetCP-1].x, checkpoints[targetCP-1].y);
					paths.graphics.lineTo(checkpoints[targetCP].x, checkpoints[targetCP].y);
				}
				targetCP++;
				if (targetCP == checkpoints.length) {
					raceComplete = true;
					container.x = container.y = 0;
					container.scaleX = container.scaleY = 1;
					next.dead = true;
					player.dead = true;
				}
			}
		} else {
			if (overlay.alpha < 0.4) {
				overlay.alpha += 0.005;
			}
		}
		
		// Update
		for (e in entities) {
			e.update();
			if (Std.is(e, Lobster))	cast(e, Lobster).goForEntity(player);
		}
		
		// Collisions
		var collEntities = entities.filter(filterCollided);
		for (i in 0...collEntities.length) {
			for (j in i+1...collEntities.length) {
				checkCollisions(collEntities[i], collEntities[j]);
			}
		}
		
		// Filter dead
		entities = entities.filter(filterDead);
		
		// Camera
		moveCamera();
	}
	
	function filterDead (e:Entity) :Bool {
		var dead = e.dead;
		if (dead) {
			if (e.sprite != null && e.sprite.parent != null)
				e.sprite.parent.removeChild(e.sprite);
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
		}
	}
	
	function moveCamera () {
		var tx = -player.x * Const.SCALE + canvas.width / 2;
		var ty = -player.y * Const.SCALE + canvas.height / 2;
		container.x += (tx - container.x) * 0.1;
		container.y += (ty - container.y) * 0.1;
		container.x = Math.max(Math.min(container.x, 0), -(container.width - Const.STAGE_WIDTH));
		container.y = Math.max(Math.min(container.y, 0), -(container.height - Const.STAGE_HEIGHT));
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
