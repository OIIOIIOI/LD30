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
@:sound("assets/sfx/start.mp3") class StartSFX extends Sound { }
@:sound("assets/sfx/capture.mp3") class StarSFX extends Sound { }
@:sound("assets/sfx/complete.mp3") class LastStarSFX extends Sound { }
@:sound("assets/sfx/dash.mp3") class DashSFX extends Sound { }
@:sound("assets/sfx/sfxhitcrabe.mp3") class LobsterHitSFX extends Sound { }
@:sound("assets/sfx/sfxhitshark.mp3") class SharkHitSFX extends Sound { }
@:sound("assets/sfx/sfxhitastero.mp3") class AsteroidHitSFX extends Sound { }
@:sound("assets/sfx/clik.mp3") class ClickSFX extends Sound { }
 
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
	
	var mainChanA:SoundChannel;
	var mainChanB:SoundChannel;
	var lastStartedA:Bool;
	
	var tona1ChanA:SoundChannel;
	var tona2ChanA:SoundChannel;
	var tona3ChanA:SoundChannel;
	var tona4ChanA:SoundChannel;
	var tona5ChanA:SoundChannel;
	
	var tona1ChanB:SoundChannel;
	var tona2ChanB:SoundChannel;
	var tona3ChanB:SoundChannel;
	var tona4ChanB:SoundChannel;
	var tona5ChanB:SoundChannel;
	
	var sfx:Map<String, Sound>;
	
	public var active(default, null):Int;
	
	public function new () {
		if (ins != null)	throw new Error("SoundMan already created");
		ins = this;
		
		lastStartedA = false;
		active = -1;
		
		mainSnd = new MainSnd();
		tona1Snd = new Tona1Snd();
		tona2Snd = new Tona2Snd();
		tona3Snd = new Tona3Snd();
		tona4Snd = new Tona4Snd();
		tona5Snd = new Tona5Snd();
		
		sfx = new Map();
		sfx.set("start", new StartSFX());
		sfx.set("star", new StarSFX());
		sfx.set("complete", new LastStarSFX());
		sfx.set("dash", new DashSFX());
		sfx.set("lobster", new LobsterHitSFX());
		sfx.set("shark", new SharkHitSFX());
		sfx.set("asteroid", new AsteroidHitSFX());
		sfx.set("click", new ClickSFX());
		
		startAll();
		setActive();
	}
	
	public function startAll () {
		if (!lastStartedA) {
			//trace("start A");
			mainChanA = mainSnd.play(46);
			mainChanA.addEventListener(Event.SOUND_COMPLETE, killAll);
			tona1ChanA = tona1Snd.play(46);
			tona2ChanA = tona2Snd.play(46);
			tona3ChanA = tona3Snd.play(46);
			tona4ChanA = tona4Snd.play(46);
			tona5ChanA = tona5Snd.play(46);
		} else {
			//trace("start B");
			mainChanB = mainSnd.play(46);
			mainChanB.addEventListener(Event.SOUND_COMPLETE, killAll);
			tona1ChanB = tona1Snd.play(46);
			tona2ChanB = tona2Snd.play(46);
			tona3ChanB = tona3Snd.play(46);
			tona4ChanB = tona4Snd.play(46);
			tona5ChanB = tona5Snd.play(46);
		}
		lastStartedA = !lastStartedA;
		
		applyActive();
	}
	
	public function setActive (a:Int = -1) {
		if (a > -2 && a < 5)	active = a;
		applyActive();
	}
	
	public function applyActive () {
		if (tona1ChanA != null)	tona1ChanA.soundTransform = (active == 0) ? ST_ON : ST_OFF;
		if (tona2ChanA != null)	tona2ChanA.soundTransform = (active == 1) ? ST_ON : ST_OFF;
		if (tona3ChanA != null)	tona3ChanA.soundTransform = (active == 2) ? ST_ON : ST_OFF;
		if (tona4ChanA != null)	tona4ChanA.soundTransform = (active == 3) ? ST_ON : ST_OFF;
		if (tona5ChanA != null)	tona5ChanA.soundTransform = (active == 4) ? ST_ON : ST_OFF;
		
		if (tona1ChanB != null)	tona1ChanB.soundTransform = (active == 0) ? ST_ON : ST_OFF;
		if (tona2ChanB != null)	tona2ChanB.soundTransform = (active == 1) ? ST_ON : ST_OFF;
		if (tona3ChanB != null)	tona3ChanB.soundTransform = (active == 2) ? ST_ON : ST_OFF;
		if (tona4ChanB != null)	tona4ChanB.soundTransform = (active == 3) ? ST_ON : ST_OFF;
		if (tona5ChanB != null)	tona5ChanB.soundTransform = (active == 4) ? ST_ON : ST_OFF;
	}
	
	public function killAll (e:Event) {
		if (e.currentTarget == mainChanA) {
			//trace("kill A");
			mainChanA.stop();
			mainChanA = null;
			tona1ChanA.stop();
			tona1ChanA = null;
			tona2ChanA.stop();
			tona2ChanA = null;
			tona3ChanA.stop();
			tona3ChanA = null;
			tona4ChanA.stop();
			tona4ChanA = null;
			tona5ChanA.stop();
			tona5ChanA = null;
		} else {
			//trace("kill B");
			mainChanB.stop();
			mainChanB = null;
			tona1ChanB.stop();
			tona1ChanB = null;
			tona2ChanB.stop();
			tona2ChanB = null;
			tona3ChanB.stop();
			tona3ChanB = null;
			tona4ChanB.stop();
			tona4ChanB = null;
			tona5ChanB.stop();
			tona5ChanB = null;
		}
	}
	
	public function update () {
		if ((lastStartedA && mainChanA.position >= 113624) || (!lastStartedA && mainChanB.position >= 113624)) {
			startAll();
		}
	}
	
	public function playSFX (s:String) {
		if (!sfx.exists(s))	return;
		sfx.get(s).play();
	}
	
}
