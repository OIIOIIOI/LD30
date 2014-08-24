package shooter;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.ui.Keyboard;
import shooter.entities.AnimEntity;
import shooter.entities.Entity;
import shooter.entities.StarShrimp;

/**
 * ...
 * @author 01101101
 */

class Shooter extends Sprite {
	
	var entities:List<Entity>;
	var canvas:Bitmap;
	var canvasData:BitmapData;
	
	public function new () {
		super();
		
		new SpriteSheet();
		
		entities = new List();
		
		canvasData = new BitmapData(Const.CANVAS_WIDTH, Const.CANVAS_HEIGHT, false);
		
		canvas = new Bitmap(canvasData);
		canvas.scaleX = canvas.scaleY = Const.CANVAS_SCALE;
		addChild(canvas);
		
		var e = new StarShrimp();
		e.x = Std.random(110);
		e.y = Std.random(75);
		entities.add(e);
		
		canvas.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
		
		addEventListener(Event.ENTER_FRAME, update);
	}
	
	function mouseDownHandler (e:MouseEvent) {
		
	}
	
	public function update (ev:Event) {
		// Update and render
		for (e in entities) {
			e.update();
		}
		render();
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
				Const.TAM.translate(e.x, e.y);
				if (e.rotation != 0)				Const.TAM.rotate(e.rotation * Math.PI / 180);
				if (e.scaleX != 1 || e.scaleY != 1)	Const.TAM.scale(e.scaleX, e.scaleY);
				canvasData.draw(SpriteSheet.ins.getTile(e.getTile()), Const.TAM);
			}
		}
	}
	
	public function kill () {
		canvasData.dispose();
		canvasData = null;
		
		removeChild(canvas);
		canvas = null;
		
		entities.clear();
		entities = null;
	}
	
}
