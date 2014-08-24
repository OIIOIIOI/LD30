package ;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Loader;
import flash.display.PixelSnapping;
import flash.events.DataEvent;
import flash.events.Event;

/**
 * ...
 * @author Grmpf
 */
class Shrimp extends Bitmap
{
	public function new(?bitmapData:BitmapData, ?pixelSnapping:PixelSnapping, smoothing:Bool=false) 
	{
		super(?bitmapData, ?pixelSnapping, smoothing);
	}
	
}