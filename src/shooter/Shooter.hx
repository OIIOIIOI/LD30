package shooter;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.filters.BlurFilter;
import flash.ui.Keyboard;
import shooter.entities.AnimEntity;
import shooter.entities.Entity;
import shooter.entities.Particle;
import shooter.entities.StarShrimp;

/**
 * ...
 * @author 01101101
 */

class Shooter extends Sprite {
	
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
		
		area = new Sprite();
		area.graphics.beginFill(0xFF00FF, 0);
		area.graphics.drawRect(0, 0, Const.CANVAS_WIDTH * Const.CANVAS_SCALE, Const.CANVAS_HEIGHT * Const.CANVAS_SCALE);
		area.graphics.endFill();
		addChild(area);
		area.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
		
		isShooting = false;
		
		addEventListener(Event.ENTER_FRAME, update);
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
	
	public function update (ev:Event) {
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
		var p = new Particle();
		p.x = Std.random(100);
		p.y = Std.random(100);
		entities.add(p);
	}
	
	public function render () {
		canvasData.fillRect(canvasData.rect, 0xFF220022);
		
		for (e in entities) {
			if (e.useCopyPixels()) {
				if (Std.is(e, AnimEntity)) {
					var ae:AnimEntity = cast(e);
					SpriteSheet.ins.renderTile(e.getTile(), ae.x + ae.ox, ae.y + ae.oy, canvasData);
				} else {
					SpriteSheet.ins.renderTile(e.getTile(), e.x, e.y, canvasData);
				}
			}
			else {
				Const.TAM.identity();
				// Rotation
				if (e.rotation != 0)				Const.TAM.rotate(e.rotation * Math.PI / 180);
				// Position
				if (Std.is(e, AnimEntity)) {
					var ae:AnimEntity = cast(e);
					Const.TAM.translate(ae.x + ae.ox, ae.y + ae.oy);
				} else {
					Const.TAM.translate(e.x, e.y);
				}
				// Scale
				if (e.scaleX != 1 || e.scaleY != 1)	Const.TAM.scale(e.scaleX, e.scaleY);
				// Render
				canvasData.draw(SpriteSheet.ins.getTile(e.getTile()), Const.TAM);
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
	
	public function kill () {
		canvasData.dispose();
		canvasData = null;
		
		removeChild(canvas);
		canvas = null;
		
		entities.clear();
		entities = null;
	}
	
}
