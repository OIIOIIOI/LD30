package ;

import flash.display.Sprite;

/**
 * ...
 * @author Grmpf
 */
class SpaceBG extends Sprite
{
	public function new(h:Int,w:Int,x:Int,y:Int) 
	{
		super();
		this.graphics.beginFill(0x000011);
		this.graphics.drawRect(x, y, w, h);
		this.graphics.endFill();
		for (i in 0...249) {
			switch(Std.random(3)) {
				case 0:
					var newstar = new Star(Small,0);
					newstar.x = Math.random() * this.width;
					newstar.y = Math.random() * this.height;
					this.addChild(newstar);
				case 1:
					var newstar = new Star(Medium,1);
					newstar.x = Math.random() * this.width;
					newstar.y = Math.random() * this.height;
					this.addChild(newstar);
				case 2:
					var newstar = new Star(Large,2);
					newstar.x = Math.random() * this.width;
					newstar.y = Math.random() * this.height;
					this.addChild(newstar);
				default:
			}
		}
	}
	public function update () {
		var clearList = new Array();
		for (i in 0...this.numChildren) {
			var currentStar = cast(this.getChildAt(i), Star);
			switch(currentStar.depth){
				case 0:
					currentStar.x -= 2;
				case 1:
					currentStar.x -= 4;
				case 2:
					currentStar.x -= 8;
				default:
			}
			if (currentStar.x <= 0) {
				clearList.push(currentStar);
			}
		}
		for(i in 0 ... clearList.length){
			switch(Std.random(3)) {
				case 0:
					var newstar = new Star(Small,0);
					newstar.y =  Math.random() * this.height;
					newstar.x = this.width;
					this.addChild(newstar);
				case 1:
					var newstar = new Star(Medium,1);
					newstar.y = Math.random() * this.height;
					newstar.x = stage.width;
					this.addChild(newstar);
				case 2:
					var newstar = new Star(Large,2);
					newstar.y = Math.random() * this.height;
					newstar.x = this.width;
					this.addChild(newstar);
				default:
			}
		}
		for (elt in clearList) {
			removeChild(elt);
		}
	}
}