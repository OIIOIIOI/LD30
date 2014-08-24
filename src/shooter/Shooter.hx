package shooter;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.events.Event;
import shooter.entities.Entity;

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
		
		entities = new List();
		
		canvasData = new BitmapData(225, 150, false);
		
		canvas = new Bitmap(canvasData);
		canvas.scaleX = canvas.scaleY = 4;
		addChild(canvas);
		
		var e = new Entity();
		e.w = Std.random(100) + 10;
		e.h = Std.random(100) + 10;
		entities.add(e);
		e = new Entity();
		e.w = Std.random(100) + 10;
		e.h = Std.random(100) + 10;
		entities.add(e);
		e = new Entity();
		e.w = Std.random(100) + 10;
		e.h = Std.random(100) + 10;
		entities.add(e);
		
		addEventListener(Event.ENTER_FRAME, update);
	}
	
	public function update (ev:Event) {
		for (e in entities) {
			e.update();
		}
		render();
	}
	
	public function render () {
		canvasData.fillRect(canvasData.rect, 0xFF220022);
		
		for (e in entities) {
			if (e.useCopyPixels()) {
				Const.TAP.x = e.x;
				Const.TAP.y = e.y;
				canvasData.copyPixels(e.getData(), e.getData().rect, Const.TAP);
			}
			else {
				Const.TAM.identity();
				Const.TAM.translate(e.x, e.y);
				if (e.rotation != 0)				Const.TAM.rotate(e.rotation * Math.PI / 180);
				if (e.scaleX != 1 || e.scaleY != 1)	Const.TAM.scale(e.scaleX, e.scaleY);
				canvasData.draw(e.getData(), Const.TAM);
			}
		}
	}
	
	public function kill () {
		
	}
	
}
