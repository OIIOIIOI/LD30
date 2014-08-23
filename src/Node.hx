package ;

import flash.display.Sprite;
import flash.events.MouseEvent;

/**
 * ...
 * @author 01101101
 */
class Node extends Sprite {
	
	static public var OFF:Int = 0;
	static public var VISITED:Int = 1;
	static public var ACTIVE:Int = 2;
	
	public var index:Int;
	public var links:Array<Int>;
	
	var coreSprite:Sprite;
	var radiusSprite:Sprite;
	
	var state:Int;
	
	public function new (i:Int) {
		super();
		
		index = i;
		links = new Array();
		
		radiusSprite = new Sprite();
		radiusSprite.graphics.beginFill(0x00FF00, 0.5);
		radiusSprite.graphics.drawCircle(0, 0, 150);
		radiusSprite.graphics.endFill();
		addChild(radiusSprite);
		radiusSprite.visible = false;
		
		coreSprite = new Sprite();
		setState(OFF);
		addChild(coreSprite);
		coreSprite.addEventListener(MouseEvent.MOUSE_DOWN, downHandler);
		coreSprite.scaleX = coreSprite.scaleY = 1 + Std.random(10)/10;
	}
	
	public function setState (s:Int) {
		state = s;
		var color = switch (state) {
			case Node.VISITED:	0x00FF00;
			case Node.ACTIVE:	0xFF0000;
			default:	0xFFFFFF;
		}
		coreSprite.graphics.clear();
		coreSprite.graphics.beginFill(color);
		coreSprite.graphics.drawCircle(0, 0, 10);
		coreSprite.graphics.endFill();
	}
	
	function downHandler (e:MouseEvent) {
		this.parent.addChild(this);
		radiusSprite.visible = true;
		coreSprite.removeEventListener(MouseEvent.MOUSE_DOWN, downHandler);
		coreSprite.addEventListener(MouseEvent.MOUSE_UP, upHandler);
		coreSprite.addEventListener(MouseEvent.MOUSE_MOVE, moveHandler);
	}
	
	function moveHandler (e:MouseEvent) {
		x = e.stageX;
		y = e.stageY;
	}
	
	function upHandler (e:MouseEvent) {
		radiusSprite.visible = false;
		coreSprite.removeEventListener(MouseEvent.MOUSE_UP, upHandler);
		coreSprite.removeEventListener(MouseEvent.MOUSE_MOVE, moveHandler);
		coreSprite.addEventListener(MouseEvent.MOUSE_DOWN, downHandler);
	}
	
}