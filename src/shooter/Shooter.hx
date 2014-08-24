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
	
	public function new () {
		super();
		
		new SpriteSheet();
		
		entities = new List();
		
		canvasData = new BitmapData(Const.CANVAS_WIDTH, Const.CANVAS_HEIGHT, false);
		
		canvas = new Bitmap(canvasData);
		canvas.scaleX = canvas.scaleY = Const.CANVAS_SCALE;
		addChild(canvas);
		
		shrimp = new StarShrimp();
		shrimp.x = Std.random(110);
		shrimp.y = Std.random(75);
		entities.add(shrimp);
		
		var p = new Particle();
		p.x = Std.random(40);
		p.y = Std.random(40);
		entities.add(p);
		
		area = new Sprite();
		area.graphics.beginFill(0xFF00FF, 0);
		area.graphics.drawRect(0, 0, Const.CANVAS_WIDTH * Const.CANVAS_SCALE, Const.CANVAS_HEIGHT * Const.CANVAS_SCALE);
		area.graphics.endFill();
		addChild(area);
		area.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
		
		isShooting = false;
	}
	
	function mouseDownHandler (e:MouseEvent) {
		area.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
		area.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
		area.addEventListener(MouseEvent.MOUSE_OUT, mouseUpHandler);
		isShooting = true;
	}
	
	function mouseUpHandler (e:MouseEvent) {
		area.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
		area.removeEventListener(MouseEvent.MOUSE_OUT, mouseUpHandler);
		area.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
		isShooting = false;
	}
	
	override public function update () {
		super.update();
		// Ray
		if (isShooting)	showRay();
		// Update
		for (e in entities) {
			e.update();
		}
		
		// Render
		render();
	}
	
	function showRay () {
		var angle = Math.atan2(mouseY / Const.CANVAS_SCALE - shrimp.y, mouseX / Const.CANVAS_SCALE - shrimp.x);
		//var p = new Particle();
		//p.x = Std.random(100);
		//p.y = Std.random(100);
		//entities.add(p);
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
				// Position
				Const.TAM.translate(e.x + e.ox, e.y + e.oy);
				// Scale
				if (e.scaleX != 1 || e.scaleY != 1)	Const.TAM.scale(e.scaleX, e.scaleY);
				// Render
				if (e.tile != -1) {
					canvasData.draw(SpriteSheet.ins.getTile(e.tile), Const.TAM);
				} else {
					canvasData.draw(e.data, Const.TAM);
				}
			}
		}
		
		//renderRay();
	}
	
	/*function renderRay () {
		var angle = Math.atan2(mouseY / Const.CANVAS_SCALE - shrimp.y, mouseX / Const.CANVAS_SCALE - shrimp.x);
		
		Const.TAM.identity();
		Const.TAM.rotate(angle);
		Const.TAM.translate(shrimp.x + 4, shrimp.y + 6);
		canvasData.draw(ray, Const.TAM);
	}*/
	
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
