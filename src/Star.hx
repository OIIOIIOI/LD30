package ;

import flash.display.Sprite;

/**
 * ...
 * @author Grmpf
 */
class Star extends Sprite
{	
	public var depth:Int;
	private var xSpawn:Int;
	private var ySpawn:Int;
	private var radius:Int;
	
	public function new(type:StarStyle,stardepth:Int)
	{
		super();
		depth = stardepth;
		switch(type){
			case Small:
				xSpawn = 2;
				xSpawn = 2;
				radius = 4;
			case Medium:
				xSpawn = 3;
				xSpawn = 3;
				radius = 6;
				
			case Large:
				xSpawn = 4;
				xSpawn = 4;
				radius = 8;
			default:
		}
		this.graphics.beginFill(0xFFFFFF);
		this.graphics.drawCircle(xSpawn, ySpawn, radius);
		this.graphics.endFill();
	}
}
enum StarStyle {
	Small;
	Medium;
	Large;
}