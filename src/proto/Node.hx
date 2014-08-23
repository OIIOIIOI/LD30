package proto;

import flash.display.Sprite;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;

/**
 * ...
 * @author 01101101
 */
class Node extends Sprite {
	
	static var format:TextFormat;
	
	var units:Int;
	var tf:TextField;
	
	public function new () {
		super();
		
		units = 99;
		
		mouseChildren = false;
		buttonMode = true;
		
		graphics.beginFill(0x000000);
		graphics.drawCircle(0, 0, 30);
		graphics.endFill();
		
		format = new TextFormat("Arial", 18, 0xFFFFFF, true);
		format.align = TextFormatAlign.CENTER;
		
		tf = new TextField();
		tf.mouseEnabled = false;
		tf.selectable = false;
		tf.defaultTextFormat = format;
		tf.width = 50;
		tf.height = 30;
		tf.x = -25;
		tf.y = -10;
		tf.text = Std.string(units);
		addChild(tf);
	}
	
	public function selectOne () {
		units--;
		tf.text = Std.string(units);
	}
	
	public function addSome (n:Int) {
		units += n;
		tf.text = Std.string(units);
	}
	
}
