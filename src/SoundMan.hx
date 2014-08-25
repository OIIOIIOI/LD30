package ;

import flash.errors.Error;
import flash.events.Event;
import flash.media.Sound;
import flash.media.SoundChannel;
import flash.media.SoundTransform;

/**
 * ...
 * @author 01101101
 */

@:sound("assets/snd/Short master main.mp3") class MainSnd extends Sound { }
@:sound("assets/snd/Tona 01 master.mp3") class Tona1Snd extends Sound { }
@:sound("assets/snd/Tona 02 master.mp3") class Tona2Snd extends Sound { }
@:sound("assets/snd/Tona 03 master.mp3") class Tona3Snd extends Sound { }
@:sound("assets/snd/Tona 04 master.mp3") class Tona4Snd extends Sound { }
@:sound("assets/snd/Tona 05 master.mp3") class Tona5Snd extends Sound { }
 
class SoundMan {
	
	static public var ins:SoundMan;
	
	static public var ST_OFF = new SoundTransform(0);
	static public var ST_ON = new SoundTransform(0.7);
	
	var mainSnd:Sound;
	var tona1Snd:Sound;
	var tona2Snd:Sound;
	var tona3Snd:Sound;
	var tona4Snd:Sound;
	var tona5Snd:Sound;
	
	var mainChan:SoundChannel;
	var tona1Chan:SoundChannel;
	var tona2Chan:SoundChannel;
	var tona3Chan:SoundChannel;
	var tona4Chan:SoundChannel;
	var tona5Chan:SoundChannel;
	
	public var active(default, null):Int;
	
	public function new () {
		if (ins != null)	throw new Error("SoundMan already created");
		ins = this;
		
		active = -1;
		
		mainSnd = new MainSnd();
		tona1Snd = new Tona1Snd();
		tona2Snd = new Tona2Snd();
		tona3Snd = new Tona3Snd();
		tona4Snd = new Tona4Snd();
		tona5Snd = new Tona5Snd();
		
		startAll();
		setActive();
	}
	
	public function startAll () {
		mainChan = mainSnd.play();
		mainChan.addEventListener(Event.SOUND_COMPLETE, sndCompleteHander);
		
		tona1Chan = tona1Snd.play();
		tona2Chan = tona2Snd.play();
		tona3Chan = tona3Snd.play();
		tona4Chan = tona4Snd.play();
		tona5Chan = tona5Snd.play();
		
		setActive();
	}
	
	public function setActive (a:Int = -1) {
		if (a > -2 && a < 5)	active = a;
		//trace(active);
		
		tona1Chan.soundTransform = (active == 0) ? ST_ON : ST_OFF;
		tona2Chan.soundTransform = (active == 1) ? ST_ON : ST_OFF;
		tona3Chan.soundTransform = (active == 2) ? ST_ON : ST_OFF;
		tona4Chan.soundTransform = (active == 3) ? ST_ON : ST_OFF;
		tona5Chan.soundTransform = (active == 4) ? ST_ON : ST_OFF;
	}
	
	public function killAll () {
		mainChan.stop();
		mainChan = null;
		tona1Chan.stop();
		tona1Chan = null;
		tona2Chan.stop();
		tona2Chan = null;
		tona3Chan.stop();
		tona3Chan = null;
		tona4Chan.stop();
		tona4Chan = null;
		tona5Chan.stop();
		tona5Chan = null;
	}
	
	function sndCompleteHander (e:Event) {
		mainChan.removeEventListener(Event.SOUND_COMPLETE, sndCompleteHander);
		killAll();
		startAll();
	}
	
}
