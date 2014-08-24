package shooter;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.filters.BlurFilter;
import flash.ui.Keyboard;
import screen.Screen;
import shooter.entities.AnimEntity;
import shooter.entities.Asteroid;
import shooter.entities.Entity;
import shooter.entities.Particle;
import shooter.entities.StarShrimp;

/**
 * ...
 * @author 01101101
 */

class Shooter extends Screen {
	
	var entities:List<Entity>;
	var canvas:Bitmap;
	var canvasData:BitmapData;
	
	var shrimp:StarShrimp;
	
	var area:Sprite;
	
	var isShooting:Bool;
	var lockedEntity:Entity;
	
	public function new () {
		super();
		
		new SpriteSheet();
		
		entities = new List();
		
		canvasData = new BitmapData(Const.CANVAS_WIDTH, Const.CANVAS_HEIGHT, false);
		
		canvas = new Bitmap(canvasData);
		canvas.scaleX = canvas.scaleY = Const.CANVAS_SCALE;
		addChild(canvas);
		
		shrimp = new StarShrimp();
		shrimp.x = Const.CANVAS_WIDTH / 2;
		shrimp.y = Const.CANVAS_HEIGHT / 2;
		entities.add(shrimp);
		
		var a = new Asteroid();
		a.x = Std.random(Const.CANVAS_WIDTH);
		a.y = Std.random(Const.CANVAS_HEIGHT);
		entities.add(a);
		a = new Asteroid();
		a.x = Std.random(Const.CANVAS_WIDTH);
		a.y = Std.random(Const.CANVAS_HEIGHT);
		entities.add(a);
		a = new Asteroid();
		a.x = Std.random(Const.CANVAS_WIDTH);
		a.y = Std.random(Const.CANVAS_HEIGHT);
		entities.add(a);
		a = new Asteroid();
		a.x = Std.random(Const.CANVAS_WIDTH);
		a.y = Std.random(Const.CANVAS_HEIGHT);
		entities.add(a);
		
		area = new Sprite();
		area.graphics.beginFill(0xFF00FF, 0);
		area.graphics.drawRect(0, 0, Const.CANVAS_WIDTH * Const.CANVAS_SCALE, Const.CANVAS_HEIGHT * Const.CANVAS_SCALE);
		area.graphics.endFill();
		addChild(area);
		area.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
		
		isShooting = false;
		lockedEntity = null;
	}
	
	function mouseDownHandler (e:MouseEvent) {
		area.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
		area.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
		area.addEventListener(MouseEvent.MOUSE_OUT, mouseUpHandler);
		isShooting = true;
		shrimp.suck();
	}
	
	function mouseUpHandler (e:MouseEvent) {
		area.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
		area.removeEventListener(MouseEvent.MOUSE_OUT, mouseUpHandler);
		area.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
		isShooting = false;
		shrimp.suck(false);
		
		if (lockedEntity != null) {
			var eAngle = Math.atan2(lockedEntity.y - shrimp.y, lockedEntity.x - shrimp.x);
			var dist = Math.sqrt((lockedEntity.x-shrimp.x)*(lockedEntity.x-shrimp.x)+(lockedEntity.y-shrimp.y)*(lockedEntity.y-shrimp.y));
			lockedEntity.setForce(eAngle, 5);
			lockedEntity = null;
		}
	}
	
	override public function update () {
		super.update();
		// Ray
		if (isShooting) {
			showRay();
			suckEntities();
		}
		if (mouseX / Const.CANVAS_SCALE >= Const.CANVAS_WIDTH / 2)	shrimp.scaleX = 1;
		else														shrimp.scaleX = -1;
		// Update
		for (e in entities) {
			if (Std.is(e, Particle))	cast(e, Particle).setTarget(shrimp.x + (4 * shrimp.scaleX), shrimp.y + 8);
			e.update();
		}
		// Filter dead
		entities = entities.filter(filterDead);
		// Render
		render();
	}
	
	function suckEntities () {
		var heavy:Entity = null;
		var minAngle:Float = 360;
		var mAngle = Math.atan2(mouseY / Const.CANVAS_SCALE - shrimp.y, mouseX / Const.CANVAS_SCALE - shrimp.x) * 180 / Math.PI;
		
		for (e in entities) {
			if (!e.suckable)	continue;
			var eAngle = Math.atan2(e.y - shrimp.y, e.x - shrimp.x) * 180 / Math.PI;
			var diff = Math.abs(mAngle - eAngle);
			if (diff < 15) {
				if (e.weight > 0) {
					if ((lockedEntity == null || e == lockedEntity) && Math.abs(eAngle) < Math.abs(minAngle)) {
						minAngle = eAngle;
						heavy = e;
					}
				} else {
					e.setForce(eAngle * Math.PI / 180);
				}
			}
		}
		
		if (heavy != null) {
			heavy.setForce(Math.atan2(heavy.y - shrimp.y, heavy.x - shrimp.x));
			lockedEntity = heavy;
		}
	}
	
	function filterDead (e:Entity) :Bool {
		return !e.dead;
	}
	
	function showRay () {
		/*var p = new Particle();
		p.x = mouseX / Const.CANVAS_SCALE + Std.random(15) * (Std.random(2)*2-1);
		p.y = mouseY / Const.CANVAS_SCALE + Std.random(15) * (Std.random(2)*2-1);
		entities.add(p);*/
		var angle = Math.atan2(mouseY / Const.CANVAS_SCALE - shrimp.y, mouseX / Const.CANVAS_SCALE - shrimp.x);
		var p = new Particle();
		p.x = shrimp.x + Std.random(20) * (Std.random(2)*2-1) + Math.cos(angle) * 100;
		p.y = shrimp.y + Std.random(20) * (Std.random(2)*2-1) + Math.sin(angle) * 100;
		entities.add(p);
	}
	
	public function render () {
		canvasData.fillRect(canvasData.rect, 0xFF220022);
		
		for (e in entities) {
			if (e.useCopyPixels()) {
				if (e.tile != -1) {
					SpriteSheet.ins.renderTile(e.tile, e.x + e.ox, e.y + e.oy, canvasData);
				} else if (e.data != null) {
					Const.TAP.x = e.x + e.ox;
					Const.TAP.y = e.y + e.oy;
					canvasData.copyPixels(e.data, e.data.rect, Const.TAP);
				}
			} else {
				Const.TAM.identity();
				// Rotation
				if (e.rotation != 0)	Const.TAM.rotate(e.rotation * Math.PI / 180);
				// Scale
				if (e.scaleX != 1 || e.scaleY != 1)	Const.TAM.scale(e.scaleX, e.scaleY);
				// Position
				Const.TAM.translate(e.x + e.ox * e.scaleX, e.y + e.oy * e.scaleY);
				// Render
				if (e.tile != -1) {
					canvasData.draw(SpriteSheet.ins.getTile(e.tile), Const.TAM);
				} else {
					canvasData.draw(e.data, Const.TAM);
				}
			}
		}
	}
	
	override public function kill () {
		super.kill();
		
		canvasData.dispose();
		canvasData = null;
		
		removeChild(canvas);
		canvas = null;
		
		entities.clear();
		entities = null;
	}
	
}
