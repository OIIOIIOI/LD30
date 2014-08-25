package racer ;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.ui.Keyboard;
import screen.Screen;

/**
 * ...
 * @author 01101101
 */

@:bitmap("assets/img/space_01.png") class SharkBG extends BitmapData { }

class Racer extends Screen {
	
	var entities:Array<Entity>;
	var container:Sprite;
	var canvas:Bitmap;
	var player:Entity;
	var next:Next;
	var checkpoints:Array<Checkpoint>;
	var targetCP:Int;
	var paths:Sprite;
	var raceComplete:Bool;
	
	public function new () {
		super();
		
		entities = new Array();
		
		container = new Sprite();
		
		canvas = new Bitmap(new SharkBG(900, 610));
		container.addChild(canvas);
		
		paths = new Sprite();
		container.addChild(paths);
		
		initMap();
		
		next = new Next();
		container.addChild(next.sprite);
		entities.push(next);
		
		player = new Player();
		player.x = Const.STAGE_WIDTH / 2;
		player.y = Const.STAGE_HEIGHT / 2;
		container.addChild(player.sprite);
		entities.push(player);
		
		container.scaleX = container.scaleY = Const.SCALE;
		addChild(container);
	}
	
	public function initMap () {
		checkpoints = new Array();
		var cp:Checkpoint;
		for (i in 0...10) {
			cp = new Checkpoint(i);
			cp.x = Std.random(Const.STAGE_WIDTH - cp.radius * 2) + cp.radius;
			cp.y = Std.random(Const.STAGE_HEIGHT - cp.radius * 2) + cp.radius;
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
		}
		// Update
		for (e in entities) {
			e.update();
		}
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
	
	function moveCamera () {
		var tx = -player.x * Const.SCALE + canvas.width / 2;
		var ty = -player.y * Const.SCALE + canvas.height / 2;
		container.x += (tx - container.x) * 0.1;
		container.y += (ty - container.y) * 0.1;
		container.x = Math.max(Math.min(container.x, 0), -(container.width - Const.STAGE_WIDTH));
		container.y = Math.max(Math.min(container.y, 0), -(container.height - Const.STAGE_HEIGHT));
	}
	
}
